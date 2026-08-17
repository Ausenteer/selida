part of 'reader_screen.dart';

final class _ReaderLoading extends StatelessWidget {
  const _ReaderLoading({this.backgroundColor});

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? const Color(0xfff7f3ea),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: _ReaderPageSkeleton(color: Color(0xffe5dfd2)),
        ),
      ),
    );
  }
}

final class _ReaderPageSkeleton extends StatelessWidget {
  const _ReaderPageSkeleton({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (final width in <double>[0.92, 1, 0.88, 0.97, 0.72, 1, 0.94, 0.81])
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: FractionallySizedBox(
              widthFactor: width,
              child: Container(height: 12, color: color),
            ),
          ),
      ],
    );
  }
}

final class _ReaderError extends StatelessWidget {
  const _ReaderError();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(AppLocalizations.of(context).bookLoadError),
                const SizedBox(height: 16),
                FilledButton.tonal(
                  onPressed: context.pop,
                  child: const Icon(Icons.arrow_back_rounded),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
final class ReaderPalette {
  const ReaderPalette({
    required this.background,
    required this.text,
    required this.mutedText,
    required this.accent,
    required this.border,
    required this.chrome,
    required this.popover,
    required this.skeleton,
    required this.savedUnderline,
  });

  factory ReaderPalette.forTheme(ReaderTheme theme) {
    return switch (theme) {
      ReaderTheme.light => const ReaderPalette(
        background: Color(0xfff5eee1),
        text: Color(0xff1d251f),
        mutedText: Color(0xff696b62),
        accent: Color(0xffa9573f),
        border: Color(0xffd8cdbc),
        chrome: Color(0xfffffaf0),
        popover: Color(0xfffffaf0),
        skeleton: Color(0xffe3dacb),
        savedUnderline: Color(0xff55715e),
      ),
      ReaderTheme.sepia => const ReaderPalette(
        background: Color(0xffeadbbc),
        text: Color(0xff382d23),
        mutedText: Color(0xff746554),
        accent: Color(0xff98533f),
        border: Color(0xffcdb890),
        chrome: Color(0xfff3e5c8),
        popover: Color(0xfff6e8cb),
        skeleton: Color(0xffd6c3a0),
        savedUnderline: Color(0xff66745b),
      ),
      ReaderTheme.dark => const ReaderPalette(
        background: Color(0xff1d211d),
        text: Color(0xffe9e2d5),
        mutedText: Color(0xffa9a397),
        accent: Color(0xffd08061),
        border: Color(0xff3d433d),
        chrome: Color(0xff272c27),
        popover: Color(0xff2b302b),
        skeleton: Color(0xff343a34),
        savedUnderline: Color(0xff8ca28d),
      ),
    };
  }

  final Color background;
  final Color text;
  final Color mutedText;
  final Color accent;
  final Color border;
  final Color chrome;
  final Color popover;
  final Color skeleton;
  final Color savedUnderline;
}
