import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:selida/features/reader/application/reader_paginator.dart';
import 'package:selida/features/reader/domain/reader_page.dart';

final class ReaderWordHit {
  const ReaderWordHit({
    required this.word,
    required this.startOffset,
    required this.endOffset,
    required this.rect,
    this.link,
  });

  final String word;
  final int startOffset;
  final int endOffset;
  final Rect rect;
  final ReaderInlineSpan? link;
}

final class ReaderSelectionHit {
  const ReaderSelectionHit({required this.selection, required this.rect});

  final ReaderTextSelection selection;
  final Rect rect;
}

final class ReaderPageSurface extends StatefulWidget {
  const ReaderPageSurface({
    required this.page,
    required this.spec,
    required this.onWordTap,
    required this.onBlankTap,
    this.onTextSelected,
    this.onLinkTap,
    this.activeSelection,
    this.selectionIsControlled = false,
    this.onSelectionChanged,
    this.onSelectionReady,
    this.onSelectionEdgeRequested,
    this.selectionHandlesVisible = true,
    this.focusedRange,
    this.focusedColor = const Color(0x24657568),
    this.savedRanges = const <ReaderTextRange>[],
    this.selectionColor = const Color(0x33657568),
    this.savedUnderlineColor = const Color(0xff657568),
    super.key,
  });

  final ReaderPage page;
  final ReaderLayoutSpec spec;
  final ValueChanged<ReaderWordHit> onWordTap;
  final ValueChanged<Offset> onBlankTap;
  final ValueChanged<ReaderSelectionHit>? onTextSelected;
  final ValueChanged<ReaderInlineSpan>? onLinkTap;
  final ReaderTextRange? activeSelection;
  final bool selectionIsControlled;
  final ValueChanged<ReaderTextRange?>? onSelectionChanged;
  final ValueChanged<ReaderSelectionHit>? onSelectionReady;
  final ValueChanged<int>? onSelectionEdgeRequested;
  final bool selectionHandlesVisible;
  final ReaderTextRange? focusedRange;
  final Color focusedColor;
  final List<ReaderTextRange> savedRanges;
  final Color selectionColor;
  final Color savedUnderlineColor;

  @override
  State<ReaderPageSurface> createState() => _ReaderPageSurfaceState();
}

final class _ReaderPageSurfaceState extends State<ReaderPageSurface> {
  static const _maximumSelectionLength = 1000;

  ReaderTextRange? _anchorWord;
  ReaderTextRange? _selection;
  DateTime? _lastEdgeRequest;

  ReaderTextRange? get _effectiveSelection =>
      widget.selectionIsControlled ? widget.activeSelection : _selection;

