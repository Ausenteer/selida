import 'package:flutter_test/flutter_test.dart';
import 'package:selida/features/reader/application/reader_interaction_controller.dart';
import 'package:selida/features/reader/domain/reader_page.dart';

void main() {
  test('boundary swipe changes chapter only after the threshold', () {
    final tracker = ReaderBoundarySwipeTracker()..begin();
    tracker.addOverscroll(
      overscroll: 20,
      isAtPageBoundary: true,
      hasAdjacentChapter: true,
    );
    tracker.addOverscroll(
      overscroll: 13,
      isAtPageBoundary: true,
      hasAdjacentChapter: true,
    );

    expect(tracker.end(chapterIndex: 0, chapterCount: 2), 1);
  });

  test('boundary swipe ignores movement below the threshold', () {
    final tracker = ReaderBoundarySwipeTracker()..begin();
    tracker.addOverscroll(
      overscroll: -20,
      isAtPageBoundary: true,
      hasAdjacentChapter: true,
    );

    expect(tracker.end(chapterIndex: 1, chapterCount: 2), isNull);
  });

  test('selection extends to the first word on the next page', () {
    const controller = ReaderSelectionController();
    const text = 'first page.   next word';
    const page = ReaderPage(
      segments: <ReaderPageSegment>[
        ReaderPageSegment(
          kind: ReaderBlockKind.paragraph,
          text: '   next word',
          globalStart: 11,
          globalEnd: 23,
          indentFirstLine: false,
          top: 0,
          height: 20,
        ),
      ],
    );

    final selection = controller.extendAcrossPage(
      selection: const ReaderTextRange(startOffset: 0, endOffset: 5),
      targetPage: page,
      chapterText: text,
      direction: 1,
    );

    expect(selection?.startOffset, 0);
    expect(selection?.endOffset, 18);
  });

  test('selection extension respects the maximum length', () {
    const controller = ReaderSelectionController();
    const text = 'start next';
    const page = ReaderPage(
      segments: <ReaderPageSegment>[
        ReaderPageSegment(
          kind: ReaderBlockKind.paragraph,
          text: ' next',
          globalStart: 5,
          globalEnd: 10,
          indentFirstLine: false,
          top: 0,
          height: 20,
        ),
      ],
    );

    final selection = controller.extendAcrossPage(
      selection: const ReaderTextRange(startOffset: 0, endOffset: 5),
      targetPage: page,
      chapterText: text,
      direction: 1,
      maximumLength: 7,
    );

    expect(selection?.endOffset, 7);
  });
}
