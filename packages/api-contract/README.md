# API contract

`openapi.json` is the canonical OpenAPI 3.1 contract for the Selida API. The
server imports its runtime JSON schemas and uses TypeScript types generated from
the same document. The Flutter application depends on the generated Dart client
in `generated/dart`.

## Regeneration

OpenAPI Generator requires Java 11 or newer. Selida's Android toolchain already
requires JDK 17.

```sh
npm install
npm run api:validate
npm run api:generate
```

Generated sources are committed so consumers do not need the generator during
normal builds. Do not edit files under `generated` by hand.
