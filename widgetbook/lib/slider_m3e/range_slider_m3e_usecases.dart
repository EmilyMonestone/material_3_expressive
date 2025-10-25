import 'package:flutter/material.dart';
import 'package:slider_m3e/slider_m3e.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

Widget _buildRangeSliderM3EDemo(
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

  // Force min == max when zeroRange is requested
  if (zeroRange) {
    final fixed = context.knobs.double.slider(
      label: 'fixed value (min==max)',
      initialValue: 25,
      min: -100,
      max: 100,
      divisions: 40,
    );
    min = fixed;
    max = fixed;
  }

  if (min >= max) {
    // Ensure valid range
    max = min + 1;
  }

  // Pick start/end values within [min, max]
  final start = context.knobs.double.slider(
    label: 'start',
    initialValue: min + (max - min) * 0.25,
    min: min,
    max: max,
    divisions: 100,
  );
  final end = context.knobs.double.slider(
    label: 'end',
    initialValue: min + (max - min) * 0.75,
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

  // Labels & semantics
  final hasLabels = context.knobs.boolean(label: 'use RangeLabels', initialValue: false);
  final startLabel = hasLabels
      ? context.knobs.string(label: 'start label', initialValue: 'Start')
      : null;
  final endLabel = hasLabels
      ? context.knobs.string(label: 'end label', initialValue: 'End')
      : null;
  final labels = hasLabels && startLabel != null && endLabel != null
      ? RangeLabels(startLabel, endLabel)
      : null;

  final semanticLabel = zeroRange
      ? null
      : context.knobs.stringOrNull(
          label: 'semanticLabel',
          initialValue: 'Progress',
        );

  final onChanged = disabled
      ? null
      : (RangeValues v) => print('RangeSliderM3E onChanged -> ${v.start} - ${v.end}');
  final onChangeStart = disabled
      ? null
      : (RangeValues v) => print('RangeSliderM3E onChangeStart -> ${v.start} - ${v.end}');
  final onChangeEnd = disabled
      ? null
      : (RangeValues v) => print('RangeSliderM3E onChangeEnd -> ${v.start} - ${v.end}');

  return Padding(
    padding: const EdgeInsets.all(16),
    child: RangeSliderM3E(
      values: RangeValues(
        start.clamp(min, max),
        end.clamp(min, max),
      ),
      onChanged: onChanged,
      onChangeStart: onChangeStart,
      onChangeEnd: onChangeEnd,
      min: min,
      max: max,
      divisions: divisions,
      labels: labels,
      semanticLabel: semanticLabel,
      size: size,
      emphasis: emphasis,
      shapeFamily: shape,
      density: density,
      showValueIndicator: showValueIndicator,
    ),
  );
}

@UseCase(name: 'default', type: RangeSliderM3E)
Widget buildRangeSliderM3EDefaultUseCase(BuildContext context) {
  return _buildRangeSliderM3EDemo(context);
}

@UseCase(name: 'discrete', type: RangeSliderM3E)
Widget buildRangeSliderM3EDiscreteUseCase(BuildContext context) {
  return _buildRangeSliderM3EDemo(context, forcedDivisions: 6);
}

@UseCase(name: 'disabled', type: RangeSliderM3E)
Widget buildRangeSliderM3EDisabledUseCase(BuildContext context) {
  return _buildRangeSliderM3EDemo(context, disabled: true);
}

@UseCase(name: 'extremes_0_to_100', type: RangeSliderM3E)
Widget buildRangeSliderM3EExtremes0100UseCase(BuildContext context) {
  return _buildRangeSliderM3EDemo(context, forcedMin: 0, forcedMax: 100);
}

@UseCase(name: 'negative_range', type: RangeSliderM3E)
Widget buildRangeSliderM3ENegativeRangeUseCase(BuildContext context) {
  return _buildRangeSliderM3EDemo(context, forcedMin: -100, forcedMax: 0);
}

@UseCase(name: 'min_equals_max', type: RangeSliderM3E)
Widget buildRangeSliderM3EMinEqualsMaxUseCase(BuildContext context) {
  // Zero-range; interactions disabled to avoid semantic division by zero
  return _buildRangeSliderM3EDemo(context, zeroRange: true, disabled: true);
}
