part of 'reader_screen.dart';

final class _ReaderContentsSheet extends StatelessWidget {
  const _ReaderContentsSheet({
    required this.document,
    required this.currentChapterIndex,
  });

  final ReaderDocument document;
  final int currentChapterIndex;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final usableToc = document.toc
        .where((StoredTocEntry entry) => entry.chapterId != null)
        .toList();
    final useToc = usableToc.isNotEmpty;
    return FractionallySizedBox(
      heightFactor: 0.62,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 4, 22, 12),
            child: Text(
              strings.contents,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: useToc ? usableToc.length : document.chapters.length,
              itemBuilder: (BuildContext context, int index) {
                if (useToc) {
                  final entry = usableToc[index];
                  final chapterIndex = document.chapters.indexWhere(
                    (StoredChapter chapter) => chapter.id == entry.chapterId,
                  );
                  return ListTile(
                    contentPadding: EdgeInsets.only(
                      left: 20 + entry.depth * 18,
                      right: 20,
                    ),
                    selected: chapterIndex == currentChapterIndex,
                    title: Text(entry.title),
                    onTap: chapterIndex < 0
                        ? null
                        : () => Navigator.of(context).pop(
                            ReaderLocation(
                              chapterIndex: chapterIndex,
                              textOffset: entry.textOffset,
                            ),
                          ),
                  );
                }
                final chapter = document.chapters[index];
                return ListTile(
                  selected: index == currentChapterIndex,
                  title: Text(
                    chapter.title ?? '${strings.chapter} ${index + 1}',
                  ),
                  onTap: () => Navigator.of(
                    context,
                  ).pop(ReaderLocation(chapterIndex: index, textOffset: 0)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
