import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as path;
import 'package:selida/features/import/domain/book_parse_exception.dart';
import 'package:selida/features/import/domain/parsed_book.dart';
import 'package:xml/xml.dart';

const int _maxArchiveEntries = 2000;
const int _maxUncompressedBytes = 50 * 1024 * 1024;

Future<ParsedBook> parseBookInBackground(String filePath) {
  return Isolate.run<ParsedBook>(() => parseBookFile(filePath));
}

ParsedBook parseBookFile(String filePath) {
  final bytes = File(filePath).readAsBytesSync();
  return parseBookBytes(bytes, sourceName: path.basename(filePath));
}

ParsedBook parseBookBytes(Uint8List bytes, {required String sourceName}) {
  final extension = path.extension(sourceName).toLowerCase();
  return switch (extension) {
    '.txt' => _parseTxt(bytes, sourceName),
    '.epub' => _parseEpub(bytes, sourceName),
    _ => throw const BookParseException(BookParseErrorCode.unsupportedFormat),
  };
}

ParsedBook _parseTxt(Uint8List bytes, String sourceName) {
  late final String decoded;
  try {
    decoded = utf8.decode(bytes, allowMalformed: false);
  } on FormatException catch (error) {
    throw BookParseException(BookParseErrorCode.invalidEncoding, error.message);
  }

  final normalized = decoded
      .replaceFirst('\ufeff', '')
      .replaceAll('\r\n', '\n')
      .replaceAll('\r', '\n')
      .trim();
  if (normalized.isEmpty) {
    throw const BookParseException(BookParseErrorCode.emptyBook);
  }

  final rawParagraphs = normalized.split(RegExp(r'\n\s*\n+'));
  final blocks = <ParsedBlock>[];
  final chapterText = StringBuffer();
  for (final rawParagraph in rawParagraphs) {
    final paragraph = _collapseWhitespace(rawParagraph);
    if (paragraph.isEmpty) {
      continue;
    }
    if (chapterText.isNotEmpty) {
      chapterText.write('\n\n');
    }
    final start = chapterText.length;
    chapterText.write(paragraph);
    blocks.add(
      ParsedBlock(
        kind: ParsedBlockKind.paragraph,
        text: paragraph,
        startOffset: start,
        endOffset: chapterText.length,
      ),
    );
  }

  final text = chapterText.toString();
  final title = path.basenameWithoutExtension(sourceName).trim();
  final chapter = ParsedChapter(
    ordinal: 0,
    title: title,
    href: null,
    plainText: text,
    blocks: List<ParsedBlock>.unmodifiable(blocks),
    anchorOffsets: const <String, int>{},
  );
  return ParsedBook(
    format: 'txt',
    title: title.isEmpty ? 'Untitled' : title,
    author: null,
    language: _detectLanguage(text),
    contentHash: sha256.convert(utf8.encode(text)).toString(),
    chapters: <ParsedChapter>[chapter],
    toc: <ParsedTocEntry>[
      ParsedTocEntry(
        ordinal: 0,
        depth: 0,
        title: title,
        chapterOrdinal: 0,
        textOffset: 0,
      ),
    ],
    coverBytes: null,
    coverExtension: null,
  );
}

