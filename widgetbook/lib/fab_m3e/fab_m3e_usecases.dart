import 'package:fab_m3e/fab_m3e.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

Widget _buildFab(
  BuildContext context, {
  required FabM3EKind kind,
  FabM3ESize size = FabM3ESize.regular,
  FabM3EShapeFamily shape = FabM3EShapeFamily.round,
  FabM3EDensity density = FabM3EDensity.regular,
  bool enabled = true,
  bool autofocus = false,
  double? elevation,
  String? tooltip,
  Object? heroTag,
  String? semanticLabel,
}) {
  final selectedKind = context.knobs.object.dropdown<FabM3EKind>(
    label: 'kind',
    initialOption: kind,
    options: FabM3EKind.values,
    labelBuilder: (v) => v.name,
  );
  final selectedSize = context.knobs.object.dropdown<FabM3ESize>(
    label: 'size',
    initialOption: size,
    options: FabM3ESize.values,
    labelBuilder: (v) => v.name,
  );
  final selectedShape = context.knobs.object.dropdown<FabM3EShapeFamily>(
    label: 'shape',
    initialOption: shape,
    options: FabM3EShapeFamily.values,
    labelBuilder: (v) => v.name,
  );
  final selectedDensity = context.knobs.object.dropdown<FabM3EDensity>(
    label: 'density',
    initialOption: density,
    options: FabM3EDensity.values,
    labelBuilder: (v) => v.name,
  );
  final isEnabled =
      context.knobs.boolean(label: 'enabled', initialValue: enabled);
  final isAutofocus =
      context.knobs.boolean(label: 'autofocus', initialValue: autofocus);
  final dblElevation = context.knobs.doubleOrNull.slider(
    label: 'elevation',
    initialValue: elevation,
    min: 0.0,
    max: 24.0,
    divisions: 24,
  );
  final tip =
      context.knobs.stringOrNull(label: 'tooltip', initialValue: tooltip);
  final semLabel = context.knobs
      .stringOrNull(label: 'semanticLabel', initialValue: semanticLabel);
  final useHero = context.knobs
      .boolean(label: 'wrap in Hero', initialValue: heroTag != null);

  final Widget fab = FabM3E(
    icon: const Icon(Icons.add),
    onPressed: isEnabled
        ? () => print('FabM3E pressed (kind=$selectedKind, size=$selectedSize)')
        : null,
    tooltip: tip,
    heroTag: useHero ? (heroTag ?? 'fab-hero') : null,
    kind: selectedKind,
    size: selectedSize,
    shapeFamily: selectedShape,
    density: selectedDensity,
    elevation: dblElevation,
    autofocus: isAutofocus,
    semanticLabel: semLabel,
  );

  return Center(child: fab);
}

@widgetbook.UseCase(name: 'default', type: FabM3E)
Widget buildFabM3EDefaultUseCase(BuildContext context) {
  return _buildFab(context, kind: FabM3EKind.primary);
}

@widgetbook.UseCase(name: 'disabled', type: FabM3E)
Widget buildFabM3EDisabledUseCase(BuildContext context) {
  return _buildFab(context, kind: FabM3EKind.primary, enabled: false);
}

@widgetbook.UseCase(name: 'small', type: FabM3E)
Widget buildFabM3ESmallUseCase(BuildContext context) {
  return _buildFab(context, kind: FabM3EKind.primary, size: FabM3ESize.small);
}

@widgetbook.UseCase(name: 'large', type: FabM3E)
Widget buildFabM3ELargeUseCase(BuildContext context) {
  return _buildFab(context, kind: FabM3EKind.primary, size: FabM3ESize.large);
}

@widgetbook.UseCase(name: 'secondary', type: FabM3E)
Widget buildFabM3ESecondaryUseCase(BuildContext context) {
  return _buildFab(context, kind: FabM3EKind.secondary);
}

@widgetbook.UseCase(name: 'tertiary', type: FabM3E)
Widget buildFabM3ETertiaryUseCase(BuildContext context) {
  return _buildFab(context, kind: FabM3EKind.tertiary);
}

@widgetbook.UseCase(name: 'surface', type: FabM3E)
Widget buildFabM3ESurfaceUseCase(BuildContext context) {
  return _buildFab(context, kind: FabM3EKind.surface);
}

@widgetbook.UseCase(name: 'square_shape', type: FabM3E)
Widget buildFabM3ESquareShapeUseCase(BuildContext context) {
  return _buildFab(context,
      kind: FabM3EKind.primary, shape: FabM3EShapeFamily.square);
}

@widgetbook.UseCase(name: 'compact_density', type: FabM3E)
Widget buildFabM3ECompactDensityUseCase(BuildContext context) {
  return _buildFab(context,
      kind: FabM3EKind.primary, density: FabM3EDensity.compact);
}

@widgetbook.UseCase(name: 'focused', type: FabM3E)
Widget buildFabM3EFocusedUseCase(BuildContext context) {
  // Emphasize focus by enabling autofocus
  return _buildFab(context, kind: FabM3EKind.primary, autofocus: true);
}
