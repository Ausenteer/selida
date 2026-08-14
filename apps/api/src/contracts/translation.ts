import type {FastifyInstance} from 'fastify';

import openApiDocument from '../../../../packages/api-contract/openapi.json' with {
  type: 'json',
};
import type {components} from '../../../../packages/api-contract/generated/types.js';

type ContractSchemas = components['schemas'];

export type HealthResponse = ContractSchemas['HealthResponse'];
export type WordTranslationRequest =
  ContractSchemas['WordTranslationRequest'];
export type WordTranslationResponse =
  ContractSchemas['WordTranslationResponse'];
export type WordTranslationResult = Omit<WordTranslationResponse, 'cached'>;
export type TextAssistanceRequest =
  ContractSchemas['TextAssistanceRequest'];
export type FragmentTranslationResponse =
  ContractSchemas['FragmentTranslationResponse'];
export type FragmentTranslationResult = Omit<
  FragmentTranslationResponse,
  'cached'
>;
export type TextExplanationExample =
  ContractSchemas['TextExplanationExample'];
export type TextExplanationResponse =
  ContractSchemas['TextExplanationResponse'];
export type TextExplanationResult = Omit<TextExplanationResponse, 'cached'>;

type SchemaName = keyof ContractSchemas;
type JsonSchema = Record<string, unknown>;

const componentSchemas = openApiDocument.components.schemas;

function schemaId(name: SchemaName): string {
  return `https://selida.app/api/schemas/${name}`;
}

function normalizeReferences(value: unknown): unknown {
  if (Array.isArray(value)) {
    return value.map(normalizeReferences);
  }
  if (value == null || typeof value !== 'object') {
    return value;
  }
  return Object.fromEntries(
    Object.entries(value).map(([key, entry]) => {
      if (
        key === '$ref' &&
        typeof entry === 'string' &&
        entry.startsWith('#/components/schemas/')
      ) {
        return [
          key,
          `${schemaId(entry.slice('#/components/schemas/'.length) as SchemaName)}#`,
        ];
      }
      return [key, normalizeReferences(entry)];
    }),
  );
}

export function registerContractSchemas(app: FastifyInstance): void {
  for (const [name, schema] of Object.entries(componentSchemas)) {
    app.addSchema({
      $id: schemaId(name as SchemaName),
      ...(normalizeReferences(schema) as JsonSchema),
    });
  }
}

function schemaReference(name: SchemaName): JsonSchema {
  return {$ref: `${schemaId(name)}#`};
}

export const healthResponseSchema = schemaReference('HealthResponse');
export const apiErrorResponseSchema = schemaReference('ApiError');
export const wordTranslationBodySchema = schemaReference(
  'WordTranslationRequest',
);
export const wordTranslationResponseSchema = schemaReference(
  'WordTranslationResponse',
);
export const textAssistanceBodySchema = schemaReference(
  'TextAssistanceRequest',
);
export const fragmentTranslationResponseSchema = schemaReference(
  'FragmentTranslationResponse',
);
export const textExplanationResponseSchema = schemaReference(
  'TextExplanationResponse',
);
