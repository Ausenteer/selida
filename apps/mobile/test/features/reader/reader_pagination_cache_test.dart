import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:selida/core/database/app_database.dart';
import 'package:selida/features/reader/application/reader_pagination_cache.dart';
import 'package:selida/features/reader/application/reader_paginator.dart';
import 'package:selida/features/reader/domain/reader_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('pagination cache persists and reuses page ranges', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final now = DateTime.utc(2026, 7, 21);
    final text = List<String>.filled(
      24,
      'Reading in context makes unfamiliar words easier to remember.',
    ).join(' ');
    await database
        .into(database.books)
        .insert(
          BooksCompanion.insert(
            id: 'book-1',
            format: 'txt',
            title: 'Example',
            language: 'en',
            contentHash: 'hash-1',
            totalLength: text.length,
            lastOpenedAt: now,
          ),
        );
    await database
        .into(database.chapters)
        .insert(
          ChaptersCompanion.insert(
            id: 'chapter-1',
            bookId: 'book-1',
            ordinal: 0,
            plainText: text,
            lengthUtf16: text.length,
          ),
        );
    final blocks = <ReaderBlock>[
      ReaderBlock(
        kind: ReaderBlockKind.paragraph,
        text: text,
        startOffset: 0,
        endOffset: text.length,
      ),
    ];
    const spec = ReaderLayoutSpec(
      width: 300,
      height: 360,
      fontSize: 18,
      lineHeight: 1.55,
      locale: Locale('en'),
      textColor: Colors.black,
    );
    final pages = ReaderPaginator.paginate(blocks: blocks, spec: spec);
    final cache = ReaderPaginationCache(database);
    final identity = cache.identityFor(spec);

    await cache.store(
      bookId: 'book-1',
      chapterId: 'chapter-1',
      spec: spec,
      identity: identity,
      pages: pages,
    );
    await cache.store(
      bookId: 'book-1',
      chapterId: 'chapter-1',
      spec: spec,
      identity: identity,
      pages: pages,
    );

    final ranges = await cache.load(
      bookId: 'book-1',
      chapterId: 'chapter-1',
      identity: identity,
      maximumOffset: text.length,
    );
    final profiles = await database.select(database.paginationProfiles).get();
    final storedPages = await database.select(database.bookPages).get();
    expect(profiles, hasLength(1));
    expect(storedPages, hasLength(pages.length));
    expect(
      ranges?.map((CachedReaderPageRange range) => range.startOffset),
      pages.map((ReaderPage page) => page.startOffset),
    );
    expect(
      ranges?.map((CachedReaderPageRange range) => range.endOffset),
      pages.map((ReaderPage page) => page.endOffset),
    );
  });

  test('pagination fingerprint ignores paint-only colors', () {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final cache = ReaderPaginationCache(database);
    const lightSpec = ReaderLayoutSpec(
      width: 300,
      height: 500,
      fontSize: 18,
      lineHeight: 1.55,
      locale: Locale('en'),
      textColor: Colors.black,
    );
    const darkSpec = ReaderLayoutSpec(
      width: 300,
      height: 500,
      fontSize: 18,
      lineHeight: 1.55,
      locale: Locale('en'),
      textColor: Colors.white,
    );
    const modernSpec = ReaderLayoutSpec(
      width: 300,
      height: 500,
      fontSize: 18,
      lineHeight: 1.55,
      locale: Locale('en'),
      textColor: Colors.black,
      paragraphStyle: ReaderParagraphStyle.modern,
    );

    expect(
      cache.identityFor(lightSpec).fingerprint,
      cache.identityFor(darkSpec).fingerprint,
    );
    expect(
      cache.identityFor(lightSpec).fingerprint,
      isNot(cache.identityFor(modernSpec).fingerprint),
    );
  });
}
