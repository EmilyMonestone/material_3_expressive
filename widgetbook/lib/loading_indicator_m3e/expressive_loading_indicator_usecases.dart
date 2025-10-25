

import 'package:flutter/material.dart';
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';
import 'package:material_new_shapes/material_new_shapes.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

// GENERATED USE CASES for ExpressiveLoadingIndicator per plan/guide.md
// - Themes are provided globally by the Widgetbook app.
// - Use knobs for critical & visual params.
// - Complex objects get meaningful defaults with TODOs where needed.

BoxConstraints _tight(double size) => BoxConstraints(
      minWidth: size,
      minHeight: size,
      maxWidth: size,
      maxHeight: size,
    );

List<RoundedPolygon> _polygonSet(String id) {
  switch (id) {
    case 'cookie→oval':
      return [MaterialShapes.cookie9Sided, MaterialShapes.oval];
    case 'softBurst→pill→sunny':
      return [MaterialShapes.softBurst, MaterialShapes.pill, MaterialShapes.sunny];
    case 'triangle→square→pentagon':
      return [MaterialShapes.triangle, MaterialShapes.square, MaterialShapes.pentagon];
    default:
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

@UseCase(name: 'default', type: ExpressiveLoadingIndicator)
Widget buildExpressiveLoadingIndicatorUseCase(BuildContext context) {
  return const Center(
    child: ExpressiveLoadingIndicator(),
  );
}

@UseCase(name: 'sizes', type: ExpressiveLoadingIndicator)
Widget buildExpressiveLoadingIndicatorSizesUseCase(BuildContext context) {
  final String size = context.knobs.object.dropdown<String>(
    label: 'size',
    initialOption: 'medium',
    options: const ['small', 'medium', 'large', 'tiny (edge)'],
    labelBuilder: (v) => v,
  );

  final double px = switch (size) {
    'small' => 36,
    'large' => 64,
    'tiny (edge)' => 16,
    _ => 48,
  };

  return Center(
    child: ExpressiveLoadingIndicator(constraints: _tight(px)),
  );
}

@UseCase(name: 'custom_polygons', type: ExpressiveLoadingIndicator)
Widget buildExpressiveLoadingIndicatorCustomPolygonsUseCase(
    BuildContext context) {
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
    child: ExpressiveLoadingIndicator(
      polygons: polygons,
      constraints: _tight(size),
    ),
  );
}

@UseCase(name: 'color_and_semantics', type: ExpressiveLoadingIndicator)
Widget buildExpressiveLoadingIndicatorColorAndSemanticsUseCase(
    BuildContext context) {
  final color = context.knobs.color(label: 'color');
  final label = context.knobs.string(
    label: 'semanticsLabel',
    initialValue: 'Loading',
  );
  final value = context.knobs.string(
    label: 'semanticsValue',
    initialValue: 'In progress',
  );

  return Center(
    child: ExpressiveLoadingIndicator(
      color: color,
      semanticsLabel: label,
      semanticsValue: value,
    ),
  );
}

@UseCase(name: 'edge: invalid polygons (debug assert)', type: ExpressiveLoadingIndicator)
Widget buildExpressiveLoadingIndicatorInvalidPolygonsUseCase(
    BuildContext context) {
  final enableInvalid = context.knobs.boolean(
    label: 'trigger invalid (single polygon)',
    initialValue: false,
  );
  final size = context.knobs.double.slider(
    label: 'size (px)',
    initialValue: 48,
    min: 24,
    max: 96,
  );

  // Note: When enabled, this will assert in debug as polygons.length must be > 1.
  final polygons = enableInvalid
      ? <RoundedPolygon>[MaterialShapes.oval]
      : _polygonSet('default');

  return Center(
    child: ExpressiveLoadingIndicator(
      polygons: polygons,
      constraints: _tight(size),
    ),
  );
}
