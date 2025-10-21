import 'package:flutter/material.dart';
import 'package:m3e_design/m3e_design.dart';
import 'enums.dart';

@immutable
class _RailMetrics {
  final double widthCompact;
  final double widthRegular;
  final double extendedMinWidth;
  final double iconSize;
  final EdgeInsetsGeometry itemPadding;
  final double stripeThickness;
  const _RailMetrics({
    required this.widthCompact,
    required this.widthRegular,
    required this.extendedMinWidth,
    required this.iconSize,
    required this.itemPadding,
    required this.stripeThickness,
  });
}

_RailMetrics _metricsFor(BuildContext context, RailDensity density) {
  final theme = Theme.of(context);
  final m3e = theme.extension<M3ETheme>() ?? M3ETheme.defaults(theme.colorScheme);
  final sp = m3e.spacing;

  double wC = 64;   // compact width
  double wR = 80;   // regular width
  double ext = 256; // extended min width
  double icon = 24;
  double stripe = 3;

  if (density == RailDensity.compact) {
    wC -= 4; wR -= 4; stripe -= 1;
  }

  return _RailMetrics(
    widthCompact: wC,
    widthRegular: wR,
    extendedMinWidth: ext,
    iconSize: icon,
    itemPadding: EdgeInsets.symmetric(horizontal: sp.md, vertical: sp.sm),
    stripeThickness: stripe,
  );
}

class RailTokensAdapter {
  RailTokensAdapter(this.context);
  final BuildContext context;

  M3ETheme get _m3e {
    final t = Theme.of(context);
    return t.extension<M3ETheme>() ?? M3ETheme.defaults(t.colorScheme);
  }

  _RailMetrics metrics(RailDensity density) => _metricsFor(context, density);

  // Container/background
  Color containerColor() => _m3e.colors.surfaceContainerHigh;

  // Indicator
  Color indicatorColor() => _m3e.colors.secondaryContainer;

  // Icon/label colors
  Color selectedColor() => _m3e.colors.onSecondaryContainer;
  Color unselectedColor() => _m3e.colors.onSurfaceVariant;

  // Typography
  TextStyle labelStyle() => _m3e.type.labelMedium;

  // Shapes
  ShapeBorder containerShape(RailShapeFamily family) {
    final set = family == RailShapeFamily.round ? _m3e.shapes.round : _m3e.shapes.square;
    return RoundedRectangleBorder(borderRadius: set.lg);
  }

  ShapeBorder indicatorShapePill() => const StadiumBorder();

  // Stripe decoration for selected destination
  BoxDecoration stripeDecoration(Color color, double thickness) {
    return BoxDecoration(
      border: Border(
        left: BorderSide(color: color, width: thickness),
      ),
    );
  }
}
