import type {
  TextAssistanceRequest,
  TextAssistanceResult,
  WordTranslationRequest,
  WordTranslationResult,
} from '../contracts/translation.js';
import {
  TranslationProviderError,
  type TranslationProvider,
} from './translation_provider.js';

interface GeminiResponse {
  candidates?: Array<{
    content?: {parts?: Array<{text?: string}>};
  }>;
}

const resultSchema = {
  type: 'OBJECT',
  required: ['translation', 'lemma', 'partOfSpeech', 'formAnalysis'],
  properties: {
    translation: {type: 'STRING'},
    lemma: {type: 'STRING'},
    partOfSpeech: {type: 'STRING'},
    formAnalysis: {type: 'STRING'},
  },
} as const;

const contentSchema = {
  type: 'OBJECT',
  required: ['content'],
  properties: {content: {type: 'STRING'}},
} as const;

export class GeminiTranslationProvider implements TranslationProvider {
  private readonly models: readonly string[];

  constructor(
    private readonly apiKey: string | undefined,
    primaryModel = 'gemini-3.1-flash-lite',
    fallbackModel = 'gemini-3.5-flash',
    private readonly fetcher: typeof fetch = fetch,
  ) {
    this.models = [...new Set([primaryModel, fallbackModel])];
  }

  async translateWord(
    request: WordTranslationRequest,
  ): Promise<WordTranslationResult> {
    if (!this.apiKey) {
      throw new TranslationProviderError(
        'GEMINI_API_KEY is not configured',
        'configuration',
      );
    }

    let lastError: TranslationProviderError | undefined;
    for (const [index, model] of this.models.entries()) {
      try {
        return await this.translateWithModel(model, request);
      } catch (error) {
        if (!(error instanceof TranslationProviderError)) {
          throw error;
        }
        lastError = error;
        const hasFallback = index < this.models.length - 1;
        if (!error.retryable || !hasFallback) {
          throw error;
        }
      }
    }
    throw (
      lastError ??
      new TranslationProviderError('Gemini request failed', 'upstream')
    );
  }

  async translateFragment(
    request: TextAssistanceRequest,
  ): Promise<TextAssistanceResult> {
    return this.assistText(
      request,
      [
        'Translate ONLY the value of selectedText into the requested targetLanguage.',
        'The surroundingContext is reference material only: never translate it, paraphrase it, or include text outside selectedText in the answer.',
        'If selectedText is a single word or hyphenated expression, return only its contextually correct equivalent.',
        'Use surroundingContext only to resolve meaning, pronouns, idioms, and ambiguity.',
        'Return only a natural translation in the content field.',
        'Do not add notes or markdown.',
      ].join(' '),
    );
  }

  async explainText(
    request: TextAssistanceRequest,
  ): Promise<TextAssistanceResult> {
    const outputLanguage = request.interfaceLanguage === 'en' ? 'English' : 'Russian';
    return this.assistText(
      request,
      [
        `Explain the selected grammar, idiom, or construction in simple ${outputLanguage}.`,
        'Keep the explanation concise and useful for an A2-B2 learner.',
        'Include one or two short examples when helpful.',
        'Return plain text in the content field without markdown.',
      ].join(' '),
    );
  }

  private async assistText(
    request: TextAssistanceRequest,
    instruction: string,
  ): Promise<TextAssistanceResult> {
    if (!this.apiKey) {
      throw new TranslationProviderError(
        'GEMINI_API_KEY is not configured',
        'configuration',
      );
    }

    let lastError: TranslationProviderError | undefined;
    for (const [index, model] of this.models.entries()) {
      try {
        return await this.assistWithModel(model, request, instruction);
      } catch (error) {
        if (!(error instanceof TranslationProviderError)) {
          throw error;
        }
        lastError = error;
        const hasFallback = index < this.models.length - 1;
        if (!error.retryable || !hasFallback) {
          throw error;
        }
      }
    }
    throw (
      lastError ??
      new TranslationProviderError('Gemini request failed', 'upstream')
    );
  }

