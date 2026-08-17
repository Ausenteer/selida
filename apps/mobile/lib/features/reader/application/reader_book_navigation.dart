import 'dart:math' as math;

final class ReaderLocation {
  const ReaderLocation({required this.chapterIndex, required this.textOffset});

  final int chapterIndex;
  final int textOffset;
}

final class ReaderBookNavigation {
  ReaderBookNavigation(Iterable<int> chapterLengths)
    : chapterLengths = List<int>.unmodifiable(
        chapterLengths.map((int length) => math.max(0, length)),
      );

  final List<int> chapterLengths;

  int get totalLength => chapterLengths.fold<int>(
    0,
    (int total, int chapterLength) => total + chapterLength,
  );

  double progressFor({required int chapterIndex, required int textOffset}) {
    var consumed = textOffset;
    for (var index = 0; index < chapterIndex; index += 1) {
      consumed += chapterLengths[index];
    }
    final total = totalLength;
    return total <= 0 ? 0 : (consumed / total).clamp(0, 1);
  }

  ReaderLocation locationForProgress({
    required double progress,
    required int fallbackChapterIndex,
  }) {
    if (chapterLengths.isEmpty) {
      return const ReaderLocation(chapterIndex: 0, textOffset: 0);
    }
    final total = totalLength;
    if (total <= 0) {
      return ReaderLocation(
        chapterIndex: fallbackChapterIndex.clamp(0, chapterLengths.length - 1),
        textOffset: 0,
      );
    }
    final target = (progress.clamp(0, 1) * math.max(0, total - 1)).round();
    var consumed = 0;
    for (var index = 0; index < chapterLengths.length; index += 1) {
      final chapterLength = chapterLengths[index];
      final isLast = index == chapterLengths.length - 1;
      if (target < consumed + chapterLength || isLast) {
        return ReaderLocation(
          chapterIndex: index,
          textOffset: (target - consumed).clamp(
            0,
            math.max(0, chapterLength - 1),
          ),
        );
      }
      consumed += chapterLength;
    }
    return ReaderLocation(
      chapterIndex: chapterLengths.length - 1,
      textOffset: math.max(0, chapterLengths.last - 1),
    );
  }
}
