# Selida

MVP системы изучения языка через чтение собственных EPUB и TXT. Репозиторий
содержит Flutter-клиент и TypeScript API. Реализованы импорт, локальная
библиотека, собственный постраничный ридер, перевод слов и фраз, AI-объяснения
и сохранение слов в локальный словарь.

## Структура

- `apps/mobile` — Flutter iOS/Android, Riverpod, go_router и Drift.
- `apps/api` — строгий TypeScript workspace с Fastify API и AI-адаптерами.
- `packages/api-contract` — канонический OpenAPI 3.1-контракт,
  сгенерированные TypeScript-типы и Dart-клиент.
- `infra` — будущие PostgreSQL-миграции и локальная инфраструктура.
- `docs` — архитектурные решения и отчёты по вехам.

## Быстрый старт мобильного приложения

Проект закреплён на Flutter 3.44.6 в `.fvmrc`.

```sh
cd apps/mobile
fvm flutter pub get
fvm dart run build_runner build --delete-conflicting-outputs
fvm flutter run
```

Без FVM используйте ту же стабильную версию Flutter напрямую. Для Android
нужны JDK 17 и Android SDK с compileSdk 37. Для iOS нужен полный Xcode; в Apple
Developer account следует зарегистрировать App Group `group.com.selida.app` для
Runner и Share Extension. Bundle ID `com.selida.app` пока считается рабочим и
может быть заменён до настройки signing.

## Запуск API

```sh
cp .env.example .env
npm install
set -a && source .env && set +a
npm run dev
```

Для реальных переводов укажите `GEMINI_API_KEY`. Для локальной проверки без
внешнего AI используйте `SELIDA_AI_PROVIDER=mock`.

## Проверки

```sh
cd apps/mobile
flutter analyze
flutter test
flutter build apk --debug

cd ../..
npm install
npm run api:validate
npm run build
```

При изменении API сначала обновите `packages/api-contract/openapi.json`, затем
перегенерируйте оба клиента одной командой:

```sh
npm run api:generate
```

Для генерации нужен Java 11+; Android toolchain проекта использует JDK 17.

Отчёты о состоянии и известных ограничениях:

- [`docs/milestone-1.md`](docs/milestone-1.md) — импорт и основа ридера;
- [`docs/milestone-2.md`](docs/milestone-2.md) — перевод и завершённые
  взаимодействия ридера.
