import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:selida/core/database/app_database.dart';
import 'package:selida/core/database/database_provider.dart';
import 'package:selida/features/import/data/book_parser.dart';
import 'package:selida/features/import/domain/book_parse_exception.dart';
import 'package:selida/features/import/domain/parsed_book.dart';
import 'package:uuid/uuid.dart';

final Provider<BookImportService> bookImportServiceProvider =
    Provider<BookImportService>((Ref ref) {
      return BookImportService(ref.watch(databaseProvider));
    });

final class BookImportService {
  BookImportService(this._database);

  static const _exampleBookAsset = 'assets/books/selida-sample.txt';
  static const _exampleBookSeedKey = 'seed.example_book.selida_sample.v1';

  final AppDatabase _database;
  final Uuid _uuid = const Uuid();

  Future<void> ensureExampleBookImported() async {
    if (await _database.localSettingValue(_exampleBookSeedKey) == 'done') {
      return;
    }

    final data = await rootBundle.load(_exampleBookAsset);
    final temporaryDirectory = await getTemporaryDirectory();
    final temporaryFile = File(
      path.join(temporaryDirectory.path, 'selida-sample.txt'),
    );
    await temporaryFile.writeAsBytes(
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
      flush: true,
    );

    try {
      await importPath(temporaryFile.path);
      await _database.saveLocalSettingValue(
        key: _exampleBookSeedKey,
        valueJson: 'done',
      );
    } finally {
      if (temporaryFile.existsSync()) {
        await temporaryFile.delete();
      }
    }
  }

  Future<String?> pickAndImport() async {
    const bookTypes = XTypeGroup(
      label: 'EPUB and TXT books',
      extensions: <String>['epub', 'txt'],
      mimeTypes: <String>['application/epub+zip', 'text/plain'],
      uniformTypeIdentifiers: <String>[
        'org.idpf.epub-container',
        'public.plain-text',
      ],
    );
    final selected = await openFile(
      acceptedTypeGroups: const <XTypeGroup>[bookTypes],
    );
    if (selected == null) {
      return null;
    }
    return importPath(selected.path);
  }

  Future<String> importPath(String sourcePath) async {
    if (!isSupportedPath(sourcePath)) {
      throw const BookParseException(BookParseErrorCode.unsupportedFormat);
    }

    final parsed = await parseBookInBackground(sourcePath);
    final existing = await _database.findActiveBookByHash(parsed.contentHash);
    if (existing != null) {
      await _database.markBookOpened(existing.id);
      return existing.id;
    }

    final bookId = _uuid.v7();
    final appDirectory = await getApplicationDocumentsDirectory();
    final booksDirectory = Directory(path.join(appDirectory.path, 'books'));
    final coversDirectory = Directory(path.join(appDirectory.path, 'covers'));
    await booksDirectory.create(recursive: true);
    await coversDirectory.create(recursive: true);

    final extension = path.extension(sourcePath).toLowerCase();
    final storedBookFile = File(
      path.join(booksDirectory.path, '$bookId$extension'),
    );
    await File(sourcePath).copy(storedBookFile.path);
    final resourceDirectory = Directory(
      path.join(booksDirectory.path, '$bookId-resources'),
    );
    String? coverPath;
    try {
      final resourcePaths = await _storeResources(
        resources: parsed.resources,
        directory: resourceDirectory,
      );
      if (parsed.coverBytes case final coverBytes?) {
        final coverExtension = parsed.coverExtension ?? '.jpg';
        final coverFile = File(
          path.join(coversDirectory.path, '$bookId$coverExtension'),
        );
        await coverFile.writeAsBytes(coverBytes, flush: true);
        coverPath = coverFile.path;
      }

      await _storeBook(
        id: bookId,
        parsed: parsed,
        filePath: storedBookFile.path,
        coverPath: coverPath,
        resourcePaths: resourcePaths,
      );
    } on Object {
      if (storedBookFile.existsSync()) {
        await storedBookFile.delete();
      }
      if (coverPath != null && File(coverPath).existsSync()) {
        await File(coverPath).delete();
      }
      if (resourceDirectory.existsSync()) {
        await resourceDirectory.delete(recursive: true);
      }
      rethrow;
    }
    return bookId;
  }

  Future<void> deleteBook(String bookId) async {
    final book = await _database.findBook(bookId);
    if (book == null) {
      return;
    }
    final now = DateTime.now().toUtc();
    await _database.transaction(() async {
      await (_database.update(
        _database.books,
      )..where((Books row) => row.id.equals(bookId))).write(
        BooksCompanion(
          filePath: const Value<String?>(null),
          coverPath: const Value<String?>(null),
          deletedAt: Value<DateTime>(now),
        ),
      );
      await (_database.delete(
        _database.chapters,
      )..where((Chapters row) => row.bookId.equals(bookId))).go();
      await (_database.delete(
        _database.tocEntries,
      )..where((TocEntries row) => row.bookId.equals(bookId))).go();
      await (_database.delete(
        _database.paginationProfiles,
      )..where((PaginationProfiles row) => row.bookId.equals(bookId))).go();
    });
    await _deleteIfPresent(book.filePath);
    await _deleteIfPresent(book.coverPath);
    if (book.filePath case final String filePath) {
      await _deleteDirectoryIfPresent(
        path.join(path.dirname(filePath), '$bookId-resources'),
      );
    }
  }