ParsedBook _parseEpub(Uint8List bytes, String sourceName) {
  late final Archive archive;
  try {
    archive = ZipDecoder().decodeBytes(bytes, verify: true);
  } on Object catch (error) {
    throw BookParseException(
      BookParseErrorCode.invalidContainer,
      error.toString(),
    );
  }

  if (archive.length > _maxArchiveEntries) {
    throw const BookParseException(BookParseErrorCode.unsafeArchive);
  }

  var totalSize = 0;
  final entries = <String, ArchiveFile>{};
  for (final entry in archive) {
    final normalizedName = _safeArchivePath(entry.name);
    totalSize += entry.size;
    if (totalSize > _maxUncompressedBytes) {
      throw const BookParseException(BookParseErrorCode.unsafeArchive);
    }
    if (entry.isFile) {
      entries[normalizedName] = entry;
    }
  }

  final containerFile = entries['META-INF/container.xml'];
  if (containerFile == null) {
    throw const BookParseException(BookParseErrorCode.invalidContainer);
  }

  try {
    final container = XmlDocument.parse(_decodeXml(containerFile.content));
    final rootfile = _elements(container, 'rootfile').firstOrNull;
    final packagePath = rootfile == null
        ? null
        : _attribute(rootfile, 'full-path');
    if (packagePath == null || packagePath.isEmpty) {
      throw const BookParseException(BookParseErrorCode.invalidContainer);
    }

    final normalizedPackagePath = _safeArchivePath(packagePath);
    final packageFile = entries[normalizedPackagePath];
    if (packageFile == null) {
      throw const BookParseException(BookParseErrorCode.invalidContainer);
    }

    final packageDocument = XmlDocument.parse(_decodeXml(packageFile.content));
    final packageDirectory = path.posix.dirname(normalizedPackagePath);
    final manifest = <String, _ManifestItem>{};
    for (final element in _elements(packageDocument, 'item')) {
      final id = _attribute(element, 'id');
      final href = _attribute(element, 'href');
      final mediaType = _attribute(element, 'media-type');
      if (id == null || href == null || mediaType == null) {
        continue;
      }
      manifest[id] = _ManifestItem(
        id: id,
        href: _resolvePackagePath(packageDirectory, href),
        mediaType: mediaType,
        properties: (_attribute(element, 'properties') ?? '')
            .split(RegExp(r'\s+'))
            .where((String value) => value.isNotEmpty)
            .toSet(),
      );
    }

    final spineItems = <_ManifestItem>[];
    for (final itemRef in _elements(packageDocument, 'itemref')) {
      final idRef = _attribute(itemRef, 'idref');
      final item = idRef == null ? null : manifest[idRef];
      if (item != null) {
        spineItems.add(item);
      }
    }
    if (spineItems.isEmpty) {
      throw const BookParseException(BookParseErrorCode.emptyBook);
    }

    final tocRefs = _readToc(
      entries: entries,
      manifest: manifest,
      packageDocument: packageDocument,
      packageDirectory: packageDirectory,
    );
    final labelsByHref = <String, String>{};
    for (final reference in tocRefs) {
      labelsByHref.putIfAbsent(reference.href, () => reference.title);
    }

    final chapters = <ParsedChapter>[];
    for (var index = 0; index < spineItems.length; index += 1) {
      final item = spineItems[index];
      final file = entries[item.href];
      if (file == null) {
        continue;
      }
      final chapter = _parseXhtmlChapter(
        content: _decodeXml(file.content),
        ordinal: chapters.length,
        href: item.href,
        tocTitle: labelsByHref[item.href],
      );
      if (chapter.plainText.isNotEmpty) {
        chapters.add(chapter);
      }
    }
    if (chapters.isEmpty) {
      throw const BookParseException(BookParseErrorCode.emptyBook);
    }

    final chapterOrdinalByHref = <String, int>{
      for (final chapter in chapters)
        if (chapter.href case final String href) href: chapter.ordinal,
    };
    final chaptersByHref = <String, ParsedChapter>{
      for (final chapter in chapters)
        if (chapter.href case final String href) href: chapter,
    };
    final toc = <ParsedTocEntry>[];
    for (var index = 0; index < tocRefs.length; index += 1) {
      final reference = tocRefs[index];
      toc.add(
        ParsedTocEntry(
          ordinal: index,
          depth: reference.depth,
          title: reference.title,
          chapterOrdinal: chapterOrdinalByHref[reference.href],
          textOffset:
              chaptersByHref[reference.href]?.anchorOffsets[reference
                  .fragment] ??
              0,
        ),
      );
    }
    if (toc.isEmpty) {
      for (final chapter in chapters) {
        toc.add(
          ParsedTocEntry(
            ordinal: toc.length,
            depth: 0,
            title: chapter.title ?? 'Chapter ${chapter.ordinal + 1}',
            chapterOrdinal: chapter.ordinal,
            textOffset: 0,
          ),
        );
      }
    }

    final title = _metadataValue(packageDocument, 'title')?.trim();
    final author = _metadataValue(packageDocument, 'creator')?.trim();
    final language = _metadataValue(packageDocument, 'language')?.trim();
    final canonicalText = chapters
        .map((ParsedChapter chapter) => chapter.plainText)
        .join('\n\n');
    final cover = _readCover(
      entries: entries,
      manifest: manifest,
      packageDocument: packageDocument,
    );

    return ParsedBook(
      format: 'epub',
      title: title == null || title.isEmpty
          ? path.basenameWithoutExtension(sourceName)
          : title,
      author: author == null || author.isEmpty ? null : author,
      language: language == null || language.isEmpty
          ? _detectLanguage(canonicalText)
          : _normalizeLanguage(language),
      contentHash: sha256.convert(utf8.encode(canonicalText)).toString(),
      chapters: List<ParsedChapter>.unmodifiable(chapters),
      toc: List<ParsedTocEntry>.unmodifiable(toc),
      coverBytes: cover?.bytes,
      coverExtension: cover?.extension,
    );
  } on BookParseException {
    rethrow;
  } on XmlParserException catch (error) {
    throw BookParseException(
      BookParseErrorCode.invalidContainer,
      error.message,
    );
  } on FormatException catch (error) {
    throw BookParseException(
      BookParseErrorCode.invalidContainer,
      error.message,
    );
  }
}

