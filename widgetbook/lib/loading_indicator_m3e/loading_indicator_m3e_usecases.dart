import 'package:flutter/material.dart';
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';
import 'package:material_new_shapes/material_new_shapes.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

// GENERATED USE CASES for LoadingIndicatorM3E per plan/guide.md
// Notes:
// - Themes are provided globally by the Widgetbook app.
// - Use knobs for critical and visual params; callbacks would print helpful messages (none here).
// - Complex objects get meaningful defaults with TODOs.

BoxConstraints _sizeToTight(double size) => BoxConstraints(
      minWidth: size,
      minHeight: size,
      maxWidth: size,
      maxHeight: size,
    );

EdgeInsets _paddingAll(double value) => EdgeInsets.all(value);

List<RoundedPolygon> _polygonSet(String id) {
  switch (id) {
    case 'cookie→oval':
      return [
        MaterialShapes.cookie9Sided,
        MaterialShapes.oval,
      ];
    case 'softBurst→pill→sunny':
      return [
        MaterialShapes.softBurst,
        MaterialShapes.pill,
        MaterialShapes.sunny,
      ];
    case 'triangle→square→pentagon':
      return [
        MaterialShapes.triangle,
        MaterialShapes.square,
        MaterialShapes.pentagon,
      ];
    default:
      // default sequence mirrors the package's internal default
      return [
        MaterialShapes.softBurst,
        MaterialShapes.cookie9Sided,
        MaterialShapes.pentagon,
        MaterialShapes.pill,
        MaterialShapes.sunny,
        MaterialShapes.cookie4Sided,
        MaterialShapes.oval,
      ];
  }
}

@UseCase(name: 'default', type: LoadingIndicatorM3E)
Widget buildLoadingIndicatorM3EDefaultUseCase(BuildContext context) {
  // Keep defaults: tokens-based sizing and colors, subtle container.
  return const Center(
    child: LoadingIndicatorM3E(),
  );
}

@UseCase(name: 'contained', type: LoadingIndicatorM3E)
Widget buildLoadingIndicatorM3EContainedUseCase(BuildContext context) {
  // Visual family: contained variant uses a stronger container color.
  return const Center(
    child: LoadingIndicatorM3E(variant: LoadingIndicatorM3EVariant.contained),
  );
}

@UseCase(name: 'sizes', type: LoadingIndicatorM3E)
Widget buildLoadingIndicatorM3ESizesUseCase(BuildContext context) {
  final String size = context.knobs.object.dropdown<String>(
    label: 'size',
    initialOption: 'medium',
    options: const ['small', 'medium', 'large', 'tiny (edge)'],
    labelBuilder: (v) => v,
  );

  final double px = switch (size) {
    'small' => 36,
    'large' => 64,
    'tiny (edge)' => 16, // boundary case
    _ => 48, // medium
  };

  return Center(
    child: LoadingIndicatorM3E(
      constraints: _sizeToTight(px),
    ),
  );
}

@UseCase(name: 'custom_colors', type: LoadingIndicatorM3E)
Widget buildLoadingIndicatorM3ECustomColorsUseCase(BuildContext context) {
  final variant = context.knobs.object.dropdown<LoadingIndicatorM3EVariant>(
    label: 'variant',
    initialOption: LoadingIndicatorM3EVariant.defaultStyle,
    options: LoadingIndicatorM3EVariant.values,
    labelBuilder: (v) => v.name,
  );
  final active = context.knobs.color(label: 'active color');
  final container = context.knobs.color(label: 'container color');

  return Center(
    child: LoadingIndicatorM3E(
      variant: variant,
      color: active,
      containerColor: container,
    ),
  );
}

@UseCase(name: 'with_padding', type: LoadingIndicatorM3E)
Widget buildLoadingIndicatorM3EWithPaddingUseCase(BuildContext context) {
  final double pad = context.knobs.double.slider(
    label: 'padding',
    initialValue: 8,
    min: 0,
    max: 32,
  );
  final double size = context.knobs.double.slider(
    label: 'size (px)',
    initialValue: 48,
    min: 16,
    max: 96,
  );

  return Center(
    child: LoadingIndicatorM3E(
      padding: _paddingAll(pad),
      constraints: _sizeToTight(size),
    ),
  );
}

@UseCase(name: 'with_semantics', type: LoadingIndicatorM3E)
Widget buildLoadingIndicatorM3EWithSemanticsUseCase(BuildContext context) {
  final String label = context.knobs.string(
    label: 'semanticsLabel',
    initialValue: 'Loading content',
  );
  final String value = context.knobs.string(
    label: 'semanticsValue',
    initialValue: 'Please wait…',
  );

  return Center(
    child: LoadingIndicatorM3E(
      semanticLabel: label,
      semanticValue: value,
    ),
  );
}

@UseCase(name: 'custom_polygons', type: LoadingIndicatorM3E)
Widget buildLoadingIndicatorM3ECustomPolygonsUseCase(BuildContext context) {
  final String setName = context.knobs.object.dropdown<String>(
    label: 'polygon set',
    initialOption: 'default',
    options: const [
      'default',
      'cookie→oval',
      'softBurst→pill→sunny',
      'triangle→square→pentagon',
    ],
    labelBuilder: (v) => v,
  );
  final double size = context.knobs.double.slider(
    label: 'size (px)',
    initialValue: 48,
    min: 24,
    max: 96,
  );

  final polygons = _polygonSet(setName);

  return Center(
    child: LoadingIndicatorM3E(
      polygons: polygons,
      constraints: _sizeToTight(size),
    ),
  );
}
