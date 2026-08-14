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

export interface FragmentTranslationResult {
  translation: string;
}

export interface FragmentTranslationResponse
  extends FragmentTranslationResult {
  cached: boolean;
}

export interface TextExplanationExample {
  source: string;
  translation: string;
}

export interface TextExplanationResult {
  summary: string;
  meaningInContext: string;
  breakdown: string;
  literalTranslation: string;
  naturalTranslation: string;
  examples: TextExplanationExample[];
  commonMistake: string;
}

export interface TextExplanationResponse extends TextExplanationResult {
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

export const fragmentTranslationResponseSchema = {
  type: 'object',
  additionalProperties: false,
  required: ['translation', 'cached'],
  properties: {
    translation: {type: 'string'},
    cached: {type: 'boolean'},
  },
} as const;

export const textExplanationResponseSchema = {
  type: 'object',
  additionalProperties: false,
  required: [
    'summary',
    'meaningInContext',
    'breakdown',
    'literalTranslation',
    'naturalTranslation',
    'examples',
    'commonMistake',
    'cached',
  ],
  properties: {
    summary: {type: 'string'},
    meaningInContext: {type: 'string'},
    breakdown: {type: 'string'},
    literalTranslation: {type: 'string'},
    naturalTranslation: {type: 'string'},
    examples: {
      type: 'array',
      maxItems: 2,
      items: {
        type: 'object',
        additionalProperties: false,
        required: ['source', 'translation'],
        properties: {
          source: {type: 'string'},
          translation: {type: 'string'},
        },
      },
    },
    commonMistake: {type: 'string'},
    cached: {type: 'boolean'},
  },
} as const;
