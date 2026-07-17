import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:selida/core/database/app_database.dart';
import 'package:selida/features/translation/application/translation_service.dart';
import 'package:selida/features/translation/domain/word_translation.dart';

void main() {
  group('isSingleVocabularyItem', () {
    test('treats a hyphenated expression as one vocabulary item', () {
      expect(isSingleVocabularyItem('near-death'), isTrue);
      expect(isSingleVocabularyItem('mother’s'), isTrue);
    });

    test('treats whitespace-separated text as a phrase', () {
      expect(isSingleVocabularyItem('walked home'), isFalse);
    });
  });

  group('sentenceContextAround', () {
    test('returns the sentence and its source offset', () {
      const source = 'First. She walked home! Next.';
      final wordStart = source.indexOf('walked');

      final result = sentenceContextAround(
        text: source,
        startOffset: wordStart,
        endOffset: wordStart + 'walked'.length,
      );

      expect(result.text, 'She walked home!');
      expect(result.startOffset, source.indexOf('She'));
      expect(wordStart - result.startOffset, 4);
    });

    test('caps an unusually long sentence at the API limit', () {
      final prefix = List<String>.filled(1500, 'a').join();
      final suffix = List<String>.filled(1500, 'b').join();
      final source = '$prefix target $suffix.';
      final wordStart = source.indexOf('target');

      final result = sentenceContextAround(
        text: source,
        startOffset: wordStart,
        endOffset: wordStart + 'target'.length,
      );

      expect(result.text.length, lessThanOrEqualTo(2000));
      expect(
        result.text.substring(wordStart - result.startOffset),
        startsWith('target'),
      );
    });
  });

  test('word and phrase translations are available from local cache', () async {
    final database = AppDatabase(NativeDatabase.memory());
    final service = TranslationService(database);
    addTearDown(() async {
      service.close();
      await database.close();
    });
    const wordRequest = WordTranslationRequest(
      sourceLanguage: 'en',
      targetLanguage: 'ru',
      interfaceLanguage: 'ru',
      source: 'walked',
      context: 'She walked home.',
    );
    const phraseRequest = TextAssistanceRequest(
      sourceLanguage: 'en',
      targetLanguage: 'ru',
      interfaceLanguage: 'ru',
      source: 'walked home',
      context: 'She walked home.',
    );
    await database.saveTranslationCacheEntry(
      key: wordTranslationCacheKey(wordRequest),
      requestKind: 'word',
      resultJson: jsonEncode(<String, Object>{
        'translation': 'пошла',
        'lemma': 'walk',
        'partOfSpeech': 'verb',
        'formAnalysis': 'past tense',
      }),
    );
    await database.saveTranslationCacheEntry(
      key: textAssistanceCacheKey(
        phraseRequest,
        TextAssistanceKind.fragmentTranslation,
      ),
      requestKind: 'fragmentTranslation',
      resultJson: jsonEncode(<String, Object>{'content': 'пошла домой'}),
    );

    final word = await service.translateWord(wordRequest);
    final phrase = await service.assistText(
      phraseRequest,
      TextAssistanceKind.fragmentTranslation,
    );

    expect(word.translation, 'пошла');
    expect(word.fromCache, isTrue);
    expect(phrase.content, 'пошла домой');
    expect(phrase.fromCache, isTrue);
  });
}
