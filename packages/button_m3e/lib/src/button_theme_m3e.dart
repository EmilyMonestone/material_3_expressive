import 'package:flutter/material.dart';
import 'package:m3e_design/m3e_design.dart';

import 'enums.dart';

@immutable
class _ButtonMetrics {
  final double heightSmall;
  final double heightMedium;
  final double heightLarge;
  final EdgeInsetsGeometry paddingSmall;
  final EdgeInsetsGeometry paddingMedium;
  final EdgeInsetsGeometry paddingLarge;
  final BorderSide outlinedBorder;
  final double elevation;
  const _ButtonMetrics({
    required this.heightSmall,
    required this.heightMedium,
    required this.heightLarge,
    required this.paddingSmall,
    required this.paddingMedium,
    required this.paddingLarge,
    required this.outlinedBorder,
    required this.elevation,
  });
}

_ButtonMetrics _metricsFor(BuildContext context, ButtonM3EDensity density) {
  final theme = Theme.of(context);
  final m3e =
      theme.extension<M3ETheme>() ?? M3ETheme.defaults(theme.colorScheme);
  final sp = m3e.spacing;

  // Heights based on Material 3 expectations; tweakable by density.
  double hS = 36;
  double hM = 40;
  double hL = 48;

  if (density == ButtonM3EDensity.compact) {
    hS -= 4;
    hM -= 4;
    hL -= 4;
  }

  return _ButtonMetrics(
    heightSmall: hS,
    heightMedium: hM,
    heightLarge: hL,
    paddingSmall: EdgeInsets.symmetric(horizontal: sp.sm),
    paddingMedium: EdgeInsets.symmetric(horizontal: sp.md),
    paddingLarge: EdgeInsets.symmetric(horizontal: sp.lg),
    outlinedBorder: BorderSide(color: m3e.colors.outline, width: 1.0),
    elevation: 1.0,
  );
}

class ButtonTokensAdapter {
  ButtonTokensAdapter(this.context);
  final BuildContext context;

  M3ETheme get _m3e {
    final t = Theme.of(context);
    return t.extension<M3ETheme>() ?? M3ETheme.defaults(t.colorScheme);
  }

  // Colors
  Color bgFilled() => _m3e.colors.primary;
  Color fgFilled() => _m3e.colors.onPrimary;
  Color bgTonal() => _m3e.colors.secondaryContainer;
  Color fgTonal() => _m3e.colors.onSecondaryContainer;
  Color bgElevated() => _m3e.colors.surfaceContainerLowest;
  Color fgElevated() => _m3e.colors.primary;
  Color fgText() => _m3e.colors.primary;
  Color borderOutlined() => _m3e.colors.outline;
  Color fgOutlined() => _m3e.colors.primary;
  Color disabledFg() => _m3e.colors.onSurface.withValues(alpha: 0.38);
  Color disabledBg() => _m3e.colors.onSurface.withValues(alpha: 0.12);

  // Typography
  TextStyle labelStyle() => _m3e.type.labelLarge;

  // Shapes
  OutlinedBorder shape(ButtonM3EShapeFamily family) {
    if (family == ButtonM3EShapeFamily.round) {
      return RoundedRectangleBorder(borderRadius: _m3e.shapes.round.lg);
    }
    // Square family should have sharp corners (no rounding)
    return const RoundedRectangleBorder(borderRadius: BorderRadius.zero);
  }

  // Spacing & heights
  _ButtonMetrics metrics(ButtonM3EDensity density) =>
      _metricsFor(context, density);
}
