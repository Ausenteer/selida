import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:hyphenatorx/hyphenatorx.dart';
import 'package:hyphenatorx/languages/language_el_monoton.dart';
import 'package:hyphenatorx/languages/language_en_us.dart';
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

final class ReaderTextPainter {
  ReaderTextPainter._({
    required this._delegate,
    required this._hyphenColor,
    required this._hyphenLength,
    required this._sourceText,
    required this._displayText,
  }) : _plainSourceText = _sourceText.toPlainText();

  final TextPainter _delegate;
  final Color _hyphenColor;
  final double _hyphenLength;
  final InlineSpan _sourceText;
  final _DisplayText _displayText;
  final String _plainSourceText;
  static final RegExp _wordCharacter = RegExp(
    r"[\p{L}\p{M}\p{N}'’\-]",
    unicode: true,
  );

  InlineSpan? get text => _sourceText;
  TextAlign get textAlign => _delegate.textAlign;
  double get height => _delegate.height;

  @visibleForTesting
  String get debugDisplayText => _displayText.value;

  @visibleForTesting
  List<(Rect, Rect)> get debugBrokenHyphenBoxes =>
      _brokenHyphenBoxes().toList(growable: false);

  void layout({double minWidth = 0, double maxWidth = double.infinity}) {
    final reserve = _displayText.softHyphenOffsets.isEmpty
        ? 0.0
        : _hyphenLength + 1;
    _delegate.layout(
      minWidth: math.max(0, minWidth - reserve),
      maxWidth: maxWidth.isFinite ? math.max(0, maxWidth - reserve) : maxWidth,
    );
  }

  List<LineMetrics> computeLineMetrics() => _delegate.computeLineMetrics();

  TextPosition getPositionForOffset(Offset offset) {
    final position = _delegate.getPositionForOffset(offset);
    return TextPosition(
      offset: _displayText.sourceOffsetFor(position.offset),
      affinity: position.affinity,
    );
  }

  TextRange getLineBoundary(TextPosition position) {
    return _sourceRangeFor(
      _delegate.getLineBoundary(
        TextPosition(
          offset: _displayText.displayOffsetFor(position.offset),
          affinity: position.affinity,
        ),
      ),
    );
  }

  TextRange getWordBoundary(TextPosition position) {
    var start = position.offset.clamp(0, _plainSourceText.length);
    var end = start;
    while (start > 0 && _isWordCharacterAt(start - 1)) {
      start -= 1;
    }
    while (end < _plainSourceText.length && _isWordCharacterAt(end)) {
      end += 1;
    }
    return TextRange(start: start, end: end);
  }

  List<TextBox> getBoxesForSelection(TextSelection selection) {
    return _delegate.getBoxesForSelection(
      TextSelection(
        baseOffset: _displayText.displayOffsetFor(selection.baseOffset),
        extentOffset: _displayText.displayOffsetFor(selection.extentOffset),
        affinity: selection.affinity,
        isDirectional: selection.isDirectional,
      ),
    );
  }

