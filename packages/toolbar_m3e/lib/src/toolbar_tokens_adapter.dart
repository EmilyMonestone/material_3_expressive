import 'package:flutter/material.dart';
import 'package:m3e_design/m3e_design.dart';
import 'enums.dart';

@immutable
class _ToolbarMetrics {
  final double heightSmall;
  final double heightMedium;
  final double heightLarge;
  final EdgeInsetsGeometry horizontalPadding;
  final double gap;
  final double iconSize;
  final double elevationSurface;
  final double elevationProminent;
  const _ToolbarMetrics({
    required this.heightSmall,
    required this.heightMedium,
    required this.heightLarge,
    required this.horizontalPadding,
    required this.gap,
    required this.iconSize,
    required this.elevationSurface,
    required this.elevationProminent,
  });
}

_ToolbarMetrics _metricsFor(BuildContext context, ToolbarM3EDensity density) {
  final theme = Theme.of(context);
  final m3e = theme.extension<M3ETheme>() ?? M3ETheme.defaults(theme.colorScheme);
  final sp = m3e.spacing;

  double hS = 40;
  double hM = 48;
  double hL = 56;
  double icon = 24;
  double gap = sp.sm;

  if (density == ToolbarM3EDensity.compact) {
    hS -= 4; hM -= 4; hL -= 4;
  }

  return _ToolbarMetrics(
    heightSmall: hS,
    heightMedium: hM,
    heightLarge: hL,
    horizontalPadding: EdgeInsets.symmetric(horizontal: sp.md),
    gap: gap,
    iconSize: icon,
    elevationSurface: 0.0,
    elevationProminent: 2.0,
  );
}

class ToolbarTokensAdapter {
  ToolbarTokensAdapter(this.context);
  final BuildContext context;

  M3ETheme get _m3e {
    final t = Theme.of(context);
    return t.extension<M3ETheme>() ?? M3ETheme.defaults(t.colorScheme);
  }

  _ToolbarMetrics metrics(ToolbarM3EDensity density) => _metricsFor(context, density);

  // Container/background color by variant
  Color containerColor(ToolbarM3EVariant variant) {
    switch (variant) {
      case ToolbarM3EVariant.surface: return _m3e.colors.surfaceContainerHigh;
      case ToolbarM3EVariant.tonal: return _m3e.colors.secondaryContainer;
      case ToolbarM3EVariant.primary: return _m3e.colors.primaryContainer;
    }
  }

  Color foregroundOn(ToolbarM3EVariant variant) {
    switch (variant) {
      case ToolbarM3EVariant.surface: return _m3e.colors.onSurface;
      case ToolbarM3EVariant.tonal: return _m3e.colors.onSecondaryContainer;
      case ToolbarM3EVariant.primary: return _m3e.colors.onPrimaryContainer;
    }
  }

  // Shapes
  ShapeBorder shape(ToolbarM3EShapeFamily family) {
    final set = family == ToolbarM3EShapeFamily.round ? _m3e.shapes.round : _m3e.shapes.square;
    return RoundedRectangleBorder(borderRadius: set.md);
  }

  // Typography
  TextStyle titleStyle() => _m3e.type.titleSmall;
  TextStyle subtitleStyle() => _m3e.type.bodySmall;
}
