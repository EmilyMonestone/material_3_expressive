

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:split_button_m3e/split_button_m3e.dart';

Widget _buildSplitButtonDemo(
  BuildContext context, {
  SplitButtonM3EEmphasis? emphasisFixed,
  SplitButtonM3ESize? sizeFixed,
  SplitButtonM3EShape? shapeFixed,
  bool? enabledFixed,
  String? labelFixed,
  IconData? iconFixed,
  int? itemsFixedCount,
}) {
  final emphasis = emphasisFixed ??
      context.knobs.object.dropdown<SplitButtonM3EEmphasis>(
        label: 'emphasis',
        initialOption: SplitButtonM3EEmphasis.filled,
        options: SplitButtonM3EEmphasis.values,
        labelBuilder: (v) => v.name,
      );

  final size = sizeFixed ?? context.knobs.object.dropdown<SplitButtonM3ESize>(
    label: 'size',
    initialOption: SplitButtonM3ESize.md,
    options: SplitButtonM3ESize.values,
    labelBuilder: (v) => v.name,
  );

  final shape = shapeFixed ??
      context.knobs.object.dropdown<SplitButtonM3EShape>(
        label: 'shape',
        initialOption: SplitButtonM3EShape.round,
        options: SplitButtonM3EShape.values,
        labelBuilder: (v) => v.name,
      );

  final trailingAlignment = context.knobs.object
      .dropdown<SplitButtonM3ETrailingAlignment>(
    label: 'trailingAlignment',
    initialOption: SplitButtonM3ETrailingAlignment.opticalCenter,
    options: SplitButtonM3ETrailingAlignment.values,
    labelBuilder: (v) => v.name,
  );

  final enabled = enabledFixed ??
      context.knobs.boolean(label: 'enabled', initialValue: true);

  // Content knobs
  final effectiveLabel = labelFixed ??
      context.knobs.string(label: 'label', initialValue: 'Save');

  final includeIcon = iconFixed != null
      ? true
      : context.knobs.boolean(label: 'leadingIcon', initialValue: true);

  final effectiveIcon = iconFixed ?? Icons.save_outlined; // TODO: icon picker knob

  // Tooltips knobs (helpful for semantics and tests)
  final leadingTooltip = context.knobs
      .string(label: 'leadingTooltip', initialValue: 'Save');
  final trailingTooltip = context.knobs
      .string(label: 'trailingTooltip', initialValue: 'Open menu');

  // Items knobs
  final itemCount = itemsFixedCount ?? context.knobs.int.slider(
    label: 'items count',
    initialValue: 4,
    min: 0,
    max: 120,
    divisions: 120,
  );

  final disableEveryNth = context.knobs.int.slider(
    label: 'disable every Nth (0 = none)',
    initialValue: 0,
    min: 0,
    max: 10,
    divisions: 10,
  );

  final items = List.generate(itemCount, (i) {
    final disabled = disableEveryNth == 0 ? false : (i % disableEveryNth == 0);
    return SplitButtonM3EItem<String>(
      value: 'value_$i',
      child: 'Option $i',
      enabled: !disabled,
    );
  });

  return Center(
    child: SplitButtonM3E<String>(
      size: size,
      shape: shape,
      emphasis: emphasis,
      label: effectiveLabel.isEmpty ? null : effectiveLabel,
      leadingIcon: includeIcon ? effectiveIcon : null,
      onPressed: enabled
          ? () => print(
              'Primary pressed: size=${size.name}, shape=${shape.name}, emphasis=${emphasis.name}',
            )
          : null,
      items: items,
      onSelected: (v) => print('Menu selected → $v'),
      trailingAlignment: trailingAlignment,
      leadingTooltip: leadingTooltip.isEmpty ? null : leadingTooltip,
      trailingTooltip: trailingTooltip.isEmpty ? null : trailingTooltip,
      enabled: enabled,
    ),
  );
}

// Default
@widgetbook.UseCase(name: 'default', type: SplitButtonM3E)
Widget buildSplitButtonM3EDefaultUseCase(BuildContext context) {
  return _buildSplitButtonDemo(context);
}

// Emphasis variants
@widgetbook.UseCase(name: 'filled', type: SplitButtonM3E)
Widget buildSplitButtonM3EFilledUseCase(BuildContext context) {
  return _buildSplitButtonDemo(
    context,
    emphasisFixed: SplitButtonM3EEmphasis.filled,
  );
}

@widgetbook.UseCase(name: 'tonal', type: SplitButtonM3E)
Widget buildSplitButtonM3ETonalUseCase(BuildContext context) {
  return _buildSplitButtonDemo(
    context,
    emphasisFixed: SplitButtonM3EEmphasis.tonal,
  );
}

