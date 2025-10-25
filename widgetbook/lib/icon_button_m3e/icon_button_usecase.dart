import 'package:flutter/material.dart';
import 'package:m3e_collection/m3e_collection.dart';
import 'package:widgetbook/widgetbook.dart';

Widget _buildIconButtonDemo(
  BuildContext context, {
  required IconButtonM3EVariant variant,
}) {
  final size = context.knobs.object.dropdown<IconButtonM3ESize>(
    label: 'size',
    initialOption: IconButtonM3ESize.md,
    options: IconButtonM3ESize.values,
    labelBuilder: (v) => v.name,
  );
  final shape = context.knobs.object.dropdown<IconButtonM3EShapeVariant>(
    label: 'shape',
    initialOption: IconButtonM3EShapeVariant.round,
    options: IconButtonM3EShapeVariant.values,
    labelBuilder: (v) => v.name,
  );
  final width = context.knobs.object.dropdown<IconButtonM3EWidth>(
    label: 'width',
    initialOption: IconButtonM3EWidth.defaultWidth,
    options: IconButtonM3EWidth.values,
    labelBuilder: (v) => v.name,
  );
  final isSelected =
      context.knobs.boolean(label: 'selected', initialValue: false);
  final tooltip =
      context.knobs.string(label: 'tooltip', initialValue: 'Favorite');

  final badgeMode = context.knobs.object.dropdown<String>(
    label: 'badge',
    initialOption: 'none',
    options: const ['none', 'dot', 'count', 'text'],
    labelBuilder: (v) => v,
  );

  Object? badgeValue;
  switch (badgeMode) {
    case 'dot':
      badgeValue = 0; // shows dot per component logic
      break;
    case 'count':
      badgeValue = context.knobs.int.slider(
        label: 'count',
        initialValue: 3,
        min: 0,
        max: 120,
        divisions: 120,
      );
      break;
    case 'text':
      badgeValue =
          context.knobs.string(label: 'badgeText', initialValue: 'NEW');
      break;
    default:
      badgeValue = null;
  }

  return Center(
    child: IconButtonM3E(
      icon: const Icon(Icons.favorite_border),
      selectedIcon: const Icon(Icons.favorite),
      isSelected: isSelected,
      tooltip: tooltip,
      variant: variant,
      size: size,
      shape: shape,
      width: width,
      onPressed: () => print('IconButton pressed: variant=$variant'),
      badgeValue: badgeValue,
    ),
  );
}
