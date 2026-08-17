part of 'reader_screen.dart';

final class _WordPopoverLayoutDelegate extends SingleChildLayoutDelegate {
  const _WordPopoverLayoutDelegate({
    required this.placement,
    required this.wordRect,
    required this.safePadding,
  });

  final WordPopoverPlacement placement;
  final Rect wordRect;
  final EdgeInsets safePadding;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints(
      minWidth: placement.width,
      maxWidth: placement.width,
      maxHeight: math.max(0, constraints.maxHeight - safePadding.vertical - 12),
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return calculateWordPopoverOffset(
      screenSize: size,
      safePadding: safePadding,
      wordRect: wordRect,
      popoverSize: childSize,
      placement: placement,
    );
  }

  @override
  bool shouldRelayout(_WordPopoverLayoutDelegate oldDelegate) {
    return oldDelegate.placement.left != placement.left ||
        oldDelegate.placement.width != placement.width ||
        oldDelegate.placement.showBelow != placement.showBelow ||
        oldDelegate.wordRect != wordRect ||
        oldDelegate.safePadding != safePadding;
  }
}

final class _AnchoredWordPopover extends StatelessWidget {
  const _AnchoredWordPopover({
    required this.showBelow,
    required this.caretX,
    required this.palette,
    required this.child,
  });

  final bool showBelow;
  final double caretX;
  final ReaderPalette palette;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final caret = Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: caretX - 8),
        child: CustomPaint(
          size: const Size(16, 8),
          painter: _PopoverCaretPainter(
            pointsUp: showBelow,
            fillColor: palette.popover,
            borderColor: palette.border,
          ),
        ),
      ),
    );
    final card = DecoratedBox(
      decoration: BoxDecoration(
        color: palette.popover,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: palette.border),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: showBelow
          ? <Widget>[
              caret,
              Transform.translate(offset: const Offset(0, -1), child: card),
            ]
          : <Widget>[
              card,
              Transform.translate(offset: const Offset(0, 1), child: caret),
            ],
    );
  }
}

final class _PopoverCaretPainter extends CustomPainter {
  const _PopoverCaretPainter({
    required this.pointsUp,
    required this.fillColor,
    required this.borderColor,
  });

  final bool pointsUp;
  final Color fillColor;
  final Color borderColor;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    if (pointsUp) {
      path
        ..moveTo(size.width / 2, 0)
        ..lineTo(size.width, size.height)
        ..lineTo(0, size.height);
    } else {
      path
        ..moveTo(0, 0)
        ..lineTo(size.width, 0)
        ..lineTo(size.width / 2, size.height);
    }
    path.close();
    canvas
      ..drawPath(path, Paint()..color = fillColor)
      ..drawPath(
        path,
        Paint()
          ..color = borderColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
      );
  }

  @override
  bool shouldRepaint(_PopoverCaretPainter oldDelegate) {
    return oldDelegate.pointsUp != pointsUp ||
        oldDelegate.fillColor != fillColor ||
        oldDelegate.borderColor != borderColor;
  }
}

final class _WordTranslationPopover extends ConsumerStatefulWidget {
  const _WordTranslationPopover({
    required this.request,
    required this.surfaceForm,
    required this.contextWordStart,
    required this.sourceBookId,
    required this.sourceBookTitle,
    required this.sourceChapterId,
    required this.sourceChapterTitle,
    required this.sourceOffset,
    required this.palette,
    required this.savedOccurrence,
    required this.onTranslateSentence,
  });

  final WordTranslationRequest request;
  final String surfaceForm;
  final int contextWordStart;
  final String sourceBookId;
  final String sourceBookTitle;
  final String sourceChapterId;
  final String? sourceChapterTitle;
  final int sourceOffset;
  final ReaderPalette palette;
  final StoredWordOccurrence? savedOccurrence;
  final VoidCallback onTranslateSentence;

  @override
  ConsumerState<_WordTranslationPopover> createState() =>
      _WordTranslationPopoverState();
}

