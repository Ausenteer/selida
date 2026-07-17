import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:selida/app/selida_theme.dart';
import 'package:selida/l10n/generated/app_localizations.dart';

final class MainShell extends StatelessWidget {
  const MainShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: _SelidaTabBar(
        selectedIndex: navigationShell.currentIndex,
        onSelected: (int index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        items: <_TabItem>[
          _TabItem(
            icon: Icons.calendar_today_outlined,
            selectedIcon: Icons.calendar_today_rounded,
            label: strings.today,
          ),
          _TabItem(
            icon: Icons.menu_book_outlined,
            selectedIcon: Icons.menu_book_rounded,
            label: strings.library,
          ),
          _TabItem(
            icon: Icons.bookmark_border_rounded,
            selectedIcon: Icons.bookmark_rounded,
            label: strings.dictionary,
          ),
        ],
      ),
    );
  }
}

final class _TabItem {
  const _TabItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
}

final class _SelidaTabBar extends StatelessWidget {
  const _SelidaTabBar({
    required this.selectedIndex,
    required this.onSelected,
    required this.items,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final List<_TabItem> items;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: SelidaColors.surface,
        border: Border(top: BorderSide(color: SelidaColors.line)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 66,
          child: Row(
            children: <Widget>[
              for (var index = 0; index < items.length; index += 1)
                Expanded(
                  child: _TabButton(
                    item: items[index],
                    selected: selectedIndex == index,
                    onTap: () => onSelected(index),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final _TabItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? SelidaColors.forest
        : SelidaColors.ink.withValues(alpha: 0.5);
    return Semantics(
      selected: selected,
      button: true,
      label: item.label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              curve: Curves.easeOut,
              width: 38,
              height: 28,
              decoration: BoxDecoration(
                color: selected
                    ? SelidaColors.mutedTerracotta
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                selected ? item.selectedIcon : item.icon,
                color: color,
                size: 20,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              item.label,
              maxLines: 1,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
