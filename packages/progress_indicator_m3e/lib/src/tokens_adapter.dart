import 'package:flutter/material.dart';
import 'package:m3e_design/m3e_design.dart';
import 'enums.dart';

@immutable
class _ProgressMetrics {
  final double circularSmall;
  final double circularMedium;
  final double circularLarge;
  final double strokeSmall;
  final double strokeMedium;
  final double strokeLarge;
  final double linearThicknessSmall;
  final double linearThicknessMedium;
  final double linearThicknessLarge;
  final double wavyWavelength; // dp (linear)
  final double wavyAmplitudeFactor; // fraction of bar height (linear)
  final double horizontalInset; // 4dp
  final double circularWaveAmplitudeFactor; // fraction of stroke
  final int circularWavesPerCircle; // rough default
  const _ProgressMetrics({
    required this.circularSmall,
    required this.circularMedium,
    required this.circularLarge,
    required this.strokeSmall,
    required this.strokeMedium,
    required this.strokeLarge,
    required this.linearThicknessSmall,
    required this.linearThicknessMedium,
    required this.linearThicknessLarge,
    required this.wavyWavelength,
    required this.wavyAmplitudeFactor,
    required this.horizontalInset,
    required this.circularWaveAmplitudeFactor,
    required this.circularWavesPerCircle,
  });
}

_ProgressMetrics _metricsFor(BuildContext context, ProgressM3EDensity density) {
  double cS = 24, cM = 32, cL = 48;
  double sS = 3,  sM = 4,  sL = 6;
  double ltS = 3, ltM = 4, ltL = 6;

  if (density == ProgressM3EDensity.compact) {
    cS -= 2; cM -= 2; cL -= 4;
    sS -= 0.5; sM -= 0.5; sL -= 1;
    ltS -= 0.5; ltM -= 0.5; ltL -= 1;
  }

  return _ProgressMetrics(
    circularSmall: cS,
    circularMedium: cM,
    circularLarge: cL,
    strokeSmall: sS,
    strokeMedium: sM,
    strokeLarge: sL,
    linearThicknessSmall: ltS,
    linearThicknessMedium: ltM,
    linearThicknessLarge: ltL,
    wavyWavelength: 40,           // per spec illustration
    wavyAmplitudeFactor: 0.33,    // amplitude ≈ 1/3 of height
    horizontalInset: 4,           // 4dp inset L/R
    circularWaveAmplitudeFactor: 0.35, // ~1/3 of stroke
    circularWavesPerCircle: 10,   // a nice default
  );
}

class ProgressTokensAdapter {
  ProgressTokensAdapter(this.context);
  final BuildContext context;

  M3ETheme get _m3e {
    final t = Theme.of(context);
    return t.extension<M3ETheme>() ?? M3ETheme.defaults(t.colorScheme);
  }

  _ProgressMetrics metrics(ProgressM3EDensity density) => _metricsFor(context, density);

  Color color(ProgressM3EEmphasis emphasis) {
    switch (emphasis) {
      case ProgressM3EEmphasis.primary:
        return _m3e.colors.primary;
      case ProgressM3EEmphasis.secondary:
        return _m3e.colors.secondary;
      case ProgressM3EEmphasis.surface:
        return _m3e.colors.onSurface;
    }
  }

  Color trackColor() => _m3e.colors.onSurface.withOpacity(0.12);
  Color bufferColor(Color progress) => progress.withOpacity(0.24);

  TextStyle labelStyle() => _m3e.type.bodySmall;
}
