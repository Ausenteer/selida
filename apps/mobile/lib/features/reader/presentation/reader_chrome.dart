part of 'reader_screen.dart';

final class _ReaderChrome extends StatelessWidget {
  const _ReaderChrome({
    required this.title,
    required this.chapterTitle,
    required this.progress,
    required this.pageNumber,
    required this.pageCount,
    required this.chapterNumber,
    required this.chapterCount,
    required this.canReturnToPreviousLocation,
    required this.palette,
    required this.onBack,
    required this.onReturnToPreviousLocation,
    required this.onContents,
    required this.onSearch,
    required this.onSettings,
    required this.onProgressChanged,
    required this.chapterForProgress,
  });

  final String title;
  final String? chapterTitle;
  final double progress;
  final int pageNumber;
  final int? pageCount;
  final int chapterNumber;
  final int chapterCount;
  final bool canReturnToPreviousLocation;
  final ReaderPalette palette;
  final VoidCallback onBack;
  final VoidCallback onReturnToPreviousLocation;
  final VoidCallback onContents;
  final VoidCallback onSearch;
  final VoidCallback onSettings;
  final ValueChanged<double> onProgressChanged;
  final int Function(double progress) chapterForProgress;

  @override
  Widget build(BuildContext context) {
    final safePadding = MediaQuery.paddingOf(context);
    final strings = AppLocalizations.of(context);
    final chapterName = chapterTitle?.trim().isNotEmpty ?? false
        ? chapterTitle!.trim()
        : title;
    final chapterLabel = '$chapterName · $chapterNumber/$chapterCount';
    return SizedBox.expand(
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 16,
            right: 16,
            top: safePadding.top + 4,
            child: DecoratedBox(
              key: const ValueKey<String>('reader-top-chrome'),
              decoration: BoxDecoration(
                color: palette.chrome.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: palette.border.withValues(alpha: 0.62),
                ),
              ),
              child: SizedBox(
                height: 44,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 88,
                      child: Row(
                        children: <Widget>[
                          _ChromeButton(
                            tooltip: MaterialLocalizations.of(
                              context,
                            ).backButtonTooltip,
                            onTap: onBack,
                            child: Icon(
                              Icons.arrow_back_rounded,
                              color: palette.text,
                            ),
                          ),
                          if (canReturnToPreviousLocation)
                            _ChromeButton(
                              tooltip: strings.returnToPreviousLocation,
                              onTap: onReturnToPreviousLocation,
                              child: Icon(
                                Icons.history_rounded,
                                color: palette.text,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Semantics(
                        button: true,
                        label: strings.contents,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: onContents,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  chapterLabel,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: palette.text,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.5,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 3),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: palette.mutedText,
                                size: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 88,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          _ChromeButton(
                            tooltip: strings.searchInBook,
                            onTap: onSearch,
                            child: Icon(
                              Icons.search_rounded,
                              color: palette.text,
                            ),
                          ),
                          _ChromeButton(
                            tooltip: strings.readerSettings,
                            onTap: onSettings,
                            child: Text(
                              'Aa',
                              style: TextStyle(
                                color: palette.text,
                                fontFamily: 'Literata',
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                height: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 22,
            right: 22,
            bottom: safePadding.bottom + 8,
            child: _ReaderProgress(
              progress: progress,
              pageNumber: pageNumber,
              pageCount: pageCount,
              chapterCount: chapterCount,
              chapterForProgress: chapterForProgress,
              palette: palette,
              onChanged: onProgressChanged,
            ),
          ),
        ],
      ),
    );
  }
}

final class _ChromeButton extends StatelessWidget {
  const _ChromeButton({
    required this.child,
    required this.tooltip,
    required this.onTap,
  });

  final Widget child;
  final String tooltip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 44,
      child: IconButton(
        onPressed: onTap,
        tooltip: tooltip,
        visualDensity: VisualDensity.compact,
        iconSize: 19,
        icon: child,
      ),
    );
  }
}

final class _ReaderProgress extends StatefulWidget {
  const _ReaderProgress({
    required this.progress,
    required this.pageNumber,
    required this.pageCount,
    required this.chapterCount,
    required this.chapterForProgress,
    required this.palette,
    required this.onChanged,
  });

  final double progress;
  final int pageNumber;
  final int? pageCount;
  final int chapterCount;
  final int Function(double progress) chapterForProgress;
  final ReaderPalette palette;
  final ValueChanged<double> onChanged;

  @override
  State<_ReaderProgress> createState() => _ReaderProgressState();
}

final class _ReaderProgressState extends State<_ReaderProgress> {
  double? _dragProgress;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final value = (_dragProgress ?? widget.progress).clamp(0.0, 1.0);
    final percent = (value * 100).round();
    final pageCount = widget.pageCount?.toString() ?? '…';
    final preview = strings.readerProgressPreview(
      percent,
      widget.chapterForProgress(value),
      widget.chapterCount,
    );
    final label = _dragProgress == null
        ? strings.readerCompactProgress(widget.pageNumber, pageCount, percent)
        : preview;
    return DecoratedBox(
      key: const ValueKey<String>('reader-bottom-progress'),
      decoration: BoxDecoration(
        color: widget.palette.chrome.withValues(alpha: 0.86),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: widget.palette.border.withValues(alpha: 0.52),
        ),
      ),
      child: SizedBox(
        height: 36,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 12),
          child: Row(
            children: <Widget>[
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 2,
                    activeTrackColor: widget.palette.accent,
                    inactiveTrackColor: widget.palette.border,
                    thumbColor: widget.palette.accent,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 5,
                    ),
                    overlayColor: widget.palette.accent.withValues(alpha: 0.1),
                    overlayShape: const RoundSliderOverlayShape(
                      overlayRadius: 14,
                    ),
                    valueIndicatorColor: widget.palette.popover,
                    valueIndicatorTextStyle: TextStyle(
                      color: widget.palette.text,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                    showValueIndicator: ShowValueIndicator.onlyForContinuous,
                  ),
                  child: Slider(
                    value: value,
                    label: preview,
                    onChanged: (double next) {
                      setState(() => _dragProgress = next);
                    },
                    onChangeEnd: (double next) {
                      setState(() => _dragProgress = null);
                      widget.onChanged(next);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                label,
                style: TextStyle(
                  color: widget.palette.mutedText,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
