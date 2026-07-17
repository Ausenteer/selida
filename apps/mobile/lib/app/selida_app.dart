import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:selida/app/app_router.dart';
import 'package:selida/app/selida_theme.dart';
import 'package:selida/features/import/application/book_import_service.dart';
import 'package:selida/l10n/generated/app_localizations.dart';

final GlobalKey<ScaffoldMessengerState> _messengerKey =
    GlobalKey<ScaffoldMessengerState>();

final class SelidaApp extends ConsumerStatefulWidget {
  const SelidaApp({super.key});

  @override
  ConsumerState<SelidaApp> createState() => _SelidaAppState();
}

final class _SelidaAppState extends ConsumerState<SelidaApp> {
  StreamSubscription<List<SharedMediaFile>>? _shareSubscription;
  var _handlingShare = false;

  @override
  void initState() {
    super.initState();
    unawaited(_seedExampleBook());
    _shareSubscription = ReceiveSharingIntent.instance.getMediaStream().listen(
      (List<SharedMediaFile> files) => unawaited(_handleSharedFiles(files)),
      onError: (Object error) => _showShareError(),
    );
    unawaited(
      ReceiveSharingIntent.instance.getInitialMedia().then((
        List<SharedMediaFile> files,
      ) async {
        await _handleSharedFiles(files);
        await ReceiveSharingIntent.instance.reset();
      }),
    );
  }

  @override
  void dispose() {
    unawaited(_shareSubscription?.cancel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'Selida',
      debugShowCheckedModeBanner: false,
      theme: SelidaTheme.light,
      routerConfig: router,
      scaffoldMessengerKey: _messengerKey,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }

  Future<void> _handleSharedFiles(List<SharedMediaFile> files) async {
    if (_handlingShare || files.isEmpty) {
      return;
    }
    final service = ref.read(bookImportServiceProvider);
    final candidate = files
        .where(
          (SharedMediaFile file) =>
              file.type == SharedMediaType.file &&
              service.isSupportedPath(file.path),
        )
        .firstOrNull;
    if (candidate == null) {
      _showShareError();
      return;
    }
    _handlingShare = true;
    try {
      final bookId = await service.importPath(candidate.path);
      unawaited(ref.read(appRouterProvider).push('/reader/$bookId'));
    } on Object {
      _showShareError();
    } finally {
      _handlingShare = false;
    }
  }

  Future<void> _seedExampleBook() async {
    try {
      await ref.read(bookImportServiceProvider).ensureExampleBookImported();
    } on Object catch (error) {
      debugPrint('Could not import the example book: $error');
    }
  }

  void _showShareError() {
    final context = _messengerKey.currentContext;
    if (context == null) {
      return;
    }
    _messengerKey.currentState?.showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).shareImportError)),
    );
  }
}

extension<T> on Iterable<T> {
  T? get firstOrNull {
    final iterator = this.iterator;
    return iterator.moveNext() ? iterator.current : null;
  }
}
