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
  });

  final double width;
  final double height;
  final double fontSize;
  final double lineHeight;
  final Locale locale;
  final Color textColor;
}

abstract final class ReaderPaginator {
  static const double paragraphSpacing = 12;
  static const String paragraphIndent = '\u2003';

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
            ReaderPaginator.paragraphSpacing + minimumLine) {
          return finishPage();
        }
        usedHeight += ReaderPaginator.paragraphSpacing;
      }

      final remaining = block.text.substring(_localOffset);
      final shouldIndent =
          block.kind == ReaderBlockKind.paragraph && _localOffset == 0;
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
