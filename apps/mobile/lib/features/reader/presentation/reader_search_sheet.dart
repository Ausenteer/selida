part of 'reader_screen.dart';

final class _ReaderSearchSheet extends StatefulWidget {
  const _ReaderSearchSheet({required this.document});

  final ReaderDocument document;

  @override
  State<_ReaderSearchSheet> createState() => _ReaderSearchSheetState();
}

final class _ReaderSearchSheetState extends State<_ReaderSearchSheet> {
  static const ReaderSearchController _searchController =
      ReaderSearchController();

  final TextEditingController _queryController = TextEditingController();
  Timer? _debounce;
  List<ReaderSearchResult> _results = const <ReaderSearchResult>[];
  var _loading = false;
  var _revision = 0;

  @override
  void dispose() {
    _debounce?.cancel();
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return FractionallySizedBox(
      heightFactor: 0.78,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 2, 12, 12),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    strings.searchInBook,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  onPressed: Navigator.of(context).pop,
                  tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _queryController,
              autofocus: true,
              textInputAction: TextInputAction.search,
              onChanged: _scheduleSearch,
              decoration: InputDecoration(
                hintText: strings.searchBookHint,
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _loading
                    ? const Padding(
                        padding: EdgeInsets.all(14),
                        child: SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : null,
              ),
            ),
          ),
          const SizedBox(height: 12),
          if (_queryController.text.trim().isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Text(
                strings.searchResultsCount(_results.length),
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          const SizedBox(height: 6),
          Expanded(child: _buildResults(strings)),
        ],
      ),
    );
  }

  Widget _buildResults(AppLocalizations strings) {
    if (_queryController.text.trim().isEmpty) {
      return Center(child: Text(strings.searchStartTyping));
    }
    if (!_loading && _results.isEmpty) {
      return Center(child: Text(strings.searchNoResults));
    }
    return ListView.separated(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.fromLTRB(14, 4, 14, 24),
      itemCount: _results.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (BuildContext context, int index) {
        final result = _results[index];
        final baseStyle = Theme.of(context).textTheme.bodyMedium;
        return ListTile(
          title: Text(result.chapterTitle),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text.rich(
              TextSpan(
                style: baseStyle,
                children: <InlineSpan>[
                  TextSpan(text: result.leadingText),
                  if (result.leadingText.isNotEmpty) const TextSpan(text: ' '),
                  TextSpan(
                    text: result.matchText,
                    style: baseStyle?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  if (result.trailingText.isNotEmpty)
                    TextSpan(text: ' ${result.trailingText}'),
                ],
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          onTap: () => Navigator.of(context).pop(
            ReaderLocation(
              chapterIndex: result.chapterIndex,
              textOffset: result.offset,
            ),
          ),
        );
      },
    );
  }

  void _scheduleSearch(String query) {
    _debounce?.cancel();
    final revision = ++_revision;
    if (query.trim().isEmpty) {
      setState(() {
        _results = const <ReaderSearchResult>[];
        _loading = false;
      });
      return;
    }
    setState(() => _loading = true);
    _debounce = Timer(const Duration(milliseconds: 220), () {
      unawaited(_runSearch(query, revision));
    });
  }

  Future<void> _runSearch(String query, int revision) async {
    final strings = AppLocalizations.of(context);
    final results = await _searchController.search(
      query: query,
      chapters: <ReaderSearchChapter>[
        for (var index = 0; index < widget.document.chapters.length; index++)
          ReaderSearchChapter(
            chapterIndex: index,
            title:
                widget.document.chapters[index].title ??
                '${strings.chapter} ${index + 1}',
            text: widget.document.chapters[index].plainText,
          ),
      ],
    );
    if (!mounted || revision != _revision) {
      return;
    }
    setState(() {
      _results = results;
      _loading = false;
    });
  }
}