  void paint(Canvas canvas, Offset offset) {
    _delegate.paint(canvas, offset);
    for (final (beforeRect, _) in _brokenHyphenBoxes()) {
      final left = beforeRect.right + 0.5;
      final y = beforeRect.top + beforeRect.height * 0.54;
      canvas.drawLine(
        offset + Offset(left, y),
        offset + Offset(left + _hyphenLength, y),
        Paint()
          ..color = _hyphenColor
          ..strokeWidth = 1.15
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  Iterable<(Rect, Rect)> _brokenHyphenBoxes() sync* {
    for (final softHyphenOffset in _displayText.softHyphenOffsets) {
      if (softHyphenOffset == 0 ||
          softHyphenOffset + 1 >= _displayText.value.length) {
        continue;
      }
      final before = _delegate.getBoxesForSelection(
        TextSelection(
          baseOffset: softHyphenOffset - 1,
          extentOffset: softHyphenOffset,
        ),
      );
      final after = _delegate.getBoxesForSelection(
        TextSelection(
          baseOffset: softHyphenOffset + 1,
          extentOffset: softHyphenOffset + 2,
        ),
      );
      if (before.isEmpty || after.isEmpty) {
        continue;
      }
      final beforeRect = before.last.toRect();
      final afterRect = after.first.toRect();
      if (afterRect.top <= beforeRect.top + 1) {
        continue;
      }
      yield (beforeRect, afterRect);
    }
  }

  void dispose() {
    _delegate.dispose();
  }

  bool _isWordCharacterAt(int offset) =>
      _wordCharacter.hasMatch(_plainSourceText.substring(offset, offset + 1));

  TextRange _sourceRangeFor(TextRange range) => TextRange(
    start: _displayText.sourceOffsetFor(range.start),
    end: _displayText.sourceOffsetFor(range.end),
  );
}

final class _DisplayText {
  const _DisplayText({
    required this.value,
    required this.sourceToDisplay,
    required this.displayToSource,
  });

  factory _DisplayText.identity(String value) {
    final offsets = List<int>.generate(value.length + 1, (int index) => index);
    return _DisplayText(
      value: value,
      sourceToDisplay: offsets,
      displayToSource: offsets,
    );
  }

  factory _DisplayText.fromHyphenated(String source, String display) {
    if (display == source || source.contains(_softHyphen)) {
      return _DisplayText.identity(source);
    }
    final sourceToDisplay = List<int>.filled(source.length + 1, 0);
    final displayToSource = List<int>.filled(display.length + 1, 0);
    var sourceOffset = 0;
    for (
      var displayOffset = 0;
      displayOffset < display.length;
      displayOffset++
    ) {
      final unit = display.codeUnitAt(displayOffset);
      if (unit == _softHyphenCodeUnit) {
        displayToSource[displayOffset + 1] = sourceOffset;
        continue;
      }
      if (sourceOffset >= source.length ||
          unit != source.codeUnitAt(sourceOffset)) {
        return _DisplayText.identity(source);
      }
      sourceToDisplay[sourceOffset] = displayOffset;
      sourceOffset += 1;
      displayToSource[displayOffset + 1] = sourceOffset;
    }
    if (sourceOffset != source.length) {
      return _DisplayText.identity(source);
    }
    sourceToDisplay[source.length] = display.length;
    return _DisplayText(
      value: display,
      sourceToDisplay: sourceToDisplay,
      displayToSource: displayToSource,
    );
  }

  static const String _softHyphen = '\u00ad';
  static const int _softHyphenCodeUnit = 0x00ad;

  final String value;
  final List<int> sourceToDisplay;
  final List<int> displayToSource;

  Iterable<int> get softHyphenOffsets sync* {
    for (var offset = 0; offset < value.length; offset++) {
      if (value.codeUnitAt(offset) == _softHyphenCodeUnit) {
        yield offset;
      }
    }
  }

  int displayOffsetFor(int sourceOffset) =>
      sourceToDisplay[sourceOffset.clamp(0, sourceToDisplay.length - 1)];

  int sourceOffsetFor(int displayOffset) =>
      displayToSource[displayOffset.clamp(0, displayToSource.length - 1)];
}

abstract final class ReaderPaginator {
  static const int layoutAlgorithmVersion = 8;
  static const String paragraphIndent = '\u2002';
  static final Hyphenator _englishHyphenator = Hyphenator(Language_en_us());
  static final Hyphenator _greekHyphenator = Hyphenator(Language_el_monoton());
  static final Map<String, _DisplayText> _hyphenationCache =
      <String, _DisplayText>{};

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
        usedHeight += _spacingBefore(
          block.kind,
          spec.paragraphStyle,
          previousKind: blockIndex > 0 ? blocks[blockIndex - 1].kind : null,
        );
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

  static ReaderTextPainter createPainter({
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
    final textHeight = isHeading
        ? math.min(spec.lineHeight, 1.3)
        : spec.lineHeight;
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
      height: textHeight,
      letterSpacing: isHeading ? -0.18 : 0,
      leadingDistribution: TextLeadingDistribution.even,
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
    final sourceRoot = TextSpan(style: baseStyle, children: children);
    final displayBody =
        spec.textAlignment == ReaderTextAlignment.justified && canJustify
        ? _hyphenatedText(text, spec.locale)
        : _DisplayText.identity(text);
    final displayText = _withPrefix(prefix, displayBody);
    final displaySpans = <ReaderInlineSpan>[
      for (final span in inlineSpans)
        ReaderInlineSpan(
          startOffset: displayBody.displayOffsetFor(span.startOffset),
          endOffset: displayBody.displayOffsetFor(span.endOffset),
          bold: span.bold,
          italic: span.italic,
          underline: span.underline,
          href: span.href,
          isFootnote: span.isFootnote,
        ),
    ];
    final displayRoot = TextSpan(
      style: baseStyle,
      children: <InlineSpan>[
        if (prefix.isNotEmpty) TextSpan(text: prefix),
        ..._styledTextSpans(
          text: displayBody.value,
          inlineSpans: displaySpans,
          linkColor: spec.linkColor ?? spec.textColor,
        ),
      ],
    );
    final delegate = TextPainter(
      text: displayRoot,
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
        height: textHeight,
        forceStrutHeight: false,
      ),
    );
    return ReaderTextPainter._(
      delegate: delegate,
      hyphenColor: spec.textColor,
      hyphenLength: spec.fontSize * 0.27,
      sourceText: sourceRoot,
      displayText: displayText,
    );
  }

  static _DisplayText _hyphenatedText(String text, Locale locale) {
    final language = locale.languageCode == 'el' ? 'el' : 'en';
    final key = '$language:$text';
    final cached = _hyphenationCache[key];
    if (cached != null) {
      return cached;
    }
    final hyphenator = language == 'el' ? _greekHyphenator : _englishHyphenator;
    final result = _DisplayText.fromHyphenated(
      text,
      hyphenator.hyphenateText(text),
    );
    if (_hyphenationCache.length >= 1024) {
      _hyphenationCache.clear();
    }
    _hyphenationCache[key] = result;
    return result;
  }

  static _DisplayText _withPrefix(String prefix, _DisplayText body) {
    if (prefix.isEmpty) {
      return body;
    }
    final sourceToDisplay = <int>[
      for (var index = 0; index <= prefix.length; index++) index,
      for (var index = 1; index < body.sourceToDisplay.length; index++)
        prefix.length + body.sourceToDisplay[index],
    ];
    final displayToSource = <int>[
      for (var index = 0; index <= prefix.length; index++) index,
      for (var index = 1; index < body.displayToSource.length; index++)
        prefix.length + body.displayToSource[index],
    ];
    return _DisplayText(
      value: '$prefix${body.value}',
      sourceToDisplay: sourceToDisplay,
      displayToSource: displayToSource,
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
    ReaderParagraphStyle style, {
    ReaderBlockKind? previousKind,
  }) {
    if (previousKind == ReaderBlockKind.heading) {
      return 12;
    }
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
          previousKind: _blockIndex > 0 ? blocks[_blockIndex - 1].kind : null,
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
