import 'dart:math' as math;

import 'package:selida/features/reader/domain/reader_page.dart';

final class ReaderBoundarySwipeTracker {
  static const double chapterChangeThreshold = 32;

  double _distance = 0;
  int _direction = 0;

  void begin() {
    _distance = 0;
    _direction = 0;
  }

  void addOverscroll({
    required double overscroll,
    required bool isAtPageBoundary,
    required bool hasAdjacentChapter,
  }) {
    if (!isAtPageBoundary || !hasAdjacentChapter || overscroll == 0) {
      return;
    }
    final direction = overscroll > 0 ? 1 : -1;
    if (_direction != direction) {
      _distance = 0;
    }
    _direction = direction;
    _distance += overscroll.abs();
  }

  int? end({required int chapterIndex, required int chapterCount}) {
    final direction = _direction;
    final shouldChangeChapter =
        direction != 0 &&
        _distance >= chapterChangeThreshold &&
        chapterIndex + direction >= 0 &&
        chapterIndex + direction < chapterCount;
    begin();
    return shouldChangeChapter ? direction : null;
  }
}

final class ReaderSelectionController {
  const ReaderSelectionController();

  ReaderTextRange? extendAcrossPage({
    required ReaderTextRange selection,
    required ReaderPage targetPage,
    required String chapterText,
    required int direction,
    int maximumLength = 1000,
  }) {
    final boundary = _wordAtPageBoundary(
      targetPage,
      chapterText: chapterText,
      fromStart: direction > 0,
    );
    if (boundary == null) {
      return null;
    }
    return direction > 0
        ? ReaderTextRange(
            startOffset: selection.startOffset,
            endOffset: math.min(
              math.max(selection.endOffset, boundary.endOffset),
              selection.startOffset + maximumLength,
            ),
          )
        : ReaderTextRange(
            startOffset: math.max(
              math.min(selection.startOffset, boundary.startOffset),
              selection.endOffset - maximumLength,
            ),
            endOffset: selection.endOffset,
          );
  }

  ReaderTextRange? _wordAtPageBoundary(
    ReaderPage page, {
    required String chapterText,
    required bool fromStart,
  }) {
    if (chapterText.isEmpty) {
      return null;
    }
    if (fromStart) {
      var start = page.startOffset.clamp(0, chapterText.length);
      final endLimit = page.endOffset.clamp(start, chapterText.length);
      while (start < endLimit && !_isWordRune(chapterText.codeUnitAt(start))) {
        start += 1;
      }
      var end = start;
      while (end < endLimit && _isWordRune(chapterText.codeUnitAt(end))) {
        end += 1;
      }
      return end > start
          ? ReaderTextRange(startOffset: start, endOffset: end)
          : null;
    }
    var end = page.endOffset.clamp(0, chapterText.length);
    final startLimit = page.startOffset.clamp(0, end);
    while (end > startLimit && !_isWordRune(chapterText.codeUnitAt(end - 1))) {
      end -= 1;
    }
    var start = end;
    while (start > startLimit &&
        _isWordRune(chapterText.codeUnitAt(start - 1))) {
      start -= 1;
    }
    return end > start
        ? ReaderTextRange(startOffset: start, endOffset: end)
        : null;
  }

  bool _isWordRune(int rune) {
    return (rune >= 0x0041 && rune <= 0x005a) ||
        (rune >= 0x0061 && rune <= 0x007a) ||
        (rune >= 0x0370 && rune <= 0x03ff) ||
        (rune >= 0x1f00 && rune <= 0x1fff) ||
        (rune >= 0x0400 && rune <= 0x052f) ||
        rune == 0x0027 ||
        rune == 0x2019 ||
        rune == 0x002d;
  }
}
