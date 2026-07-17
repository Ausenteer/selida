# Selida MVP architecture

## Applications

- `apps/mobile`: Flutter application for iOS and Android.
- `apps/api`: Fastify and TypeScript API.
- `packages/api-contract`: generated OpenAPI artifacts and conformance fixtures.
- `infra`: PostgreSQL migrations and local infrastructure.

## Mobile boundaries

The mobile application is feature-first. Features depend on small domain
interfaces and use Riverpod for composition. Drift is the local source of truth;
network writes are queued in a sync outbox.

The reader pipeline is:

1. Copy the selected file into the application sandbox.
2. Parse and normalize it in a worker isolate.
3. Store books, chapters, blocks, and TOC entries in one Drift transaction.
4. Lay out the current page exactly with TextPainter on the UI isolate.
5. Prefetch adjacent pages and persist their UTF-16 ranges by layout fingerprint.

## Server boundaries

The API is split into auth, sync, AI, entitlements, and public configuration
modules. AI providers implement one typed adapter contract. AI secrets and model
selection are server-only.

The translation cache key includes the request kind, language direction,
normalized source, context hash where required, schema version, and prompt
version. Cache rows do not contain the source book fragment.

## Privacy

Book files, chapters, and full text remain local. The server receives only AI
request fragments and context sentences explicitly saved into the synced
dictionary. The latter must be stated in the privacy policy.
