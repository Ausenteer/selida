import 'dart:math' as math;
import 'package:flutter/painting.dart';
import 'package:selida/features/reader/domain/reader_page.dart';

final class ReaderLayoutSpec {
  const ReaderLayoutSpec({
    required this.width,
    required this.height,
    required this.fontSize,
    required this.lineHeight,
    required this.locale,
    required this.textColor,
    this.paragraphStyle = ReaderParagraphStyle.book,
  });

  final double width;
  final double height;
  final double fontSize;
  final double lineHeight;
  final Locale locale;
  final Color textColor;
  final ReaderParagraphStyle paragraphStyle;
}

abstract final class ReaderPaginator {
  static const int layoutAlgorithmVersion = 2;
  static const String paragraphIndent = '\u2003';

  static double paragraphSpacingFor(ReaderParagraphStyle style) {
    return switch (style) {
      ReaderParagraphStyle.book => 4,
      ReaderParagraphStyle.modern => 14,
    };
  }

  static List<ReaderPage> paginate({
    required List<ReaderBlock> blocks,
    required ReaderLayoutSpec spec,
  }) {
    final cursor = start(blocks: blocks, spec: spec);
    final pages = <ReaderPage>[];
    while (!cursor.isComplete) {
      final page = cursor.nextPage();
      if (page != null) {
        pages.add(page);
      }
    }
    return List<ReaderPage>.unmodifiable(pages);
  }

  static ReaderPaginationCursor start({
    required List<ReaderBlock> blocks,
    required ReaderLayoutSpec spec,
  }) {
    return ReaderPaginationCursor._(blocks: blocks, spec: spec);
  }

  static ReaderPage? restorePage({
    required List<ReaderBlock> blocks,
    required ReaderLayoutSpec spec,
    required int startOffset,
    required int endOffset,
  }) {
    if (startOffset < 0 || endOffset <= startOffset) {
      return null;
    }
    final segments = <ReaderPageSegment>[];
    var usedHeight = 0.0;
    for (var blockIndex = 0; blockIndex < blocks.length; blockIndex += 1) {
      final block = blocks[blockIndex];
      if (block.endOffset <= startOffset) {
        continue;
      }
      if (block.startOffset >= endOffset) {
        break;
      }
      final segmentStart = math.max(startOffset, block.startOffset);
      final segmentEnd = math.min(endOffset, block.endOffset);
      if (segmentEnd <= segmentStart) {
        continue;
      }
      final localStart = segmentStart - block.startOffset;
      final localEnd = segmentEnd - block.startOffset;
      if (localStart < 0 ||
          localEnd > block.text.length ||
          localEnd <= localStart) {
        return null;
      }
      if (segments.isNotEmpty && localStart == 0) {
        usedHeight += paragraphSpacingFor(spec.paragraphStyle);
      }
      final shouldIndent = _shouldIndent(
        blocks: blocks,
        blockIndex: blockIndex,
        localOffset: localStart,
        style: spec.paragraphStyle,
      );
      final prefix = shouldIndent ? paragraphIndent : '';
      final text = block.text.substring(localStart, localEnd);
      final painter = _createPainter(
        text: '$prefix$text',
        kind: block.kind,
        spec: spec,
      )..layout(maxWidth: spec.width);
      final height = painter.height;
      painter.dispose();
      segments.add(
        ReaderPageSegment(
          kind: block.kind,
          text: text,
          globalStart: segmentStart,
          globalEnd: segmentEnd,
          indentFirstLine: shouldIndent,
          top: usedHeight,
          height: height,
        ),
      );
      usedHeight += height;
    }
    if (segments.isEmpty ||
        segments.first.globalStart != startOffset ||
        segments.last.globalEnd != endOffset ||
        usedHeight >
            spec.height + (spec.fontSize * 1.16 * spec.lineHeight) + 0.5) {
      return null;
    }
    return ReaderPage(segments: List<ReaderPageSegment>.unmodifiable(segments));
  }

  static TextPainter createPainter({
    required String text,
    required ReaderBlockKind kind,
    required ReaderLayoutSpec spec,
    int? maxLines,
  }) {
    return _createPainter(
      text: text,
      kind: kind,
      spec: spec,
      maxLines: maxLines,
    );
  }