  @override
  Widget build(BuildContext context) {
    final painter = _ReaderPagePainter(
      page: widget.page,
      spec: widget.spec,
      selection: _effectiveSelection,
      focusedRange: widget.focusedRange,
      savedRanges: widget.savedRanges,
      selectionColor: widget.selectionColor,
      focusedColor: widget.focusedColor,
      savedUnderlineColor: widget.savedUnderlineColor,
    );
    final handles = widget.selectionHandlesVisible
        ? painter.selectionHandles()
        : const <_SelectionHandlePosition>[];
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapUp: (TapUpDetails details) => _handleTap(details, painter),
          onLongPressStart: (LongPressStartDetails details) {
            final word = painter.wordAt(details.localPosition);
            if (word == null) {
              return;
            }
            final range = ReaderTextRange(
              startOffset: word.startOffset,
              endOffset: word.endOffset,
            );
            _anchorWord = range;
            _setSelection(range);
            unawaited(HapticFeedback.selectionClick());
          },
          onLongPressMoveUpdate: (LongPressMoveUpdateDetails details) {
            _requestAdjacentPageIfNeeded(details.localPosition.dx);
            final anchor = _anchorWord;
            final word = painter.wordAt(details.localPosition);
            if (anchor == null || word == null) {
              return;
            }
            _setSelection(
              word.startOffset < anchor.startOffset
                  ? ReaderTextRange(
                      startOffset: math.max(
                        word.startOffset,
                        anchor.endOffset - _maximumSelectionLength,
                      ),
                      endOffset: anchor.endOffset,
                    )
                  : ReaderTextRange(
                      startOffset: anchor.startOffset,
                      endOffset: math.min(
                        word.endOffset,
                        anchor.startOffset + _maximumSelectionLength,
                      ),
                    ),
            );
          },
          onLongPressEnd: (_) {
            _anchorWord = null;
            _notifySelectionReady(painter);
          },
          child: CustomPaint(painter: painter, size: Size.infinite),
        ),
        for (final segment in widget.page.segments)
          if (segment.kind == ReaderBlockKind.image)
            Positioned(
              left: 0,
              right: 0,
              top: segment.top,
              height: segment.height,
              child: IgnorePointer(
                child: Semantics(
                  image: true,
                  label: segment.altText ?? segment.text,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child:
                        segment.resourcePath != null &&
                            File(segment.resourcePath!).existsSync()
                        ? Image.file(
                            File(segment.resourcePath!),
                            fit: BoxFit.contain,
                            errorBuilder: (_, _, _) => _ImageFallback(
                              label: segment.altText ?? segment.text,
                            ),
                          )
                        : _ImageFallback(
                            label: segment.altText ?? segment.text,
                          ),
                  ),
                ),
              ),
            ),
        for (final handle in handles)
          Positioned(
            left: handle.position.dx - 18,
            top: handle.position.dy - 8,
            width: 36,
            height: 42,
            child: GestureDetector(
              key: ValueKey<String>(
                handle.isStart
                    ? 'selection-start-handle'
                    : 'selection-end-handle',
              ),
              behavior: HitTestBehavior.opaque,
              onPanUpdate: (DragUpdateDetails details) =>
                  _moveHandle(handle.isStart, details.globalPosition, painter),
              onPanEnd: (_) => _notifySelectionReady(painter),
              child: _SelectionHandle(
                color: widget.selectionColor.withAlpha(255),
              ),
            ),
          ),
      ],
    );
  }

  void _handleTap(TapUpDetails details, _ReaderPagePainter painter) {
    final selection = _effectiveSelection;
    if (selection != null) {
      final hit = painter.wordAt(details.localPosition);
      if (hit != null &&
          hit.startOffset < selection.endOffset &&
          hit.endOffset > selection.startOffset) {
        final hit = painter.selectionHit(selection);
        if (hit != null) {
          widget.onTextSelected?.call(hit);
        }
        return;
      }
      _setSelection(null);
      return;
    }
    final hit = painter.wordAt(details.localPosition);
    if (hit == null) {
      widget.onBlankTap(details.localPosition);
    } else if (hit.link case final link?) {
      widget.onLinkTap?.call(link);
    } else {
      widget.onWordTap(hit);
    }
  }

  void _notifySelectionReady(_ReaderPagePainter painter) {
    final selection = _effectiveSelection;
    if (selection == null) {
      return;
    }
    final hit = painter.selectionHit(selection);
    if (hit != null) {
      widget.onSelectionReady?.call(hit);
    }
  }

  void _moveHandle(
    bool isStart,
    Offset globalPosition,
    _ReaderPagePainter painter,
  ) {
    final box = context.findRenderObject()! as RenderBox;
    final position = box.globalToLocal(globalPosition);
    _requestAdjacentPageIfNeeded(position.dx);
    final word = painter.wordAt(position);
    final selection = _effectiveSelection;
    if (word == null || selection == null) {
      return;
    }
    final updated = isStart
        ? ReaderTextRange(
            startOffset: math.max(
              math.min(word.startOffset, selection.endOffset - 1),
              selection.endOffset - _maximumSelectionLength,
            ),
            endOffset: selection.endOffset,
          )
        : ReaderTextRange(
            startOffset: selection.startOffset,
            endOffset: math.min(
              math.max(word.endOffset, selection.startOffset + 1),
              selection.startOffset + _maximumSelectionLength,
            ),
          );
    _setSelection(updated);
  }

  void _requestAdjacentPageIfNeeded(double dx) {
    const deliberateOvershoot = 24.0;
    final direction = dx < -deliberateOvershoot
        ? -1
        : dx > context.size!.width + deliberateOvershoot
        ? 1
        : 0;
    if (direction == 0 || widget.onSelectionEdgeRequested == null) {
      return;
    }
    final now = DateTime.now();
    if (_lastEdgeRequest != null &&
        now.difference(_lastEdgeRequest!) < const Duration(milliseconds: 450)) {
      return;
    }
    _lastEdgeRequest = now;
    widget.onSelectionEdgeRequested!(direction);
  }

  void _setSelection(ReaderTextRange? value) {
    if (mounted) {
      setState(() => _selection = value);
    }
    widget.onSelectionChanged?.call(value);
  }
}

