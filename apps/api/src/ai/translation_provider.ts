import type {
  TextAssistanceRequest,
  TextAssistanceResult,
  WordTranslationRequest,
  WordTranslationResult,
} from '../contracts/translation.js';

export interface TranslationProvider {
  translateWord(request: WordTranslationRequest): Promise<WordTranslationResult>;
  translateFragment(
    request: TextAssistanceRequest,
  ): Promise<TextAssistanceResult>;
  explainText(request: TextAssistanceRequest): Promise<TextAssistanceResult>;
}

export class TranslationProviderError extends Error {
  constructor(
    message: string,
    readonly kind: 'configuration' | 'upstream' | 'invalid-response',
    readonly retryable = false,
  ) {
    super(message);
    this.name = 'TranslationProviderError';
  }
}
