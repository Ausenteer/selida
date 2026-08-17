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

  test('selection extends from the end of one chapter into the next', () {
    const controller = ReaderSelectionController();

    final selection = controller.extendAcrossChapter(
      currentChapterIndex: 0,
      targetChapterIndex: 1,
      currentSelection: const ReaderTextRange(startOffset: 4, endOffset: 7),
      currentChapterText: 'The ending',
      targetChapterText: 'Next chapter starts here.',
      direction: 1,
    );

    expect(selection?.firstRange.startOffset, 4);
    expect(selection?.firstRange.endOffset, 10);
    expect(selection?.secondRange.startOffset, 0);
    expect(selection?.secondRange.endOffset, 4);
    expect(
      selection?.selectedText(const <String>[
        'The ending',
        'Next chapter starts here.',
      ]),
      'ending\n\nNext',
    );
  });

  test('selection extends backward across a chapter boundary', () {
    const controller = ReaderSelectionController();

    final selection = controller.extendAcrossChapter(
      currentChapterIndex: 1,
      targetChapterIndex: 0,
      currentSelection: const ReaderTextRange(startOffset: 0, endOffset: 4),
      currentChapterText: 'Next chapter',
      targetChapterText: 'Previous ending',
      direction: -1,
    );

    expect(selection?.firstRange.startOffset, 9);
    expect(selection?.firstRange.endOffset, 15);
    expect(selection?.secondRange.startOffset, 0);
    expect(selection?.secondRange.endOffset, 4);
    expect(
      selection?.selectedText(const <String>[
        'Previous ending',
        'Next chapter',
      ]),
      'ending\n\nNext',
    );
  });
}
