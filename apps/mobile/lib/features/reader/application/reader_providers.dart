import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:selida/core/database/app_database.dart';
import 'package:selida/core/database/database_provider.dart';
import 'package:selida/features/reader/domain/reader_page.dart';

final StreamProvider<List<StoredBook>> libraryBooksProvider =
    StreamProvider<List<StoredBook>>((Ref ref) {
      return ref.watch(databaseProvider).watchActiveBooks();
    });

final readerDocumentProvider = FutureProvider.family<ReaderDocument?, String>((
  Ref ref,
  String bookId,
) async {
  final database = ref.watch(databaseProvider);
  final book = await database.findBook(bookId);
  if (book == null || book.deletedAt != null) {
    return null;
  }
  final chapters = await database.chaptersForBook(bookId);
  final toc = await database.tocForBook(bookId);
  final position = await database.positionForBook(bookId);
  return ReaderDocument(
    book: book,
    chapters: chapters,
    toc: toc,
    position: position,
  );
});

final readerPositionProvider =
    FutureProvider.family<StoredReaderPosition?, String>((
      Ref ref,
      String bookId,
    ) {
      return ref.watch(databaseProvider).positionForBook(bookId);
    });

final chapterBlocksProvider = FutureProvider.family<List<ReaderBlock>, String>((
  Ref ref,
  String chapterId,
) async {
  final rows = await ref.watch(databaseProvider).blocksForChapter(chapterId);
  return <ReaderBlock>[
    for (final row in rows)
      ReaderBlock(
        kind: switch (row.kind) {
          'heading' => ReaderBlockKind.heading,
          'quote' => ReaderBlockKind.quote,
          _ => ReaderBlockKind.paragraph,
        },
        text: row.textContent,
        startOffset: row.startOffset,
        endOffset: row.endOffset,
      ),
  ];
});

@immutable
final class ReaderDocument {
  const ReaderDocument({
    required this.book,
    required this.chapters,
    required this.toc,
    required this.position,
  });

  final StoredBook book;
  final List<StoredChapter> chapters;
  final List<StoredTocEntry> toc;
  final StoredReaderPosition? position;
}