final class _ImageFallback extends StatelessWidget {
  const _ImageFallback({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(Icons.image_outlined),
              const SizedBox(height: 6),
              Text(
                label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _SelectionHandle extends StatelessWidget {
  const _SelectionHandle({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(width: 2, height: 14, color: color),
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
        ],
      ),
    );
  }
}

final class _SelectionHandlePosition {
  const _SelectionHandlePosition({
    required this.position,
    required this.isStart,
  });

  final Offset position;
  final bool isStart;
}

final class _ReaderPagePainter extends CustomPainter {
  _ReaderPagePainter({
    required this.page,
    required this.spec,
    required this.selection,
    required this.focusedRange,
    required this.savedRanges,
    required this.selectionColor,
    required this.focusedColor,
    required this.savedUnderlineColor,
  });

  final ReaderPage page;
  final ReaderLayoutSpec spec;
  final ReaderTextRange? selection;
  final ReaderTextRange? focusedRange;
  final List<ReaderTextRange> savedRanges;
  final Color selectionColor;
  final Color focusedColor;
  final Color savedUnderlineColor;

  @override
  void paint(Canvas canvas, Size size) {
    for (final segment in page.segments) {
      if (segment.kind == ReaderBlockKind.image) {
        continue;
      }
      final prefix = segment.indentFirstLine
          ? ReaderPaginator.paragraphIndent
          : '';
      final painter = ReaderPaginator.createPainter(
        text: segment.text,
        prefix: prefix,
        inlineSpans: segment.inlineSpans,
        kind: segment.kind,
        spec: spec,
      )..layout(maxWidth: spec.width);
      if (focusedRange case final range?) {
        _paintFocusedHighlight(
          canvas,
          painter,
          segment,
          prefix.length,
          range,
          focusedColor,
        );
      }
      if (selection case final range?) {
        _paintHighlight(
          canvas,
          painter,
          segment,
          prefix.length,
          range,
          selectionColor,
        );
      }
      painter.paint(canvas, Offset(0, segment.top));
      for (final range in savedRanges) {
        _paintSavedUnderline(canvas, painter, segment, prefix.length, range);
      }
      painter.dispose();
    }
  }

  ReaderWordHit? wordAt(Offset position) {
    for (final segment in page.segments) {
      if (segment.kind == ReaderBlockKind.image) {
        continue;
      }
      if (position.dy < segment.top ||
          position.dy > segment.top + segment.height) {
        continue;
      }
      final prefix = segment.indentFirstLine
          ? ReaderPaginator.paragraphIndent
          : '';
      final painter = ReaderPaginator.createPainter(
        text: segment.text,
        prefix: prefix,
        inlineSpans: segment.inlineSpans,
        kind: segment.kind,
        spec: spec,
      )..layout(maxWidth: spec.width);
      final localPosition = position - Offset(0, segment.top);
      final textPosition = painter.getPositionForOffset(localPosition);
      final boundary = painter.getWordBoundary(textPosition);
      final start = (boundary.start - prefix.length).clamp(
        0,
        segment.text.length,
      );
      final end = (boundary.end - prefix.length).clamp(0, segment.text.length);
      if (end <= start) {
        painter.dispose();
        return null;
      }
      final word = segment.text.substring(start, end);
      if (!_containsLetter(word)) {
        painter.dispose();
        return null;
      }
      final boxes = painter.getBoxesForSelection(
        TextSelection(
          baseOffset: start + prefix.length,
          extentOffset: end + prefix.length,
        ),
      );
      final hitBoxes = <Rect>[
        for (final box in boxes)
          box.toRect().shift(Offset(0, segment.top)).inflate(2.5),
      ];
      if (!hitBoxes.any((Rect rect) => rect.contains(position))) {
        painter.dispose();
        return null;
      }
      final rect = boxes.isEmpty
          ? Rect.fromLTWH(position.dx, position.dy, 1, spec.fontSize)
          : boxes.first.toRect().shift(Offset(0, segment.top));
      painter.dispose();
      ReaderInlineSpan? link;
      for (final span in segment.inlineSpans) {
        if (span.href != null &&
            span.startOffset < end &&
            span.endOffset > start) {
          link = span;
          break;
        }
      }
      return ReaderWordHit(
        word: word,
        startOffset: segment.globalStart + start,
        endOffset: segment.globalStart + end,
        rect: rect,
        link: link,
      );
    }
    return null;
  }

  List<_SelectionHandlePosition> selectionHandles() {
    final range = selection;
    if (range == null) {
      return const <_SelectionHandlePosition>[];
    }
    final result = <_SelectionHandlePosition>[];
    for (final segment in page.segments) {
      if (segment.kind == ReaderBlockKind.image) {
        continue;
      }
      final prefix = segment.indentFirstLine
          ? ReaderPaginator.paragraphIndent
          : '';
      final painter = ReaderPaginator.createPainter(
        text: segment.text,
        prefix: prefix,
        inlineSpans: segment.inlineSpans,
        kind: segment.kind,
        spec: spec,
      )..layout(maxWidth: spec.width);
      if (range.startOffset >= segment.globalStart &&
          range.startOffset < segment.globalEnd) {
        final local = range.startOffset - segment.globalStart + prefix.length;
        final boxes = painter.getBoxesForSelection(
          TextSelection(
            baseOffset: local,
            extentOffset: math.min(
              local + 1,
              painter.text!.toPlainText().length,
            ),
          ),
        );
        if (boxes.isNotEmpty) {
          final rect = boxes.first.toRect().shift(Offset(0, segment.top));
          result.add(
            _SelectionHandlePosition(
              position: Offset(rect.left, rect.bottom),
              isStart: true,
            ),
          );
        }
      }
      if (range.endOffset > segment.globalStart &&
          range.endOffset <= segment.globalEnd) {
        final local = range.endOffset - segment.globalStart + prefix.length;
        final boxes = painter.getBoxesForSelection(
          TextSelection(
            baseOffset: math.max(prefix.length, local - 1),
            extentOffset: local,
          ),
        );
        if (boxes.isNotEmpty) {
          final rect = boxes.last.toRect().shift(Offset(0, segment.top));
          result.add(
            _SelectionHandlePosition(
              position: Offset(rect.right, rect.bottom),
              isStart: false,
            ),
          );
        }
      }
      painter.dispose();
    }
    return result;
  }

  ReaderSelectionHit? selectionHit(ReaderTextRange range) {
    Rect? bounds;
    for (final segment in page.segments) {
      if (segment.kind == ReaderBlockKind.image ||
          range.endOffset <= segment.globalStart ||
          range.startOffset >= segment.globalEnd) {
        continue;
      }
      final prefix = segment.indentFirstLine
          ? ReaderPaginator.paragraphIndent
          : '';
      final painter = ReaderPaginator.createPainter(
        text: segment.text,
        prefix: prefix,
        inlineSpans: segment.inlineSpans,
        kind: segment.kind,
        spec: spec,
      )..layout(maxWidth: spec.width);
      final localStart =
          math.max(range.startOffset, segment.globalStart) -
          segment.globalStart +
          prefix.length;
      final localEnd =
          math.min(range.endOffset, segment.globalEnd) -
          segment.globalStart +
          prefix.length;
      final boxes = painter.getBoxesForSelection(
        TextSelection(baseOffset: localStart, extentOffset: localEnd),
      );
      for (final box in boxes) {
        final rect = box.toRect().shift(Offset(0, segment.top));
        bounds = bounds == null ? rect : bounds.expandToInclude(rect);
      }
      painter.dispose();
    }
    if (bounds == null) {
      return null;
    }
    return ReaderSelectionHit(
      selection: ReaderTextSelection(
        startOffset: range.startOffset,
        endOffset: range.endOffset,
      ),
      rect: bounds,
    );
  }

  void _paintHighlight(
    Canvas canvas,
    ReaderTextPainter painter,
    ReaderPageSegment segment,
    int prefixLength,
    ReaderTextRange range,
    Color color,
  ) {
    final boxes = _boxesForRange(painter, segment, prefixLength, range);
    final paint = Paint()..color = color;
    for (final box in boxes) {
      final rect = box.toRect().shift(Offset(0, segment.top));
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect.inflate(1), const Radius.circular(3)),
        paint,
      );
    }
  }

