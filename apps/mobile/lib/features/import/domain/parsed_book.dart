import 'dart:typed_data';

enum ParsedBlockKind { paragraph, heading, quote }

final class ParsedBlock {
  const ParsedBlock({
    required this.kind,
    required this.text,
    required this.startOffset,
    required this.endOffset,
  });

  final ParsedBlockKind kind;
  final String text;
  final int startOffset;
  final int endOffset;
}

final class ParsedChapter {
  const ParsedChapter({
    required this.ordinal,
    required this.title,
    required this.href,
    required this.plainText,
    required this.blocks,
    required this.anchorOffsets,
  });

  final int ordinal;
  final String? title;
  final String? href;
  final String plainText;
  final List<ParsedBlock> blocks;
  final Map<String, int> anchorOffsets;
}

final class ParsedTocEntry {
  const ParsedTocEntry({
    required this.ordinal,
    required this.depth,
    required this.title,
    required this.chapterOrdinal,
    required this.textOffset,
  });

  final int ordinal;
  final int depth;
  final String title;
  final int? chapterOrdinal;
  final int textOffset;
}

final class ParsedBook {
  const ParsedBook({
    required this.format,
    required this.title,
    required this.author,
    required this.language,
    required this.contentHash,
    required this.chapters,
    required this.toc,
    required this.coverBytes,
    required this.coverExtension,
  });

  final String format;
  final String title;
  final String? author;
  final String language;
  final String contentHash;
  final List<ParsedChapter> chapters;
  final List<ParsedTocEntry> toc;
  final Uint8List? coverBytes;
  final String? coverExtension;

  int get totalLength => chapters.fold<int>(
    0,
    (int total, ParsedChapter chapter) => total + chapter.plainText.length,
  );
}
