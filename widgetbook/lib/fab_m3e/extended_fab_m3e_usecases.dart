

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:fab_m3e/fab_m3e.dart';

Widget _buildExtendedFab(
  BuildContext context, {
  required FabM3EKind kind,
  Widget? icon,
  String labelText = 'Create',
  FabM3ESize size = FabM3ESize.regular,
  FabM3EShapeFamily shape = FabM3EShapeFamily.round,
  FabM3EDensity density = FabM3EDensity.regular,
  bool enabled = true,
  bool expand = false,
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

  final label = context.knobs.string(label: 'label', initialValue: labelText);
  final withIcon = context.knobs.boolean(label: 'with_icon', initialValue: icon != null);
  final isEnabled = context.knobs.boolean(label: 'enabled', initialValue: enabled);
  final shouldExpand = context.knobs.boolean(label: 'expand', initialValue: expand);
  final dblElevation = context.knobs.doubleOrNull.slider(
    label: 'elevation',
    initialValue: elevation,
    min: 0.0,
    max: 24.0,
    divisions: 24,
  );
  final tip = context.knobs.stringOrNull(label: 'tooltip', initialValue: tooltip);
  final semLabel = context.knobs.stringOrNull(label: 'semanticLabel', initialValue: semanticLabel);
  final useHero = context.knobs.boolean(label: 'wrap in Hero', initialValue: heroTag != null);

  final Widget fab = ExtendedFabM3E(
    label: Text(label, overflow: TextOverflow.ellipsis),
    icon: withIcon ? const Icon(Icons.add) : null,
    onPressed: isEnabled ? () => print('ExtendedFabM3E pressed (kind=$selectedKind, size=$selectedSize)') : null,
    tooltip: tip,
    heroTag: useHero ? (heroTag ?? 'extended-fab-hero') : null,
    kind: selectedKind,
    size: selectedSize,
    shapeFamily: selectedShape,
    density: selectedDensity,
    expand: shouldExpand,
    elevation: dblElevation,
    semanticLabel: semLabel,
  );

  return Center(
    child: SizedBox(width: shouldExpand ? 360 : null, child: fab),
  );
}

@widgetbook.UseCase(name: 'default', type: ExtendedFabM3E)
Widget buildExtendedFabM3EUseCase(BuildContext context) {
  return _buildExtendedFab(context, kind: FabM3EKind.primary, icon: const Icon(Icons.add));
}

@widgetbook.UseCase(name: 'with_icon', type: ExtendedFabM3E)
Widget buildExtendedFabM3EWithIconUseCase(BuildContext context) {
  return _buildExtendedFab(context, kind: FabM3EKind.primary, icon: const Icon(Icons.add));
}

@widgetbook.UseCase(name: 'without_label', type: ExtendedFabM3E)
Widget buildExtendedFabM3EWithoutLabelUseCase(BuildContext context) {
  return _buildExtendedFab(context, kind: FabM3EKind.primary, labelText: '');
}

@widgetbook.UseCase(name: 'disabled', type: ExtendedFabM3E)
Widget buildExtendedFabM3EDisabledUseCase(BuildContext context) {
  return _buildExtendedFab(context, kind: FabM3EKind.primary, icon: const Icon(Icons.add), enabled: false);
}

@widgetbook.UseCase(name: 'expand', type: ExtendedFabM3E)
Widget buildExtendedFabM3EExpandUseCase(BuildContext context) {
  return _buildExtendedFab(context, kind: FabM3EKind.primary, icon: const Icon(Icons.add), expand: true);
}

@widgetbook.UseCase(name: 'long_text', type: ExtendedFabM3E)
Widget buildExtendedFabM3ELongTextUseCase(BuildContext context) {
  return _buildExtendedFab(context, kind: FabM3EKind.primary, icon: const Icon(Icons.add), labelText: 'Compose a very long descriptive label that may overflow');
}

@widgetbook.UseCase(name: 'secondary', type: ExtendedFabM3E)
Widget buildExtendedFabM3ESecondaryUseCase(BuildContext context) {
  return _buildExtendedFab(context, kind: FabM3EKind.secondary, icon: const Icon(Icons.edit));
}

@widgetbook.UseCase(name: 'square_shape', type: ExtendedFabM3E)
Widget buildExtendedFabM3ESquareShapeUseCase(BuildContext context) {
  return _buildExtendedFab(context, kind: FabM3EKind.primary, icon: const Icon(Icons.add), shape: FabM3EShapeFamily.square);
}

@widgetbook.UseCase(name: 'compact_density', type: ExtendedFabM3E)
Widget buildExtendedFabM3ECompactDensityUseCase(BuildContext context) {
  return _buildExtendedFab(context, kind: FabM3EKind.primary, icon: const Icon(Icons.add), density: FabM3EDensity.compact);
}
