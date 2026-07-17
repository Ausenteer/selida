import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:selida/app/selida_theme.dart';
import 'package:selida/core/database/app_database.dart';
import 'package:selida/features/import/application/book_import_service.dart';
import 'package:selida/features/import/domain/book_parse_exception.dart';
import 'package:selida/features/reader/application/reader_providers.dart';
import 'package:selida/l10n/generated/app_localizations.dart';

final class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({super.key});

  @override
  ConsumerState<LibraryScreen> createState() => _LibraryScreenState();
}

final class _LibraryScreenState extends ConsumerState<LibraryScreen> {
  var _isImporting = false;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final books = ref.watch(libraryBooksProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          strings.library,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: <Widget>[
            Expanded(
              child: books.when(
                data: (List<StoredBook> value) => value.isEmpty
                    ? const _EmptyLibrary()
                    : _BookGrid(books: value, onDelete: _confirmDelete),
                error: (Object error, StackTrace stackTrace) => _LibraryError(
                  onRetry: () => ref.invalidate(libraryBooksProvider),
                ),
                loading: _LibrarySkeleton.new,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 18),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton.icon(
                  onPressed: _isImporting ? null : _importBook,
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: _isImporting
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.add_rounded),
                  label: Text(
                    _isImporting ? strings.importingBook : strings.importBook,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _importBook() async {
    setState(() => _isImporting = true);
    try {
      final id = await ref.read(bookImportServiceProvider).pickAndImport();
      if (!mounted || id == null) {
        return;
      }
      unawaited(context.push('/reader/$id'));
    } on BookParseException catch (error) {
      if (!mounted) {
        return;
      }
      final strings = AppLocalizations.of(context);
      final message = switch (error.code) {
        BookParseErrorCode.unsupportedFormat ||
        BookParseErrorCode.invalidEncoding => strings.unsupportedBook,
        _ => strings.invalidBook,
      };
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } finally {
      if (mounted) {
        setState(() => _isImporting = false);
      }
    }
  }

  Future<void> _confirmDelete(StoredBook book) async {
    final strings = AppLocalizations.of(context);
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(strings.deleteBook),
        content: Text(strings.deleteBookBody),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(strings.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: SelidaColors.error),
            child: Text(strings.delete),
          ),
        ],
      ),
    );
    if (shouldDelete ?? false) {
      await ref.read(bookImportServiceProvider).deleteBook(book.id);
    }
  }
}

final class _BookGrid extends StatelessWidget {
  const _BookGrid({required this.books, required this.onDelete});

  final List<StoredBook> books;
  final ValueChanged<StoredBook> onDelete;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 24,
        crossAxisSpacing: 18,
        childAspectRatio: 0.58,
      ),
      itemCount: books.length,
      itemBuilder: (BuildContext context, int index) {
        final book = books[index];
        return _BookTile(
          book: book,
          onTap: () => context.push('/reader/${book.id}'),
          onLongPress: () => onDelete(book),
        );
      },
    );
  }
}

final class _BookTile extends ConsumerWidget {
  const _BookTile({
    required this.book,
    required this.onTap,
    required this.onLongPress,
  });

  final StoredBook book;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context);
    final progress =
        ref.watch(readerPositionProvider(book.id)).value?.progress ?? 0.0;
    return Semantics(
      button: true,
      label: book.title,
      child: GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _BookCover(book: book)),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 3,
                backgroundColor: SelidaColors.line,
                color: SelidaColors.sage,
              ),
            ),
            const SizedBox(height: 9),
            Text(
              book.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 3),
            Text(
              book.author ?? strings.unknownAuthor,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: SelidaColors.ink.withValues(alpha: 0.58),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _BookCover extends StatelessWidget {
  const _BookCover({required this.book});

  final StoredBook book;

  @override
  Widget build(BuildContext context) {
    final coverPath = book.coverPath;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: SelidaColors.forest.withValues(alpha: 0.16),
            blurRadius: 14,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: ColoredBox(
          color: _coverColor(book.id),
          child: coverPath != null && File(coverPath).existsSync()
              ? Image.file(
                  File(coverPath),
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => _GeneratedCover(book: book),
                )
              : _GeneratedCover(book: book),
        ),
      ),
    );
  }

  Color _coverColor(String seed) {
    const colors = <Color>[
      Color(0xff355844),
      Color(0xffa65f49),
      Color(0xff465a68),
      Color(0xff8b7044),
    ];
    return colors[seed.hashCode.abs() % colors.length];
  }
}

final class _GeneratedCover extends StatelessWidget {
  const _GeneratedCover({required this.book});

  final StoredBook book;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 22),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withValues(alpha: 0.42)),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              book.title,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Literata',
                fontSize: 17,
                height: 1.2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final class _EmptyLibrary extends StatelessWidget {
  const _EmptyLibrary();

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(36),
        child: Column(
          children: <Widget>[
            const _BookStackIllustration(),
            const SizedBox(height: 30),
            Text(
              strings.emptyLibraryTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Text(
              strings.emptyLibraryBody,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: SelidaColors.ink.withValues(alpha: 0.62),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _BookStackIllustration extends StatelessWidget {
  const _BookStackIllustration();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      height: 124,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          _bookShape(width: 160, height: 34, color: const Color(0xff9d8c72)),
          Positioned(
            bottom: 31,
            child: _bookShape(
              width: 142,
              height: 37,
              color: const Color(0xff7c8a80),
            ),
          ),
          Positioned(
            bottom: 65,
            child: Transform.rotate(
              angle: -0.06,
              child: _bookShape(
                width: 126,
                height: 43,
                color: const Color(0xffb7a38a),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bookShape({
    required double width,
    required double height,
    required Color color,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: SelidaColors.ink.withValues(alpha: 0.18)),
      ),
    );
  }
}

final class _LibrarySkeleton extends StatelessWidget {
  const _LibrarySkeleton();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 24,
        crossAxisSpacing: 18,
        childAspectRatio: 0.58,
      ),
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: SelidaColors.line.withValues(alpha: 0.72),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(height: 12, width: 110, color: SelidaColors.line),
          const SizedBox(height: 7),
          Container(height: 9, width: 72, color: SelidaColors.line),
        ],
      ),
    );
  }
}

final class _LibraryError extends StatelessWidget {
  const _LibraryError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Center(
      child: FilledButton.tonal(onPressed: onRetry, child: Text(strings.retry)),
    );
  }
}
