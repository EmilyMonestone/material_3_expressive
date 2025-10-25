import 'package:flutter/material.dart';
import 'package:slider_m3e/slider_m3e.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

Widget _buildSliderM3EDemo(
  BuildContext context, {
  double? forcedMin,
  double? forcedMax,
  int? forcedDivisions,
  bool disabled = false,
  bool zeroRange = false,
}) {
  // Critical params via knobs
  final minKnob = forcedMin ??
      context.knobs.double.slider(
        label: 'min',
        initialValue: 0,
        min: -100,
        max: 100,
        divisions: 40,
      );
  final maxKnob = forcedMax ??
      context.knobs.double.slider(
        label: 'max',
        initialValue: 100,
        min: -100,
        max: 200,
        divisions: 60,
      );

  double min = minKnob;
  double max = maxKnob;

  // Special handling when zeroRange is requested
  if (zeroRange) {
    // Force min == max and disable interactions to avoid semantic division by zero
    final fixed = context.knobs.double.slider(
      label: 'fixed value (min==max)',
      initialValue: 50,
      min: -100,
      max: 100,
      divisions: 40,
    );
    min = fixed;
    max = fixed;
  }

  if (min >= max) {
    // Guard against invalid ranges; ensure there is at least a small span
    max = min + 1;
  }

  final value = context.knobs.double.slider(
    label: 'value',
    initialValue: (min + max) / 2,
    min: min,
    max: max,
    divisions: 100,
  );

  final divisions = forcedDivisions ??
      context.knobs.intOrNull.slider(
        label: 'divisions',
        initialValue: null,
        min: 1,
        max: 20,
        divisions: 19,
      );

  // Visual params via knobs
  final size = context.knobs.object.dropdown<SliderM3ESize>(
    label: 'size',
    initialOption: SliderM3ESize.medium,
    options: SliderM3ESize.values,
    labelBuilder: (v) => v.name,
  );
  final emphasis = context.knobs.object.dropdown<SliderM3EEmphasis>(
    label: 'emphasis',
    initialOption: SliderM3EEmphasis.primary,
    options: SliderM3EEmphasis.values,
    labelBuilder: (v) => v.name,
  );
  final shape = context.knobs.object.dropdown<SliderM3EShapeFamily>(
    label: 'shapeFamily',
    initialOption: SliderM3EShapeFamily.round,
    options: SliderM3EShapeFamily.values,
    labelBuilder: (v) => v.name,
  );
  final density = context.knobs.object.dropdown<SliderM3EDensity>(
    label: 'density',
    initialOption: SliderM3EDensity.regular,
    options: SliderM3EDensity.values,
    labelBuilder: (v) => v.name,
  );

  final showValueIndicator = context.knobs.boolean(
    label: 'showValueIndicator',
    initialValue: false,
  );
  final withStartIcon = context.knobs.boolean(
    label: 'startIcon',
    initialValue: false,
  );
  final withEndIcon = context.knobs.boolean(
    label: 'endIcon',
    initialValue: false,
  );

  // Content params
  final label = context.knobs.stringOrNull(
    label: 'label',
    initialValue: null,
  );
  // Avoid semantic callback when zeroRange to prevent divide-by-zero in tokens formatting
  final semanticLabel = zeroRange
      ? null
      : context.knobs.stringOrNull(
          label: 'semanticLabel',
          initialValue: 'Progress',
        );

  final onChanged = disabled
      ? null
      : (double v) => print('SliderM3E onChanged -> $v');
  final onChangeStart = disabled
      ? null
      : (double v) => print('SliderM3E onChangeStart -> $v');
  final onChangeEnd = disabled
      ? null
      : (double v) => print('SliderM3E onChangeEnd -> $v');

  return Padding(
    padding: const EdgeInsets.all(16),
    child: SliderM3E(
      value: value,
      onChanged: onChanged,
      onChangeStart: onChangeStart,
      onChangeEnd: onChangeEnd,
      min: min,
      max: max,
      divisions: divisions,
      label: label,
      semanticLabel: semanticLabel,
      size: size,
      emphasis: emphasis,
      shapeFamily: shape,
      density: density,
      showValueIndicator: showValueIndicator,
      startIcon: withStartIcon ? const Icon(Icons.remove) : null,
      endIcon: withEndIcon ? const Icon(Icons.add) : null,
    ),
  );
}

@UseCase(name: 'default', type: SliderM3E)
Widget buildSliderM3EDefaultUseCase(BuildContext context) {
  return _buildSliderM3EDemo(context);
}

@UseCase(name: 'discrete', type: SliderM3E)
Widget buildSliderM3EDiscreteUseCase(BuildContext context) {
  // Provide a default divisions count; still knob-customizable via 'divisions'
  return _buildSliderM3EDemo(context, forcedDivisions: 5);
}

@UseCase(name: 'disabled', type: SliderM3E)
Widget buildSliderM3EDisabledUseCase(BuildContext context) {
  return _buildSliderM3EDemo(context, disabled: true);
}

@UseCase(name: 'extremes_0_to_100', type: SliderM3E)
Widget buildSliderM3EExtremes0100UseCase(BuildContext context) {
  return _buildSliderM3EDemo(context, forcedMin: 0, forcedMax: 100);
}

@UseCase(name: 'negative_range', type: SliderM3E)
Widget buildSliderM3ENegativeRangeUseCase(BuildContext context) {
  return _buildSliderM3EDemo(context, forcedMin: -100, forcedMax: 0);
}

@UseCase(name: 'min_equals_max', type: SliderM3E)
Widget buildSliderM3EMinEqualsMaxUseCase(BuildContext context) {
  // Show a zero-range slider (min == max), interactions disabled to avoid semantic math
  return _buildSliderM3EDemo(context, zeroRange: true, disabled: true);
}
