part of 'reader_screen.dart';

final class _TextAssistanceSheet extends ConsumerStatefulWidget {
  const _TextAssistanceSheet({
    required this.request,
    required this.sourceText,
    required this.savesAsWord,
    required this.savedOccurrence,
    this.onSave,
    this.onRemove,
  });

  final TextAssistanceRequest request;
  final String sourceText;
  final bool savesAsWord;
  final StoredWordOccurrence? savedOccurrence;
  final Future<StoredWordOccurrence?> Function(FragmentTranslation translation)?
  onSave;
  final Future<void> Function(StoredWordOccurrence occurrence)? onRemove;

  @override
  ConsumerState<_TextAssistanceSheet> createState() =>
      _TextAssistanceSheetState();
}

final class _TextAssistanceSheetState
    extends ConsumerState<_TextAssistanceSheet> {
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();
  late Future<FragmentTranslation> _translation;
  Future<TextExplanation>? _explanation;
  StoredWordOccurrence? _savedOccurrence;
  var _saving = false;

  bool get _saved => _savedOccurrence != null;

  @override
  void initState() {
    super.initState();
    _savedOccurrence = widget.savedOccurrence;
    _translation = _loadTranslation();
  }

  @override
  void dispose() {
    _sheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return DraggableScrollableSheet(
      controller: _sheetController,
      expand: false,
      initialChildSize: 0.43,
      minChildSize: 0.32,
      maxChildSize: 0.82,
      builder: (BuildContext context, ScrollController scrollController) {
        return ListView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          children: <Widget>[
            Center(
              child: Container(
                width: 38,
                height: 5,
                decoration: BoxDecoration(
                  color: colors.onSurface.withValues(alpha: 0.72),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            const SizedBox(height: 11),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    strings.fragmentTranslationTitle,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontFamily: 'Literata',
                      fontSize: 19,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                  onPressed: () => Navigator.of(context).pop(),
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(Icons.close_rounded, size: 21),
                ),
              ],
            ),
            const SizedBox(height: 10),
            DecoratedBox(
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.055),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: colors.primary.withValues(alpha: 0.12),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 11,
                ),
                child: Text(
                  widget.sourceText,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.onSurface.withValues(alpha: 0.72),
                    fontFamily: 'Literata',
                    height: 1.4,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            FutureBuilder<FragmentTranslation>(
              future: _translation,
              builder:
                  (
                    BuildContext context,
                    AsyncSnapshot<FragmentTranslation> snapshot,
                  ) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildTranslationResult(
                        snapshot: snapshot,
                        onRetry: () => setState(() {
                          _translation = _loadTranslation();
                        }),
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontFamily: 'Literata',
                          fontSize: 19,
                          height: 1.4,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: <Widget>[
                          if (widget.onSave != null) ...<Widget>[
                            Expanded(
                              child: _AssistanceActionButton(
                                key: const ValueKey<String>(
                                  'save-selection-action',
                                ),
                                selected: _saved,
                                onPressed: _saving || !snapshot.hasData
                                    ? null
                                    : _saved
                                    ? _removeSelection
                                    : () =>
                                          _saveSelection(snapshot.requireData),
                                icon: _saving
                                    ? const SizedBox.square(
                                        dimension: 17,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 1.8,
                                        ),
                                      )
                                    : Icon(
                                        _saved
                                            ? Icons.bookmark_added_rounded
                                            : Icons.bookmark_add_outlined,
                                        size: 19,
                                      ),
                                label: _saved
                                    ? strings.savedAction
                                    : widget.savesAsWord
                                    ? strings.saveWord
                                    : strings.savePhrase,
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                          Expanded(
                            child: _AssistanceActionButton(
                              key: const ValueKey<String>(
                                'explain-selection-action',
                              ),
                              selected: _explanation != null,
                              onPressed: _showExplanation,
                              icon: const Icon(
                                Icons.auto_awesome_outlined,
                                size: 18,
                              ),
                              label: strings.explainText,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
            ),
            if (_explanation case final explanation?) ...<Widget>[
              const SizedBox(height: 24),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.auto_awesome_rounded,
                    color: colors.secondary,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    strings.explanationTitle,
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              FutureBuilder<TextExplanation>(
                future: explanation,
                builder:
                    (
                      BuildContext context,
                      AsyncSnapshot<TextExplanation> snapshot,
                    ) => _buildExplanationResult(
                      snapshot: snapshot,
                      onRetry: () => setState(() {
                        _explanation = _loadExplanation();
                      }),
                    ),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildTranslationResult({
    required AsyncSnapshot<FragmentTranslation> snapshot,
    required VoidCallback onRetry,
    TextStyle? style,
  }) {
    if (snapshot.connectionState != ConnectionState.done) {
      return const _AssistanceSkeleton();
    }
    if (snapshot.hasError || snapshot.data == null) {
      return _buildAssistanceFailure(snapshot.error, onRetry);
    }
    return Text(
      snapshot.requireData.translation,
      style: style ?? Theme.of(context).textTheme.bodyLarge,
    );
  }

  Widget _buildExplanationResult({
    required AsyncSnapshot<TextExplanation> snapshot,
    required VoidCallback onRetry,
  }) {
    if (snapshot.connectionState != ConnectionState.done) {
      return const _AssistanceSkeleton();
    }
    if (snapshot.hasError || snapshot.data == null) {
      return _buildAssistanceFailure(snapshot.error, onRetry);
    }
    final explanation = snapshot.requireData;
    final strings = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _ExplanationSection(
          label: strings.explanationSummaryLabel,
          content: explanation.summary,
          emphasized: true,
        ),
        _ExplanationSection(
          label: strings.explanationMeaningLabel,
          content: explanation.meaningInContext,
        ),
        _ExplanationSection(
          label: strings.explanationBreakdownLabel,
          content: explanation.breakdown,
        ),
        if (explanation.literalTranslation.isNotEmpty)
          _ExplanationSection(
            label: strings.explanationLiteralLabel,
            content: explanation.literalTranslation,
          ),
        _ExplanationSection(
          label: strings.explanationNaturalLabel,
          content: explanation.naturalTranslation,
        ),
        if (explanation.examples.isNotEmpty)
          _ExplanationSection(
            label: strings.explanationExamplesLabel,
            content: explanation.examples
                .map(
                  (TextExplanationExample example) =>
                      '${example.source}\n${example.translation}',
                )
                .join('\n\n'),
          ),
        if (explanation.commonMistake.isNotEmpty)
          _ExplanationSection(
            label: strings.explanationCommonMistakeLabel,
            content: explanation.commonMistake,
          ),
      ],
    );
  }

  Widget _buildAssistanceFailure(Object? error, VoidCallback onRetry) {
    final strings = AppLocalizations.of(context);
    final message = switch (error) {
      TranslationException(failure: TranslationFailure.offline) =>
        strings.translationOffline,
      TranslationException(failure: TranslationFailure.invalidResponse) =>
        strings.translationInvalid,
      _ => strings.translationUnavailable,
    };
    return Row(
      children: <Widget>[
        Expanded(child: Text(message)),
        IconButton(
          tooltip: strings.retry,
          onPressed: onRetry,
          icon: const Icon(Icons.refresh_rounded),
        ),
      ],
    );
  }

  void _showExplanation() {
    if (_explanation == null) {
      setState(() {
        _explanation = _loadExplanation();
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _sheetController.isAttached) {
        unawaited(
          _sheetController.animateTo(
            0.76,
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
          ),
        );
      }
    });
  }

  Future<void> _saveSelection(FragmentTranslation translation) async {
    final onSave = widget.onSave;
    if (onSave == null) {
      return;
    }
    setState(() => _saving = true);
    try {
      final occurrence = await onSave(translation);
      unawaited(HapticFeedback.lightImpact());
      if (mounted) {
        setState(() {
          _saving = false;
          _savedOccurrence = occurrence;
        });
      }
    } on Object {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  Future<void> _removeSelection() async {
    final onRemove = widget.onRemove;
    final occurrence = _savedOccurrence;
    if (onRemove == null || occurrence == null) {
      return;
    }
    setState(() => _saving = true);
    try {
      await onRemove(occurrence);
      unawaited(HapticFeedback.lightImpact());
      if (mounted) {
        setState(() {
          _saving = false;
          _savedOccurrence = null;
        });
      }
    } on Object {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  Future<FragmentTranslation> _loadTranslation() =>
      ref.read(textAssistantProvider).translateFragment(widget.request);

  Future<TextExplanation> _loadExplanation() =>
      ref.read(textAssistantProvider).explainText(widget.request);
}

final class _ExplanationSection extends StatelessWidget {
  const _ExplanationSection({
    required this.label,
    required this.content,
    this.emphasized = false,
  });

  final String label;
  final String content;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: emphasized
              ? colors.secondaryContainer.withValues(alpha: 0.48)
              : colors.surfaceContainerHighest.withValues(alpha: 0.34),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 11, 14, 13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                label,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                content,
                style: theme.textTheme.bodyLarge?.copyWith(height: 1.45),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _AssistanceActionButton extends StatelessWidget {
  const _AssistanceActionButton({
    required this.selected,
    required this.onPressed,
    required this.icon,
    required this.label,
    super.key,
  });

  final bool selected;
  final VoidCallback? onPressed;
  final Widget icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, 48),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        backgroundColor: selected ? colors.primary : Colors.transparent,
        foregroundColor: selected ? colors.onPrimary : colors.primary,
        disabledBackgroundColor: colors.onSurface.withValues(alpha: 0.045),
        disabledForegroundColor: colors.onSurface.withValues(alpha: 0.35),
        side: BorderSide(
          color: selected
              ? colors.primary
              : colors.onSurface.withValues(alpha: 0.16),
        ),
      ),
      icon: icon,
      label: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
    );
  }
}

final class _AssistanceSkeleton extends StatelessWidget {
  const _AssistanceSkeleton();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(
      context,
    ).colorScheme.onSurface.withValues(alpha: 0.1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (final width in <double>[1, 0.92, 0.68])
          Padding(
            padding: const EdgeInsets.only(bottom: 9),
            child: FractionallySizedBox(
              widthFactor: width,
              child: Container(
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
