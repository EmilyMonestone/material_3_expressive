// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:icon_button_m3e/icon_button_m3e.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

// GENERATED USE CASES for IconButtonM3E per plan/guide.md
// Notes:
// - Themes are provided globally by the Widgetbook app.
// - Use knobs for critical and visual params; callbacks print helpful messages.
// - Complex objects get meaningful defaults with TODOs.

@UseCase(name: 'default', type: IconButtonM3E)
Widget buildIconButtonM3EDefaultUseCase(BuildContext context) {
  final bool isToggle = context.knobs.boolean(
    label: 'is toggle (provides selected state)',
    initialValue: true,
  );
  final bool selected = isToggle
      ? context.knobs.boolean(label: 'isSelected', initialValue: false)
      : false;
  final IconButtonM3EVariant variant = context.knobs.object.dropdown(
    label: 'variant',
    initialOption: IconButtonM3EVariant.standard,
    options: IconButtonM3EVariant.values,
    labelBuilder: (v) => v.name,
  );
  final IconButtonM3ESize size = context.knobs.object.dropdown(
    label: 'size',
    initialOption: IconButtonM3ESize.sm,
    options: IconButtonM3ESize.values,
    labelBuilder: (v) => v.name,
  );
  final IconButtonM3EShapeVariant shape = context.knobs.object.dropdown(
    label: 'shape',
    initialOption: IconButtonM3EShapeVariant.round,
    options: IconButtonM3EShapeVariant.values,
    labelBuilder: (v) => v.name,
  );
  final IconButtonM3EWidth width = context.knobs.object.dropdown(
    label: 'width',
    initialOption: IconButtonM3EWidth.defaultWidth,
    options: IconButtonM3EWidth.values,
    labelBuilder: (v) => v.name,
  );
  final String? tooltip = context.knobs.stringOrNull(
    label: 'tooltip',
    initialValue: 'Favorite',
  );
  final bool enableFeedback = context.knobs.boolean(
    label: 'enableFeedback',
    initialValue: true,
  );

  final bool showBadge = context.knobs.boolean(
    label: 'show badge',
    initialValue: false,
  );
  final bool badgeIsNumber = context.knobs.boolean(
    label: 'badge is number (off = string)',
    initialValue: true,
  );
  final Object? badgeValue = showBadge
      ? (badgeIsNumber
          ? context.knobs.int.slider(
              label: 'badge count',
              initialValue: 1,
              min: 0,
              max: 999,
              divisions: 30,
            )
          : context.knobs.string(label: 'badge label', initialValue: 'NEW'))
      : null;

  return Center(
    child: IconButtonM3E(
      icon: const Icon(Icons.favorite_border),
      selectedIcon: const Icon(Icons.favorite),
      onPressed: () => debugPrint('IconButtonM3E pressed'),
      isSelected: isToggle ? selected : null,
      tooltip: tooltip,
      enableFeedback: enableFeedback,
      variant: variant,
      size: size,
      shape: shape,
      width: width,
      badgeValue: badgeValue,
    ),
  );
}

@UseCase(name: 'disabled', type: IconButtonM3E)
Widget buildIconButtonM3EDisabledUseCase(BuildContext context) {
  final IconButtonM3EVariant variant = context.knobs.object.dropdown(
    label: 'variant',
    initialOption: IconButtonM3EVariant.standard,
    options: IconButtonM3EVariant.values,
    labelBuilder: (v) => v.name,
  );
  final IconButtonM3ESize size = context.knobs.object.dropdown(
    label: 'size',
    initialOption: IconButtonM3ESize.sm,
    options: IconButtonM3ESize.values,
    labelBuilder: (v) => v.name,
  );
  final IconButtonM3EShapeVariant shape = context.knobs.object.dropdown(
    label: 'shape',
    initialOption: IconButtonM3EShapeVariant.round,
    options: IconButtonM3EShapeVariant.values,
    labelBuilder: (v) => v.name,
  );
  final IconButtonM3EWidth width = context.knobs.object.dropdown(
    label: 'width',
    initialOption: IconButtonM3EWidth.defaultWidth,
    options: IconButtonM3EWidth.values,
    labelBuilder: (v) => v.name,
  );

  return Center(
    child: IconButtonM3E(
      icon: const Icon(Icons.volume_up),
      selectedIcon: const Icon(Icons.volume_off),
      onPressed: null, // disabled state
      variant: variant,
      size: size,
      shape: shape,
      width: width,
      tooltip: 'Disabled button',
    ),
  );
}

