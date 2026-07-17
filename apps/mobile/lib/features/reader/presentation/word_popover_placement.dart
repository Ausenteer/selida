import 'package:flutter/widgets.dart';

@immutable
final class WordPopoverPlacement {
  const WordPopoverPlacement({
    required this.left,
    required this.width,
    required this.showBelow,
    required this.caretX,
  });

  final double left;
  final double width;
  final bool showBelow;
  final double caretX;
}

WordPopoverPlacement calculateWordPopoverPlacement({
  required Size screenSize,
  required EdgeInsets safePadding,
  required Rect wordRect,
  double estimatedHeight = 190,
}) {
  final width = (screenSize.width - 32).clamp(240.0, 300.0);
  final left = (wordRect.center.dx - width / 2)
      .clamp(12.0, screenSize.width - width - 12)
      .toDouble();
  final minimumTop = safePadding.top + 6;
  final maximumBottom = screenSize.height - safePadding.bottom - 6;
  final spaceBelow = maximumBottom - wordRect.bottom;
  final spaceAbove = wordRect.top - minimumTop;
  final showBelow = spaceBelow >= estimatedHeight || spaceBelow >= spaceAbove;
  final caretX = (wordRect.center.dx - left).clamp(22.0, width - 22).toDouble();
  return WordPopoverPlacement(
    left: left,
    width: width,
    showBelow: showBelow,
    caretX: caretX,
  );
}

Offset calculateWordPopoverOffset({
  required Size screenSize,
  required EdgeInsets safePadding,
  required Rect wordRect,
  required Size popoverSize,
  required WordPopoverPlacement placement,
}) {
  final minimumTop = safePadding.top + 6;
  final maximumTop =
      screenSize.height - safePadding.bottom - 6 - popoverSize.height;
  final preferredTop = placement.showBelow
      ? wordRect.bottom + 5
      : wordRect.top - popoverSize.height - 5;
  return Offset(
    placement.left,
    preferredTop.clamp(minimumTop, maximumTop).toDouble(),
  );
}
