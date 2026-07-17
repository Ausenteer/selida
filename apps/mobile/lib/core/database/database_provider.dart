import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:selida/core/database/app_database.dart';

final Provider<AppDatabase> databaseProvider = Provider<AppDatabase>((Ref ref) {
  final database = AppDatabase.defaults();
  ref.onDispose(database.close);
  return database;
});