@UseCase(name: 'standard', type: IconButtonM3E)
Widget buildIconButtonM3EStandardUseCase(BuildContext context) {
  return _buildStyleDemo(context, IconButtonM3EVariant.standard);
}

@UseCase(name: 'filled', type: IconButtonM3E)
Widget buildIconButtonM3EFilledUseCase(BuildContext context) {
  return _buildStyleDemo(context, IconButtonM3EVariant.filled);
}

@UseCase(name: 'tonal', type: IconButtonM3E)
Widget buildIconButtonM3ETonalUseCase(BuildContext context) {
  return _buildStyleDemo(context, IconButtonM3EVariant.tonal);
}

@UseCase(name: 'outlined', type: IconButtonM3E)
Widget buildIconButtonM3EOutlinedUseCase(BuildContext context) {
  return _buildStyleDemo(context, IconButtonM3EVariant.outlined);
}

Widget _buildStyleDemo(BuildContext context, IconButtonM3EVariant variant) {
  final IconButtonM3ESize size = context.knobs.object.dropdown(
    label: 'size',
    initialOption: IconButtonM3ESize.sm,
    options: IconButtonM3ESize.values,
    labelBuilder: (v) => v.name,
  );
  final IconButtonM3EShapeVariant shape = context.knobs.object.dropdown(
    label: 'shape',
    initialOption: IconButtonM3EShapeVariant.round,
    options: IconButtonM3EShapeVariant.values,
    labelBuilder: (v) => v.name,
  );
  final IconButtonM3EWidth width = context.knobs.object.dropdown(
    label: 'width',
    initialOption: IconButtonM3EWidth.defaultWidth,
    options: IconButtonM3EWidth.values,
    labelBuilder: (v) => v.name,
  );
  final bool isSelected = context.knobs.boolean(
    label: 'isSelected (toggle) ',
    initialValue: false,
  );

  final String iconChoice = context.knobs.object.dropdown(
    label: 'icon',
    initialOption: 'favorite',
    options: const ['favorite', 'alarm', 'share', 'settings'],
    labelBuilder: (s) => s,
  );

  IconData data;
  switch (iconChoice) {
    case 'alarm':
      data = Icons.alarm;
      break;
    case 'share':
      data = Icons.share;
      break;
    case 'settings':
      data = Icons.settings;
      break;
    default:
      data = isSelected ? Icons.favorite : Icons.favorite_border;
  }

  return Center(
    child: IconButtonM3E(
      icon: Icon(data),
      selectedIcon: const Icon(Icons.check),
      isSelected: isSelected,
      onPressed: () => debugPrint('Pressed style=$variant size=$size'),
      variant: variant,
      size: size,
      shape: shape,
      width: width,
      tooltip: 'Icon: $iconChoice',
    ),
  );
}

@UseCase(name: 'sizes', type: IconButtonM3E)
Widget buildIconButtonM3ESizesUseCase(BuildContext context) {
  final IconButtonM3EVariant variant = context.knobs.object.dropdown(
    label: 'variant',
    initialOption: IconButtonM3EVariant.standard,
    options: IconButtonM3EVariant.values,
    labelBuilder: (v) => v.name,
  );
  final IconButtonM3EShapeVariant shape = context.knobs.object.dropdown(
    label: 'shape',
    initialOption: IconButtonM3EShapeVariant.round,
    options: IconButtonM3EShapeVariant.values,
    labelBuilder: (v) => v.name,
  );
  final IconButtonM3EWidth width = context.knobs.object.dropdown(
    label: 'width',
    initialOption: IconButtonM3EWidth.defaultWidth,
    options: IconButtonM3EWidth.values,
    labelBuilder: (v) => v.name,
  );

  return Wrap(
    spacing: 16,
    runSpacing: 16,
    children: IconButtonM3ESize.values.map((s) {
      return IconButtonM3E(
        icon: const Icon(Icons.star_border),
        selectedIcon: const Icon(Icons.star),
        onPressed: () => debugPrint('Size $s pressed'),
        variant: variant,
        size: s,
        shape: shape,
        width: width,
        tooltip: 'size: ${s.name}',
      );
    }).toList(),
  );
}

