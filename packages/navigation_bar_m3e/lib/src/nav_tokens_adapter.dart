import 'package:flutter/material.dart';
import 'package:m3e_design/m3e_design.dart';
import 'enums.dart';

@immutable
class _NavMetrics {
  final double heightSmall;
  final double heightMedium;
  final double iconSize;
  final EdgeInsetsGeometry padding;
  final double indicatorThickness; // for underline
  const _NavMetrics({
    required this.heightSmall,
    required this.heightMedium,
    required this.iconSize,
    required this.padding,
    required this.indicatorThickness,
  });
}

_NavMetrics _metricsFor(BuildContext context, NavBarM3EDensity density) {
  final theme = Theme.of(context);
  final m3e = theme.extension<M3ETheme>() ?? M3ETheme.defaults(theme.colorScheme);
  final sp = m3e.spacing;

  double hSmall = 64; // compact/phone-tight
  double hMedium = 80; // default M3 nav bar height
  double icon = 24;
  double underline = 3;

  if (density == NavBarM3EDensity.compact) {
    hSmall -= 4; hMedium -= 4; underline -= 1;
  }

  return _NavMetrics(
    heightSmall: hSmall,
    heightMedium: hMedium,
    iconSize: icon,
    padding: EdgeInsets.symmetric(horizontal: sp.md),
    indicatorThickness: underline,
  );
}

class NavTokensAdapter {
  NavTokensAdapter(this.context);
  final BuildContext context;

  M3ETheme get _m3e {
    final t = Theme.of(context);
    return t.extension<M3ETheme>() ?? M3ETheme.defaults(t.colorScheme);
  }

  _NavMetrics metrics(NavBarM3EDensity density) => _metricsFor(context, density);

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
  ShapeBorder containerShape(NavBarM3EShapeFamily family) {
    final set = family == NavBarM3EShapeFamily.round ? _m3e.shapes.round : _m3e.shapes.square;
    return RoundedRectangleBorder(borderRadius: set.lg);
  }

  ShapeBorder indicatorShapePill() => const StadiumBorder();

  // Underline decoration for selected.
  BoxDecoration underlineDecoration(Color color, double thickness) {
    return BoxDecoration(
      border: Border(
        bottom: BorderSide(color: color, width: thickness),
      ),
    );
  }
}
