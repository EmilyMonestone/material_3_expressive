import 'package:flutter/material.dart';
import 'package:m3e_design/m3e_design.dart' as m3e;

/// Provides colors & shapes from `m3e_design` with safe fallbacks to Theme.of(context).
class NavigationRailTokensAdapter {
  const NavigationRailTokensAdapter(this.context);

  final BuildContext context;

  ColorScheme get _cs => Theme.of(context).colorScheme;

  // Colors per spec
  Color get containerColor {
    // Use surface container token if present, else fallback.
    return _maybe(() => context.m3e.colors.surfaceContainer) ??
        _cs.surfaceContainer;
  }

  Color get activeIndicatorColor {
    return _maybe(() => context.m3e.colors.secondaryContainer) ??
        _cs.secondaryContainer;
  }

  Color get activeIconAndLabel {
    return _maybe(() => context.m3e.colors.secondary) ?? _cs.secondary;
  }

  Color get inactiveIconAndLabel {
    return _maybe(() => context.m3e.colors.onSurfaceVariant) ??
        _cs.onSurfaceVariant;
  }

  Color get menuColor {
    return _maybe(() => context.m3e.colors.onSecondaryContainer) ??
        _cs.onSecondaryContainer;
  }

  Color get badgeBackground =>
      _maybe(() => context.m3e.colors.error) ?? _cs.error;
  Color get badgeLargeLabel =>
      _maybe(() => context.m3e.colors.onError) ?? _cs.onError;
  Color get badgeSmallDot =>
      _maybe(() => context.m3e.colors.error) ?? _cs.error;

  ShapeBorder get indicatorShapeFull {
    // Full corner per M3E: use the most rounded token, fallback to StadiumBorder.
    final br = _maybe(() => context.m3e.shapes.round.xs);
    if (br != null) return RoundedRectangleBorder(borderRadius: br);
    return const StadiumBorder();
  }

  T? _maybe<T>(T Function() pick) {
    try {
      return pick();
    } catch (_) {
      return null;
    }
  }
}
