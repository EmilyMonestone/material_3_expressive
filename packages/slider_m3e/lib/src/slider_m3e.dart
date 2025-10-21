import 'package:flutter/material.dart';
import 'slider_theme_m3e.dart';
import 'enums.dart';

class SliderM3E extends StatelessWidget {
  const SliderM3E({
    super.key,
    required this.value,
    required this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.label,
    this.semanticLabel,
    this.size = SliderM3ESize.medium,
    this.emphasis = SliderM3EEmphasis.primary,
    this.shapeFamily = SliderM3EShapeFamily.round,
    this.density = SliderM3EDensity.regular,
    this.showValueIndicator,
    this.startIcon,
    this.endIcon,
  });

  final double value;
  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onChangeStart;
  final ValueChanged<double>? onChangeEnd;
  final double min;
  final double max;
  final int? divisions;
  final String? label;
  final String? semanticLabel;

  final SliderM3ESize size;
  final SliderM3EEmphasis emphasis;
  final SliderM3EShapeFamily shapeFamily;
  final SliderM3EDensity density;
  final bool? showValueIndicator;

  final Widget? startIcon;
  final Widget? endIcon;

  @override
  Widget build(BuildContext context) {
    final theme = sliderThemeM3E(
      context,
      size: size,
      emphasis: emphasis,
      shapeFamily: shapeFamily,
      density: density,
      showValueIndicator: showValueIndicator ?? false,
    );

    final slider = Slider(
      value: value.clamp(min, max),
      onChanged: onChanged,
      onChangeStart: onChangeStart,
      onChangeEnd: onChangeEnd,
      min: min,
      max: max,
      divisions: divisions,
      label: label,
      semanticFormatterCallback: semanticLabel != null
          ? (v) => '$semanticLabel ${(100 * ((v - min) / (max - min))).toStringAsFixed(0)}%'
          : null,
    );

    if (startIcon == null && endIcon == null) {
      return SliderTheme(data: theme, child: slider);
    }

    return SliderTheme(
      data: theme,
      child: Row(
        children: [
          if (startIcon != null) ...[startIcon!, const SizedBox(width: 8)],
          Expanded(child: slider),
          if (endIcon != null) ...[const SizedBox(width: 8), endIcon!],
        ],
      ),
    );
  }
}
