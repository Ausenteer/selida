import 'package:flutter/foundation.dart';

enum ReaderBlockKind { paragraph, heading, quote, listItem, separator, image }

enum ReaderParagraphStyle { book, modern }

enum ReaderTextAlignment { left, justified }

enum ReaderFontFamily { literata, inter }

@immutable
final class ReaderInlineSpan {
  const ReaderInlineSpan({
    required this.startOffset,
    required this.endOffset,
    this.bold = false,
    this.italic = false,
    this.underline = false,
    this.href,
    this.isFootnote = false,
    this.targetChapterOrdinal,
    this.targetOffset,
  });

  final int startOffset;
  final int endOffset;
  final bool bold;
  final bool italic;
  final bool underline;
  final String? href;
  final bool isFootnote;
  final int? targetChapterOrdinal;
  final int? targetOffset;

  ReaderInlineSpan? slice(int start, int end) {
    final overlapStart = startOffset < start ? start : startOffset;
    final overlapEnd = endOffset > end ? end : endOffset;
    if (overlapEnd <= overlapStart) {
      return null;
    }
    return ReaderInlineSpan(
      startOffset: overlapStart - start,
      endOffset: overlapEnd - start,
      bold: bold,
      italic: italic,
      underline: underline,
      href: href,
      isFootnote: isFootnote,
      targetChapterOrdinal: targetChapterOrdinal,
      targetOffset: targetOffset,
    );
  }
}

@immutable
final class ReaderBlock {
  const ReaderBlock({
    required this.kind,
    required this.text,
    required this.startOffset,
    required this.endOffset,
    this.inlineSpans = const <ReaderInlineSpan>[],
    this.resourcePath,
    this.altText,
  });

  final ReaderBlockKind kind;
  final String text;
  final int startOffset;
  final int endOffset;
  final List<ReaderInlineSpan> inlineSpans;
  final String? resourcePath;
  final String? altText;
}

@immutable
final class ReaderPageSegment {
  const ReaderPageSegment({
    required this.kind,
    required this.text,
    required this.globalStart,
    required this.globalEnd,
    required this.indentFirstLine,
    required this.top,
    required this.height,
    this.inlineSpans = const <ReaderInlineSpan>[],
    this.resourcePath,
    this.altText,
  });

  final ReaderBlockKind kind;
  final String text;
  final int globalStart;
  final int globalEnd;
  final bool indentFirstLine;
  final double top;
  final double height;
  final List<ReaderInlineSpan> inlineSpans;
  final String? resourcePath;
  final String? altText;
}

@immutable
final class ReaderPage {
  const ReaderPage({required this.segments});

  final List<ReaderPageSegment> segments;

  int get startOffset => segments.isEmpty ? 0 : segments.first.globalStart;
  int get endOffset => segments.isEmpty ? 0 : segments.last.globalEnd;
}

@immutable
final class ReaderTextRange {
  const ReaderTextRange({required this.startOffset, required this.endOffset});

  final int startOffset;
  final int endOffset;

  int get length => endOffset - startOffset;
}

@immutable
final class ReaderTextSelection extends ReaderTextRange {
  const ReaderTextSelection({
    required super.startOffset,
    required super.endOffset,
  });
}
