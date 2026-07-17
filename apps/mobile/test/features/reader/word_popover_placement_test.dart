import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:selida/features/reader/presentation/word_popover_placement.dart';

void main() {
  test('places the popover below a word in the upper half', () {
    final placement = calculateWordPopoverPlacement(
      screenSize: const Size(390, 844),
      safePadding: const EdgeInsets.fromLTRB(0, 47, 0, 34),
      wordRect: const Rect.fromLTWH(80, 180, 54, 24),
    );

    expect(placement.showBelow, isTrue);
    expect(placement.caretX, inInclusiveRange(22, placement.width - 22));
    final offset = calculateWordPopoverOffset(
      screenSize: const Size(390, 844),
      safePadding: const EdgeInsets.fromLTRB(0, 47, 0, 34),
      wordRect: const Rect.fromLTWH(80, 180, 54, 24),
      popoverSize: Size(placement.width, 176),
      placement: placement,
    );
    expect(offset.dy, 209);
  });

  test('places the popover directly above a word near the bottom', () {
    const word = Rect.fromLTWH(210, 720, 72, 24);
    final placement = calculateWordPopoverPlacement(
      screenSize: const Size(390, 844),
      safePadding: const EdgeInsets.fromLTRB(0, 47, 0, 34),
      wordRect: word,
    );

    expect(placement.showBelow, isFalse);
    final offset = calculateWordPopoverOffset(
      screenSize: const Size(390, 844),
      safePadding: const EdgeInsets.fromLTRB(0, 47, 0, 34),
      wordRect: word,
      popoverSize: Size(placement.width, 176),
      placement: placement,
    );
    expect(offset.dy + 176, word.top - 5);
  });

  test('reserves enough room for a fully loaded two-line popover', () {
    final placement = calculateWordPopoverPlacement(
      screenSize: const Size(390, 844),
      safePadding: const EdgeInsets.fromLTRB(0, 47, 0, 34),
      wordRect: const Rect.fromLTWH(120, 620, 70, 24),
    );

    expect(placement.showBelow, isFalse);
  });
}
