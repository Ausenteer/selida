import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:selida/features/reader/application/reader_paginator.dart';
import 'package:selida/features/reader/domain/reader_page.dart';
import 'package:selida/features/reader/presentation/reader_page_surface.dart';

void main() {
  testWidgets('tap maps to a Greek word and its source offset', (
    WidgetTester tester,
  ) async {
    const text = 'Αθήνα διαβάζει';
    const spec = ReaderLayoutSpec(
      width: 280,
      height: 200,
      fontSize: 20,
      lineHeight: 1.5,
      locale: Locale('el'),
      textColor: Colors.black,
    );
    final page = ReaderPaginator.paginate(
      blocks: const <ReaderBlock>[
        ReaderBlock(
          kind: ReaderBlockKind.heading,
          text: text,
          startOffset: 40,
          endOffset: 54,
        ),
      ],
      spec: spec,
    ).single;
    ReaderWordHit? result;

    await tester.pumpWidget(
      MaterialApp(
        home: Center(
          child: SizedBox(
            width: 280,
            height: 200,
            child: ReaderPageSurface(
              page: page,
              spec: spec,
              onWordTap: (ReaderWordHit hit) => result = hit,
              onBlankTap: (_) {},
            ),
          ),
        ),
      ),
    );
    final origin = tester.getTopLeft(find.byType(ReaderPageSurface));
    await tester.tapAt(origin + const Offset(20, 20));
    await tester.pump();

    expect(result?.word, 'Αθήνα');
    expect(result?.startOffset, 40);
    expect(result?.endOffset, 45);
  });

  testWidgets('long press drag returns a bounded phrase selection', (
    WidgetTester tester,
  ) async {
    const text = 'one two three four';
    const spec = ReaderLayoutSpec(
      width: 320,
      height: 200,
      fontSize: 20,
      lineHeight: 1.5,
      locale: Locale('en'),
      textColor: Colors.black,
    );
    final page = ReaderPaginator.paginate(
      blocks: const <ReaderBlock>[
        ReaderBlock(
          kind: ReaderBlockKind.heading,
          text: text,
          startOffset: 10,
          endOffset: 28,
        ),
      ],
      spec: spec,
    ).single;
    ReaderTextSelection? result;
    var edgeDirection = 0;
    final textPainter = ReaderPaginator.createPainter(
      text: text,
      kind: ReaderBlockKind.heading,
      spec: spec,
    )..layout(maxWidth: spec.width);
    final startBox = textPainter
        .getBoxesForSelection(
          const TextSelection(baseOffset: 4, extentOffset: 7),
        )
        .single
        .toRect();
    final endBox = textPainter
        .getBoxesForSelection(
          const TextSelection(baseOffset: 14, extentOffset: 18),
        )
        .single
        .toRect();
    textPainter.dispose();

    await tester.pumpWidget(
      MaterialApp(
        home: Center(
          child: SizedBox(
            width: 320,
            height: 200,
            child: ReaderPageSurface(
              page: page,
              spec: spec,
              onWordTap: (_) {},
              onBlankTap: (_) {},
              onSelectionChanged: (ReaderTextRange? value) {
                result = value == null
                    ? null
                    : ReaderTextSelection(
                        startOffset: value.startOffset,
                        endOffset: value.endOffset,
                      );
              },
              onSelectionEdgeRequested: (int value) => edgeDirection = value,
            ),
          ),
        ),
      ),
    );
    final origin = tester.getTopLeft(find.byType(ReaderPageSurface));
    final gesture = await tester.startGesture(origin + startBox.center);
    await tester.pump(const Duration(milliseconds: 600));
    await gesture.moveTo(origin + endBox.center);
    await tester.pump();
    await gesture.up();
    await tester.pump();

    expect(result?.startOffset, 14);
    expect(result?.endOffset, 28);
    expect(text.substring(4, 18), 'two three four');
    expect(
      find.byKey(const ValueKey<String>('selection-start-handle')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey<String>('selection-end-handle')),
      findsOneWidget,
    );
    final endHandle = find.byKey(
      const ValueKey<String>('selection-end-handle'),
    );
    final handleGesture = await tester.startGesture(
      tester.getCenter(endHandle),
    );
    await handleGesture.moveTo(origin + const Offset(319, 30));
    await tester.pump();
    await handleGesture.up();
    expect(edgeDirection, 1);
  });

  testWidgets('a tap outside the actual glyphs is treated as blank space', (
    WidgetTester tester,
  ) async {
    const spec = ReaderLayoutSpec(
      width: 320,
      height: 160,
      fontSize: 20,
      lineHeight: 1.5,
      locale: Locale('en'),
      textColor: Colors.black,
    );
    final page = ReaderPaginator.paginate(
      blocks: const <ReaderBlock>[
        ReaderBlock(
          kind: ReaderBlockKind.heading,
          text: 'one two',
          startOffset: 0,
          endOffset: 7,
        ),
      ],
      spec: spec,
    ).single;
    var blankTapped = false;
    ReaderWordHit? word;

    await tester.pumpWidget(
      MaterialApp(
        home: SizedBox(
          width: 320,
          height: 160,
          child: ReaderPageSurface(
            page: page,
            spec: spec,
            onWordTap: (ReaderWordHit value) => word = value,
            onBlankTap: (_) => blankTapped = true,
          ),
        ),
      ),
    );
    final origin = tester.getTopLeft(find.byType(ReaderPageSurface));
    await tester.tapAt(origin + const Offset(250, 20));
    await tester.pump();

    expect(blankTapped, isTrue);
    expect(word, isNull);
  });

  testWidgets('a word at the page edge remains tappable', (
    WidgetTester tester,
  ) async {
    const spec = ReaderLayoutSpec(
      width: 320,
      height: 160,
      fontSize: 20,
      lineHeight: 1.5,
      locale: Locale('en'),
      textColor: Colors.black,
    );
    final page = ReaderPaginator.paginate(
      blocks: const <ReaderBlock>[
        ReaderBlock(
          kind: ReaderBlockKind.heading,
          text: 'one two',
          startOffset: 0,
          endOffset: 7,
        ),
      ],
      spec: spec,
    ).single;
    var blankTapped = false;
    ReaderWordHit? word;

    await tester.pumpWidget(
      MaterialApp(
        home: SizedBox(
          width: 320,
          height: 160,
          child: ReaderPageSurface(
            page: page,
            spec: spec,
            onWordTap: (ReaderWordHit value) => word = value,
            onBlankTap: (_) => blankTapped = true,
          ),
        ),
      ),
    );
    final origin = tester.getTopLeft(find.byType(ReaderPageSurface));
    await tester.tapAt(origin + const Offset(20, 20));
    await tester.pump();

    expect(blankTapped, isFalse);
    expect(word?.word, 'one');
  });

  testWidgets('a horizontal swipe turns the page', (WidgetTester tester) async {
    const spec = ReaderLayoutSpec(
      width: 320,
      height: 160,
      fontSize: 20,
      lineHeight: 1.5,
      locale: Locale('en'),
      textColor: Colors.black,
    );
    final text = List<String>.filled(80, 'word').join(' ');
    final pages = ReaderPaginator.paginate(
      blocks: <ReaderBlock>[
        ReaderBlock(
          kind: ReaderBlockKind.paragraph,
          text: text,
          startOffset: 0,
          endOffset: text.length,
        ),
      ],
      spec: spec,
    );
    expect(pages.length, greaterThan(1));
    var currentPage = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 320,
              height: 160,
              child: PageView.builder(
                itemCount: pages.length,
                onPageChanged: (int page) => currentPage = page,
                itemBuilder: (BuildContext context, int index) =>
                    ReaderPageSurface(
                      page: pages[index],
                      spec: spec,
                      onWordTap: (_) {},
                      onBlankTap: (_) {},
                    ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.fling(find.byType(PageView), const Offset(-260, 0), 1200);
    await tester.pumpAndSettle();

    expect(currentPage, 1);
  });
}
