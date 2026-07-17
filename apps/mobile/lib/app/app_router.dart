import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:selida/app/main_shell.dart';
import 'package:selida/features/dictionary/presentation/dictionary_screen.dart';
import 'package:selida/features/library/presentation/library_screen.dart';
import 'package:selida/features/reader/presentation/reader_screen.dart';
import 'package:selida/features/today/presentation/today_screen.dart';

final Provider<GoRouter> appRouterProvider = Provider<GoRouter>((Ref ref) {
  final router = GoRouter(
    initialLocation: '/today',
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder:
            (
              BuildContext context,
              GoRouterState state,
              StatefulNavigationShell navigationShell,
            ) {
              return MainShell(navigationShell: navigationShell);
            },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(path: '/today', builder: (_, _) => const TodayScreen()),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/library',
                builder: (_, _) => const LibraryScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/dictionary',
                builder: (_, _) => const DictionaryScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/reader/:bookId',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CupertinoPage<void>(
            key: state.pageKey,
            child: ReaderScreen(bookId: state.pathParameters['bookId']!),
          );
        },
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