  void _paintFocusedHighlight(
    Canvas canvas,
    ReaderTextPainter painter,
    ReaderPageSegment segment,
    int prefixLength,
    ReaderTextRange range,
    Color color,
  ) {
    final boxes = _boxesForRange(painter, segment, prefixLength, range);
    final markerPaint = Paint()..color = color;
    final underlinePaint = Paint()
      ..color = color.withValues(alpha: 0.62)
      ..strokeWidth = 1.15
      ..strokeCap = StrokeCap.round;
    for (final box in boxes) {
      final rect = box.toRect().shift(Offset(0, segment.top));
      final marker = Rect.fromLTRB(
        rect.left - 0.5,
        rect.bottom - math.max(4, spec.fontSize * 0.22),
        rect.right + 0.5,
        rect.bottom + 0.5,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(marker, const Radius.circular(2)),
        markerPaint,
      );
      canvas.drawLine(
        Offset(rect.left, rect.bottom + 0.8),
        Offset(rect.right, rect.bottom + 0.8),
        underlinePaint,
      );
    }
  }

  void _paintSavedUnderline(
    Canvas canvas,
    ReaderTextPainter painter,
    ReaderPageSegment segment,
    int prefixLength,
    ReaderTextRange range,
  ) {
    final boxes = _boxesForRange(painter, segment, prefixLength, range);
    final paint = Paint()..color = savedUnderlineColor;
    for (final box in boxes) {
      final rect = box.toRect().shift(Offset(0, segment.top));
      final y = rect.bottom + 1;
      for (var x = rect.left + 1; x < rect.right; x += 3.5) {
        canvas.drawCircle(Offset(x, y), 0.75, paint);
      }
    }
  }

