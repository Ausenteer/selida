import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:selida/app/selida_theme.dart';
import 'package:selida/core/database/app_database.dart';
import 'package:selida/core/database/database_provider.dart';
import 'package:selida/features/library/presentation/library_screen.dart';
import 'package:selida/l10n/generated/app_localizations.dart';

void main() {
  testWidgets('empty library has one clear import action', (
    WidgetTester tester,
  ) async {
    final database = AppDatabase(NativeDatabase.memory());
    await tester.pumpWidget(
      ProviderScope(
        overrides: [databaseProvider.overrideWithValue(database)],
        child: MaterialApp(
          theme: SelidaTheme.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const LibraryScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Your next story starts here'), findsOneWidget);
    expect(find.text('Import book'), findsOneWidget);

    await database.close();
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