ParsedChapter _parseXhtmlChapter({
  required String content,
  required int ordinal,
  required String href,
  required String? tocTitle,
}) {
  final document = XmlDocument.parse(content);
  final body = _elements(document, 'body').firstOrNull ?? document.rootElement;
  final blocks = <ParsedBlock>[];
  final anchorOffsets = <String, int>{};
  final chapterText = StringBuffer();

  void addBlock(XmlElement element, ParsedBlockKind kind) {
    final text = _collapseWhitespace(_elementText(element));
    if (text.isEmpty) {
      return;
    }
    if (chapterText.isNotEmpty) {
      chapterText.write('\n\n');
    }
    final start = chapterText.length;
    chapterText.write(text);
    for (final anchored in <XmlElement>[
      element,
      ...element.descendants.whereType<XmlElement>(),
    ]) {
      final id = _attribute(anchored, 'id');
      if (id != null && id.isNotEmpty) {
        anchorOffsets.putIfAbsent(id, () => start);
      }
    }
    blocks.add(
      ParsedBlock(
        kind: kind,
        text: text,
        startOffset: start,
        endOffset: chapterText.length,
      ),
    );
  }

  void visit(XmlElement element) {
    final name = element.name.local.toLowerCase();
    if (<String>{'h1', 'h2', 'h3', 'h4', 'h5', 'h6'}.contains(name)) {
      addBlock(element, ParsedBlockKind.heading);
      return;
    }
    if (<String>{'p', 'li', 'pre'}.contains(name)) {
      addBlock(element, ParsedBlockKind.paragraph);
      return;
    }
    if (name == 'blockquote') {
      addBlock(element, ParsedBlockKind.quote);
      return;
    }
    for (final child in element.children.whereType<XmlElement>()) {
      visit(child);
    }
  }

  visit(body);
  if (blocks.isEmpty) {
    addBlock(body, ParsedBlockKind.paragraph);
  }

  final firstHeading = blocks
      .where((ParsedBlock block) => block.kind == ParsedBlockKind.heading)
      .firstOrNull;
  return ParsedChapter(
    ordinal: ordinal,
    title: tocTitle ?? firstHeading?.text,
    href: href,
    plainText: chapterText.toString(),
    blocks: List<ParsedBlock>.unmodifiable(blocks),
    anchorOffsets: Map<String, int>.unmodifiable(anchorOffsets),
  );
}

