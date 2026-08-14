import assert from 'node:assert/strict';
import test from 'node:test';

import type {TranslationProvider} from './ai/translation_provider.js';
import {buildApp} from './app.js';
import {MemoryTranslationCache} from './cache/translation_cache.js';
import type {
  FragmentTranslationResult,
  TextExplanationResult,
  WordTranslationRequest,
  WordTranslationResult,
} from './contracts/translation.js';

test('translation route validates and caches contextual results', async () => {
  let calls = 0;
  const provider: TranslationProvider = {
    async translateWord(): Promise<WordTranslationResult> {
      calls += 1;
      return {
        translation: 'читал',
        lemma: 'διαβάζω',
        partOfSpeech: 'глагол',
        formAnalysis: 'Прошедшее время.',
      };
    },
    async translateFragment(): Promise<FragmentTranslationResult> {
      return {translation: 'Я читала книгу.'};
    },
    async explainText(): Promise<TextExplanationResult> {
      return explanationResult('Форма прошедшего времени.');
    },
  };
  const app = buildApp({provider, cache: new MemoryTranslationCache()});
  const body: WordTranslationRequest = {
    sourceLanguage: 'el',
    targetLanguage: 'ru',
    interfaceLanguage: 'ru',
    source: 'διάβαζα',
    context: 'Χθες διάβαζα ένα βιβλίο.',
  };

  const first = await app.inject({
    method: 'POST',
    url: '/v1/translate/word',
    payload: body,
  });
  const second = await app.inject({
    method: 'POST',
    url: '/v1/translate/word',
    payload: body,
  });

  assert.equal(first.statusCode, 200);
  assert.equal(first.json().cached, false);
  assert.equal(second.statusCode, 200);
  assert.equal(second.json().cached, true);
  assert.equal(calls, 1);
  await app.close();
});

test('translation route rejects unsupported language pairs', async () => {
  const provider: TranslationProvider = {
    async translateWord(): Promise<WordTranslationResult> {
      throw new Error('must not be called');
    },
    async translateFragment(): Promise<FragmentTranslationResult> {
      throw new Error('must not be called');
    },
    async explainText(): Promise<TextExplanationResult> {
      throw new Error('must not be called');
    },
  };
  const app = buildApp({provider, cache: new MemoryTranslationCache()});
  const response = await app.inject({
    method: 'POST',
    url: '/v1/translate/word',
    payload: {
      sourceLanguage: 'de',
      targetLanguage: 'ru',
      interfaceLanguage: 'ru',
      source: 'Buch',
      context: 'Ich lese ein Buch.',
    },
  });

  assert.equal(response.statusCode, 400);
  await app.close();
});

test('fragment translation and explanation use separate caches', async () => {
  let fragmentCalls = 0;
  let explanationCalls = 0;
  const provider: TranslationProvider = {
    async translateWord(): Promise<WordTranslationResult> {
      throw new Error('must not be called');
    },
    async translateFragment(): Promise<FragmentTranslationResult> {
      fragmentCalls += 1;
      return {translation: 'шла домой'};
    },
    async explainText(): Promise<TextExplanationResult> {
      explanationCalls += 1;
      return explanationResult('Past Continuous описывает процесс.');
    },
  };
  const app = buildApp({provider, cache: new MemoryTranslationCache()});
  const payload = {
    sourceLanguage: 'en',
    targetLanguage: 'ru',
    interfaceLanguage: 'ru',
    source: 'She was walking home.',
    context: 'She was walking home when it started snowing.',
  };

  const fragment = await app.inject({
    method: 'POST',
    url: '/v1/translate/fragment',
    payload,
  });
  const fragmentCached = await app.inject({
    method: 'POST',
    url: '/v1/translate/fragment',
    payload,
  });
  const explanation = await app.inject({
    method: 'POST',
    url: '/v1/explain',
    payload,
  });

  assert.equal(fragment.statusCode, 200);
  assert.equal(fragment.json().translation, 'шла домой');
  assert.equal(fragmentCached.json().cached, true);
  assert.equal(
    explanation.json().meaningInContext,
    'Past Continuous описывает процесс.',
  );
  assert.equal(fragmentCalls, 1);
  assert.equal(explanationCalls, 1);
  await app.close();
});

function explanationResult(meaningInContext: string): TextExplanationResult {
  return {
    summary: 'Краткое объяснение.',
    meaningInContext,
    breakdown: 'Разбор конструкции.',
    literalTranslation: '',
    naturalTranslation: 'шла домой',
    examples: [],
    commonMistake: '',
  };
}
