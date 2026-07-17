import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

@DataClassName('StoredBook')
class Books extends Table {
  TextColumn get id => text()();
  TextColumn get syncKey => text().nullable()();
  TextColumn get format => text()();
  TextColumn get title => text()();
  TextColumn get author => text().nullable()();
  TextColumn get language => text()();
  TextColumn get filePath => text().nullable()();
  TextColumn get coverPath => text().nullable()();
  TextColumn get contentHash => text()();
  IntColumn get totalLength => integer()();
  DateTimeColumn get lastOpenedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}

@DataClassName('StoredChapter')
class Chapters extends Table {
  TextColumn get id => text()();
  TextColumn get bookId =>
      text().references(Books, #id, onDelete: KeyAction.cascade)();
  IntColumn get ordinal => integer()();
  TextColumn get title => text().nullable()();
  TextColumn get href => text().nullable()();
  TextColumn get plainText => text()();
  IntColumn get lengthUtf16 => integer()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}

@DataClassName('StoredContentBlock')
class ContentBlocks extends Table {
  TextColumn get id => text()();
  TextColumn get chapterId =>
      text().references(Chapters, #id, onDelete: KeyAction.cascade)();
  IntColumn get ordinal => integer()();
  TextColumn get kind => text()();
  TextColumn get textContent => text()();
  IntColumn get startOffset => integer()();
  IntColumn get endOffset => integer()();
  TextColumn get inlineSpansJson => text().withDefault(const Constant('[]'))();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}

@DataClassName('StoredTocEntry')
class TocEntries extends Table {
  TextColumn get id => text()();
  TextColumn get bookId =>
      text().references(Books, #id, onDelete: KeyAction.cascade)();
  TextColumn get parentId => text().nullable()();
  IntColumn get ordinal => integer()();
  IntColumn get depth => integer().withDefault(const Constant(0))();
  TextColumn get title => text()();
  TextColumn get chapterId => text().nullable()();
  IntColumn get textOffset => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}

@DataClassName('StoredPaginationProfile')
class PaginationProfiles extends Table {
  TextColumn get id => text()();
  TextColumn get bookId =>
      text().references(Books, #id, onDelete: KeyAction.cascade)();
  TextColumn get fingerprint => text()();
  RealColumn get viewportWidth => real()();
  RealColumn get viewportHeight => real()();
  TextColumn get settingsJson => text()();
  IntColumn get algorithmVersion => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}

@DataClassName('StoredPage')
class BookPages extends Table {
  TextColumn get id => text()();
  TextColumn get profileId =>
      text().references(PaginationProfiles, #id, onDelete: KeyAction.cascade)();
  TextColumn get chapterId =>
      text().references(Chapters, #id, onDelete: KeyAction.cascade)();
  IntColumn get pageIndex => integer()();
  IntColumn get startOffset => integer()();
  IntColumn get endOffset => integer()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}

@DataClassName('StoredReaderPosition')
class ReaderPositions extends Table {
  TextColumn get bookId => text()();
  TextColumn get chapterId => text()();
  IntColumn get textOffset => integer()();
  RealColumn get progress => real()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{bookId};
}

@DataClassName('StoredVocabularyItem')
class VocabularyItems extends Table {
  TextColumn get id => text()();
  TextColumn get sourceLanguage => text()();
  TextColumn get targetLanguage => text()();
  TextColumn get lemma => text()();
  TextColumn get normalizedLemma => text()();
  TextColumn get translation => text()();
  TextColumn get kind => text().withDefault(const Constant('word'))();
  TextColumn get partOfSpeech => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('new'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  IntColumn get serverRevision => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}

@DataClassName('StoredWordOccurrence')
class WordOccurrences extends Table {
  TextColumn get id => text()();
  TextColumn get vocabularyId =>
      text().references(VocabularyItems, #id, onDelete: KeyAction.cascade)();
  TextColumn get surfaceForm => text()();
  TextColumn get contextSentence => text()();
  IntColumn get wordStart => integer()();
  IntColumn get wordEnd => integer()();
  TextColumn get sourceBookId => text().nullable()();
  TextColumn get sourceBookTitle => text()();
  TextColumn get sourceChapterId => text().nullable()();
  TextColumn get sourceChapterTitle => text().nullable()();
  IntColumn get sourceOffset => integer().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}

@DataClassName('StoredSrsCard')
class SrsCards extends Table {
  TextColumn get id => text()();
  TextColumn get vocabularyId => text().unique().references(
    VocabularyItems,
    #id,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get algorithm => text()();
  IntColumn get algorithmVersion => integer()();
  TextColumn get stateJson => text()();
  DateTimeColumn get dueAt => dateTime()();
  DateTimeColumn get lastReviewedAt => dateTime().nullable()();
  IntColumn get serverRevision => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}

@DataClassName('StoredReviewEvent')
class ReviewEvents extends Table {
  TextColumn get id => text()();
  TextColumn get cardId =>
      text().references(SrsCards, #id, onDelete: KeyAction.cascade)();
  IntColumn get rating => integer()();
  DateTimeColumn get reviewedAt => dateTime()();
  TextColumn get stateBeforeJson => text()();
  TextColumn get stateAfterJson => text()();
  IntColumn get durationMs => integer().nullable()();
  IntColumn get serverRevision => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}

@DataClassName('StoredSetting')
class LocalSettings extends Table {
  TextColumn get key => text()();
  TextColumn get valueJson => text()();
  DateTimeColumn get updatedAt => dateTime()();
  IntColumn get serverRevision => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{key};
}

@DataClassName('StoredTranslationCacheEntry')
class TranslationCacheEntries extends Table {
  TextColumn get cacheKey => text()();
  TextColumn get requestKind => text()();
  TextColumn get resultJson => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{cacheKey};
}

@DataClassName('StoredSyncOutboxEntry')
class SyncOutboxEntries extends Table {
  TextColumn get mutationId => text()();
  TextColumn get entityType => text()();
  TextColumn get entityId => text()();
  TextColumn get operation => text()();
  TextColumn get payloadJson => text()();
  IntColumn get attempts => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get nextAttemptAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{mutationId};
}

@DataClassName('StoredSyncState')
class SyncStates extends Table {
  TextColumn get accountId => text()();
  IntColumn get serverCursor => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastSuccessfulSyncAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{accountId};
}

@DriftDatabase(
  tables: <Type>[
    Books,
    Chapters,
    ContentBlocks,
    TocEntries,
    PaginationProfiles,
    BookPages,
    ReaderPositions,
    VocabularyItems,
    WordOccurrences,
    SrsCards,
    ReviewEvents,
    LocalSettings,
    TranslationCacheEntries,
    SyncOutboxEntries,
    SyncStates,
  ],
)
final class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  AppDatabase.defaults()
    : super(
        driftDatabase(
          name: 'selida',
          native: const DriftNativeOptions(shareAcrossIsolates: true),
        ),
      );

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator migrator) => migrator.createAll(),
    onUpgrade: (Migrator migrator, int from, int to) async {
      if (from < 2) {
        await migrator.addColumn(
          wordOccurrences,
          wordOccurrences.sourceChapterId,
        );
      }
      if (from < 3) {
        await migrator.addColumn(vocabularyItems, vocabularyItems.kind);
      }
    },
    beforeOpen: (OpeningDetails details) async {
      await customStatement('PRAGMA foreign_keys = ON');
      await customStatement('PRAGMA journal_mode = WAL');
    },
  );

  Stream<List<StoredBook>> watchActiveBooks() {
    final query = select(books)
      ..where((Books row) => row.deletedAt.isNull())
      ..orderBy(<OrderingTerm Function(Books)>[
        (Books row) => OrderingTerm.desc(row.lastOpenedAt),
      ]);
    return query.watch();
  }

  Future<StoredBook?> findActiveBookByHash(String hash) {
    final query = select(books)
      ..where(
        (Books row) => row.contentHash.equals(hash) & row.deletedAt.isNull(),
      )
      ..limit(1);
    return query.getSingleOrNull();
  }

  Future<StoredBook?> findBook(String id) {
    final query = select(books)..where((Books row) => row.id.equals(id));
    return query.getSingleOrNull();
  }

  Future<void> markBookOpened(String id) {
    final now = DateTime.now().toUtc();
    return (update(books)..where((Books row) => row.id.equals(id))).write(
      BooksCompanion(lastOpenedAt: Value<DateTime>(now)),
    );
  }

  Future<void> updateBookLanguage(String id, String language) {
    return (update(books)..where((Books row) => row.id.equals(id))).write(
      BooksCompanion(language: Value<String>(language)),
    );
  }

  Future<List<StoredChapter>> chaptersForBook(String bookId) {
    final query = select(chapters)
      ..where((Chapters row) => row.bookId.equals(bookId))
      ..orderBy(<OrderingTerm Function(Chapters)>[
        (Chapters row) => OrderingTerm.asc(row.ordinal),
      ]);
    return query.get();
  }

  Future<List<StoredContentBlock>> blocksForChapter(String chapterId) {
    final query = select(contentBlocks)
      ..where((ContentBlocks row) => row.chapterId.equals(chapterId))
      ..orderBy(<OrderingTerm Function(ContentBlocks)>[
        (ContentBlocks row) => OrderingTerm.asc(row.ordinal),
      ]);
    return query.get();
  }

  Future<List<StoredTocEntry>> tocForBook(String bookId) {
    final query = select(tocEntries)
      ..where((TocEntries row) => row.bookId.equals(bookId))
      ..orderBy(<OrderingTerm Function(TocEntries)>[
        (TocEntries row) => OrderingTerm.asc(row.ordinal),
      ]);
    return query.get();
  }

  Future<StoredReaderPosition?> positionForBook(String bookId) {
    final query = select(readerPositions)
      ..where((ReaderPositions row) => row.bookId.equals(bookId));
    return query.getSingleOrNull();
  }

  Future<String?> localSettingValue(String key) async {
    final query = select(localSettings)
      ..where((LocalSettings row) => row.key.equals(key));
    return (await query.getSingleOrNull())?.valueJson;
  }

  Future<void> saveLocalSettingValue({
    required String key,
    required String valueJson,
  }) {
    return into(localSettings).insertOnConflictUpdate(
      LocalSettingsCompanion.insert(
        key: key,
        valueJson: valueJson,
        updatedAt: DateTime.now().toUtc(),
      ),
    );
  }

  Future<StoredTranslationCacheEntry?> translationCacheEntry(String key) {
    final query = select(translationCacheEntries)
      ..where((TranslationCacheEntries row) => row.cacheKey.equals(key));
    return query.getSingleOrNull();
  }

  Future<void> saveTranslationCacheEntry({
    required String key,
    required String requestKind,
    required String resultJson,
  }) {
    return into(translationCacheEntries).insertOnConflictUpdate(
      TranslationCacheEntriesCompanion.insert(
        cacheKey: key,
        requestKind: requestKind,
        resultJson: resultJson,
        createdAt: Value<DateTime>(DateTime.now().toUtc()),
      ),
    );
  }

  Stream<List<StoredVocabularyItem>> watchActiveVocabularyItems() {
    final query = select(vocabularyItems)
      ..where((VocabularyItems row) => row.deletedAt.isNull())
      ..orderBy(<OrderingTerm Function(VocabularyItems)>[
        (VocabularyItems row) => OrderingTerm.desc(row.updatedAt),
      ]);
    return query.watch();
  }

  Future<List<StoredWordOccurrence>> occurrencesForVocabulary(
    String vocabularyId,
  ) {
    final query = select(wordOccurrences)
      ..where((WordOccurrences row) => row.vocabularyId.equals(vocabularyId))
      ..orderBy(<OrderingTerm Function(WordOccurrences)>[
        (WordOccurrences row) => OrderingTerm.desc(row.createdAt),
      ]);
    return query.get();
  }

  Future<StoredVocabularyItem?> vocabularyItemById(String id) {
    final query = select(vocabularyItems)
      ..where(
        (VocabularyItems row) => row.id.equals(id) & row.deletedAt.isNull(),
      );
    return query.getSingleOrNull();
  }

  Stream<List<StoredWordOccurrence>> watchOccurrencesForBook(String bookId) {
    final query = select(wordOccurrences)
      ..where((WordOccurrences row) => row.sourceBookId.equals(bookId));
    return query.watch();
  }

  Future<String> saveVocabularyWord({
    required String vocabularyId,
    required String occurrenceId,
    required String sourceLanguage,
    required String targetLanguage,
    required String lemma,
    required String normalizedLemma,
    required String translation,
    required String kind,
    required String? partOfSpeech,
    required String surfaceForm,
    required String contextSentence,
    required int wordStart,
    required int wordEnd,
    required String sourceBookId,
    required String sourceBookTitle,
    required String sourceChapterId,
    required String? sourceChapterTitle,
    required int sourceOffset,
  }) {
    return transaction(() async {
      final itemQuery = select(vocabularyItems)
        ..where(
          (VocabularyItems row) =>
              row.sourceLanguage.equals(sourceLanguage) &
              row.targetLanguage.equals(targetLanguage) &
              row.normalizedLemma.equals(normalizedLemma) &
              row.kind.equals(kind) &
              row.deletedAt.isNull(),
        )
        ..limit(1);
      final existing = await itemQuery.getSingleOrNull();
      final resolvedVocabularyId = existing?.id ?? vocabularyId;
      final now = DateTime.now().toUtc();

      if (existing == null) {
        await into(vocabularyItems).insert(
          VocabularyItemsCompanion.insert(
            id: resolvedVocabularyId,
            sourceLanguage: sourceLanguage,
            targetLanguage: targetLanguage,
            lemma: lemma,
            normalizedLemma: normalizedLemma,
            translation: translation,
            kind: Value<String>(kind),
            partOfSpeech: Value<String?>(partOfSpeech),
            updatedAt: now,
          ),
        );
      } else {
        await (update(
          vocabularyItems,
        )..where((VocabularyItems row) => row.id.equals(existing.id))).write(
          VocabularyItemsCompanion(
            lemma: Value<String>(lemma),
            translation: Value<String>(translation),
            kind: Value<String>(kind),
            partOfSpeech: Value<String?>(partOfSpeech),
            updatedAt: Value<DateTime>(now),
          ),
        );
      }

      final occurrenceQuery = select(wordOccurrences)
        ..where(
          (WordOccurrences row) =>
              row.vocabularyId.equals(resolvedVocabularyId) &
              row.sourceBookId.equals(sourceBookId) &
              row.sourceOffset.equals(sourceOffset),
        )
        ..limit(1);
      if (await occurrenceQuery.getSingleOrNull() == null) {
        await into(wordOccurrences).insert(
          WordOccurrencesCompanion.insert(
            id: occurrenceId,
            vocabularyId: resolvedVocabularyId,
            surfaceForm: surfaceForm,
            contextSentence: contextSentence,
            wordStart: wordStart,
            wordEnd: wordEnd,
            sourceBookId: Value<String>(sourceBookId),
            sourceBookTitle: sourceBookTitle,
            sourceChapterId: Value<String>(sourceChapterId),
            sourceChapterTitle: Value<String?>(sourceChapterTitle),
            sourceOffset: Value<int>(sourceOffset),
          ),
        );
      }
      return resolvedVocabularyId;
    });
  }

  Future<void> removeVocabularyOccurrence({
    required String vocabularyId,
    required String occurrenceId,
  }) {
    return transaction(() async {
      await (delete(
        wordOccurrences,
      )..where((WordOccurrences row) => row.id.equals(occurrenceId))).go();
      final remaining = await occurrencesForVocabulary(vocabularyId);
      if (remaining.isEmpty) {
        await (update(
          vocabularyItems,
        )..where((VocabularyItems row) => row.id.equals(vocabularyId))).write(
          VocabularyItemsCompanion(
            deletedAt: Value<DateTime>(DateTime.now().toUtc()),
            updatedAt: Value<DateTime>(DateTime.now().toUtc()),
          ),
        );
      }
    });
  }

  Future<void> saveReaderPosition({
    required String bookId,
    required String chapterId,
    required int textOffset,
    required double progress,
  }) {
    final now = DateTime.now().toUtc();
    return transaction(() async {
      await into(readerPositions).insertOnConflictUpdate(
        ReaderPositionsCompanion.insert(
          bookId: bookId,
          chapterId: chapterId,
          textOffset: textOffset,
          progress: progress.clamp(0, 1),
          updatedAt: now,
        ),
      );
      await (update(books)..where((Books row) => row.id.equals(bookId))).write(
        BooksCompanion(lastOpenedAt: Value<DateTime>(now)),
      );
    });
  }
}
