import 'package:flutter/material.dart';
import 'package:m3e_collection/m3e_collection.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

// GENERATED USE CASES for ButtonGroupM3E per plan/guide.md
// Notes:
// - Themes are provided globally by the Widgetbook app.
// - Use knobs for critical and visual params; callbacks print helpful messages.
// - Complex objects get meaningful defaults with TODOs.

List<Widget> _demoButtonsWithLabels(BuildContext context) => <Widget>[
      ButtonM3E(
        style: ButtonM3EStyle.elevated,
        onPressed: () => debugPrint('Pressed: Primary'),
        label: const Text('Elevated'),
      ),
      ButtonM3E(
        style: ButtonM3EStyle.outlined,
        onPressed: () => debugPrint('Pressed: Secondary'),
        label: const Text('Outlined'),
      ),
      ButtonM3E(
        style: ButtonM3EStyle.text,
        onPressed: () => debugPrint('Pressed: Tertiary'),
        label: const Text('Textbutton'),
      ),
    ];

List<Widget> _demoButtonsWithIcons(BuildContext context) => <Widget>[
      ButtonM3E(
        style: ButtonM3EStyle.elevated,
        onPressed: () => debugPrint('Pressed: Favorite'),
        label: const Text('Favorite'),
        icon: const Icon(Icons.favorite_border),
      ),
      ButtonM3E(
        style: ButtonM3EStyle.outlined,
        onPressed: () => debugPrint('Pressed: Search'),
        label: const Text('Search'),
        icon: const Icon(Icons.search),
      ),
      ButtonM3E(
        style: ButtonM3EStyle.text,
        onPressed: () => debugPrint('Pressed: Settings'),
        label: const Text('Settings'),
        icon: const Icon(Icons.settings_outlined),
      ),
    ];

ButtonGroupM3EType _knobType(
  BuildContext context, {
  ButtonGroupM3EType initial = ButtonGroupM3EType.standard,
}) =>
    context.knobs.object.dropdown<ButtonGroupM3EType>(
      label: 'type',
      initialOption: initial,
      options: ButtonGroupM3EType.values,
      labelBuilder: (ButtonGroupM3EType v) => v.name,
    );

ButtonGroupM3EShape _knobShape(
  BuildContext context, {
  ButtonGroupM3EShape initial = ButtonGroupM3EShape.round,
}) =>
    context.knobs.object.dropdown<ButtonGroupM3EShape>(
      label: 'shape',
      initialOption: initial,
      options: ButtonGroupM3EShape.values,
      labelBuilder: (ButtonGroupM3EShape v) => v.name,
    );

ButtonGroupM3ESize _knobSize(
  BuildContext context, {
  ButtonGroupM3ESize initial = ButtonGroupM3ESize.md,
}) =>
    context.knobs.object.dropdown<ButtonGroupM3ESize>(
      label: 'size',
      initialOption: initial,
      options: ButtonGroupM3ESize.values,
      labelBuilder: (ButtonGroupM3ESize v) => v.name,
    );

ButtonGroupM3EDensity _knobDensity(
  BuildContext context, {
  ButtonGroupM3EDensity initial = ButtonGroupM3EDensity.regular,
}) =>
    context.knobs.object.dropdown<ButtonGroupM3EDensity>(
      label: 'density',
      initialOption: initial,
      options: ButtonGroupM3EDensity.values,
      labelBuilder: (ButtonGroupM3EDensity v) => v.name,
    );

Axis _knobDirection(BuildContext context, {Axis initial = Axis.horizontal}) =>
    context.knobs.object.dropdown<Axis>(
      label: 'direction',
      initialOption: initial,
      options: const <Axis>[Axis.horizontal, Axis.vertical],
      labelBuilder: (Axis v) => v.name,
    );

WrapAlignment _knobWrapAlignment(
  BuildContext context, {
  String label = 'alignment',
  WrapAlignment initial = WrapAlignment.start,
}) =>
    context.knobs.object.dropdown<WrapAlignment>(
      label: label,
      initialOption: initial,
      options: WrapAlignment.values,
      labelBuilder: (WrapAlignment v) => v.name,
    );

