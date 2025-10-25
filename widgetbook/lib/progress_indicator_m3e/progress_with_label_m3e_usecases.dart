import 'package:flutter/material.dart';
import 'package:progress_indicator_m3e/progress_indicator_m3e.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

// Use cases for ProgressWithLabelM3E per plan/guide.md
// - Themes are injected globally by the Widgetbook app.
// - Knobs for value, size, and label style/text.

@UseCase(name: 'default', type: ProgressWithLabelM3E)
Widget buildProgressWithLabelM3EDefaultUseCase(BuildContext context) {
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

  return Center(
    child: ProgressWithLabelM3E(
      value: value,
      size: size,
    ),
  );
}

@UseCase(name: 'determinate_with_label', type: ProgressWithLabelM3E)
Widget buildProgressWithLabelM3EDeterminateWithLabelUseCase(
    BuildContext context) {
  final double value = context.knobs.double.slider(
    label: 'value',
    initialValue: 0.85,
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
  final double fontSize = context.knobs.double.slider(
    label: 'fontSize',
    initialValue: 12.0,
    min: 8.0,
    max: 32.0,
    divisions: 24,
  );

  return Center(
    child: ProgressWithLabelM3E(
      value: value,
      size: size,
      textStyle: TextStyle(fontSize: fontSize),
    ),
  );
}

@UseCase(name: 'long_label_text', type: ProgressWithLabelM3E)
Widget buildProgressWithLabelM3ELongLabelTextUseCase(BuildContext context) {
  final double value = context.knobs.double.slider(
    label: 'value',
    initialValue: 0.33,
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
  final String label = context.knobs.string(
    label: 'label (overrides %)',
    initialValue:
        'Downloading super-duper long file name with many-many characters... 33%',
  );
  final bool useCustom = context.knobs.boolean(
    label: 'use custom text instead of percent',
    initialValue: true,
  );
  // Note: The stock ProgressWithLabelM3E renders percentage by default.
  // To show a long label, we overlay an extra Text widget for demonstration.

  return SizedBox(
    width: size.diameterWavy,
    height: size.diameterWavy,
    child: Stack(
      alignment: Alignment.center,
      children: [
        CircularProgressIndicatorM3E(value: value, size: size),
        if (useCustom)
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          )
        else
          ProgressWithLabelM3E(value: value, size: size),
      ],
    ),
  );
}
