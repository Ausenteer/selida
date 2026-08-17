import 'package:flutter_test/flutter_test.dart';
import 'package:selida/features/reader/application/reader_search_controller.dart';

void main() {
  test('book search is case-insensitive and keeps exact offsets', () {
    const text = 'First chapter. She Walked home. Then she walked back.';

    final results = searchBookText(
      query: 'walked',
      chapters: const <ReaderSearchChapter>[
        ReaderSearchChapter(chapterIndex: 0, title: 'One', text: text),
      ],
    );

    expect(results, hasLength(2));
    expect(results.first.offset, text.indexOf('Walked'));
    expect(results.first.matchText, 'Walked');
    expect(results.last.offset, text.lastIndexOf('walked'));
  });

  test(
    'book search returns chapter identity and enforces its result limit',
    () {
      final results = searchBookText(
        query: 'word',
        maximumResults: 2,
        chapters: const <ReaderSearchChapter>[
          ReaderSearchChapter(
            chapterIndex: 3,
            title: 'Four',
            text: 'word word word',
          ),
        ],
      );

      expect(results, hasLength(2));
      expect(results.every((result) => result.chapterIndex == 3), isTrue);
      expect(results.every((result) => result.chapterTitle == 'Four'), isTrue);
    },
  );

  test('case-insensitive search keeps original UTF-16 offsets', () {
    final results = searchBookText(
      query: 'foo',
      chapters: const <ReaderSearchChapter>[
        ReaderSearchChapter(
          chapterIndex: 0,
          title: 'Unicode',
          text: 'İstanbul FOO',
        ),
      ],
    );

    expect(results, hasLength(1));
    expect(results.single.offset, 9);
    expect(results.single.matchText, 'FOO');
  });
}
