import 'package:flutter/material.dart';
import 'slider_theme_m3e.dart';
import 'enums.dart';

class RangeSliderM3E extends StatelessWidget {
  const RangeSliderM3E({
    super.key,
    required this.values,
    required this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.labels,
    this.semanticLabel,
    this.size = SliderM3ESize.medium,
    this.emphasis = SliderM3EEmphasis.primary,
    this.shapeFamily = SliderM3EShapeFamily.round,
    this.density = SliderM3EDensity.regular,
    this.showValueIndicator,
  });

  final RangeValues values;
  final ValueChanged<RangeValues>? onChanged;
  final ValueChanged<RangeValues>? onChangeStart;
  final ValueChanged<RangeValues>? onChangeEnd;
  final double min;
  final double max;
  final int? divisions;
  final RangeLabels? labels;
  final String? semanticLabel;

  final SliderM3ESize size;
  final SliderM3EEmphasis emphasis;
  final SliderM3EShapeFamily shapeFamily;
  final SliderM3EDensity density;
  final bool? showValueIndicator;

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

    return SliderTheme(
      data: theme,
      child: RangeSlider(
        values: RangeValues(
          values.start.clamp(min, max),
          values.end.clamp(min, max),
        ),
        onChanged: onChanged,
        onChangeStart: onChangeStart,
        onChangeEnd: onChangeEnd,
        min: min,
        max: max,
        divisions: divisions,
        labels: labels,
        semanticFormatterCallback: semanticLabel != null
            ? (v) => '$semanticLabel ${(100 * ((v - min) / (max - min))).toStringAsFixed(0)}%'
            : null,
      ),
    );
  }
}
