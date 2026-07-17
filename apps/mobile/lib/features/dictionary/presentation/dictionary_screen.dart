import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:selida/app/selida_theme.dart';
import 'package:selida/features/dictionary/application/vocabulary_service.dart';
import 'package:selida/l10n/generated/app_localizations.dart';

final class DictionaryScreen extends ConsumerStatefulWidget {
  const DictionaryScreen({super.key});

  @override
  ConsumerState<DictionaryScreen> createState() => _DictionaryScreenState();
}

final class _DictionaryScreenState extends ConsumerState<DictionaryScreen> {
  var _query = '';
  var _bookId = '';
  var _status = '';

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final entries = ref.watch(vocabularyEntriesProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          strings.dictionary,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: entries.when(
        data: (List<VocabularyEntry> value) => _buildDictionary(value),
        error: (_, _) => _DictionaryError(
          onRetry: () => ref.invalidate(vocabularyEntriesProvider),
        ),
        loading: _DictionarySkeleton.new,
      ),
    );
  }

  Widget _buildDictionary(List<VocabularyEntry> entries) {
    final strings = AppLocalizations.of(context);
    if (entries.isEmpty) {
      return const _EmptyDictionary();
    }

    final books = <String, String>{};
    for (final entry in entries) {
      for (final occurrence in entry.occurrences) {
        final bookId = occurrence.sourceBookId;
        if (bookId != null) {
          books[bookId] = occurrence.sourceBookTitle;
        }
      }
    }
    final normalizedQuery = _query.trim().toLowerCase();
    final filtered = entries.where((VocabularyEntry entry) {
      final occurrence = entry.latestOccurrence;
      final matchesQuery =
          normalizedQuery.isEmpty ||
          entry.item.lemma.toLowerCase().contains(normalizedQuery) ||
          entry.item.translation.toLowerCase().contains(normalizedQuery) ||
          (occurrence?.surfaceForm.toLowerCase().contains(normalizedQuery) ??
              false) ||
          (occurrence?.contextSentence.toLowerCase().contains(
                normalizedQuery,
              ) ??
              false);
      final matchesBook =
          _bookId.isEmpty ||
          entry.occurrences.any(
            (occurrence) => occurrence.sourceBookId == _bookId,
          );
      final matchesStatus = _status.isEmpty || entry.item.status == _status;
      return matchesQuery && matchesBook && matchesStatus;
    }).toList();

    return SafeArea(
      top: false,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 10),
            child: TextField(
              onChanged: (String value) => setState(() => _query = value),
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: strings.searchWords,
                prefixIcon: const Icon(Icons.search_rounded),
                filled: true,
                fillColor: SelidaColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: SelidaColors.line),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: SelidaColors.line),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: Row(
              children: <Widget>[
                _DictionaryFilter(
                  label: _bookId.isEmpty
                      ? strings.allBooks
                      : books[_bookId] ?? strings.allBooks,
                  selectedValue: _bookId,
                  options: <(String, String)>[
                    ('', strings.allBooks),
                    for (final book in books.entries) (book.key, book.value),
                  ],
                  onSelected: (String value) => setState(() => _bookId = value),
                ),
                const SizedBox(width: 8),
                _DictionaryFilter(
                  label: _statusLabel(strings, _status),
                  selectedValue: _status,
                  options: <(String, String)>[
                    ('', strings.allStatuses),
                    ('new', strings.statusNew),
                    ('learning', strings.statusLearning),
                    ('learned', strings.statusLearned),
                  ],
                  onSelected: (String value) => setState(() => _status = value),
                ),
              ],
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? const _EmptySearchResult()
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
                    physics: const BouncingScrollPhysics(),
                    itemCount: filtered.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 10),
                    itemBuilder: (BuildContext context, int index) =>
                        _VocabularyTile(entry: filtered[index]),
                  ),
          ),
        ],
      ),
    );
  }

  String _statusLabel(AppLocalizations strings, String status) {
    return switch (status) {
      'new' => strings.statusNew,
      'learning' => strings.statusLearning,
      'learned' => strings.statusLearned,
      _ => strings.allStatuses,
    };
  }
}

final class _DictionaryFilter extends StatelessWidget {
  const _DictionaryFilter({
    required this.label,
    required this.selectedValue,
    required this.options,
    required this.onSelected,
  });

  final String label;
  final String selectedValue;
  final List<(String, String)> options;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      initialValue: selectedValue,
      onSelected: onSelected,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        for (final option in options)
          PopupMenuItem<String>(value: option.$1, child: Text(option.$2)),
      ],
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: SelidaColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: SelidaColors.line),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 9, 9, 9),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(label, style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(width: 4),
              const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

final class _VocabularyTile extends StatelessWidget {
  const _VocabularyTile({required this.entry});

  final VocabularyEntry entry;

  @override
  Widget build(BuildContext context) {
    final occurrence = entry.latestOccurrence;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: SelidaColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: SelidaColors.line),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: SelidaColors.forest.withValues(alpha: 0.055),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 7,
                  height: 7,
                  margin: const EdgeInsets.only(top: 8, right: 10),
                  decoration: BoxDecoration(
                    color: _statusColor(entry.item.status),
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        entry.item.lemma,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontFamily: 'Literata',
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        entry.item.translation,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                if (entry.item.kind == 'phrase' ||
                    entry.item.partOfSpeech != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 3),
                    child: Text(
                      entry.item.kind == 'phrase'
                          ? AppLocalizations.of(context).phraseLabel
                          : entry.item.partOfSpeech!,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: SelidaColors.ink.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
              ],
            ),
            if (occurrence != null) ...<Widget>[
              const SizedBox(height: 12),
              Text(
                occurrence.contextSentence,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  height: 1.4,
                  color: SelidaColors.ink.withValues(alpha: 0.62),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                occurrence.sourceBookTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: SelidaColors.sage),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    return switch (status) {
      'learned' => const Color(0xff4f7960),
      'learning' => SelidaColors.terracotta,
      _ => const Color(0xff8b9188),
    };
  }
}

final class _EmptyDictionary extends StatelessWidget {
  const _EmptyDictionary();

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(36),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(
              Icons.bookmark_outline_rounded,
              size: 48,
              color: SelidaColors.sage,
            ),
            const SizedBox(height: 18),
            Text(
              strings.emptyDictionaryTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              strings.emptyDictionaryBody,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

final class _EmptySearchResult extends StatelessWidget {
  const _EmptySearchResult();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.search_off_rounded,
        size: 42,
        color: SelidaColors.ink.withValues(alpha: 0.35),
      ),
    );
  }
}

final class _DictionaryError extends StatelessWidget {
  const _DictionaryError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(strings.dictionaryLoadError),
          const SizedBox(height: 12),
          OutlinedButton(onPressed: onRetry, child: Text(strings.retry)),
        ],
      ),
    );
  }
}

final class _DictionarySkeleton extends StatelessWidget {
  const _DictionarySkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: 5,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (_, _) => Container(
        height: 124,
        decoration: BoxDecoration(
          color: SelidaColors.mutedSage.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(18),
        ),
      ),
    );
  }
}