@UseCase(name: 'with_badge', type: IconButtonM3E)
Widget buildIconButtonM3EWithBadgeUseCase(BuildContext context) {
  final int count = context.knobs.int.slider(
    label: 'count',
    initialValue: 1,
    min: 0,
    max: 999,
    divisions: 20,
  );
  final IconButtonM3EVariant variant = context.knobs.object.dropdown(
    label: 'variant',
    initialOption: IconButtonM3EVariant.standard,
    options: IconButtonM3EVariant.values,
    labelBuilder: (v) => v.name,
  );
  final IconButtonM3ESize size = context.knobs.object.dropdown(
    label: 'size',
    initialOption: IconButtonM3ESize.sm,
    options: IconButtonM3ESize.values,
    labelBuilder: (v) => v.name,
  );

  return Center(
    child: IconButtonM3E(
      icon: const Icon(Icons.mail_outline),
      selectedIcon: const Icon(Icons.mail),
      onPressed: () => debugPrint('Mail pressed'),
      variant: variant,
      size: size,
      badgeValue: count,
      tooltip: 'Inbox',
    ),
  );
}

@UseCase(name: 'with_badge_string', type: IconButtonM3E)
Widget buildIconButtonM3EWithBadgeStringUseCase(BuildContext context) {
  final String label = context.knobs.string(
    label: 'badge label',
    initialValue: 'NEW',
  );
  final IconButtonM3EVariant variant = context.knobs.object.dropdown(
    label: 'variant',
    initialOption: IconButtonM3EVariant.filled,
    options: IconButtonM3EVariant.values,
    labelBuilder: (v) => v.name,
  );

  return Center(
    child: IconButtonM3E(
      icon: const Icon(Icons.shopping_bag_outlined),
      selectedIcon: const Icon(Icons.shopping_bag),
      onPressed: () => debugPrint('Bag pressed'),
      variant: variant,
      badgeValue: label,
      tooltip: 'Cart',
    ),
  );
}

@UseCase(name: 'badge_edge_cases', type: IconButtonM3E)
Widget buildIconButtonM3EBadgeEdgeCasesUseCase(BuildContext context) {
  return Wrap(
    spacing: 16,
    runSpacing: 16,
    children: const [
      IconButtonM3E(
        icon: Icon(Icons.notifications_none),
        badgeValue: 0, // dot badge
        tooltip: '0 = dot',
      ),
      IconButtonM3E(
        icon: Icon(Icons.notifications_none),
        badgeValue: 1,
        tooltip: '1',
      ),
      IconButtonM3E(
        icon: Icon(Icons.notifications_none),
        badgeValue: 99,
        tooltip: '99',
      ),
      IconButtonM3E(
        icon: Icon(Icons.notifications_none),
        badgeValue: 999999, // clamped
        tooltip: 'big number',
      ),
    ],
  );
}

@UseCase(name: 'with_tooltip', type: IconButtonM3E)
Widget buildIconButtonM3EWithTooltipUseCase(BuildContext context) {
  final String text = context.knobs.string(
    label: 'tooltip',
    initialValue: 'Open menu',
  );
  final bool long = context.knobs.boolean(
    label: 'use long tooltip',
    initialValue: false,
  );
  final String value = long
      ? 'This is a very long tooltip that demonstrates how the control behaves with extended descriptive text. '
          'Try hovering or long-pressing to read the entire message.'
      : text;
  return Center(
    child: IconButtonM3E(
      icon: const Icon(Icons.more_vert),
      onPressed: () => debugPrint('More pressed'),
      tooltip: value,
    ),
  );
}

@UseCase(name: 'shapes', type: IconButtonM3E)
Widget buildIconButtonM3EShapesUseCase(BuildContext context) {
  final IconButtonM3EVariant variant = context.knobs.object.dropdown(
    label: 'variant',
    initialOption: IconButtonM3EVariant.standard,
    options: IconButtonM3EVariant.values,
    labelBuilder: (v) => v.name,
  );
  final IconButtonM3ESize size = context.knobs.object.dropdown(
    label: 'size',
    initialOption: IconButtonM3ESize.sm,
    options: IconButtonM3ESize.values,
    labelBuilder: (v) => v.name,
  );

  return Wrap(
    spacing: 16,
    children: [
      IconButtonM3E(
        icon: const Icon(Icons.crop_5_4),
        onPressed: () {},
        variant: variant,
        size: size,
        shape: IconButtonM3EShapeVariant.round,
        tooltip: 'round',
      ),
      IconButtonM3E(
        icon: const Icon(Icons.crop_square),
        onPressed: () {},
        variant: variant,
        size: size,
        shape: IconButtonM3EShapeVariant.square,
        tooltip: 'square',
      ),
    ],
  );
}

