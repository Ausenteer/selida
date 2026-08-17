part of 'reader_screen.dart';

final class _ReaderSettingsSheet extends ConsumerWidget {
  const _ReaderSettingsSheet({
    required this.bookLanguage,
    required this.onBookLanguageChanged,
  });

  final String bookLanguage;
  final Future<void> Function(String language) onBookLanguageChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context);
    final preferences = ref.watch(readerPreferencesProvider);
    final notifier = ref.read(readerPreferencesProvider.notifier);
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(22, 4, 22, 22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              strings.readerSettings,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 18),
            Text(
              strings.paragraphStyle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            SegmentedButton<ReaderParagraphStyle>(
              segments: <ButtonSegment<ReaderParagraphStyle>>[
                ButtonSegment<ReaderParagraphStyle>(
                  value: ReaderParagraphStyle.book,
                  label: Text(strings.bookParagraphStyle),
                ),
                ButtonSegment<ReaderParagraphStyle>(
                  value: ReaderParagraphStyle.modern,
                  label: Text(strings.modernParagraphStyle),
                ),
              ],
              selected: <ReaderParagraphStyle>{preferences.paragraphStyle},
              onSelectionChanged: (Set<ReaderParagraphStyle> value) {
                notifier.setParagraphStyle(value.single);
              },
              showSelectedIcon: false,
            ),
            const SizedBox(height: 12),
            _SettingSlider(
              label: strings.fontSize,
              value: preferences.fontSize,
              min: 15,
              max: 24,
              divisions: 9,
              onChanged: notifier.setFontSize,
            ),
            _SettingSlider(
              label: strings.lineHeight,
              value: preferences.lineHeight,
              min: 1.3,
              max: 1.8,
              divisions: 5,
              onChanged: notifier.setLineHeight,
            ),
            _SettingSlider(
              label: strings.margins,
              value: preferences.horizontalMargin,
              min: 16,
              max: 36,
              divisions: 10,
              onChanged: notifier.setHorizontalMargin,
            ),
            _SettingSlider(
              label: strings.readerBrightness,
              value: preferences.brightness,
              min: 0.25,
              max: 1,
              divisions: 15,
              onChanged: notifier.setBrightness,
            ),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              title: Text(strings.pageAnimation),
              value: preferences.pageAnimationEnabled,
              onChanged: (bool value) =>
                  notifier.setPageAnimationEnabled(value: value),
            ),
            const SizedBox(height: 8),
            Text(
              strings.bookLanguage,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            SegmentedButton<String>(
              segments: <ButtonSegment<String>>[
                ButtonSegment<String>(
                  value: 'en',
                  label: Text(strings.englishLanguage),
                ),
                ButtonSegment<String>(
                  value: 'el',
                  label: Text(strings.greekLanguage),
                ),
              ],
              selected: <String>{bookLanguage},
              onSelectionChanged: (Set<String> value) {
                unawaited(onBookLanguageChanged(value.single));
              },
              showSelectedIcon: false,
            ),
            const SizedBox(height: 18),
            Text(strings.theme, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            SegmentedButton<ReaderTheme>(
              segments: <ButtonSegment<ReaderTheme>>[
                ButtonSegment<ReaderTheme>(
                  value: ReaderTheme.light,
                  label: Text(strings.lightTheme),
                ),
                ButtonSegment<ReaderTheme>(
                  value: ReaderTheme.sepia,
                  label: Text(strings.sepiaTheme),
                ),
                ButtonSegment<ReaderTheme>(
                  value: ReaderTheme.dark,
                  label: Text(strings.darkTheme),
                ),
              ],
              selected: <ReaderTheme>{preferences.theme},
              onSelectionChanged: (Set<ReaderTheme> value) {
                notifier.setTheme(value.single);
              },
              showSelectedIcon: false,
            ),
          ],
        ),
      ),
    );
  }
}

final class _SettingSlider extends StatelessWidget {
  const _SettingSlider({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.onChanged,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 92, child: Text(label)),
        Expanded(
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
