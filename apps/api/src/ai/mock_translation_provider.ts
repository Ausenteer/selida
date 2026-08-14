import type {
  FragmentTranslationResult,
  TextAssistanceRequest,
  TextExplanationResult,
  WordTranslationRequest,
  WordTranslationResult,
} from '../contracts/translation.js';
import type {TranslationProvider} from './translation_provider.js';

export class MockTranslationProvider implements TranslationProvider {
  async translateWord(
    request: WordTranslationRequest,
  ): Promise<WordTranslationResult> {
    const normalized = request.source.toLocaleLowerCase(request.sourceLanguage);
    const known: Record<string, WordTranslationResult> = {
      athens: {
        translation: 'Афины',
        lemma: 'Athens',
        partOfSpeech: 'proper noun',
        formAnalysis: 'Название города во множественном числе.',
      },
      αθήνα: {
        translation: 'Афины',
        lemma: 'Αθήνα',
        partOfSpeech: 'существительное, имя собственное',
        formAnalysis: 'Именительный падеж, единственное число.',
      },
    };
    return (
      known[normalized] ?? {
        translation: `Перевод: ${request.source}`,
        lemma: request.source,
        partOfSpeech: 'слово',
        formAnalysis: 'Демонстрационный ответ локального провайдера.',
      }
    );
  }

  async translateFragment(
    request: TextAssistanceRequest,
  ): Promise<FragmentTranslationResult> {
    return {translation: `Перевод фрагмента: ${request.source}`};
  }

  async explainText(
    request: TextAssistanceRequest,
  ): Promise<TextExplanationResult> {
    return {
      summary: `Значение: ${request.source}`,
      meaningInContext: 'Демонстрационное объяснение в контексте.',
      breakdown: 'Разбор конструкции локальным провайдером.',
      literalTranslation: '',
      naturalTranslation: `Перевод фрагмента: ${request.source}`,
      examples: [],
      commonMistake: '',
    };
  }
}