  List<TextBox> _boxesForRange(
    ReaderTextPainter painter,
    ReaderPageSegment segment,
    int prefixLength,
    ReaderTextRange range,
  ) {
    final start = math.max(range.startOffset, segment.globalStart);
    final end = math.min(range.endOffset, segment.globalEnd);
    if (end <= start) {
      return const <TextBox>[];
    }
    return painter.getBoxesForSelection(
      TextSelection(
        baseOffset: start - segment.globalStart + prefixLength,
        extentOffset: end - segment.globalStart + prefixLength,
      ),
    );
  }

  @override
  bool shouldRepaint(_ReaderPagePainter oldDelegate) {
    return oldDelegate.page != page ||
        oldDelegate.spec != spec ||
        oldDelegate.selection != selection ||
        oldDelegate.focusedRange != focusedRange ||
        oldDelegate.savedRanges != savedRanges ||
        oldDelegate.selectionColor != selectionColor ||
        oldDelegate.focusedColor != focusedColor ||
        oldDelegate.savedUnderlineColor != savedUnderlineColor;
  }

  bool _containsLetter(String value) {
    for (final rune in value.runes) {
      if ((rune >= 0x0041 && rune <= 0x005a) ||
          (rune >= 0x0061 && rune <= 0x007a) ||
          (rune >= 0x0370 && rune <= 0x03ff) ||
          (rune >= 0x1f00 && rune <= 0x1fff) ||
          (rune >= 0x0400 && rune <= 0x052f)) {
        return true;
      }
    }
    return false;
  }
}