@widgetbook.UseCase(name: 'elevated', type: SplitButtonM3E)
Widget buildSplitButtonM3EElevatedUseCase(BuildContext context) {
  return _buildSplitButtonDemo(
    context,
    emphasisFixed: SplitButtonM3EEmphasis.elevated,
  );
}

@widgetbook.UseCase(name: 'outlined', type: SplitButtonM3E)
Widget buildSplitButtonM3EOutlinedUseCase(BuildContext context) {
  return _buildSplitButtonDemo(
    context,
    emphasisFixed: SplitButtonM3EEmphasis.outlined,
  );
}

@widgetbook.UseCase(name: 'text', type: SplitButtonM3E)
Widget buildSplitButtonM3ETextUseCase(BuildContext context) {
  return _buildSplitButtonDemo(
    context,
    emphasisFixed: SplitButtonM3EEmphasis.text,
  );
}

// Size variants
@widgetbook.UseCase(name: 'xs', type: SplitButtonM3E)
Widget buildSplitButtonM3EXSUseCase(BuildContext context) {
  return _buildSplitButtonDemo(
    context,
    sizeFixed: SplitButtonM3ESize.xs,
  );
}

@widgetbook.UseCase(name: 'sm', type: SplitButtonM3E)
Widget buildSplitButtonM3ESMUseCase(BuildContext context) {
  return _buildSplitButtonDemo(
    context,
    sizeFixed: SplitButtonM3ESize.sm,
  );
}

@widgetbook.UseCase(name: 'md', type: SplitButtonM3E)
Widget buildSplitButtonM3EMDUseCase(BuildContext context) {
  return _buildSplitButtonDemo(
    context,
    sizeFixed: SplitButtonM3ESize.md,
  );
}

@widgetbook.UseCase(name: 'lg', type: SplitButtonM3E)
Widget buildSplitButtonM3ELGUseCase(BuildContext context) {
  return _buildSplitButtonDemo(
    context,
    sizeFixed: SplitButtonM3ESize.lg,
  );
}

@widgetbook.UseCase(name: 'xl', type: SplitButtonM3E)
Widget buildSplitButtonM3EXLUseCase(BuildContext context) {
  return _buildSplitButtonDemo(
    context,
    sizeFixed: SplitButtonM3ESize.xl,
  );
}

// Shape variants
@widgetbook.UseCase(name: 'round', type: SplitButtonM3E)
Widget buildSplitButtonM3ERoundUseCase(BuildContext context) {
  return _buildSplitButtonDemo(
    context,
    shapeFixed: SplitButtonM3EShape.round,
  );
}

@widgetbook.UseCase(name: 'square', type: SplitButtonM3E)
Widget buildSplitButtonM3ESquareUseCase(BuildContext context) {
  return _buildSplitButtonDemo(
    context,
    shapeFixed: SplitButtonM3EShape.square,
  );
}

// Content variants
@widgetbook.UseCase(name: 'with_icon', type: SplitButtonM3E)
Widget buildSplitButtonM3EWithIconUseCase(BuildContext context) {
  return _buildSplitButtonDemo(
    context,
    labelFixed: '',
    iconFixed: Icons.save_outlined,
  );
}

@widgetbook.UseCase(name: 'with_label', type: SplitButtonM3E)
Widget buildSplitButtonM3EWithLabelUseCase(BuildContext context) {
  return _buildSplitButtonDemo(
    context,
    labelFixed: 'Save',
    iconFixed: null,
  );
}

@widgetbook.UseCase(name: 'long_label', type: SplitButtonM3E)
Widget buildSplitButtonM3ELongLabelUseCase(BuildContext context) {
  return _buildSplitButtonDemo(
    context,
    labelFixed: 'Save document and sync to cloud',
    iconFixed: Icons.cloud_upload_outlined,
  );
}

// Edge cases
@widgetbook.UseCase(name: 'many_items', type: SplitButtonM3E)
Widget buildSplitButtonM3EManyItemsUseCase(BuildContext context) {
  return _buildSplitButtonDemo(
    context,
    itemsFixedCount: 60,
  );
}

@widgetbook.UseCase(name: 'empty_items', type: SplitButtonM3E)
Widget buildSplitButtonM3EEmptyItemsUseCase(BuildContext context) {
  return _buildSplitButtonDemo(
    context,
    itemsFixedCount: 0,
  );
}

@widgetbook.UseCase(name: 'disabled', type: SplitButtonM3E)
Widget buildSplitButtonM3EDisabledUseCase(BuildContext context) {
  return _buildSplitButtonDemo(
    context,
    enabledFixed: false,
  );
}
