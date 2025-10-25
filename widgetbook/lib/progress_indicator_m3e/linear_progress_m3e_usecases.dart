

import 'package:flutter/material.dart';
import 'package:progress_indicator_m3e/progress_indicator_m3e.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

// Use cases for LinearProgressIndicatorM3E per plan/guide.md
// - Themes are injected globally by the Widgetbook app.
// - Knobs for value (when determinate), size, shape, phase (wavy), and inset.
// - TODO: Consider adding color knobs for active/track colors.

@UseCase(name: 'indeterminate', type: LinearProgressIndicatorM3E)
Widget buildLinearProgressIndicatorM3EIndeterminateUseCase(
    BuildContext context) {
  final LinearProgressM3ESize size = context.knobs.object.dropdown(
    label: 'size',
    initialOption: LinearProgressM3ESize.m,
    options: LinearProgressM3ESize.values,
    labelBuilder: (v) => v.name,
  );
  final ProgressM3EShape shape = context.knobs.object.dropdown(
    label: 'shape',
    initialOption: ProgressM3EShape.wavy,
    options: ProgressM3EShape.values,
    labelBuilder: (v) => v.name,
  );
  final double phase = context.knobs.double.slider(
    label: 'phase (rad) — wavy only',
    initialValue: 0.0,
    min: 0.0,
    max: 6.28318,
    divisions: 36,
  );
  final double inset = context.knobs.double.slider(
    label: 'inset',
    initialValue: 4.0,
    min: 0.0,
    max: 24.0,
    divisions: 24,
  );

  return Padding(
    padding: const EdgeInsets.all(16),
    child: LinearProgressIndicatorM3E(
      value: null, // indeterminate
      size: size,
      shape: shape,
      phase: phase,
      inset: inset,
    ),
  );
}

@UseCase(name: 'determinate', type: LinearProgressIndicatorM3E)
Widget buildLinearProgressIndicatorM3EDeterminateUseCase(
    BuildContext context) {
  final double value = context.knobs.double.slider(
    label: 'value',
    initialValue: 0.5,
    min: 0.0,
    max: 1.0,
    divisions: 100,
  );
  final LinearProgressM3ESize size = context.knobs.object.dropdown(
    label: 'size',
    initialOption: LinearProgressM3ESize.m,
    options: LinearProgressM3ESize.values,
    labelBuilder: (v) => v.name,
  );
  final ProgressM3EShape shape = context.knobs.object.dropdown(
    label: 'shape',
    initialOption: ProgressM3EShape.wavy,
    options: ProgressM3EShape.values,
    labelBuilder: (v) => v.name,
  );
  final double phase = context.knobs.double.slider(
    label: 'phase (rad) — wavy only',
    initialValue: 0.0,
    min: 0.0,
    max: 6.28318,
    divisions: 36,
  );
  final double inset = context.knobs.double.slider(
    label: 'inset',
    initialValue: 4.0,
    min: 0.0,
    max: 24.0,
    divisions: 24,
  );

  return Padding(
    padding: const EdgeInsets.all(16),
    child: LinearProgressIndicatorM3E(
      value: value,
      size: size,
      shape: shape,
      phase: phase,
      inset: inset,
    ),
  );
}

@UseCase(name: 'size_s', type: LinearProgressIndicatorM3E)
Widget buildLinearProgressIndicatorM3ESizeSUseCase(BuildContext context) {
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
  final ProgressM3EShape shape = context.knobs.object.dropdown(
    label: 'shape',
    initialOption: ProgressM3EShape.flat,
    options: ProgressM3EShape.values,
    labelBuilder: (v) => v.name,
  );
  final double inset = context.knobs.double.slider(
    label: 'inset',
    initialValue: 0.0,
    min: 0.0,
    max: 24.0,
    divisions: 24,
  );

  return Padding(
    padding: const EdgeInsets.all(16),
    child: LinearProgressIndicatorM3E(
      value: valueOrNull,
      size: LinearProgressM3ESize.s,
      shape: shape,
      inset: inset,
    ),
  );
}

@UseCase(name: 'size_m', type: LinearProgressIndicatorM3E)
Widget buildLinearProgressIndicatorM3ESizeMUseCase(BuildContext context) {
  final double? valueOrNull = context.knobs.boolean(
    label: 'determinate',
    initialValue: true,
  )
      ? context.knobs.double.slider(
          label: 'value',
          initialValue: 1.0, // boundary case
          min: 0.0,
          max: 1.0,
          divisions: 100,
        )
      : null;
  final ProgressM3EShape shape = context.knobs.object.dropdown(
    label: 'shape',
    initialOption: ProgressM3EShape.wavy,
    options: ProgressM3EShape.values,
    labelBuilder: (v) => v.name,
  );
  final double phase = context.knobs.double.slider(
    label: 'phase (rad) — wavy only',
    initialValue: 0.0,
    min: 0.0,
    max: 6.28318,
    divisions: 36,
  );
  final double inset = context.knobs.double.slider(
    label: 'inset',
    initialValue: 8.0,
    min: 0.0,
    max: 24.0,
    divisions: 24,
  );

  return Padding(
    padding: const EdgeInsets.all(16),
    child: LinearProgressIndicatorM3E(
      value: valueOrNull,
      size: LinearProgressM3ESize.m,
      shape: shape,
      phase: phase,
      inset: inset,
    ),
  );
}
