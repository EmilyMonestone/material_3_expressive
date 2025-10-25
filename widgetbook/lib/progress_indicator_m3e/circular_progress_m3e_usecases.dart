

import 'package:flutter/material.dart';
import 'package:progress_indicator_m3e/progress_indicator_m3e.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

// Use cases for CircularProgressIndicatorM3E per plan/guide.md
// - Themes are injected globally by the Widgetbook app.
// - Knobs for value (when determinate), size, shape, rotation.
// - TODO: Consider adding color knobs for active/track colors.

@UseCase(name: 'indeterminate', type: CircularProgressIndicatorM3E)
Widget buildCircularProgressIndicatorM3EIndeterminateUseCase(
    BuildContext context) {
  final CircularProgressM3ESize size = context.knobs.object.dropdown(
    label: 'size',
    initialOption: CircularProgressM3ESize.m,
    options: CircularProgressM3ESize.values,
    labelBuilder: (v) => v.name,
  );
  final ProgressM3EShape shape = context.knobs.object.dropdown(
    label: 'shape',
    initialOption: ProgressM3EShape.wavy,
    options: ProgressM3EShape.values,
    labelBuilder: (v) => v.name,
  );
  final double rotation = context.knobs.double.slider(
    label: 'rotation (rad)',
    initialValue: 0.0,
    min: 0.0,
    max: 6.28318,
    divisions: 36,
  );

  return Center(
    child: CircularProgressIndicatorM3E(
      value: null, // indeterminate
      size: size,
      shape: shape,
      rotation: rotation,
    ),
  );
}

@UseCase(name: 'determinate', type: CircularProgressIndicatorM3E)
Widget buildCircularProgressIndicatorM3EDeterminateUseCase(
    BuildContext context) {
  final double value = context.knobs.double.slider(
    label: 'value',
    initialValue: 0.6,
    min: 0.0,
    max: 1.0,
    divisions: 100,
  );
  final CircularProgressM3ESize size = context.knobs.object.dropdown(
    label: 'size',
    initialOption: CircularProgressM3ESize.m,
    options: CircularProgressM3ESize.values,
    labelBuilder: (v) => v.name,
  );
  final ProgressM3EShape shape = context.knobs.object.dropdown(
    label: 'shape',
    initialOption: ProgressM3EShape.wavy,
    options: ProgressM3EShape.values,
    labelBuilder: (v) => v.name,
  );

  return Center(
    child: CircularProgressIndicatorM3E(
      value: value,
      size: size,
      shape: shape,
    ),
  );
}

@UseCase(name: 'flat', type: CircularProgressIndicatorM3E)
Widget buildCircularProgressIndicatorM3EFlatUseCase(BuildContext context) {
  final double? valueOrNull = context.knobs.boolean(
    label: 'determinate',
    initialValue: true,
  )
      ? context.knobs.double.slider(
          label: 'value',
          initialValue: 0.75,
          min: 0.0,
          max: 1.0,
          divisions: 100,
        )
      : null;
  final CircularProgressM3ESize size = context.knobs.object.dropdown(
    label: 'size',
    initialOption: CircularProgressM3ESize.m,
    options: CircularProgressM3ESize.values,
    labelBuilder: (v) => v.name,
  );

  return Center(
    child: CircularProgressIndicatorM3E(
      value: valueOrNull,
      size: size,
      shape: ProgressM3EShape.flat,
    ),
  );
}

@UseCase(name: 'wavy', type: CircularProgressIndicatorM3E)
Widget buildCircularProgressIndicatorM3EWavyUseCase(BuildContext context) {
  final double? valueOrNull = context.knobs.boolean(
    label: 'determinate',
    initialValue: false,
  )
      ? context.knobs.double.slider(
          label: 'value',
          initialValue: 0.4,
          min: 0.0,
          max: 1.0,
          divisions: 100,
        )
      : null;
  final CircularProgressM3ESize size = context.knobs.object.dropdown(
    label: 'size',
    initialOption: CircularProgressM3ESize.m,
    options: CircularProgressM3ESize.values,
    labelBuilder: (v) => v.name,
  );
  final double rotation = context.knobs.double.slider(
    label: 'rotation (rad)',
    initialValue: 0.0,
    min: 0.0,
    max: 6.28318,
    divisions: 36,
  );

  return Center(
    child: CircularProgressIndicatorM3E(
      value: valueOrNull,
      size: size,
      shape: ProgressM3EShape.wavy,
      rotation: rotation,
    ),
  );
}

@UseCase(name: 'size_s', type: CircularProgressIndicatorM3E)
Widget buildCircularProgressIndicatorM3ESizeSUseCase(BuildContext context) {
  final ProgressM3EShape shape = context.knobs.object.dropdown(
    label: 'shape',
    initialOption: ProgressM3EShape.wavy,
    options: ProgressM3EShape.values,
    labelBuilder: (v) => v.name,
  );
  final double? valueOrNull = context.knobs.boolean(
    label: 'determinate',
    initialValue: true,
  )
      ? context.knobs.double.slider(
          label: 'value',
          initialValue: 1.0,
          min: 0.0,
          max: 1.0,
          divisions: 100,
        )
      : null;

  return Center(
    child: CircularProgressIndicatorM3E(
      value: valueOrNull,
      size: CircularProgressM3ESize.s,
      shape: shape,
    ),
  );
}

@UseCase(name: 'size_m', type: CircularProgressIndicatorM3E)
Widget buildCircularProgressIndicatorM3ESizeMUseCase(BuildContext context) {
  final ProgressM3EShape shape = context.knobs.object.dropdown(
    label: 'shape',
    initialOption: ProgressM3EShape.wavy,
    options: ProgressM3EShape.values,
    labelBuilder: (v) => v.name,
  );
  final double? valueOrNull = context.knobs.boolean(
    label: 'determinate',
    initialValue: true,
  )
      ? context.knobs.double.slider(
          label: 'value',
          initialValue: 0.0, // boundary case
          min: 0.0,
          max: 1.0,
          divisions: 100,
        )
      : null;

  return Center(
    child: CircularProgressIndicatorM3E(
      value: valueOrNull,
      size: CircularProgressM3ESize.m,
      shape: shape,
    ),
  );
}
