import {createHash} from 'node:crypto';

import type {
  TextAssistanceRequest,
  WordTranslationRequest,
} from '../contracts/translation.js';

export interface TranslationCache {
  get<T>(key: string): Promise<T | undefined>;
  put<T>(key: string, value: T): Promise<void>;
}

export class MemoryTranslationCache implements TranslationCache {
  private readonly values = new Map<string, unknown>();

  async get<T>(key: string): Promise<T | undefined> {
    return this.values.get(key) as T | undefined;
  }

  async put<T>(key: string, value: T): Promise<void> {
    this.values.set(key, value);
  }
}

export function wordTranslationCacheKey(
  request: WordTranslationRequest,
): string {
  const contextHash = createHash('sha256')
    .update(request.context.trim())
    .digest('hex');
  return createHash('sha256')
    .update(
      JSON.stringify({
        kind: 'word',
        sourceLanguage: request.sourceLanguage,
        targetLanguage: request.targetLanguage,
        source: request.source.trim().toLocaleLowerCase(request.sourceLanguage),
        contextHash,
        schemaVersion: 1,
        promptVersion: 1,
      }),
    )
    .digest('hex');
}

export function textAssistanceCacheKey(
  kind: 'fragment' | 'explanation',
  request: TextAssistanceRequest,
): string {
  return createHash('sha256')
    .update(
      JSON.stringify({
        kind,
        sourceLanguage: request.sourceLanguage,
        targetLanguage: request.targetLanguage,
        interfaceLanguage: request.interfaceLanguage,
        source: request.source.trim(),
        contextHash: createHash('sha256')
          .update(request.context.trim())
          .digest('hex'),
        schemaVersion: 1,
        promptVersion: 2,
      }),
    )
    .digest('hex');
}
