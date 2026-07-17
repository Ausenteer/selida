# ADR 0001: MVP foundation

- Status: accepted
- Date: 2026-07-16

## Decision

Selida is a monorepo with a Flutter iOS/Android client and a Fastify TypeScript
API. The client uses Riverpod, go_router, Drift, a custom EPUB parser, and a
custom TextPainter-based reader. PostgreSQL is the server source of truth for
synced user data; book files and full book text never leave the device.

Riverpod is selected over Bloc because it keeps dependency composition and
asynchronous local-first state explicit without introducing event/transition
boilerplate for every screen. Providers remain replaceable in tests, while
domain and persistence types do not depend on Riverpod.

Exact glyph measurement remains on Flutter's UI isolate because TextPainter
depends on dart:ui. Parsing and text preprocessing run in worker isolates, while
layout is incremental, frame-budgeted, prefetched, and persisted by a layout
fingerprint.

SM-2 is the first scheduling engine behind a versioned interface. Review events
are retained so the scheduler can later be replaced with FSRS.

## Consequences

- Reader positions are UTF-16 text offsets, never page numbers.
- EPUB content is converted to a small canonical block model.
- A book deletion removes local content but keeps vocabulary source snapshots.
- API schemas are published as OpenAPI and used to generate the Dart client.
- Flutter Web, PDF, FB2, MOBI, TTS, Anki export, and book catalogs are outside
  the MVP.