final class _WordTranslationPopoverState
    extends ConsumerState<_WordTranslationPopover> {
  late Future<WordTranslation> _translation;
  var _saving = false;
  StoredWordOccurrence? _savedOccurrence;
  StoredVocabularyItem? _savedItem;

  bool get _saved => _savedOccurrence != null;

  @override
  void initState() {
    super.initState();
    _savedOccurrence = widget.savedOccurrence;
    _translation = _loadTranslation();
    unawaited(_loadSavedItem());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: const ValueKey<String>('word-translation-popover'),
      padding: const EdgeInsets.fromLTRB(15, 12, 10, 7),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOutCubic,
        alignment: Alignment.topCenter,
        child: FutureBuilder<WordTranslation>(
          future: _translation,
          builder: (BuildContext context, AsyncSnapshot<WordTranslation> data) {
            if (data.connectionState != ConnectionState.done) {
              return _buildLoading();
            }
            if (data.hasError || data.data == null) {
              return _buildError(data.error);
            }
            return _buildTranslation(data.requireData);
          },
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return SizedBox(
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            widget.request.source,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: widget.palette.text,
              fontFamily: 'Literata',
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 9),
          FractionallySizedBox(
            widthFactor: 0.72,
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                color: widget.palette.border.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 7),
          FractionallySizedBox(
            widthFactor: 0.46,
            child: Container(
              height: 7,
              decoration: BoxDecoration(
                color: widget.palette.border.withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(Object? error) {
    final strings = AppLocalizations.of(context);
    final message = switch (error) {
      TranslationException(failure: TranslationFailure.offline) =>
        strings.translationOffline,
      TranslationException(failure: TranslationFailure.invalidResponse) =>
        strings.translationInvalid,
      _ => strings.translationUnavailable,
    };
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Text(
            message,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: widget.palette.mutedText, fontSize: 12),
          ),
        ),
        IconButton(
          tooltip: strings.retry,
          onPressed: _retry,
          visualDensity: VisualDensity.compact,
          icon: Icon(
            Icons.refresh_rounded,
            color: widget.palette.accent,
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildTranslation(WordTranslation translation) {
    final strings = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          translation.translation,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: widget.palette.text,
            fontFamily: 'Literata',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          strings.lemmaDetails(translation.lemma, translation.partOfSpeech),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: widget.palette.mutedText, fontSize: 11),
        ),
        if (translation.formAnalysis.isNotEmpty) ...<Widget>[
          const SizedBox(height: 2),
          Text(
            translation.formAnalysis,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: widget.palette.mutedText, fontSize: 11),
          ),
        ],
        if (_saved) ...<Widget>[
          const SizedBox(height: 4),
          Text(
            strings.savedVocabularyStatus(
              _statusLabel(strings, _savedItem?.status ?? 'new'),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: widget.palette.accent,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
        const SizedBox(height: 8),
        Divider(height: 1, color: widget.palette.border),
        const SizedBox(height: 2),
        Row(
          children: <Widget>[
            Expanded(
              child: TextButton.icon(
                onPressed: widget.onTranslateSentence,
                style: TextButton.styleFrom(
                  foregroundColor: widget.palette.accent,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                ),
                icon: const Icon(Icons.subject_rounded, size: 18),
                label: Text(strings.sentenceAction),
              ),
            ),
            IconButton(
              tooltip: _saved ? strings.removeFromDictionary : strings.saveWord,
              onPressed: _saving
                  ? null
                  : _saved
                  ? _removeTranslation
                  : () => _saveTranslation(translation),
              visualDensity: VisualDensity.compact,
              icon: _saving
                  ? SizedBox.square(
                      dimension: 17,
                      child: CircularProgressIndicator(
                        strokeWidth: 1.8,
                        color: widget.palette.accent,
                      ),
                    )
                  : Icon(
                      _saved
                          ? Icons.bookmark_remove_rounded
                          : Icons.bookmark_add_outlined,
                      color: widget.palette.accent,
                      size: 22,
                    ),
            ),
          ],
        ),
      ],
    );
  }

  Future<WordTranslation> _loadTranslation() {
    return ref.read(translationServiceProvider).translateWord(widget.request);
  }

  void _retry() {
    setState(() {
      _translation = _loadTranslation();
    });
  }

  Future<void> _saveTranslation(WordTranslation translation) async {
    setState(() => _saving = true);
    try {
      final service = ref.read(vocabularyServiceProvider);
      final vocabularyId = await service.saveTranslation(
        request: widget.request,
        translation: translation,
        surfaceForm: widget.surfaceForm,
        contextSentence: widget.request.context,
        contextWordStart: widget.contextWordStart,
        sourceBookId: widget.sourceBookId,
        sourceBookTitle: widget.sourceBookTitle,
        sourceChapterId: widget.sourceChapterId,
        sourceChapterTitle: widget.sourceChapterTitle,
        sourceOffset: widget.sourceOffset,
      );
      final occurrence = await service.occurrenceAt(
        vocabularyId: vocabularyId,
        sourceBookId: widget.sourceBookId,
        sourceOffset: widget.sourceOffset,
      );
      final item = await service.vocabularyItem(vocabularyId);
      unawaited(HapticFeedback.lightImpact());
      if (mounted) {
        setState(() {
          _saving = false;
          _savedOccurrence = occurrence;
          _savedItem = item;
        });
      }
    } on Object {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  Future<void> _loadSavedItem() async {
    final occurrence = _savedOccurrence;
    if (occurrence == null) {
      return;
    }
    final item = await ref
        .read(vocabularyServiceProvider)
        .vocabularyItem(occurrence.vocabularyId);
    if (mounted) {
      setState(() => _savedItem = item);
    }
  }

  Future<void> _removeTranslation() async {
    final occurrence = _savedOccurrence;
    if (occurrence == null || _saving) {
      return;
    }
    setState(() => _saving = true);
    try {
      await ref.read(vocabularyServiceProvider).removeOccurrence(occurrence);
      unawaited(HapticFeedback.lightImpact());
      if (mounted) {
        setState(() {
          _saving = false;
          _savedOccurrence = null;
          _savedItem = null;
        });
      }
    } on Object {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  String _statusLabel(AppLocalizations strings, String status) {
    return switch (status) {
      'learning' => strings.statusLearning,
      'learned' => strings.statusLearned,
      _ => strings.statusNew,
    };
  }
}