  private async assistWithModel(
    model: string,
    request: TextAssistanceRequest,
    instruction: string,
  ): Promise<TextAssistanceResult> {
    let response: Response;
    try {
      response = await this.fetcher(
        `https://generativelanguage.googleapis.com/v1beta/models/${encodeURIComponent(model)}:generateContent`,
        {
          method: 'POST',
          headers: {
            'content-type': 'application/json',
            'x-goog-api-key': this.apiKey as string,
          },
          body: JSON.stringify({
            systemInstruction: {parts: [{text: instruction}]},
            contents: [
              {
                role: 'user',
                parts: [
                  {
                    text: JSON.stringify({
                      sourceLanguage: request.sourceLanguage,
                      targetLanguage: request.targetLanguage,
                      selectedText: request.source,
                      surroundingContext: request.context,
                    }),
                  },
                ],
              },
            ],
            generationConfig: {
              temperature: 0.15,
              maxOutputTokens: 700,
              responseMimeType: 'application/json',
              responseSchema: contentSchema,
            },
          }),
          signal: AbortSignal.timeout(15_000),
        },
      );
    } catch (error) {
      throw new TranslationProviderError(
        `Gemini ${model} request failed: ${errorMessage(error)}`,
        'upstream',
        true,
      );
    }

    if (!response.ok) {
      const details = compactDetails(await response.text());
      const suffix = details.length === 0 ? '' : `: ${details}`;
      throw new TranslationProviderError(
        `Gemini ${model} returned HTTP ${response.status}${suffix}`,
        'upstream',
        isRetryableStatus(response.status),
      );
    }
    const payload = (await response.json()) as GeminiResponse;
    const text = payload.candidates?.[0]?.content?.parts?.[0]?.text;
    if (!text) {
      throw new TranslationProviderError(
        `Gemini ${model} returned an empty response`,
        'invalid-response',
      );
    }

    try {
      const parsed = JSON.parse(text) as {content?: unknown};
      if (typeof parsed.content !== 'string' || parsed.content.trim().length === 0) {
        throw new TranslationProviderError(
          'Text assistance result has invalid content',
          'invalid-response',
        );
      }
      return {content: parsed.content.trim()};
    } catch (error) {
      if (error instanceof TranslationProviderError) {
        throw error;
      }
      throw new TranslationProviderError(
        `Gemini ${model} returned invalid JSON`,
        'invalid-response',
      );
    }
  }

  private async translateWithModel(
    model: string,
    request: WordTranslationRequest,
  ): Promise<WordTranslationResult> {
    let response: Response;
    try {
      response = await this.fetcher(
        `https://generativelanguage.googleapis.com/v1beta/models/${encodeURIComponent(model)}:generateContent`,
        {
          method: 'POST',
          headers: {
            'content-type': 'application/json',
            'x-goog-api-key': this.apiKey as string,
          },
          body: JSON.stringify({
            systemInstruction: {
              parts: [
                {
                  text: [
                    'You are a concise dictionary assistant for language learners.',
                    'Analyze the exact word form in its sentence context.',
                    'Return Russian translation, dictionary lemma, part of speech,',
                    'and a short form/morphology analysis. Do not add markdown.',
                  ].join(' '),
                },
              ],
            },
            contents: [
              {
                role: 'user',
                parts: [
                  {
                    text: JSON.stringify({
                      sourceLanguage: request.sourceLanguage,
                      targetLanguage: request.targetLanguage,
                      interfaceLanguage: request.interfaceLanguage,
                      selectedWord: request.source,
                      sentenceContext: request.context,
                    }),
                  },
                ],
              },
            ],
            generationConfig: {
              temperature: 0.1,
              maxOutputTokens: 300,
              responseMimeType: 'application/json',
              responseSchema: resultSchema,
            },
          }),
          signal: AbortSignal.timeout(12_000),
        },
      );
    } catch (error) {
      throw new TranslationProviderError(
        `Gemini ${model} request failed: ${errorMessage(error)}`,
        'upstream',
        true,
      );
    }

    if (!response.ok) {
      const details = compactDetails(await response.text());
      const suffix = details.length === 0 ? '' : `: ${details}`;
      throw new TranslationProviderError(
        `Gemini ${model} returned HTTP ${response.status}${suffix}`,
        'upstream',
        isRetryableStatus(response.status),
      );
    }
    const payload = (await response.json()) as GeminiResponse;
    const text = payload.candidates?.[0]?.content?.parts?.[0]?.text;
    if (!text) {
      throw new TranslationProviderError(
        `Gemini ${model} returned an empty response`,
        'invalid-response',
      );
    }

    try {
      return parseResult(JSON.parse(text) as unknown);
    } catch (error) {
      if (error instanceof TranslationProviderError) {
        throw error;
      }
      throw new TranslationProviderError(
        `Gemini ${model} returned invalid JSON`,
        'invalid-response',
      );
    }
  }
}

function isRetryableStatus(status: number): boolean {
  return status === 404 || status === 429 || status >= 500;
}

function compactDetails(value: string): string {
  return value.replaceAll(/\s+/g, ' ').trim().slice(0, 240);
}

function errorMessage(error: unknown): string {
  return error instanceof Error ? error.message : 'unknown network error';
}

function parseResult(value: unknown): WordTranslationResult {
  if (typeof value !== 'object' || value === null) {
    throw new TranslationProviderError(
      'Translation result is not an object',
      'invalid-response',
    );
  }
  const result = value as Record<string, unknown>;
  const keys = [
    'translation',
    'lemma',
    'partOfSpeech',
    'formAnalysis',
  ] as const;
  for (const key of keys) {
    if (typeof result[key] !== 'string' || result[key].trim().length === 0) {
      throw new TranslationProviderError(
        `Translation result has invalid ${key}`,
        'invalid-response',
      );
    }
  }
  return {
    translation: result.translation as string,
    lemma: result.lemma as string,
    partOfSpeech: result.partOfSpeech as string,
    formAnalysis: result.formAnalysis as string,
  };
}
