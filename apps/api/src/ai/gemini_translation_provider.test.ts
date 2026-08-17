import assert from 'node:assert/strict';
import test from 'node:test';

import {GeminiTranslationProvider} from './gemini_translation_provider.js';

test('falls back to the lightweight model after a transient error', async () => {
  const requestedModels: string[] = [];
  const fetcher: typeof fetch = async (input) => {
    const url = input.toString();
    requestedModels.push(url);
    if (url.includes('primary-model')) {
      return new Response('{"error":"temporarily unavailable"}', {
        status: 503,
      });
    }
    return new Response(
      JSON.stringify({
        candidates: [
          {
            content: {
              parts: [
                {
                  text: JSON.stringify({
                    translation: 'ходила',
                    lemma: 'walk',
                    partOfSpeech: 'глагол',
                    formAnalysis: 'Прошедшее время.',
                  }),
                },
              ],
            },
          },
        ],
      }),
      {status: 200, headers: {'content-type': 'application/json'}},
    );
  };
  const provider = new GeminiTranslationProvider(
    'test-key',
    'primary-model',
    'fallback-model',
    fetcher,
  );

  const result = await provider.translateWord({
    sourceLanguage: 'en',
    targetLanguage: 'ru',
    interfaceLanguage: 'ru',
    source: 'walked',
    context: 'She walked home.',
  });

  assert.equal(result.translation, 'ходила');
  assert.equal(requestedModels.length, 2);
  assert.match(requestedModels[0] ?? '', /primary-model/);
  assert.match(requestedModels[1] ?? '', /fallback-model/);
});

test('fragment prompt translates only selected text and treats context as reference', async () => {
  let requestBody:
    | {
        systemInstruction?: {parts?: Array<{text?: string}>};
        contents?: Array<{parts?: Array<{text?: string}>}>;
      }
    | undefined;
  const fetcher: typeof fetch = async (_input, init) => {
    requestBody = JSON.parse(String(init?.body));
    return new Response(
      JSON.stringify({
        candidates: [
          {
            content: {
              parts: [
                {text: JSON.stringify({translation: 'предсмертный'})},
              ],
            },
          },
        ],
      }),
      {status: 200, headers: {'content-type': 'application/json'}},
    );
  };
  const provider = new GeminiTranslationProvider(
    'test-key',
    'test-model',
    'test-model',
    fetcher,
  );

  const result = await provider.translateFragment({
    sourceLanguage: 'en',
    targetLanguage: 'ru',
    interfaceLanguage: 'ru',
    source: 'near-death',
    context: 'My near-death dreams are ridiculous.',
  });

  const instruction = requestBody?.systemInstruction?.parts?.[0]?.text ?? '';
  assert.match(instruction, /ONLY the exact value of selectedText/);
  assert.match(instruction, /never translate it/);
  const userText = requestBody?.contents?.[0]?.parts?.[0]?.text ?? '{}';
  const userPayload = JSON.parse(userText) as {selectedText?: string};
  assert.equal(userPayload.selectedText, 'near-death');
  assert.equal(result.translation, 'предсмертный');
});

test('explanation prompt stays scoped to selected text and returns sections', async () => {
  let requestBody:
    | {
        systemInstruction?: {parts?: Array<{text?: string}>};
        contents?: Array<{parts?: Array<{text?: string}>}>;
      }
    | undefined;
  const fetcher: typeof fetch = async (_input, init) => {
    requestBody = JSON.parse(String(init?.body));
    return new Response(
      JSON.stringify({
        candidates: [
          {
            content: {
              parts: [
                {
                  text: JSON.stringify({
                    focusType: 'grammar',
                    focusText: 'near-death',
                    title: 'Составное определение',
                    explanation:
                      'near и death образуют единое определение перед существительным.',
                    structure: 'near-death + noun',
                    literalTranslation: 'близкий к смерти',
                    naturalTranslation: 'предсмертный',
                    examples: [
                      {
                        source: 'a near-death experience',
                        translation: 'околосмертный опыт',
                      },
                    ],
                    commonMistake: 'Не переводите всё предложение.',
                  }),
                },
              ],
            },
          },
        ],
      }),
      {status: 200, headers: {'content-type': 'application/json'}},
    );
  };
  const provider = new GeminiTranslationProvider(
    'test-key',
    'test-model',
    'test-model',
    fetcher,
  );

  const result = await provider.explainText({
    sourceLanguage: 'en',
    targetLanguage: 'ru',
    interfaceLanguage: 'ru',
    source: 'near-death',
    context: 'My near-death dreams are ridiculous.',
  });

  const instruction = requestBody?.systemInstruction?.parts?.[0]?.text ?? '';
  assert.match(instruction, /Explain ONLY selectedText/);
  assert.match(instruction, /do not explain or translate the whole/);
  assert.match(instruction, /Do not retell or paraphrase/);
  assert.match(instruction, /never merely repeat focusText/);
  assert.equal(result.naturalTranslation, 'предсмертный');
  assert.equal(result.focusType, 'grammar');
  assert.equal(result.focusText, 'near-death');
  assert.equal(result.title, 'Составное определение');
  assert.equal(result.examples.length, 1);
});
