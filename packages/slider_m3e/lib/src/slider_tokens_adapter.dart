import 'package:flutter/material.dart';
import 'package:m3e_design/m3e_design.dart';
import 'enums.dart';

@immutable
class _SliderMetrics {
  final double trackSmall;
  final double trackMedium;
  final double trackLarge;
  final double thumbSmall;
  final double thumbMedium;
  final double thumbLarge;
  final double overlayRadius;
  final double tickRadius;
  const _SliderMetrics({
    required this.trackSmall,
    required this.trackMedium,
    required this.trackLarge,
    required this.thumbSmall,
    required this.thumbMedium,
    required this.thumbLarge,
    required this.overlayRadius,
    required this.tickRadius,
  });
}

_SliderMetrics _metricsFor(BuildContext context, SliderM3EDensity density) {
  // Based on M3 defaults with a slightly more expressive large option.
  double trS = 2, trM = 4, trL = 6;
  double thS = 10, thM = 12, thL = 14;
  double overlay = 20, tick = 2;

  if (density == SliderM3EDensity.compact) {
    trS -= 0.5; trM -= 0.5; trL -= 1.0;
    thS -= 1; thM -= 1; thL -= 2;
    overlay -= 2;
  }

  return _SliderMetrics(
    trackSmall: trS,
    trackMedium: trM,
    trackLarge: trL,
    thumbSmall: thS,
    thumbMedium: thM,
    thumbLarge: thL,
    overlayRadius: overlay,
    tickRadius: tick,
  );
}

class SliderTokensAdapter {
  SliderTokensAdapter(this.context);
  final BuildContext context;

  M3ETheme get _m3e {
    final t = Theme.of(context);
    return t.extension<M3ETheme>() ?? M3ETheme.defaults(t.colorScheme);
  }

  _SliderMetrics metrics(SliderM3EDensity density) => _metricsFor(context, density);

  // Colors
  Color activeColor(SliderM3EEmphasis e) {
    switch (e) {
      case SliderM3EEmphasis.primary: return _m3e.colors.primary;
      case SliderM3EEmphasis.secondary: return _m3e.colors.secondary;
      case SliderM3EEmphasis.surface: return _m3e.colors.onSurface;
    }
  }
  Color inactiveColor() => _m3e.colors.onSurface.withValues(alpha: 0.24);
  Color tickColorActive(SliderM3EEmphasis e) => activeColor(e).withValues(alpha: 0.9);
  Color tickColorInactive() => _m3e.colors.onSurface.withValues(alpha: 0.38);
  Color thumbColor(SliderM3EEmphasis e) => activeColor(e);
  Color overlayColor(SliderM3EEmphasis e) => activeColor(e).withValues(alpha: 0.12);
  Color valueIndicatorColor() => _m3e.colors.secondaryContainer;
  TextStyle valueIndicatorTextStyle() => _m3e.type.labelSmall.copyWith(color: _m3e.colors.onSecondaryContainer);

  // Shapes
  OutlinedBorder containerShape(SliderM3EShapeFamily family) {
    final set = family == SliderM3EShapeFamily.round ? _m3e.shapes.round : _m3e.shapes.square;
    return RoundedRectangleBorder(borderRadius: set.md);
  }
}
