import 'package:flutter/material.dart';
import 'package:toolbar_m3e/toolbar_m3e.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'default', type: ToolbarIconButtonM3E)
Widget buildToolbarIconButtonM3EDefaultUseCase(BuildContext context) {
  final enabled = context.knobs.boolean(label: 'enabled', initialValue: true);
  final iconSize = context.knobs.double.slider(
    label: 'iconSize',
    initialValue: 24,
    min: 12,
    max: 48,
    divisions: 12,
  );
  final color = context.knobs.colorOrNull(label: 'color', initialValue: null);

  return Center(
    child: ToolbarIconButtonM3E(
      action: ToolbarActionM3E(
        icon: Icons.search,
        tooltip: 'Search',
        label: 'Search',
        enabled: enabled,
        onPressed: () => print('ToolbarIconButtonM3E -> Search pressed'),
      ),
      iconSize: iconSize,
      color: color,
    ),
  );
}

@UseCase(name: 'destructive', type: ToolbarIconButtonM3E)
Widget buildToolbarIconButtonM3EDestructiveUseCase(BuildContext context) {
  final enabled = context.knobs.boolean(label: 'enabled', initialValue: true);
  return Center(
    child: ToolbarIconButtonM3E(
      action: ToolbarActionM3E(
        icon: Icons.delete,
        tooltip: 'Delete',
        label: 'Delete',
        isDestructive: true,
        enabled: enabled,
        onPressed: () => print('ToolbarIconButtonM3E -> Delete pressed'),
      ),
      color: Theme.of(context).colorScheme.error,
    ),
  );
}

@UseCase(name: 'custom_color_and_size', type: ToolbarIconButtonM3E)
Widget buildToolbarIconButtonM3ECustomColorAndSizeUseCase(
    BuildContext context) {
  final color = context.knobs.color(label: 'color', initialValue: Colors.teal);
  final iconSize = context.knobs.double.slider(
    label: 'iconSize',
    initialValue: 32,
    min: 16,
    max: 56,
  );
  return Center(
    child: ToolbarIconButtonM3E(
      action: ToolbarActionM3E(
        icon: Icons.share,
        tooltip: 'Share',
        label: 'Share',
        onPressed: () => print('ToolbarIconButtonM3E -> Share pressed'),
      ),
      color: color,
      iconSize: iconSize,
    ),
  );
}