WrapCrossAlignment _knobCrossAlignment(
  BuildContext context, {
  WrapCrossAlignment initial = WrapCrossAlignment.center,
}) =>
    context.knobs.object.dropdown<WrapCrossAlignment>(
      label: 'crossAxisAlignment',
      initialOption: initial,
      options: WrapCrossAlignment.values,
      labelBuilder: (WrapCrossAlignment v) => v.name,
    );

Clip _knobClipBehavior(BuildContext context, {Clip initial = Clip.none}) =>
    context.knobs.object.dropdown<Clip>(
      label: 'clipBehavior',
      initialOption: initial,
      options: Clip.values,
      labelBuilder: (Clip v) => v.name,
    );

@UseCase(name: 'default', type: ButtonGroupM3E)
Widget buildButtonGroupM3EDefaultUseCase(BuildContext context) {
  final ButtonGroupM3EType type = _knobType(context);
  final ButtonGroupM3EShape shape = _knobShape(context);
  final ButtonGroupM3ESize size = _knobSize(context);
  final ButtonGroupM3EDensity density = _knobDensity(context);
  final Axis direction = _knobDirection(context);
  final bool wrap = context.knobs.boolean(label: 'wrap', initialValue: false);
  final bool showDividers = context.knobs.boolean(
    label: 'showDividers (connected only)',
    initialValue: false,
  );
  final bool equalizeWidths = context.knobs.boolean(
    label: 'equalizeWidths',
    initialValue: false,
  );
  final double spacing = context.knobs.double.slider(
    label: 'spacing',
    initialValue: 8,
    min: 0,
    max: 32,
    divisions: 32,
  );
  final double runSpacing = context.knobs.double.slider(
    label: 'runSpacing',
    initialValue: 8,
    min: 0,
    max: 32,
    divisions: 32,
  );
  final Color? dividerColor = context.knobs.colorOrNull(
    label: 'dividerColor',
    initialValue: null,
  );
  final double dividerThickness = context.knobs.double.slider(
    label: 'dividerThickness',
    initialValue: 1,
    min: 0.5,
    max: 2.0,
    divisions: 15,
  );
  final String? semanticLabel = context.knobs.stringOrNull(
    label: 'semanticLabel',
    initialValue: 'Action group',
  );
  final WrapAlignment alignment =
      _knobWrapAlignment(context, label: 'alignment');
  final WrapAlignment runAlignment =
      _knobWrapAlignment(context, label: 'runAlignment');
  final WrapCrossAlignment cross = _knobCrossAlignment(context);
  final Clip clip = _knobClipBehavior(context);

  final String contentMode = context.knobs.object.dropdown<String>(
    label: 'content',
    initialOption: 'with_label',
    options: const <String>['with_label', 'with_icon', 'without_label'],
    labelBuilder: (String v) => v,
  );

  late final List<Widget> children;
  switch (contentMode) {
    case 'with_icon':
      children = _demoButtonsWithIcons(context);
      break;
    default:
      children = _demoButtonsWithLabels(context);
  }

  return Center(
    child: ButtonGroupM3E(
      type: type,
      shape: shape,
      size: size,
      density: density,
      direction: direction,
      wrap: wrap,
      spacing: spacing,
      runSpacing: runSpacing,
      alignment: alignment,
      runAlignment: runAlignment,
      crossAxisAlignment: cross,
      showDividers: showDividers,
      dividerColor: dividerColor,
      dividerThickness: dividerThickness,
      equalizeWidths: equalizeWidths,
      semanticLabel: semanticLabel,
      clipBehavior: clip,
      children: children,
    ),
  );
}

