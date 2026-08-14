import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:selida/core/database/app_database.dart';
import 'package:selida/core/database/database_provider.dart';
import 'package:selida/features/translation/domain/word_translation.dart';
import 'package:uuid/uuid.dart';

final Provider<VocabularyService> vocabularyServiceProvider =
    Provider<VocabularyService>((Ref ref) {
      return VocabularyService(ref.watch(databaseProvider));
    });

final StreamProvider<List<VocabularyEntry>> vocabularyEntriesProvider =
    StreamProvider<List<VocabularyEntry>>((Ref ref) {
      final database = ref.watch(databaseProvider);
      return database.watchActiveVocabularyItems().asyncMap((items) async {
        return Future.wait(<Future<VocabularyEntry>>[
          for (final item in items)
            database
                .occurrencesForVocabulary(item.id)
                .then(
                  (List<StoredWordOccurrence> occurrences) =>
                      VocabularyEntry(item: item, occurrences: occurrences),
                ),
        ]);
      });
    });

final class VocabularyService {
  VocabularyService(this._database);

  final AppDatabase _database;
  final Uuid _uuid = const Uuid();

  Future<String> saveTranslation({
    required WordTranslationRequest request,
    required WordTranslation translation,
    required String surfaceForm,
    required String contextSentence,
    required int contextWordStart,
    required String sourceBookId,
    required String sourceBookTitle,
    required String sourceChapterId,
    required String? sourceChapterTitle,
    required int sourceOffset,
  }) {
    final safeWordStart = contextWordStart.clamp(0, contextSentence.length);
    final safeWordEnd = (safeWordStart + surfaceForm.length).clamp(
      safeWordStart,
      contextSentence.length,
    );
    return _database.saveVocabularyWord(
      vocabularyId: _uuid.v7(),
      occurrenceId: _uuid.v7(),
      sourceLanguage: request.sourceLanguage,
      targetLanguage: request.targetLanguage,
      lemma: translation.lemma.trim(),
      normalizedLemma: translation.lemma.trim().toLowerCase(),
      translation: translation.translation.trim(),
      kind: 'word',
      partOfSpeech: translation.partOfSpeech.trim(),
      surfaceForm: surfaceForm,
      contextSentence: contextSentence,
      wordStart: safeWordStart,
      wordEnd: safeWordEnd,
      sourceBookId: sourceBookId,
      sourceBookTitle: sourceBookTitle,
      sourceChapterId: sourceChapterId,
      sourceChapterTitle: sourceChapterTitle,
      sourceOffset: sourceOffset,
    );
  }

  Future<String> savePhrase({
    required TextAssistanceRequest request,
    required FragmentTranslation translation,
    required String contextSentence,
    required int contextPhraseStart,
    required String sourceBookId,
    required String sourceBookTitle,
    required String sourceChapterId,
    required String? sourceChapterTitle,
    required int sourceOffset,
    required bool savesAsWord,
  }) {
    final phrase = request.source.trim();
    final safeStart = contextPhraseStart.clamp(0, contextSentence.length);
    final safeEnd = (safeStart + phrase.length).clamp(
      safeStart,
      contextSentence.length,
    );
    return _database.saveVocabularyWord(
      vocabularyId: _uuid.v7(),
      occurrenceId: _uuid.v7(),
      sourceLanguage: request.sourceLanguage,
      targetLanguage: request.targetLanguage,
      lemma: phrase,
      normalizedLemma: phrase.toLowerCase(),
      translation: translation.translation.trim(),
      kind: savesAsWord ? 'word' : 'phrase',
      partOfSpeech: savesAsWord ? null : 'phrase',
      surfaceForm: phrase,
      contextSentence: contextSentence,
      wordStart: safeStart,
      wordEnd: safeEnd,
      sourceBookId: sourceBookId,
      sourceBookTitle: sourceBookTitle,
      sourceChapterId: sourceChapterId,
      sourceChapterTitle: sourceChapterTitle,
      sourceOffset: sourceOffset,
    );
  }

  Future<StoredVocabularyItem?> vocabularyItem(String id) {
    return _database.vocabularyItemById(id);
  }

  Future<StoredWordOccurrence?> occurrenceAt({
    required String vocabularyId,
    required String sourceBookId,
    required int sourceOffset,
  }) async {
    final occurrences = await _database.occurrencesForVocabulary(vocabularyId);
    for (final occurrence in occurrences) {
      if (occurrence.sourceBookId == sourceBookId &&
          occurrence.sourceOffset == sourceOffset) {
        return occurrence;
      }
    }
    return null;
  }

  Future<void> removeOccurrence(StoredWordOccurrence occurrence) {
    return _database.removeVocabularyOccurrence(
      vocabularyId: occurrence.vocabularyId,
      occurrenceId: occurrence.id,
    );
  }
}

@immutable
final class ChapterVocabularyQuery {
  const ChapterVocabularyQuery({
    required this.bookId,
    required this.chapterId,
    required this.chapterTitle,
  });

  final String bookId;
  final String chapterId;
  final String? chapterTitle;

  @override
  bool operator ==(Object other) =>
      other is ChapterVocabularyQuery &&
      other.bookId == bookId &&
      other.chapterId == chapterId &&
      other.chapterTitle == chapterTitle;

  @override
  int get hashCode => Object.hash(bookId, chapterId, chapterTitle);
}

final chapterVocabularyOccurrencesProvider =
    StreamProvider.family<List<StoredWordOccurrence>, ChapterVocabularyQuery>((
      Ref ref,
      ChapterVocabularyQuery query,
    ) {
      return ref
          .watch(databaseProvider)
          .watchOccurrencesForBook(query.bookId)
          .map(
            (List<StoredWordOccurrence> occurrences) => occurrences
                .where(
                  (StoredWordOccurrence occurrence) =>
                      occurrence.sourceChapterId == query.chapterId ||
                      (occurrence.sourceChapterId == null &&
                          occurrence.sourceChapterTitle == query.chapterTitle),
                )
                .toList(growable: false),
          );
    });

@immutable
final class VocabularyEntry {
  const VocabularyEntry({required this.item, required this.occurrences});

  final StoredVocabularyItem item;
  final List<StoredWordOccurrence> occurrences;

  StoredWordOccurrence? get latestOccurrence =>
      occurrences.isEmpty ? null : occurrences.first;
}
