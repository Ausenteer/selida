import 'dart:isolate';

final class ReaderSearchChapter {
  const ReaderSearchChapter({
    required this.chapterIndex,
    required this.title,
    required this.text,
  });

  final int chapterIndex;
  final String title;
  final String text;
}

final class ReaderSearchResult {
  const ReaderSearchResult({
    required this.chapterIndex,
    required this.chapterTitle,
    required this.offset,
    required this.length,
    required this.leadingText,
    required this.matchText,
    required this.trailingText,
  });

  final int chapterIndex;
  final String chapterTitle;
  final int offset;
  final int length;
  final String leadingText;
  final String matchText;
  final String trailingText;
}

final class ReaderSearchController {
  const ReaderSearchController();

  Future<List<ReaderSearchResult>> search({
    required String query,
    required List<ReaderSearchChapter> chapters,
    int maximumResults = 100,
  }) {
    final normalizedQuery = query.trim();
    if (normalizedQuery.isEmpty || chapters.isEmpty || maximumResults <= 0) {
      return Future<List<ReaderSearchResult>>.value(
        const <ReaderSearchResult>[],
      );
    }
    return Isolate.run<List<ReaderSearchResult>>(
      () => searchBookText(
        query: normalizedQuery,
        chapters: chapters,
        maximumResults: maximumResults,
      ),
    );
  }
}

List<ReaderSearchResult> searchBookText({
  required String query,
  required List<ReaderSearchChapter> chapters,
  int maximumResults = 100,
}) {
  final needle = query.trim();
  if (needle.isEmpty || maximumResults <= 0) {
    return const <ReaderSearchResult>[];
  }
  final pattern = RegExp(
    RegExp.escape(needle),
    caseSensitive: false,
    unicode: true,
  );
  final results = <ReaderSearchResult>[];
  for (final chapter in chapters) {
    for (final match in pattern.allMatches(chapter.text)) {
      if (results.length >= maximumResults) {
        break;
      }
      final offset = match.start;
      final end = match.end;
      final contextStart = _contextBoundary(
        chapter.text,
        offset,
        direction: -1,
      );
      final contextEnd = _contextBoundary(chapter.text, end, direction: 1);
      results.add(
        ReaderSearchResult(
          chapterIndex: chapter.chapterIndex,
          chapterTitle: chapter.title,
          offset: offset,
          length: end - offset,
          leadingText: _cleanSnippet(
            chapter.text.substring(contextStart, offset),
          ),
          matchText: chapter.text.substring(offset, end),
          trailingText: _cleanSnippet(chapter.text.substring(end, contextEnd)),
        ),
      );
    }
    if (results.length >= maximumResults) {
      break;
    }
  }
  return List<ReaderSearchResult>.unmodifiable(results);
}

int _contextBoundary(String text, int offset, {required int direction}) {
  final hardLimit = direction < 0
      ? (offset - 56).clamp(0, text.length)
      : (offset + 72).clamp(0, text.length);
  var cursor = offset.clamp(0, text.length);
  while (cursor != hardLimit) {
    cursor += direction;
    final unit = text.codeUnitAt(direction < 0 ? cursor : cursor - 1);
    if (unit == 0x0a || unit == 0x2e || unit == 0x21 || unit == 0x3f) {
      break;
    }
  }
  return cursor;
}

String _cleanSnippet(String value) {
  return value.replaceAll(RegExp(r'\s+'), ' ').trim();
}