List<_TocReference> _readToc({
  required Map<String, ArchiveFile> entries,
  required Map<String, _ManifestItem> manifest,
  required XmlDocument packageDocument,
  required String packageDirectory,
}) {
  final navItem = manifest.values
      .where((_ManifestItem item) => item.properties.contains('nav'))
      .firstOrNull;
  if (navItem != null) {
    final navFile = entries[navItem.href];
    if (navFile != null) {
      final navDocument = XmlDocument.parse(_decodeXml(navFile.content));
      final references = <_TocReference>[];
      final navs = _elements(navDocument, 'nav').toList();
      final tocNav = navs
          .where(
            (XmlElement nav) => (_attribute(nav, 'type') ?? '')
                .split(RegExp(r'\s+'))
                .contains('toc'),
          )
          .firstOrNull;
      final nav = tocNav ?? navs.firstOrNull;

      void visitList(XmlElement list, int depth) {
        for (final item in list.children.whereType<XmlElement>().where(
          (XmlElement child) => child.name.local.toLowerCase() == 'li',
        )) {
          final anchor = item.children
              .whereType<XmlElement>()
              .where(
                (XmlElement child) => child.name.local.toLowerCase() == 'a',
              )
              .firstOrNull;
          final rawHref = anchor == null ? null : _attribute(anchor, 'href');
          final title = anchor == null
              ? ''
              : _collapseWhitespace(_elementText(anchor));
          if (rawHref != null && title.isNotEmpty) {
            references.add(
              _TocReference.fromRawHref(
                rawHref: rawHref,
                title: title,
                depth: depth,
                baseDirectory: path.posix.dirname(navItem.href),
              ),
            );
          }
          for (final childList in item.children.whereType<XmlElement>().where(
            (XmlElement child) =>
                <String>{'ol', 'ul'}.contains(child.name.local.toLowerCase()),
          )) {
            visitList(childList, depth + 1);
          }
        }
      }

      if (nav != null) {
        final rootList = nav.children
            .whereType<XmlElement>()
            .where(
              (XmlElement child) =>
                  <String>{'ol', 'ul'}.contains(child.name.local.toLowerCase()),
            )
            .firstOrNull;
        if (rootList != null) {
          visitList(rootList, 0);
        }
      }
      if (references.isNotEmpty) {
        return references;
      }
    }
  }

  final spine = _elements(packageDocument, 'spine').firstOrNull;
  final tocId = spine == null ? null : _attribute(spine, 'toc');
  final ncxItem = tocId == null
      ? manifest.values
            .where(
              (_ManifestItem item) =>
                  item.mediaType == 'application/x-dtbncx+xml',
            )
            .firstOrNull
      : manifest[tocId];
  if (ncxItem == null) {
    return const <_TocReference>[];
  }
  final ncxFile = entries[ncxItem.href];
  if (ncxFile == null) {
    return const <_TocReference>[];
  }

  final ncxDocument = XmlDocument.parse(_decodeXml(ncxFile.content));
  final references = <_TocReference>[];
  void visitNavPoint(XmlElement navPoint, int depth) {
    final labelElement = _descendants(navPoint, 'text').firstOrNull;
    final contentElement = navPoint.children
        .whereType<XmlElement>()
        .where((XmlElement child) => child.name.local == 'content')
        .firstOrNull;
    final rawHref = contentElement == null
        ? null
        : _attribute(contentElement, 'src');
    final title = labelElement == null
        ? ''
        : _collapseWhitespace(_elementText(labelElement));
    if (rawHref != null && title.isNotEmpty) {
      references.add(
        _TocReference.fromRawHref(
          rawHref: rawHref,
          title: title,
          depth: depth,
          baseDirectory: path.posix.dirname(ncxItem.href),
        ),
      );
    }
    for (final child in navPoint.children.whereType<XmlElement>()) {
      if (child.name.local == 'navPoint') {
        visitNavPoint(child, depth + 1);
      }
    }
  }

  for (final navPoint in _elements(ncxDocument, 'navPoint').where(
    (XmlElement element) => element.parentElement?.name.local != 'navPoint',
  )) {
    visitNavPoint(navPoint, 0);
  }
  return references;
}

_CoverAsset? _readCover({
  required Map<String, ArchiveFile> entries,
  required Map<String, _ManifestItem> manifest,
  required XmlDocument packageDocument,
}) {
  var coverItem = manifest.values
      .where((_ManifestItem item) => item.properties.contains('cover-image'))
      .firstOrNull;
  if (coverItem == null) {
    final coverMeta = _elements(packageDocument, 'meta')
        .where((XmlElement element) => _attribute(element, 'name') == 'cover')
        .firstOrNull;
    final coverId = coverMeta == null ? null : _attribute(coverMeta, 'content');
    coverItem = coverId == null ? null : manifest[coverId];
  }
  if (coverItem == null) {
    return null;
  }
  final file = entries[coverItem.href];
  if (file == null) {
    return null;
  }
  final extension = switch (coverItem.mediaType) {
    'image/jpeg' => '.jpg',
    'image/png' => '.png',
    _ => null,
  };
  return extension == null
      ? null
      : _CoverAsset(bytes: file.content, extension: extension);
}

