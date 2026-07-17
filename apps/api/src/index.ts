import {GeminiTranslationProvider} from './ai/gemini_translation_provider.js';
import {MockTranslationProvider} from './ai/mock_translation_provider.js';
import type {TranslationProvider} from './ai/translation_provider.js';
import {buildApp} from './app.js';
import {MemoryTranslationCache} from './cache/translation_cache.js';

const provider: TranslationProvider =
  process.env.SELIDA_AI_PROVIDER === 'mock'
    ? new MockTranslationProvider()
    : new GeminiTranslationProvider(
        process.env.GEMINI_API_KEY,
        process.env.GEMINI_MODEL,
        process.env.GEMINI_FALLBACK_MODEL,
      );
const app = buildApp({
  provider,
  cache: new MemoryTranslationCache(),
  logger: true,
});

const port = Number.parseInt(process.env.PORT ?? '8787', 10);
await app.listen({host: process.env.HOST ?? '127.0.0.1', port});
