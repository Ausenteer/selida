import Fastify, {type FastifyInstance} from 'fastify';

import {TranslationProviderError, type TranslationProvider} from './ai/translation_provider.js';
import {
  type TranslationCache,
  textAssistanceCacheKey,
  wordTranslationCacheKey,
} from './cache/translation_cache.js';
import {
  type FragmentTranslationResponse,
  type FragmentTranslationResult,
  type TextAssistanceRequest,
  type TextExplanationResponse,
  type TextExplanationResult,
  type WordTranslationRequest,
  type WordTranslationResponse,
  type WordTranslationResult,
  fragmentTranslationResponseSchema,
  textAssistanceBodySchema,
  textExplanationResponseSchema,
  wordTranslationBodySchema,
  wordTranslationResponseSchema,
} from './contracts/translation.js';

export interface AppDependencies {
  provider: TranslationProvider;
  cache: TranslationCache;
  logger?: boolean;
}

export function buildApp(dependencies: AppDependencies): FastifyInstance {
  const app = Fastify({logger: dependencies.logger ?? false});

  app.get('/health', async () => ({status: 'ok'}));

  app.post<{Body: WordTranslationRequest; Reply: WordTranslationResponse}>(
    '/v1/translate/word',
    {
      schema: {
        body: wordTranslationBodySchema,
        response: {200: wordTranslationResponseSchema},
      },
    },
    async (request, reply) => {
      const key = wordTranslationCacheKey(request.body);
      const cached = await dependencies.cache.get<WordTranslationResult>(key);
      if (cached != null) {
        return {...cached, cached: true};
      }

      try {
        const result = await dependencies.provider.translateWord(request.body);
        await dependencies.cache.put(key, result);
        return {...result, cached: false};
      } catch (error) {
        if (error instanceof TranslationProviderError) {
          request.log.warn(
            {kind: error.kind, message: error.message},
            'translation provider request failed',
          );
          const statusCode = error.kind === 'configuration' ? 503 : 502;
          return reply.code(statusCode).send({
            error: error.kind,
            message: error.message,
          } as never);
        }
        throw error;
      }
    },
  );

  app.post<{
    Body: TextAssistanceRequest;
    Reply: FragmentTranslationResponse;
  }>(
    '/v1/translate/fragment',
    {
      schema: {
        body: textAssistanceBodySchema,
        response: {200: fragmentTranslationResponseSchema},
      },
    },
    async (request, reply) => {
      const key = textAssistanceCacheKey('fragment', request.body);
      const cached = await dependencies.cache.get<FragmentTranslationResult>(
        key,
      );
      if (cached != null) {
        return {...cached, cached: true};
      }
      try {
        const result = await dependencies.provider.translateFragment(
          request.body,
        );
        await dependencies.cache.put(key, result);
        return {...result, cached: false};
      } catch (error) {
        if (error instanceof TranslationProviderError) {
          request.log.warn(
            {kind: error.kind, message: error.message},
            'fragment translation request failed',
          );
          const statusCode = error.kind === 'configuration' ? 503 : 502;
          return reply.code(statusCode).send({
            error: error.kind,
            message: error.message,
          } as never);
        }
        throw error;
      }
    },
  );

  app.post<{
    Body: TextAssistanceRequest;
    Reply: TextExplanationResponse;
  }>(
    '/v1/explain',
    {
      schema: {
        body: textAssistanceBodySchema,
        response: {200: textExplanationResponseSchema},
      },
    },
    async (request, reply) => {
      const key = textAssistanceCacheKey('explanation', request.body);
      const cached = await dependencies.cache.get<TextExplanationResult>(key);
      if (cached != null) {
        return {...cached, cached: true};
      }
      try {
        const result = await dependencies.provider.explainText(request.body);
        await dependencies.cache.put(key, result);
        return {...result, cached: false};
      } catch (error) {
        if (error instanceof TranslationProviderError) {
          request.log.warn(
            {kind: error.kind, message: error.message},
            'text explanation request failed',
          );
          const statusCode = error.kind === 'configuration' ? 503 : 502;
          return reply.code(statusCode).send({
            error: error.kind,
            message: error.message,
          } as never);
        }
        throw error;
      }
    },
  );

  return app;
}
