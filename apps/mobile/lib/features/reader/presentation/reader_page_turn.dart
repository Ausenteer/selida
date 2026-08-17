part of 'reader_screen.dart';

final class _ReaderPagePhysics extends PageScrollPhysics {
  const _ReaderPagePhysics({super.parent});

  @override
  _ReaderPagePhysics applyTo(ScrollPhysics? ancestor) {
    return _ReaderPagePhysics(parent: buildParent(ancestor));
  }

  @override
  SpringDescription get spring =>
      const SpringDescription(mass: 0.65, stiffness: 105, damping: 16.5);
}

final class _ReaderPageTurn extends StatelessWidget {
  const _ReaderPageTurn({
    required this.controller,
    required this.pageIndex,
    required this.enabled,
    required this.backgroundColor,
    required this.child,
    super.key,
  });

  final PageController controller;
  final int pageIndex;
  final bool enabled;
  final Color backgroundColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return RepaintBoundary(child: child);
    }
    return AnimatedBuilder(
      animation: controller,
      child: RepaintBoundary(child: child),
      builder: (BuildContext context, Widget? child) {
        final page =
            controller.hasClients && controller.position.hasContentDimensions
            ? controller.page ?? controller.initialPage.toDouble()
            : controller.initialPage.toDouble();
        final offset = (page - pageIndex).clamp(-1.0, 1.0);
        final progress = offset.abs();
        final shadowOpacity = math.sin(progress * math.pi) * 0.13;
        return FractionalTranslation(
          translation: Offset(offset * 0.022, 0),
          child: ColoredBox(
            color: backgroundColor,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Opacity(opacity: 1 - progress * 0.045, child: child),
                if (progress > 0.001)
                  IgnorePointer(
                    child: Align(
                      alignment: offset > 0
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        width: 30,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: offset > 0
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            end: offset > 0
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            colors: <Color>[
                              Colors.transparent,
                              Colors.black.withValues(alpha: shadowOpacity),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
