export interface WordTranslationRequest {
  sourceLanguage: 'en' | 'el';
  targetLanguage: 'ru';
  interfaceLanguage: 'ru' | 'en';
  source: string;
  context: string;
}

export interface WordTranslationResult {
  translation: string;
  lemma: string;
  partOfSpeech: string;
  formAnalysis: string;
}

export interface WordTranslationResponse extends WordTranslationResult {
  cached: boolean;
}

export interface TextAssistanceRequest {
  sourceLanguage: 'en' | 'el';
  targetLanguage: 'ru';
  interfaceLanguage: 'ru' | 'en';
  source: string;
  context: string;
}

export interface TextAssistanceResult {
  content: string;
}

export interface TextAssistanceResponse extends TextAssistanceResult {
  cached: boolean;
}

export const wordTranslationBodySchema = {
  type: 'object',
  additionalProperties: false,
  required: [
    'sourceLanguage',
    'targetLanguage',
    'interfaceLanguage',
    'source',
    'context',
  ],
  properties: {
    sourceLanguage: {type: 'string', enum: ['en', 'el']},
    targetLanguage: {type: 'string', enum: ['ru']},
    interfaceLanguage: {type: 'string', enum: ['ru', 'en']},
    source: {type: 'string', minLength: 1, maxLength: 120},
    context: {type: 'string', minLength: 1, maxLength: 2000},
  },
} as const;

export const wordTranslationResponseSchema = {
  type: 'object',
  additionalProperties: false,
  required: [
    'translation',
    'lemma',
    'partOfSpeech',
    'formAnalysis',
    'cached',
  ],
  properties: {
    translation: {type: 'string'},
    lemma: {type: 'string'},
    partOfSpeech: {type: 'string'},
    formAnalysis: {type: 'string'},
    cached: {type: 'boolean'},
  },
} as const;

export const textAssistanceBodySchema = {
  type: 'object',
  additionalProperties: false,
  required: [
    'sourceLanguage',
    'targetLanguage',
    'interfaceLanguage',
    'source',
    'context',
  ],
  properties: {
    sourceLanguage: {type: 'string', enum: ['en', 'el']},
    targetLanguage: {type: 'string', enum: ['ru']},
    interfaceLanguage: {type: 'string', enum: ['ru', 'en']},
    source: {type: 'string', minLength: 1, maxLength: 1000},
    context: {type: 'string', minLength: 1, maxLength: 2000},
  },
} as const;

export const textAssistanceResponseSchema = {
  type: 'object',
  additionalProperties: false,
  required: ['content', 'cached'],
  properties: {
    content: {type: 'string'},
    cached: {type: 'boolean'},
  },
} as const;