@UseCase(name: 'connected', type: ButtonGroupM3E)
Widget buildButtonGroupM3EConnectedUseCase(BuildContext context) {
  return Center(
    child: ButtonGroupM3E(
      type: ButtonGroupM3EType.connected,
      shape: _knobShape(context),
      size: _knobSize(context),
      density: _knobDensity(context),
      direction: _knobDirection(context),
      equalizeWidths: context.knobs.boolean(
        label: 'equalizeWidths',
        initialValue: false,
      ),
      children: _demoButtonsWithLabels(context),
    ),
  );
}

@UseCase(name: 'vertical', type: ButtonGroupM3E)
Widget buildButtonGroupM3EVerticalUseCase(BuildContext context) {
  return Center(
    child: ButtonGroupM3E(
      direction: Axis.vertical,
      type: _knobType(context),
      shape: _knobShape(context),
      size: _knobSize(context),
      density: _knobDensity(context),
      spacing: context.knobs.double.slider(
        label: 'spacing',
        initialValue: 8,
        min: 0,
        max: 32,
        divisions: 32,
      ),
      children: _demoButtonsWithLabels(context),
    ),
  );
}

@UseCase(name: 'wrapped_many_items', type: ButtonGroupM3E)
Widget buildButtonGroupM3EWrappedManyItemsUseCase(BuildContext context) {
  final int count = context.knobs.int.slider(
    label: 'item count',
    initialValue: 12,
    min: 0,
    max: 40,
    divisions: 40,
  );
  final List<Widget> items = List<Widget>.generate(count, (int i) {
    return OutlinedButton(
      onPressed: () => debugPrint('Pressed: Item #$i'),
      child: Text('Item $i'),
    );
  });

  return Center(
    child: SizedBox(
      width: 360,
      child: ButtonGroupM3E(
        type: _knobType(context),
        shape: _knobShape(context),
        size: _knobSize(context),
        density: _knobDensity(context),
        direction: _knobDirection(context),
        wrap: true,
        spacing: context.knobs.double.slider(
          label: 'spacing',
          initialValue: 8,
          min: 0,
          max: 24,
          divisions: 24,
        ),
        runSpacing: context.knobs.double.slider(
          label: 'runSpacing',
          initialValue: 8,
          min: 0,
          max: 24,
          divisions: 24,
        ),
        alignment: _knobWrapAlignment(context, label: 'alignment'),
        runAlignment: _knobWrapAlignment(context, label: 'runAlignment'),
        crossAxisAlignment: _knobCrossAlignment(context),
        children: items,
      ),
    ),
  );
}

@UseCase(name: 'equalized_long_text', type: ButtonGroupM3E)
Widget buildButtonGroupM3EEqualizedLongTextUseCase(BuildContext context) {
  final List<Widget> children = <Widget>[
    ElevatedButton(
      onPressed: () => debugPrint('Pressed: Very long primary label'),
      child: const Text('Very long primary label'),
    ),
    OutlinedButton(
      onPressed: () => debugPrint('Pressed: Short'),
      child: const Text('Short'),
    ),
    TextButton(
      onPressed: () => debugPrint('Pressed: Mid length'),
      child: const Text('Mid length'),
    ),
  ];

  return Center(
    child: ButtonGroupM3E(
      type: _knobType(context),
      shape: _knobShape(context),
      size: _knobSize(context),
      density: _knobDensity(context),
      equalizeWidths: true,
      children: children,
    ),
  );
}

@UseCase(name: 'empty', type: ButtonGroupM3E)
Widget buildButtonGroupM3EEmptyUseCase(BuildContext context) {
  // Boundary: no children → should layout to zero size.
  return const Center(
    child: ButtonGroupM3E(children: <Widget>[]),
  );
}

@UseCase(name: 'with_icon', type: ButtonGroupM3E)
Widget buildButtonGroupM3EWithIconUseCase(BuildContext context) {
  return Center(
    child: ButtonGroupM3E(
      type: _knobType(context),
      shape: _knobShape(context),
      size: _knobSize(context),
      density: _knobDensity(context),
      direction: _knobDirection(context),
      children: _demoButtonsWithIcons(context),
    ),
  );
}
