import 'package:flutter_test/flutter_test.dart';
import 'package:selida/features/reader/application/reader_book_navigation.dart';

void main() {
  test('book progress includes all preceding chapters', () {
    final navigation = ReaderBookNavigation(<int>[100, 200, 300]);

    expect(navigation.progressFor(chapterIndex: 1, textOffset: 50), 0.25);
  });

  test('book progress resolves a chapter and local text offset', () {
    final navigation = ReaderBookNavigation(<int>[100, 200, 300]);

    final location = navigation.locationForProgress(
      progress: 0.25,
      fallbackChapterIndex: 0,
    );

    expect(location.chapterIndex, 1);
    expect(location.textOffset, 50);
  });

  test('book progress clamps both ends', () {
    final navigation = ReaderBookNavigation(<int>[10, 20]);

    final start = navigation.locationForProgress(
      progress: -1,
      fallbackChapterIndex: 0,
    );
    final end = navigation.locationForProgress(
      progress: 2,
      fallbackChapterIndex: 0,
    );

    expect((start.chapterIndex, start.textOffset), (0, 0));
    expect((end.chapterIndex, end.textOffset), (1, 19));
  });
}