@UseCase(name: 'widths', type: IconButtonM3E)
Widget buildIconButtonM3EWidthsUseCase(BuildContext context) {
  final IconButtonM3EVariant variant = context.knobs.object.dropdown(
    label: 'variant',
    initialOption: IconButtonM3EVariant.standard,
    options: IconButtonM3EVariant.values,
    labelBuilder: (v) => v.name,
  );
  final IconButtonM3ESize size = context.knobs.object.dropdown(
    label: 'size',
    initialOption: IconButtonM3ESize.sm,
    options: IconButtonM3ESize.values,
    labelBuilder: (v) => v.name,
  );

  return Wrap(
    spacing: 16,
    children: const [
      IconButtonM3E(
        icon: Icon(Icons.aspect_ratio),
        onPressed: null,
        width: IconButtonM3EWidth.narrow,
        tooltip: 'narrow (disabled) ',
      ),
      IconButtonM3E(
        icon: Icon(Icons.aspect_ratio),
        onPressed: null,
        width: IconButtonM3EWidth.defaultWidth,
        tooltip: 'default (disabled)',
      ),
      IconButtonM3E(
        icon: Icon(Icons.aspect_ratio),
        onPressed: null,
        width: IconButtonM3EWidth.wide,
        tooltip: 'wide (disabled)',
      ),
    ],
  );
}

@UseCase(name: 'selected', type: IconButtonM3E)
Widget buildIconButtonM3ESelectedUseCase(BuildContext context) {
  final IconButtonM3EVariant variant = context.knobs.object.dropdown(
    label: 'variant',
    initialOption: IconButtonM3EVariant.standard,
    options: IconButtonM3EVariant.values,
    labelBuilder: (v) => v.name,
  );
  final IconButtonM3ESize size = context.knobs.object.dropdown(
    label: 'size',
    initialOption: IconButtonM3ESize.sm,
    options: IconButtonM3ESize.values,
    labelBuilder: (v) => v.name,
  );

  return Center(
    child: IconButtonM3E(
      icon: const Icon(Icons.radio_button_unchecked),
      selectedIcon: const Icon(Icons.radio_button_checked),
      isSelected: true,
      onPressed: () => debugPrint('Selected toggled'),
      variant: variant,
      size: size,
      tooltip: 'Selected = true',
    ),
  );
}

@UseCase(name: 'focused', type: IconButtonM3E)
Widget buildIconButtonM3EFocusedUseCase(BuildContext context) {
  final IconButtonM3EVariant variant = context.knobs.object.dropdown(
    label: 'variant',
    initialOption: IconButtonM3EVariant.standard,
    options: IconButtonM3EVariant.values,
    labelBuilder: (v) => v.name,
  );
  final IconButtonM3ESize size = context.knobs.object.dropdown(
    label: 'size',
    initialOption: IconButtonM3ESize.sm,
    options: IconButtonM3ESize.values,
    labelBuilder: (v) => v.name,
  );

  return Center(
    child: Focus(
      autofocus: true,
      child: IconButtonM3E(
        icon: const Icon(Icons.center_focus_strong),
        onPressed: () => debugPrint('Focused pressed'),
        variant: variant,
        size: size,
        tooltip: 'Autofocused control',
      ),
    ),
  );
}

@UseCase(name: 'error_badge_type', type: IconButtonM3E)
Widget buildIconButtonM3EErrorBadgeTypeUseCase(BuildContext context) {
  // This intentionally passes an unsupported type to badgeValue to demonstrate
  // assertion behavior in debug mode. In release/profile, this simply omits the badge.
  // TODO: Consider exposing a strongly-typed API for badges to avoid runtime asserts.
  final Object invalid = const [1, 2, 3];
  return Center(
    child: IconButtonM3E(
      icon: const Icon(Icons.error_outline),
      onPressed: () => debugPrint('Pressed error_badge_type case'),
      badgeValue: invalid, // will assert in debug
      tooltip: 'Invalid badge value (List)',
    ),
  );
}
