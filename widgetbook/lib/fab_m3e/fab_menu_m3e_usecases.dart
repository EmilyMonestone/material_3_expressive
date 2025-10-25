

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:fab_m3e/fab_m3e.dart';

FabMenuM3E _buildMenu(
  BuildContext context, {
  required List<FabMenuItem> items,
  FabMenuDirection direction = FabMenuDirection.up,
  bool overlay = true,
  double? spacing,
  Alignment alignment = Alignment.bottomRight,
  bool popOnItemTap = true,
  Object? heroTag,
  bool initiallyOpen = false,
}) {
  final selectedDirection = context.knobs.object.dropdown<FabMenuDirection>(
    label: 'direction',
    initialOption: direction,
    options: FabMenuDirection.values,
    labelBuilder: (v) => v.name,
  );
  final showOverlay = context.knobs.boolean(label: 'overlay', initialValue: overlay);
  final gap = context.knobs.doubleOrNull.slider(
    label: 'spacing',
    initialValue: spacing,
    min: 0,
    max: 48,
    divisions: 24,
  );
  final alignOpt = context.knobs.object.dropdown<String>(
    label: 'alignment',
    initialOption: 'bottomRight',
    options: const ['bottomRight', 'bottomLeft', 'topRight', 'topLeft', 'center'],
    labelBuilder: (v) => v,
  );
  final Alignment align = switch (alignOpt) {
    'bottomLeft' => Alignment.bottomLeft,
    'topRight' => Alignment.topRight,
    'topLeft' => Alignment.topLeft,
    'center' => Alignment.center,
    _ => Alignment.bottomRight,
  };
  final popOnTap = context.knobs.boolean(label: 'popOnItemTap', initialValue: popOnItemTap);
  final useHero = context.knobs.boolean(label: 'wrap in Hero', initialValue: heroTag != null);

  final controller = FabMenuController();
  if (initiallyOpen) controller.open();

  return FabMenuM3E(
    primaryFab: FabM3E(
      icon: AnimatedRotation(
        duration: const Duration(milliseconds: 200),
        turns: controller.isOpen ? 0.125 : 0,
        child: const Icon(Icons.add),
      ),
      onPressed: controller.toggle,
      heroTag: useHero ? (heroTag ?? 'fab-menu-hero') : null,
    ),
    items: items,
    direction: selectedDirection,
    overlay: showOverlay,
    spacing: gap,
    controller: controller,
    alignment: align,
    popOnItemTap: popOnTap,
  );
}

List<FabMenuItem> _makeItems(BuildContext context, int count) {
  return List.generate(count, (i) {
    return FabMenuItem(
      icon: Icon([Icons.share, Icons.edit, Icons.delete, Icons.copy][i % 4]),
      label: Text('Action ${i + 1}'),
      onPressed: () => print('Menu item ${i + 1} pressed'),
      semanticLabel: 'Menu action ${i + 1}',
    );
  });
}

@widgetbook.UseCase(name: 'default', type: FabMenuM3E)
Widget buildFabMenuM3EUseCase(BuildContext context) {
  return Stack(
    children: [
      Positioned.fill(
        child: Container(),
      ),
      _buildMenu(
        context,
        items: _makeItems(context, 3),
        direction: FabMenuDirection.up,
        overlay: true,
      ),
    ],
  );
}

@widgetbook.UseCase(name: 'initially_open', type: FabMenuM3E)
Widget buildFabMenuM3EInitiallyOpenUseCase(BuildContext context) {
  return _buildMenu(
    context,
    items: _makeItems(context, 3),
    direction: FabMenuDirection.up,
    overlay: true,
    initiallyOpen: true,
  );
}

@widgetbook.UseCase(name: 'direction_down', type: FabMenuM3E)
Widget buildFabMenuM3EDirectionDownUseCase(BuildContext context) {
  return _buildMenu(context, items: _makeItems(context, 3), direction: FabMenuDirection.down);
}

@widgetbook.UseCase(name: 'direction_left', type: FabMenuM3E)
Widget buildFabMenuM3EDirectionLeftUseCase(BuildContext context) {
  return _buildMenu(context, items: _makeItems(context, 3), direction: FabMenuDirection.left);
}

@widgetbook.UseCase(name: 'direction_right', type: FabMenuM3E)
Widget buildFabMenuM3EDirectionRightUseCase(BuildContext context) {
  return _buildMenu(context, items: _makeItems(context, 3), direction: FabMenuDirection.right);
}

@widgetbook.UseCase(name: 'overlay_off', type: FabMenuM3E)
Widget buildFabMenuM3EOverlayOffUseCase(BuildContext context) {
  return _buildMenu(context, items: _makeItems(context, 3), overlay: false);
}

@widgetbook.UseCase(name: 'spacing_tight', type: FabMenuM3E)
Widget buildFabMenuM3ESpacingTightUseCase(BuildContext context) {
  return _buildMenu(context, items: _makeItems(context, 3), spacing: 4);
}

@widgetbook.UseCase(name: 'many_items', type: FabMenuM3E)
Widget buildFabMenuM3EManyItemsUseCase(BuildContext context) {
  return _buildMenu(context, items: _makeItems(context, 8));
}

@widgetbook.UseCase(name: 'empty_items', type: FabMenuM3E)
Widget buildFabMenuM3EEmptyItemsUseCase(BuildContext context) {
  return _buildMenu(context, items: const []);
}
