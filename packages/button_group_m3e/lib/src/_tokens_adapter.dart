import 'package:flutter/material.dart';
import 'package:m3e_design/m3e_design.dart';
import 'button_group_m3e_enums.dart';

class _GroupMetrics {
  final double spacing;
  final double runSpacing;
  final double dividerThickness;
  const _GroupMetrics({required this.spacing, required this.runSpacing, required this.dividerThickness});
}

_GroupMetrics metricsFor(BuildContext context, ButtonGroupM3ESize size, ButtonGroupM3EDensity density) {
  final m3e = Theme.of(context).extension<M3ETheme>() ?? M3ETheme.defaults(Theme.of(context).colorScheme);
  final sp = m3e.spacing;

  double space;
  double run;
  switch (size) {
    case ButtonGroupM3ESize.xs: space = 6; run = 6; break;
    case ButtonGroupM3ESize.sm: space = sp.sm; run = sp.sm; break;
    case ButtonGroupM3ESize.md: space = sp.sm; run = sp.md; break;
    case ButtonGroupM3ESize.lg: space = sp.md; run = sp.lg; break;
    case ButtonGroupM3ESize.xl: space = sp.lg; run = sp.lg; break;
  }

  if (density == ButtonGroupM3EDensity.compact) {
    space = (space * 0.75).floorToDouble();
    run = (run * 0.75).floorToDouble();
  }

  return _GroupMetrics(spacing: space, runSpacing: run, dividerThickness: 1);
}

BorderRadius radiusFor(BuildContext context, ButtonGroupM3EShape shape, ButtonGroupM3ESize size) {
  final m3e = Theme.of(context).extension<M3ETheme>() ?? M3ETheme.defaults(Theme.of(context).colorScheme);
  final set = shape == ButtonGroupM3EShape.round ? m3e.shapes.round : m3e.shapes.square;
  switch (size) {
    case ButtonGroupM3ESize.xs: return set.xs;
    case ButtonGroupM3ESize.sm: return set.sm;
    case ButtonGroupM3ESize.md: return set.md;
    case ButtonGroupM3ESize.lg: return set.lg;
    case ButtonGroupM3ESize.xl: return set.xl;
  }
}
