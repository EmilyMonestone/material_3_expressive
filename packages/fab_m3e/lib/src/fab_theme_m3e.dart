import 'package:flutter/material.dart';
import 'package:m3e_design/m3e_design.dart';

import 'enums.dart';

@immutable
class _FabMetrics {
  final double small;
  final double regular;
  final double large;
  final double extendedHeight;
  final EdgeInsetsGeometry extendedPadding;
  final double iconSize;
  final double elevationRest;
  final double elevationHover;
  final double elevationPressed;
  const _FabMetrics({
    required this.small,
    required this.regular,
    required this.large,
    required this.extendedHeight,
    required this.extendedPadding,
    required this.iconSize,
    required this.elevationRest,
    required this.elevationHover,
    required this.elevationPressed,
  });
}

_FabMetrics _metricsFor(BuildContext context, FabM3EDensity density) {
  final theme = Theme.of(context);
  final m3e =
      theme.extension<M3ETheme>() ?? M3ETheme.defaults(theme.colorScheme);
  final sp = m3e.spacing;

  double small = 40;
  double regular = 56;
  double large = 96;
  double extH = 56;
  double icon = 24;

  if (density == FabM3EDensity.compact) {
    small -= 4;
    regular -= 4;
    large -= 4;
    extH -= 4;
  }

  return _FabMetrics(
    small: small,
    regular: regular,
    large: large,
    extendedHeight: extH,
    extendedPadding: EdgeInsets.symmetric(horizontal: sp.lg),
    iconSize: icon,
    elevationRest: 6.0,
    elevationHover: 8.0,
    elevationPressed: 12.0,
  );
}

class FabTokensAdapter {
  FabTokensAdapter(this.context);
  final BuildContext context;

  M3ETheme get _m3e {
    final t = Theme.of(context);
    return t.extension<M3ETheme>() ?? M3ETheme.defaults(t.colorScheme);
  }

  _FabMetrics metrics(FabM3EDensity density) => _metricsFor(context, density);

  // Colors by kind
  Color bg(FabM3EKind kind) {
    switch (kind) {
      case FabM3EKind.primary:
        return _m3e.colors.primaryContainer;
      case FabM3EKind.secondary:
        return _m3e.colors.secondaryContainer;
      case FabM3EKind.tertiary:
        return _m3e.colors.tertiaryContainer;
      case FabM3EKind.surface:
        return _m3e.colors.surfaceContainerHigh;
    }
  }

  Color fg(FabM3EKind kind) {
    switch (kind) {
      case FabM3EKind.primary:
        return _m3e.colors.onPrimaryContainer;
      case FabM3EKind.secondary:
        return _m3e.colors.onSecondaryContainer;
      case FabM3EKind.tertiary:
        return _m3e.colors.onTertiaryContainer;
      case FabM3EKind.surface:
        return _m3e.colors.onSurface;
    }
  }

  // Shapes
  ShapeBorder shape(FabM3EShapeFamily family, FabM3ESize size) {
    final set = family == FabM3EShapeFamily.round
        ? _m3e.shapes.round
        : _m3e.shapes.square;
    // circular-ish fab: use large radius to approach circle; actual size enforced by constraints
    final radius = switch (size) {
      FabM3ESize.small => set.lg,
      FabM3ESize.regular => set.xl,
      FabM3ESize.large => set.xl
    };
    return RoundedRectangleBorder(borderRadius: radius);
  }

  // Typography
  TextStyle labelStyle() => _m3e.type.labelLarge;
}
