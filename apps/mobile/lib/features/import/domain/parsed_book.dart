import 'dart:typed_data';

enum ParsedBlockKind { paragraph, heading, quote, listItem, separator, image }

final class ParsedInlineSpan {
  const ParsedInlineSpan({
    required this.startOffset,
    required this.endOffset,
    this.bold = false,
    this.italic = false,
    this.underline = false,
    this.href,
    this.isFootnote = false,
    this.targetChapterOrdinal,
    this.targetOffset,
  });

  final int startOffset;
  final int endOffset;
  final bool bold;
  final bool italic;
  final bool underline;
  final String? href;
  final bool isFootnote;
  final int? targetChapterOrdinal;
  final int? targetOffset;

  ParsedInlineSpan copyWith({int? targetChapterOrdinal, int? targetOffset}) {
    return ParsedInlineSpan(
      startOffset: startOffset,
      endOffset: endOffset,
      bold: bold,
      italic: italic,
      underline: underline,
      href: href,
      isFootnote: isFootnote,
      targetChapterOrdinal: targetChapterOrdinal ?? this.targetChapterOrdinal,
      targetOffset: targetOffset ?? this.targetOffset,
    );
  }

  Map<String, Object> toJson() => <String, Object>{
    'start': startOffset,
    'end': endOffset,
    if (bold) 'bold': true,
    if (italic) 'italic': true,
    if (underline) 'underline': true,
    'href': ?href,
    if (isFootnote) 'footnote': true,
    'targetChapter': ?targetChapterOrdinal,
    'targetOffset': ?targetOffset,
  };
}

final class ParsedBlock {
  const ParsedBlock({
    required this.kind,
    required this.text,
    required this.startOffset,
    required this.endOffset,
    this.inlineSpans = const <ParsedInlineSpan>[],
    this.resourceHref,
    this.altText,
  });

  final ParsedBlockKind kind;
  final String text;
  final int startOffset;
  final int endOffset;
  final List<ParsedInlineSpan> inlineSpans;
  final String? resourceHref;
  final String? altText;

  ParsedBlock copyWith({List<ParsedInlineSpan>? inlineSpans}) {
    return ParsedBlock(
      kind: kind,
      text: text,
      startOffset: startOffset,
      endOffset: endOffset,
      inlineSpans: inlineSpans ?? this.inlineSpans,
      resourceHref: resourceHref,
      altText: altText,
    );
  }
}

final class ParsedResource {
  const ParsedResource({
    required this.href,
    required this.mediaType,
    required this.bytes,
  });

  final String href;
  final String mediaType;
  final Uint8List bytes;
}

final class ParsedChapter {
  const ParsedChapter({
    required this.ordinal,
    required this.title,
    required this.href,
    required this.plainText,
    required this.blocks,
    required this.anchorOffsets,
  });

  final int ordinal;
  final String? title;
  final String? href;
  final String plainText;
  final List<ParsedBlock> blocks;
  final Map<String, int> anchorOffsets;
}

final class ParsedTocEntry {
  const ParsedTocEntry({
    required this.ordinal,
    required this.depth,
    required this.title,
    required this.chapterOrdinal,
    required this.textOffset,
  });

  final int ordinal;
  final int depth;
  final String title;
  final int? chapterOrdinal;
  final int textOffset;
}

final class ParsedBook {
  const ParsedBook({
    required this.format,
    required this.title,
    required this.author,
    required this.language,
    required this.contentHash,
    required this.chapters,
    required this.toc,
    required this.coverBytes,
    required this.coverExtension,
    this.resources = const <ParsedResource>[],
  });

  final String format;
  final String title;
  final String? author;
  final String language;
  final String contentHash;
  final List<ParsedChapter> chapters;
  final List<ParsedTocEntry> toc;
  final Uint8List? coverBytes;
  final String? coverExtension;
  final List<ParsedResource> resources;

  int get totalLength => chapters.fold<int>(
    0,
    (int total, ParsedChapter chapter) => total + chapter.plainText.length,
  );
}