  bool isSupportedPath(String filePath) {
    final extension = path.extension(filePath).toLowerCase();
    return extension == '.epub' || extension == '.txt';
  }

  Future<void> _storeBook({
    required String id,
    required ParsedBook parsed,
    required String filePath,
    required String? coverPath,
    required Map<String, String> resourcePaths,
  }) async {
    final now = DateTime.now().toUtc();
    final chapterIds = <int, String>{};
    final chapterRows = <ChaptersCompanion>[];
    final blockRows = <ContentBlocksCompanion>[];
    for (final chapter in parsed.chapters) {
      final chapterId = _uuid.v7();
      chapterIds[chapter.ordinal] = chapterId;
      chapterRows.add(
        ChaptersCompanion.insert(
          id: chapterId,
          bookId: id,
          ordinal: chapter.ordinal,
          title: Value<String?>(chapter.title),
          href: Value<String?>(chapter.href),
          plainText: chapter.plainText,
          lengthUtf16: chapter.plainText.length,
        ),
      );
      for (
        var blockIndex = 0;
        blockIndex < chapter.blocks.length;
        blockIndex++
      ) {
        final block = chapter.blocks[blockIndex];
        blockRows.add(
          ContentBlocksCompanion.insert(
            id: _uuid.v7(),
            chapterId: chapterId,
            ordinal: blockIndex,
            kind: block.kind.name,
            textContent: block.text,
            startOffset: block.startOffset,
            endOffset: block.endOffset,
            inlineSpansJson: Value<String>(
              jsonEncode(
                block.inlineSpans
                    .map((span) => span.toJson())
                    .toList(growable: false),
              ),
            ),
            resourcePath: Value<String?>(
              block.resourceHref == null
                  ? null
                  : resourcePaths[block.resourceHref],
            ),
            altText: Value<String?>(block.altText),
          ),
        );
      }
    }

    final tocRows = <TocEntriesCompanion>[
      for (final entry in parsed.toc)
        TocEntriesCompanion.insert(
          id: _uuid.v7(),
          bookId: id,
          ordinal: entry.ordinal,
          depth: Value<int>(entry.depth),
          title: entry.title,
          chapterId: Value<String?>(chapterIds[entry.chapterOrdinal]),
          textOffset: Value<int>(entry.textOffset),
        ),
    ];

    await _database.transaction(() async {
      await _database
          .into(_database.books)
          .insert(
            BooksCompanion.insert(
              id: id,
              format: parsed.format,
              title: parsed.title,
              author: Value<String?>(parsed.author),
              language: parsed.language,
              filePath: Value<String>(filePath),
              coverPath: Value<String?>(coverPath),
              contentHash: parsed.contentHash,
              totalLength: parsed.totalLength,
              lastOpenedAt: now,
              createdAt: Value<DateTime>(now),
            ),
          );
      await _database.batch((Batch batch) {
        batch.insertAll(_database.chapters, chapterRows);
        batch.insertAll(_database.contentBlocks, blockRows);
        batch.insertAll(_database.tocEntries, tocRows);
      });
    });
  }

  Future<void> _deleteIfPresent(String? filePath) async {
    if (filePath == null) {
      return;
    }
    final file = File(filePath);
    if (file.existsSync()) {
      await file.delete();
    }
  }

  Future<Map<String, String>> _storeResources({
    required List<ParsedResource> resources,
    required Directory directory,
  }) async {
    if (resources.isEmpty) {
      return const <String, String>{};
    }
    await directory.create(recursive: true);
    final result = <String, String>{};
    for (final resource in resources) {
      final digest = sha256.convert(utf8.encode(resource.href)).toString();
      final extension = switch (resource.mediaType) {
        'image/jpeg' => '.jpg',
        'image/png' => '.png',
        'image/gif' => '.gif',
        'image/webp' => '.webp',
        _ => path.extension(resource.href).toLowerCase(),
      };
      final file = File(
        path.join(directory.path, '${digest.substring(0, 24)}$extension'),
      );
      await file.writeAsBytes(resource.bytes, flush: true);
      result[resource.href] = file.path;
    }
    return Map<String, String>.unmodifiable(result);
  }

  Future<void> _deleteDirectoryIfPresent(String directoryPath) async {
    final directory = Directory(directoryPath);
    if (directory.existsSync()) {
      await directory.delete(recursive: true);
    }
  }
}
