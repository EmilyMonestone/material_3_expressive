import 'package:button_m3e/button_m3e.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

// GENERATED USE CASES for ButtonM3E per plan/guide.md
// Notes:
// - Themes are provided globally by the Widgetbook app.
// - Use knobs for critical and visual params; callbacks print helpful messages.
// - Complex objects get meaningful defaults with TODOs.

Widget _buildDemo(
  BuildContext context, {
  required ButtonM3EStyle style,
  bool? forceEnabled,
  bool forceFocused = false,
  bool? forceToggleable,
  bool? forceSelected,
  bool forceEmptyLabel = false,
  bool forceLongText = false,
}) {
  // Visual/critical knobs
  final ButtonM3ESize size = context.knobs.object.dropdown(
    label: 'size',
    initialOption: ButtonM3ESize.md,
    options: ButtonM3ESize.values,
    labelBuilder: (v) => v.name,
  );
  final ButtonM3EShape shape = context.knobs.object.dropdown(
    label: 'shape',
    initialOption: ButtonM3EShape.round,
    options: ButtonM3EShape.values,
    labelBuilder: (v) => v.name,
  );

  final bool enabled = forceEnabled ??
      context.knobs.boolean(label: 'enabled', initialValue: true);
  final bool toggleable = forceToggleable ??
      context.knobs.boolean(label: 'toggleable', initialValue: false);
  final bool selected = forceSelected ??
      context.knobs.boolean(label: 'selected', initialValue: false);

  final bool withIcon =
      context.knobs.boolean(label: 'with_icon', initialValue: false);
  final String iconChoice = context.knobs.object.dropdown(
    label: 'icon',
    initialOption: 'favorite',
    options: const ['favorite', 'add', 'download', 'none'],
    labelBuilder: (v) => v,
  );

  // Content knobs
  String labelText;
  if (forceEmptyLabel) {
    labelText = '';
  } else if (forceLongText) {
    labelText = context.knobs.string(
      label: 'label (long)',
      initialValue:
          'This is a very long label to test truncation and layout behavior',
    );
  } else {
    labelText = context.knobs.string(label: 'label', initialValue: 'Button');
  }

  // Misc
  final bool smallPaddingDeprecated24 = context.knobs.boolean(
    label: 'smallPaddingDeprecated24',
    initialValue: false,
  );

  // States controller for focused/selected demos
  final statesController = WidgetStatesController();
  if (forceFocused) {
    statesController.update(WidgetState.focused, true);
  }
  if (selected && !toggleable) {
    statesController.update(WidgetState.selected, true);
  }

  // Compute icon based on knobs
  Widget? icon;
  if (withIcon && iconChoice != 'none') {
    switch (iconChoice) {
      case 'favorite':
        icon = const Icon(Icons.favorite);
        break;
      case 'add':
        icon = const Icon(Icons.add);
        break;
      case 'download':
        icon = const Icon(Icons.download);
        break;
      default:
        icon = null;
    }
  }

  return Center(
    child: ButtonM3E(
      style: style,
      size: size,
      shape: shape,
      enabled: enabled,
      toggleable: toggleable,
      selected: selected,
      onSelectedChange: toggleable
          ? (val) => debugPrint('ButtonM3E onSelectedChange: newValue=$val')
          : null,
      onPressed: () => debugPrint(
          'ButtonM3E onPressed: style=${style.name}, size=${size.name}, shape=${shape.name}'),
      label: Text(labelText),
      icon: icon,
      smallPaddingDeprecated24: smallPaddingDeprecated24,
      statesController: statesController,
    ),
  );
}

@UseCase(name: 'default', type: ButtonM3E)
Widget buildButtonM3EUseCase(BuildContext context) {
  // Default uses filled style; other params adjustable with knobs
  return _buildDemo(context, style: ButtonM3EStyle.filled);
}

@UseCase(name: 'filled', type: ButtonM3E)
Widget buildButtonM3EFilledUseCase(BuildContext context) {
  return _buildDemo(context, style: ButtonM3EStyle.filled);
}

@UseCase(name: 'tonal', type: ButtonM3E)
Widget buildButtonM3ETonalUseCase(BuildContext context) {
  return _buildDemo(context, style: ButtonM3EStyle.tonal);
}

@UseCase(name: 'elevated', type: ButtonM3E)
Widget buildButtonM3EElevatedUseCase(BuildContext context) {
  return _buildDemo(context, style: ButtonM3EStyle.elevated);
}

@UseCase(name: 'outlined', type: ButtonM3E)
Widget buildButtonM3EOutlinedUseCase(BuildContext context) {
  return _buildDemo(context, style: ButtonM3EStyle.outlined);
}

@UseCase(name: 'text', type: ButtonM3E)
Widget buildButtonM3ETextUseCase(BuildContext context) {
  return _buildDemo(context, style: ButtonM3EStyle.text);
}

@UseCase(name: 'disabled', type: ButtonM3E)
Widget buildButtonM3EDisabledUseCase(BuildContext context) {
  // Force disabled regardless of knob default
  return _buildDemo(context, style: ButtonM3EStyle.filled, forceEnabled: false);
}

@UseCase(name: 'focused', type: ButtonM3E)
Widget buildButtonM3EFocusedUseCase(BuildContext context) {
  // Preview focused visuals using WidgetStatesController
  return _buildDemo(context, style: ButtonM3EStyle.filled, forceFocused: true);
}

@UseCase(name: 'selected', type: ButtonM3E)
Widget buildButtonM3ESelectedUseCase(BuildContext context) {
  // Force toggleable + selected for selection visuals
  return _buildDemo(
    context,
    style: ButtonM3EStyle.filled,
    forceToggleable: true,
    forceSelected: true,
  );
}

@UseCase(name: 'with_icon', type: ButtonM3E)
Widget buildButtonM3EWithIconUseCase(BuildContext context) {
  // Use knobs to enable icon
  return _buildDemo(context, style: ButtonM3EStyle.filled);
}

@UseCase(name: 'long_text', type: ButtonM3E)
Widget buildButtonM3ELongTextUseCase(BuildContext context) {
  return _buildDemo(
    context,
    style: ButtonM3EStyle.filled,
    forceLongText: true,
  );
}

@UseCase(name: 'empty_label', type: ButtonM3E)
Widget buildButtonM3EEmptyLabelUseCase(BuildContext context) {
  // Boundary case: empty label when icon is present or not
  return _buildDemo(
    context,
    style: ButtonM3EStyle.filled,
    forceEmptyLabel: true,
  );
}

@UseCase(name: 'sizes', type: ButtonM3E)
Widget buildButtonM3ESizesUseCase(BuildContext context) {
  final ButtonM3EStyle style = context.knobs.object.dropdown(
    label: 'style',
    initialOption: ButtonM3EStyle.filled,
    options: ButtonM3EStyle.values,
    labelBuilder: (v) => v.name,
  );
  final ButtonM3EShape shape = context.knobs.object.dropdown(
    label: 'shape',
    initialOption: ButtonM3EShape.round,
    options: ButtonM3EShape.values,
    labelBuilder: (v) => v.name,
  );
  final bool withIcon =
      context.knobs.boolean(label: 'with_icon', initialValue: false);

  return Wrap(
    spacing: 16,
    runSpacing: 16,
    children: ButtonM3ESize.values.map((s) {
      return ButtonM3E(
        style: style,
        size: s,
        shape: shape,
        onPressed: () => debugPrint('Pressed size: ${s.name}'),
        icon: withIcon ? const Icon(Icons.check) : null,
        label: Text('Size: ${s.name}'),
      );
    }).toList(),
  );
}
