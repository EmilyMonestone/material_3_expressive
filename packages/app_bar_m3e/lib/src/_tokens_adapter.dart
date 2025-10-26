import 'package:flutter/material.dart';
import 'package:m3e_design/m3e_design.dart';

import 'app_bar_m3e_enums.dart';

@immutable
class _AppBarMetrics {
  final double smallHeight;
  final double collapsedHeight;
  final double mediumExpanded;
  final double largeExpanded;
  final EdgeInsetsGeometry horizontalPadding;
  final double iconSize;
  final double elevation;
  const _AppBarMetrics({
    required this.smallHeight,
    required this.collapsedHeight,
    required this.mediumExpanded,
    required this.largeExpanded,
    required this.horizontalPadding,
    required this.iconSize,
    required this.elevation,
  });
}

_AppBarMetrics metricsFor(BuildContext context, AppBarM3EDensity density) {
  final theme = Theme.of(context);
  final m3e =
      theme.extension<M3ETheme>() ?? M3ETheme.defaults(theme.colorScheme);
  final sp = m3e.spacing;

  // Heights (approx per M3 specs; can be tuned via Theme extension in m3e_design if desired)
  double small = 64;
  double collapsed = 64;
  double medium = 112;
  double large = 152;

  // Density tweaks
  if (density == AppBarM3EDensity.compact) {
    small -= 8;
    collapsed -= 8;
    medium -= 8;
    large -= 8;
  }

  return _AppBarMetrics(
    smallHeight: small,
    collapsedHeight: collapsed,
    mediumExpanded: medium,
    largeExpanded: large,
    horizontalPadding: EdgeInsets.symmetric(horizontal: sp.md),
    iconSize: 24,
    elevation: 0.0,
  );
}

Color backgroundFor(BuildContext context) {
  final theme = Theme.of(context);
  final m3e =
      theme.extension<M3ETheme>() ?? M3ETheme.defaults(theme.colorScheme);
  // Prefer container surfaces for bars
  return m3e.colors.surfaceContainerHigh;
}

TextStyle titleStyleFor(BuildContext context, {bool collapsed = true}) {
  final theme = Theme.of(context);
  final m3e =
      theme.extension<M3ETheme>() ?? M3ETheme.defaults(theme.colorScheme);
  return collapsed ? m3e.type.titleLarge : m3e.type.headlineSmallEmphasized;
}

ShapeBorder shapeFor(BuildContext context, AppBarM3EShapeFamily family) {
  final theme = Theme.of(context);
  final m3e =
      theme.extension<M3ETheme>() ?? M3ETheme.defaults(theme.colorScheme);
  final set = family == AppBarM3EShapeFamily.round
      ? m3e.shapes.round
      : m3e.shapes.square;
  // Use medium size radius for the bar container by default
  return RoundedRectangleBorder(borderRadius: set.sm);
}
