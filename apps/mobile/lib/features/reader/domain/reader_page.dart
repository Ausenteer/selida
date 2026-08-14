import 'package:flutter/foundation.dart';

enum ReaderBlockKind { paragraph, heading, quote }

enum ReaderParagraphStyle { book, modern }

@immutable
final class ReaderBlock {
  const ReaderBlock({
    required this.kind,
    required this.text,
    required this.startOffset,
    required this.endOffset,
  });

  final ReaderBlockKind kind;
  final String text;
  final int startOffset;
  final int endOffset;
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
  });

  final ReaderBlockKind kind;
  final String text;
  final int globalStart;
  final int globalEnd;
  final bool indentFirstLine;
  final double top;
  final double height;
}

@immutable
final class ReaderPage {
  const ReaderPage({required this.segments});

  final List<ReaderPageSegment> segments;

  int get startOffset => segments.isEmpty ? 0 : segments.first.globalStart;
  int get endOffset => segments.isEmpty ? 0 : segments.last.globalEnd;
}