  static TextPainter _createPainter({
    required String text,
    required ReaderBlockKind kind,
    required ReaderLayoutSpec spec,
    int? maxLines,
  }) {
    final isHeading = kind == ReaderBlockKind.heading;
    final isQuote = kind == ReaderBlockKind.quote;
    return TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: spec.textColor,
          fontFamily: 'Literata',
          fontSize: isHeading ? spec.fontSize * 1.16 : spec.fontSize,
          fontWeight: isHeading ? FontWeight.w600 : FontWeight.w400,
          fontStyle: isQuote ? FontStyle.italic : FontStyle.normal,
          height: spec.lineHeight,
          letterSpacing: 0.05,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
      locale: spec.locale,
      maxLines: maxLines,
      textScaler: TextScaler.noScaling,
      strutStyle: StrutStyle(
        fontFamily: 'Literata',
        fontSize: isHeading ? spec.fontSize * 1.16 : spec.fontSize,
        height: spec.lineHeight,
        forceStrutHeight: false,
      ),
    );
  }

  static int _firstCharacterLength(String value) {
    if (value.isEmpty) {
      return 0;
    }
    return value.runes.first > 0xffff ? 2 : 1;
  }

  static bool _shouldIndent({
    required List<ReaderBlock> blocks,
    required int blockIndex,
    required int localOffset,
    required ReaderParagraphStyle style,
  }) {
    return style == ReaderParagraphStyle.book &&
        localOffset == 0 &&
        blockIndex > 0 &&
        blocks[blockIndex].kind == ReaderBlockKind.paragraph &&
        blocks[blockIndex - 1].kind == ReaderBlockKind.paragraph;
  }
}

final class ReaderPaginationCursor {
  ReaderPaginationCursor._({required this.blocks, required this.spec});

  final List<ReaderBlock> blocks;
  final ReaderLayoutSpec spec;

  var _blockIndex = 0;
  var _localOffset = 0;

  bool get isComplete =>
      _blockIndex >= blocks.length ||
      blocks.isEmpty ||
      spec.width <= 0 ||
      spec.height <= 0;

  ReaderPage? nextPage() {
    if (isComplete) {
      return null;
    }

    final pageSegments = <ReaderPageSegment>[];
    var usedHeight = 0.0;

    ReaderPage finishPage() {
      return ReaderPage(
        segments: List<ReaderPageSegment>.unmodifiable(pageSegments),
      );
    }

    while (_blockIndex < blocks.length) {
      final block = blocks[_blockIndex];
      if (_localOffset >= block.text.length) {
        _blockIndex += 1;
        _localOffset = 0;
        continue;
      }

      if (_localOffset == 0 && pageSegments.isNotEmpty) {
        final minimumLine = spec.fontSize * spec.lineHeight;
        if (spec.height - usedHeight <
            ReaderPaginator.paragraphSpacingFor(spec.paragraphStyle) +
                minimumLine) {
          return finishPage();
        }
        usedHeight += ReaderPaginator.paragraphSpacingFor(spec.paragraphStyle);
      }

      final remaining = block.text.substring(_localOffset);
      final shouldIndent = ReaderPaginator._shouldIndent(
        blocks: blocks,
        blockIndex: _blockIndex,
        localOffset: _localOffset,
        style: spec.paragraphStyle,
      );
      final prefix = shouldIndent ? ReaderPaginator.paragraphIndent : '';
      final availableHeight = math.max(0, spec.height - usedHeight);
      final fullPainter = ReaderPaginator._createPainter(
        text: '$prefix$remaining',
        kind: block.kind,
        spec: spec,
      )..layout(maxWidth: spec.width);

      var consumed = remaining.length;
      if (fullPainter.height > availableHeight) {
        fullPainter.dispose();
        final approximateLineHeight = spec.fontSize * spec.lineHeight;
        final maxLines = math.max(
          1,
          (availableHeight / approximateLineHeight).floor(),
        );
        final clippedPainter = ReaderPaginator._createPainter(
          text: '$prefix$remaining',
          kind: block.kind,
          spec: spec,
          maxLines: maxLines,
        )..layout(maxWidth: spec.width);
        final position = clippedPainter.getPositionForOffset(
          Offset(spec.width - 0.5, math.max(0.5, clippedPainter.height - 0.5)),
        );
        final line = clippedPainter.getLineBoundary(position);
        consumed = (line.end - prefix.length).clamp(0, remaining.length);
        if (consumed == 0) {
          consumed = ReaderPaginator._firstCharacterLength(remaining);
        }
        clippedPainter.dispose();
      } else {
        fullPainter.dispose();
      }

      final segmentText = remaining.substring(0, consumed);
      final segmentPainter = ReaderPaginator._createPainter(
        text: '$prefix$segmentText',
        kind: block.kind,
        spec: spec,
      )..layout(maxWidth: spec.width);
      final segmentHeight = segmentPainter.height;
      segmentPainter.dispose();
      pageSegments.add(
        ReaderPageSegment(
          kind: block.kind,
          text: segmentText,
          globalStart: block.startOffset + _localOffset,
          globalEnd: block.startOffset + _localOffset + consumed,
          indentFirstLine: shouldIndent,
          top: usedHeight,
          height: segmentHeight,
        ),
      );
      usedHeight += segmentHeight;
      _localOffset += consumed;

      if (_localOffset < block.text.length) {
        return finishPage();
      } else {
        _blockIndex += 1;
        _localOffset = 0;
      }
    }
    return pageSegments.isEmpty ? null : finishPage();
  }
}
