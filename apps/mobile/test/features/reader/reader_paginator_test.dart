import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:selida/features/reader/application/reader_paginator.dart';
import 'package:selida/features/reader/domain/reader_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('pagination preserves every UTF-16 code unit and page bounds', () {
    final firstText = List<String>.filled(
      20,
      'Reading in context makes unfamiliar words easier to remember.',
    ).join(' ');
    const secondText = 'Η Αθήνα έχει πολλές όμορφες ιστορίες και παλιά βιβλία.';
    final blocks = <ReaderBlock>[
      ReaderBlock(
        kind: ReaderBlockKind.paragraph,
        text: firstText,
        startOffset: 0,
        endOffset: firstText.length,
      ),
      ReaderBlock(
        kind: ReaderBlockKind.paragraph,
        text: secondText,
        startOffset: firstText.length + 2,
        endOffset: firstText.length + 2 + secondText.length,
      ),
    ];
    const spec = ReaderLayoutSpec(
      width: 300,
      height: 360,
      fontSize: 18,
      lineHeight: 1.55,
      locale: Locale('el'),
      textColor: Colors.black,
    );

    final pages = ReaderPaginator.paginate(blocks: blocks, spec: spec);
    final cursor = ReaderPaginator.start(blocks: blocks, spec: spec);
    final incrementalPages = <ReaderPage>[];
    while (!cursor.isComplete) {
      final page = cursor.nextPage();
      if (page != null) {
        incrementalPages.add(page);
      }
    }

    expect(pages.length, greaterThan(1));
    expect(incrementalPages.length, pages.length);
    expect(
      incrementalPages
          .expand((ReaderPage page) => page.segments)
          .map((ReaderPageSegment segment) => segment.text),
      pages
          .expand((ReaderPage page) => page.segments)
          .map((ReaderPageSegment segment) => segment.text),
    );
    expect(cursor.nextPage(), isNull);
    final firstSegments = pages
        .expand((ReaderPage page) => page.segments)
        .where(
          (ReaderPageSegment segment) => segment.globalStart < firstText.length,
        )
        .map((ReaderPageSegment segment) => segment.text)
        .join();
    final secondSegments = pages
        .expand((ReaderPage page) => page.segments)
        .where(
          (ReaderPageSegment segment) => segment.globalStart > firstText.length,
        )
        .map((ReaderPageSegment segment) => segment.text)
        .join();
    expect(firstSegments, firstText);
    expect(secondSegments, secondText);
    for (final page in pages) {
      final usedHeight = page.segments.isEmpty
          ? 0.0
          : page.segments.last.top + page.segments.last.height;
      expect(usedHeight, lessThanOrEqualTo(spec.height + 0.01));
    }
  });
}
