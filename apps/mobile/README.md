# Selida mobile

Flutter-клиент для iOS и Android. Код организован по продуктовым функциям:

- `lib/core/database` — локальная Drift-схема и миграции;
- `lib/features/import` — file picker, EPUB/TXT parser и запись книги;
- `lib/features/library` — библиотека и удаление книг;
- `lib/features/reader` — пагинация, canvas-рендер, hit testing и настройки;
- `lib/app` — навигация, тема, локализация и обработка системного Share.

Генерируемые Drift и localization-файлы хранятся рядом с исходниками, чтобы
чистый checkout можно было анализировать и тестировать сразу после `pub get`.

Не редактируйте вручную `app_database.g.dart` и файлы в
`lib/l10n/generated` — они обновляются build_runner и `flutter gen-l10n`.
