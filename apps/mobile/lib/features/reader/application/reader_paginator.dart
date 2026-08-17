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
    this.linkColor,
    this.paragraphStyle = ReaderParagraphStyle.book,
    this.textAlignment = ReaderTextAlignment.left,
    this.fontFamily = ReaderFontFamily.literata,
  });

  final double width;
  final double height;
  final double fontSize;
  final double lineHeight;
  final Locale locale;
  final Color textColor;
  final Color? linkColor;
  final ReaderParagraphStyle paragraphStyle;
  final ReaderTextAlignment textAlignment;
  final ReaderFontFamily fontFamily;
}

abstract final class ReaderPaginator {
  static const int layoutAlgorithmVersion = 4;
  static const String paragraphIndent = '\u2003';

  static double paragraphSpacingFor(ReaderParagraphStyle style) {
    return switch (style) {
      ReaderParagraphStyle.book => 4,
      ReaderParagraphStyle.modern => 14,
    };
  }

  static double imageHeightFor(ReaderLayoutSpec spec) {
    return math.min(240, math.max(120, spec.height * 0.42));
  }

  static String fontFamilyFor(ReaderFontFamily family) {
    return switch (family) {
      ReaderFontFamily.literata => 'Literata',
      ReaderFontFamily.inter => 'Inter',
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
        usedHeight += _spacingBefore(block.kind, spec.paragraphStyle);
      }
      final shouldIndent = _shouldIndent(
        blocks: blocks,
        blockIndex: blockIndex,
        localOffset: localStart,
        style: spec.paragraphStyle,
      );
      final text = block.text.substring(localStart, localEnd);
      final inlineSpans = _sliceInlineSpans(
        block.inlineSpans,
        localStart,
        localEnd,
      );
      late final double height;
      if (block.kind == ReaderBlockKind.image) {
        height = imageHeightFor(spec);
      } else {
        final painter = createPainter(
          text: text,
          prefix: shouldIndent ? paragraphIndent : '',
          inlineSpans: inlineSpans,
          kind: block.kind,
          spec: spec,
        )..layout(maxWidth: spec.width);
        height = painter.height;
        painter.dispose();
      }
      segments.add(
        ReaderPageSegment(
          kind: block.kind,
          text: text,
          globalStart: segmentStart,
          globalEnd: segmentEnd,
          indentFirstLine: shouldIndent,
          top: usedHeight,
          height: height,
          inlineSpans: inlineSpans,
          resourcePath: block.resourcePath,
          altText: block.altText,
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
    String prefix = '',
    List<ReaderInlineSpan> inlineSpans = const <ReaderInlineSpan>[],
    int? maxLines,
  }) {
    final isHeading = kind == ReaderBlockKind.heading;
    final isQuote = kind == ReaderBlockKind.quote;
    final isSeparator = kind == ReaderBlockKind.separator;
    final baseStyle = TextStyle(
      color: spec.textColor,
      fontFamily: fontFamilyFor(spec.fontFamily),
      fontSize: isHeading
          ? spec.fontSize * 1.16
          : isSeparator
          ? spec.fontSize * 0.9
          : spec.fontSize,
      fontWeight: isHeading ? FontWeight.w600 : FontWeight.w400,
      fontStyle: isQuote ? FontStyle.italic : FontStyle.normal,
      height: spec.lineHeight,
      letterSpacing: 0.05,
    );
    final children = <InlineSpan>[
      if (prefix.isNotEmpty) TextSpan(text: prefix),
      ..._styledTextSpans(
        text: text,
        inlineSpans: inlineSpans,
        linkColor: spec.linkColor ?? spec.textColor,
      ),
    ];
    final canJustify =
        kind == ReaderBlockKind.paragraph ||
        kind == ReaderBlockKind.quote ||
        kind == ReaderBlockKind.listItem;
    return TextPainter(
      text: TextSpan(style: baseStyle, children: children),
      textDirection: TextDirection.ltr,
      textAlign: isSeparator
          ? TextAlign.center
          : spec.textAlignment == ReaderTextAlignment.justified && canJustify
          ? TextAlign.justify
          : TextAlign.left,
      locale: spec.locale,
      maxLines: maxLines,
      textScaler: TextScaler.noScaling,
      strutStyle: StrutStyle(
        fontFamily: fontFamilyFor(spec.fontFamily),
        fontSize: isHeading ? spec.fontSize * 1.16 : spec.fontSize,
        height: spec.lineHeight,
        forceStrutHeight: false,
      ),
    );
  }

  static List<InlineSpan> _styledTextSpans({
    required String text,
    required List<ReaderInlineSpan> inlineSpans,
    required Color linkColor,
  }) {
    if (inlineSpans.isEmpty) {
      return <InlineSpan>[TextSpan(text: text)];
    }
    final result = <InlineSpan>[];
    var cursor = 0;
    for (final span in inlineSpans) {
      final start = span.startOffset.clamp(cursor, text.length);
      final end = span.endOffset.clamp(start, text.length);
      if (start > cursor) {
        result.add(TextSpan(text: text.substring(cursor, start)));
      }
      if (end > start) {
        result.add(
          TextSpan(
            text: text.substring(start, end),
            style: TextStyle(
              color: span.href == null ? null : linkColor,
              fontWeight: span.bold ? FontWeight.w700 : null,
              fontStyle: span.italic ? FontStyle.italic : null,
              decoration: span.underline || span.href != null
                  ? TextDecoration.underline
                  : null,
              decorationStyle: span.isFootnote
                  ? TextDecorationStyle.dotted
                  : null,
            ),
          ),
        );
      }
      cursor = end;
    }
    if (cursor < text.length) {
      result.add(TextSpan(text: text.substring(cursor)));
    }
    return result;
  }

  static List<ReaderInlineSpan> _sliceInlineSpans(
    List<ReaderInlineSpan> spans,
    int start,
    int end,
  ) {
    return List<ReaderInlineSpan>.unmodifiable(<ReaderInlineSpan>[
      for (final span in spans) ?span.slice(start, end),
    ]);
  }

  static int _firstCharacterLength(String value) {
    if (value.isEmpty) {
      return 0;
    }
    return value.runes.first > 0xffff ? 2 : 1;
  }

  static double _spacingBefore(
    ReaderBlockKind kind,
    ReaderParagraphStyle style,
  ) {
    return switch (kind) {
      ReaderBlockKind.heading => 18,
      ReaderBlockKind.separator => 14,
      ReaderBlockKind.image => 16,
      _ => paragraphSpacingFor(style),
    };
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
        final spacing = ReaderPaginator._spacingBefore(
          block.kind,
          spec.paragraphStyle,
        );
        final minimumHeight = block.kind == ReaderBlockKind.image
            ? ReaderPaginator.imageHeightFor(spec)
            : spec.fontSize * spec.lineHeight;
        if (spec.height - usedHeight < spacing + minimumHeight) {
          return finishPage();
        }
        usedHeight += spacing;
      }

      if (block.kind == ReaderBlockKind.image) {
        final imageHeight = math.min(
          ReaderPaginator.imageHeightFor(spec),
          spec.height - usedHeight,
        );
        pageSegments.add(
          ReaderPageSegment(
            kind: block.kind,
            text: block.text,
            globalStart: block.startOffset,
            globalEnd: block.endOffset,
            indentFirstLine: false,
            top: usedHeight,
            height: imageHeight,
            resourcePath: block.resourcePath,
            altText: block.altText,
          ),
        );
        usedHeight += imageHeight;
        _blockIndex += 1;
        _localOffset = 0;
        if (_blockIndex < blocks.length) {
          return finishPage();
        }
        continue;
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
      final remainingSpans = ReaderPaginator._sliceInlineSpans(
        block.inlineSpans,
        _localOffset,
        block.text.length,
      );
      final fullPainter = ReaderPaginator.createPainter(
        text: remaining,
        prefix: prefix,
        inlineSpans: remainingSpans,
        kind: block.kind,
        spec: spec,
      )..layout(maxWidth: spec.width);

      var consumed = remaining.length;
      if (fullPainter.height > availableHeight) {
        final totalLineCount = fullPainter.computeLineMetrics().length;
        fullPainter.dispose();
        final approximateLineHeight = spec.fontSize * spec.lineHeight;
        var maxLines = math.max(
          1,
          (availableHeight / approximateLineHeight).floor(),
        );
        if (totalLineCount - maxLines == 1 && maxLines > 2) {
          maxLines -= 1;
        }
        if (maxLines < 2 && pageSegments.isNotEmpty) {
          return finishPage();
        }
        final clippedPainter = ReaderPaginator.createPainter(
          text: remaining,
          prefix: prefix,
          inlineSpans: remainingSpans,
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
      final segmentSpans = ReaderPaginator._sliceInlineSpans(
        block.inlineSpans,
        _localOffset,
        _localOffset + consumed,
      );
      final segmentPainter = ReaderPaginator.createPainter(
        text: segmentText,
        prefix: prefix,
        inlineSpans: segmentSpans,
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
          inlineSpans: segmentSpans,
          resourcePath: block.resourcePath,
          altText: block.altText,
        ),
      );
      usedHeight += segmentHeight;
      _localOffset += consumed;

      if (_localOffset < block.text.length) {
        return finishPage();
      }
      _blockIndex += 1;
      _localOffset = 0;
    }
    return pageSegments.isEmpty ? null : finishPage();
  }
}
