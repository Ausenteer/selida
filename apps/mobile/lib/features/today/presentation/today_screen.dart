import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:selida/app/selida_theme.dart';
import 'package:selida/core/database/app_database.dart';
import 'package:selida/features/reader/application/reader_providers.dart';
import 'package:selida/l10n/generated/app_localizations.dart';

final class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context);
    final books = ref.watch(libraryBooksProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          strings.today,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          children: <Widget>[
            Text(
              strings.continueReading,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            books.when(
              data: (List<StoredBook> value) => value.isEmpty
                  ? const _NoRecentBook()
                  : _ContinueReadingCard(book: value.first),
              error: (_, _) => const _NoRecentBook(),
              loading: () => const _TodaySkeleton(height: 174),
            ),
            const SizedBox(height: 28),
            Text(
              strings.reviewsDue,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            DecoratedBox(
              decoration: BoxDecoration(
                color: SelidaColors.mutedSage.withValues(alpha: 0.72),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: SelidaColors.sage.withValues(alpha: 0.2),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: <Widget>[
                    const SizedBox.square(
                      dimension: 46,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: SelidaColors.forest,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check_rounded,
                          color: SelidaColors.surface,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        strings.noReviews,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _ContinueReadingCard extends ConsumerWidget {
  const _ContinueReadingCard({required this.book});

  final StoredBook book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(readerPositionProvider(book.id)).value;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: SelidaColors.forest.withValues(alpha: 0.1),
            blurRadius: 22,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Material(
          color: SelidaColors.surface,
          child: InkWell(
            onTap: () => unawaited(context.push('/reader/${book.id}')),
            child: SizedBox(
              height: 180,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 116,
                    height: double.infinity,
                    child:
                        book.coverPath != null &&
                            File(book.coverPath!).existsSync()
                        ? Image.file(File(book.coverPath!), fit: BoxFit.cover)
                        : ColoredBox(
                            color: SelidaColors.forest,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(14),
                                child: Text(
                                  book.title,
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: SelidaColors.surface,
                                    fontFamily: 'Literata',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 17),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 32,
                            height: 3,
                            decoration: BoxDecoration(
                              color: SelidaColors.terracotta,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            book.title,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          if (book.author case final String author) ...<Widget>[
                            const SizedBox(height: 5),
                            Text(
                              author,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                          const Spacer(),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: LinearProgressIndicator(
                              value: position?.progress ?? 0.0,
                              minHeight: 3,
                              backgroundColor: SelidaColors.line,
                              color: SelidaColors.terracotta,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final class _NoRecentBook extends StatelessWidget {
  const _NoRecentBook();

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(strings.emptyLibraryBody),
      ),
    );
  }
}

final class _TodaySkeleton extends StatelessWidget {
  const _TodaySkeleton({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: SelidaColors.line,
        borderRadius: BorderRadius.circular(18),
      ),
    );
  }
}
