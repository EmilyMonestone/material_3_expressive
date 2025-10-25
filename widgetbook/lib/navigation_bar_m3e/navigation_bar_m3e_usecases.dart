import 'package:flutter/material.dart';
import 'package:navigation_bar_m3e/navigation_bar_m3e.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

// Helper: Build demo destinations (3–5), optionally with badges
List<NavigationDestinationM3E> _demoDestinations(
  int count, {
  bool withBadges = false,
}) {
  final clamped = count.clamp(3, 5);
  final base = <(IconData, IconData, String)>[
    (Icons.home_outlined, Icons.home_rounded, 'Home'),
    (Icons.search, Icons.search_rounded, 'Search'),
    (Icons.notifications_none_rounded, Icons.notifications_rounded, 'Alerts'),
    (Icons.person_outline_rounded, Icons.person_rounded, 'Profile'),
    (Icons.settings_outlined, Icons.settings_rounded, 'Settings'),
  ];

  return List.generate(clamped, (i) {
    final (icon, selectedIcon, label) = base[i];
    return NavigationDestinationM3E(
      icon: Icon(icon),
      selectedIcon: Icon(selectedIcon),
      label: label,
      badgeCount: withBadges && i == 2 ? 12 : null,
      badgeDot: withBadges && i == 1,
      semanticLabel: withBadges ? 'Tab $label with badge' : 'Tab $label',
    );
  });
}

// A flexible "playground" builder used by the variants below
Widget _buildNavBar(
  BuildContext context, {
  NavBarM3EIndicatorStyle? indicatorStyle,
  NavBarM3ESize? size,
  NavBarM3EShapeFamily? shapeFamily,
  NavBarM3EDensity? density,
  bool? withBadges,
  Color? backgroundColor,
  Color? indicatorColor,
}) {
  final count = context.knobs.int.slider(
    label: 'destinations',
    initialValue: 4,
    min: 3,
    max: 5,
  );

  final idx = context.knobs.int.slider(
    label: 'selectedIndex',
    initialValue: 0,
    min: 0,
    max: count - 1,
  );

  final labelBehavior = context.knobs.object.dropdown<NavBarM3ELabelBehavior>(
    label: 'labelBehavior',
    initialOption: NavBarM3ELabelBehavior.alwaysShow,
    options: const [
      NavBarM3ELabelBehavior.alwaysShow,
      NavBarM3ELabelBehavior.onlySelected,
      NavBarM3ELabelBehavior.alwaysHide,
    ],
    labelBuilder: (v) => v.name,
  );

  final safeArea = context.knobs.boolean(label: 'safeArea', initialValue: true);

  final bg = context.knobs.colorOrNull(label: 'backgroundColor');
  final ind = context.knobs.colorOrNull(label: 'indicatorColor');

  return NavigationBarM3E(
    destinations: _demoDestinations(count, withBadges: withBadges ?? false),
    selectedIndex: idx,
    onDestinationSelected: (i) =>
        debugPrint('NavigationBarM3E: selected index = $i'),
    labelBehavior: labelBehavior,
    size: size ?? NavBarM3ESize.medium,
    shapeFamily: shapeFamily ?? NavBarM3EShapeFamily.round,
    density: density ?? NavBarM3EDensity.regular,
    indicatorStyle: indicatorStyle ?? NavBarM3EIndicatorStyle.pill,
    safeArea: safeArea,
    backgroundColor: backgroundColor ?? bg,
    indicatorColor: indicatorColor ?? ind,
  );
}

@UseCase(name: 'default', type: NavigationBarM3E)
Widget buildNavigationBarM3EDefaultUseCase(BuildContext context) {
  return _buildNavBar(context);
}

@UseCase(name: 'playground', type: NavigationBarM3E)
Widget buildNavigationBarM3EPlaygroundUseCase(BuildContext context) {
  final indicator = context.knobs.object.dropdown<NavBarM3EIndicatorStyle>(
    label: 'indicatorStyle',
    initialOption: NavBarM3EIndicatorStyle.pill,
    options: const [
      NavBarM3EIndicatorStyle.pill,
      NavBarM3EIndicatorStyle.underline,
      NavBarM3EIndicatorStyle.none,
    ],
    labelBuilder: (v) => v.name,
  );

  final size = context.knobs.object.dropdown<NavBarM3ESize>(
    label: 'size',
    initialOption: NavBarM3ESize.medium,
    options: const [NavBarM3ESize.small, NavBarM3ESize.medium],
    labelBuilder: (v) => v.name,
  );

  final shape = context.knobs.object.dropdown<NavBarM3EShapeFamily>(
    label: 'shapeFamily',
    initialOption: NavBarM3EShapeFamily.round,
    options: const [NavBarM3EShapeFamily.round, NavBarM3EShapeFamily.square],
    labelBuilder: (v) => v.name,
  );

  final density = context.knobs.object.dropdown<NavBarM3EDensity>(
    label: 'density',
    initialOption: NavBarM3EDensity.regular,
    options: const [NavBarM3EDensity.regular, NavBarM3EDensity.compact],
    labelBuilder: (v) => v.name,
  );

  final withBadges =
      context.knobs.boolean(label: 'withBadges', initialValue: false);

  return _buildNavBar(
    context,
    indicatorStyle: indicator,
    size: size,
    shapeFamily: shape,
    density: density,
    withBadges: withBadges,
  );
}

@UseCase(name: 'pill_indicator', type: NavigationBarM3E)
Widget buildNavigationBarM3EPillIndicatorUseCase(BuildContext context) {
  return _buildNavBar(context, indicatorStyle: NavBarM3EIndicatorStyle.pill);
}

@UseCase(name: 'underline_indicator', type: NavigationBarM3E)
Widget buildNavigationBarM3EUnderlineIndicatorUseCase(BuildContext context) {
  return _buildNavBar(context,
      indicatorStyle: NavBarM3EIndicatorStyle.underline);
}

@UseCase(name: 'no_indicator', type: NavigationBarM3E)
Widget buildNavigationBarM3ENoIndicatorUseCase(BuildContext context) {
  return _buildNavBar(context, indicatorStyle: NavBarM3EIndicatorStyle.none);
}

@UseCase(name: 'small_size', type: NavigationBarM3E)
Widget buildNavigationBarM3ESmallSizeUseCase(BuildContext context) {
  return _buildNavBar(context, size: NavBarM3ESize.small);
}

@UseCase(name: 'square_shape', type: NavigationBarM3E)
Widget buildNavigationBarM3ESquareShapeUseCase(BuildContext context) {
  return _buildNavBar(context, shapeFamily: NavBarM3EShapeFamily.square);
}

@UseCase(name: 'compact_density', type: NavigationBarM3E)
Widget buildNavigationBarM3ECompactDensityUseCase(BuildContext context) {
  return _buildNavBar(context, density: NavBarM3EDensity.compact);
}

@UseCase(name: 'with_badges', type: NavigationBarM3E)
Widget buildNavigationBarM3EWithBadgesUseCase(BuildContext context) {
  return _buildNavBar(context, withBadges: true);
}