Iterable<XmlElement> _elements(XmlNode node, String localName) {
  return node.descendants.whereType<XmlElement>().where(
    (XmlElement element) => element.name.local == localName,
  );
}

Iterable<XmlElement> _descendants(XmlNode node, String localName) {
  return node.descendants.whereType<XmlElement>().where(
    (XmlElement element) => element.name.local == localName,
  );
}

String? _attribute(XmlElement element, String localName) {
  for (final attribute in element.attributes) {
    if (attribute.name.local == localName) {
      return attribute.value;
    }
  }
  return null;
}

String? _metadataValue(XmlDocument document, String localName) {
  return _elements(document, localName).firstOrNull?.innerText;
}

String _decodeXml(Uint8List bytes) {
  try {
    return utf8.decode(bytes, allowMalformed: false);
  } on FormatException catch (error) {
    throw BookParseException(BookParseErrorCode.invalidEncoding, error.message);
  }
}

String _safeArchivePath(String value) {
  final replaced = value.replaceAll('\\', '/');
  final decoded = Uri.decodeComponent(replaced);
  final normalized = path.posix.normalize(decoded);
  if (path.posix.isAbsolute(normalized) ||
      normalized == '..' ||
      normalized.startsWith('../')) {
    throw const BookParseException(BookParseErrorCode.unsafeArchive);
  }
  return normalized;
}

String _resolvePackagePath(String directory, String href) {
  final withoutFragment = href.split('#').first;
  return _safeArchivePath(path.posix.join(directory, withoutFragment));
}

String _elementText(XmlElement element) {
  final output = StringBuffer();
  void visit(XmlNode node) {
    if (node is XmlText) {
      output.write(node.value);
      return;
    }
    if (node is XmlElement && node.name.local.toLowerCase() == 'br') {
      output.write(' ');
      return;
    }
    for (final child in node.children) {
      visit(child);
    }
  }

  visit(element);
  return output.toString();
}

String _collapseWhitespace(String value) {
  return value.replaceAll(RegExp(r'[\s\u00a0]+'), ' ').trim();
}

String _detectLanguage(String text) {
  var greek = 0;
  var latin = 0;
  for (final rune in text.runes.take(20000)) {
    if ((rune >= 0x0370 && rune <= 0x03ff) ||
        (rune >= 0x1f00 && rune <= 0x1fff)) {
      greek += 1;
    } else if ((rune >= 0x0041 && rune <= 0x005a) ||
        (rune >= 0x0061 && rune <= 0x007a)) {
      latin += 1;
    }
  }
  return greek > latin * 0.15 ? 'el' : 'en';
}

String _normalizeLanguage(String language) {
  final lower = language.toLowerCase();
  if (lower == 'el' || lower.startsWith('gr')) {
    return 'el';
  }
  return 'en';
}

final class _ManifestItem {
  const _ManifestItem({
    required this.id,
    required this.href,
    required this.mediaType,
    required this.properties,
  });

  final String id;
  final String href;
  final String mediaType;
  final Set<String> properties;
}

final class _TocReference {
  const _TocReference({
    required this.href,
    required this.title,
    required this.depth,
    required this.fragment,
  });

  factory _TocReference.fromRawHref({
    required String rawHref,
    required String title,
    required int depth,
    required String baseDirectory,
  }) {
    final parts = rawHref.split('#');
    return _TocReference(
      href: _safeArchivePath(path.posix.join(baseDirectory, parts.first)),
      title: title,
      depth: depth,
      fragment: parts.length > 1
          ? Uri.decodeComponent(parts.skip(1).join('#'))
          : null,
    );
  }

  final String href;
  final String title;
  final int depth;
  final String? fragment;
}

final class _CoverAsset {
  const _CoverAsset({required this.bytes, required this.extension});

  final Uint8List bytes;
  final String extension;
}

extension<T> on Iterable<T> {
  T? get firstOrNull {
    final iterator = this.iterator;
    return iterator.moveNext() ? iterator.current : null;
  }
}
