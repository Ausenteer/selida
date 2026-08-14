import type {
  FragmentTranslationResult,
  TextAssistanceRequest,
  TextExplanationResult,
  WordTranslationRequest,
  WordTranslationResult,
} from '../contracts/translation.js';

export interface TranslationProvider {
  translateWord(request: WordTranslationRequest): Promise<WordTranslationResult>;
  translateFragment(
    request: TextAssistanceRequest,
  ): Promise<FragmentTranslationResult>;
  explainText(request: TextAssistanceRequest): Promise<TextExplanationResult>;
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
