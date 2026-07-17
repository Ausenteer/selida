import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:selida/core/database/app_database.dart';

void main() {
  test('schema version 3 creates all local-first tables', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);

    final tables = await database
        .customSelect("SELECT name FROM sqlite_master WHERE type = 'table'")
        .get();
    final names = tables
        .map((QueryRow row) => row.read<String>('name'))
        .toSet();

    expect(database.schemaVersion, 3);
    expect(
      names,
      containsAll(<String>{
        'books',
        'chapters',
        'content_blocks',
        'reader_positions',
        'vocabulary_items',
        'srs_cards',
        'sync_outbox_entries',
      }),
    );
  });

  test('saving the same word occurrence is idempotent', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);

    Future<void> save({required String vocabularyId, required String value}) {
      return database
          .saveVocabularyWord(
            vocabularyId: vocabularyId,
            occurrenceId: 'occurrence-$vocabularyId',
            sourceLanguage: 'en',
            targetLanguage: 'ru',
            lemma: 'walk',
            normalizedLemma: 'walk',
            translation: value,
            kind: 'word',
            partOfSpeech: 'verb',
            surfaceForm: 'walked',
            contextSentence: 'She walked home.',
            wordStart: 4,
            wordEnd: 10,
            sourceBookId: 'book-1',
            sourceBookTitle: 'Example',
            sourceChapterId: 'chapter-1',
            sourceChapterTitle: 'One',
            sourceOffset: 42,
          )
          .then((_) {});
    }

    await save(vocabularyId: 'vocabulary-1', value: 'идти');
    await save(vocabularyId: 'vocabulary-2', value: 'ходить');

    final words = await database.select(database.vocabularyItems).get();
    final occurrences = await database.select(database.wordOccurrences).get();
    expect(words, hasLength(1));
    expect(words.single.id, 'vocabulary-1');
    expect(words.single.translation, 'ходить');
    expect(occurrences, hasLength(1));
    expect(occurrences.single.wordStart, 4);
    expect(occurrences.single.wordEnd, 10);
  });

  test(
    'migration from schema 1 adds reader vocabulary columns without data loss',
    () async {
      final executor = NativeDatabase.memory(
        setup: (rawDatabase) {
          rawDatabase.execute('''
          CREATE TABLE vocabulary_items (
            id TEXT NOT NULL PRIMARY KEY
          )
        ''');
          rawDatabase.execute('''
          CREATE TABLE word_occurrences (
            id TEXT NOT NULL PRIMARY KEY,
            vocabulary_id TEXT NOT NULL,
            surface_form TEXT NOT NULL,
            context_sentence TEXT NOT NULL,
            word_start INTEGER NOT NULL,
            word_end INTEGER NOT NULL,
            source_book_id TEXT NULL,
            source_book_title TEXT NOT NULL,
            source_chapter_title TEXT NULL,
            source_offset INTEGER NULL,
            created_at INTEGER NOT NULL
          )
        ''');
          rawDatabase.execute('''
          INSERT INTO word_occurrences (
            id, vocabulary_id, surface_form, context_sentence,
            word_start, word_end, source_book_id, source_book_title,
            source_chapter_title, source_offset, created_at
          ) VALUES (
            'occurrence-1', 'word-1', 'walked', 'She walked home.',
            4, 10, 'book-1', 'Example', 'One', 42, 0
          )
        ''');
          rawDatabase.execute('PRAGMA user_version = 1');
        },
      );
      final database = AppDatabase(executor);
      addTearDown(database.close);

      final columns = await database
          .customSelect('PRAGMA table_info(word_occurrences)')
          .get();
      final names = columns
          .map((QueryRow row) => row.read<String>('name'))
          .toSet();
      final vocabularyColumns = await database
          .customSelect('PRAGMA table_info(vocabulary_items)')
          .get();
      final vocabularyColumnNames = vocabularyColumns
          .map((QueryRow row) => row.read<String>('name'))
          .toSet();
      final occurrence = await database
          .customSelect(
            'SELECT surface_form, source_chapter_id FROM word_occurrences',
          )
          .getSingle();

      expect(names, contains('source_chapter_id'));
      expect(vocabularyColumnNames, contains('kind'));
      expect(occurrence.read<String>('surface_form'), 'walked');
      expect(occurrence.readNullable<String>('source_chapter_id'), null);
    },
  );
}
