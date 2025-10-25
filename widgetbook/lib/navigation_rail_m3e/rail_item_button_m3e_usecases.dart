import 'package:flutter/material.dart';
import 'package:navigation_rail_m3e/navigation_rail_m3e.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

Widget _buildRailItemButtonDemo(
  BuildContext context, {
  required bool expanded,
}) {
  final isSelected =
      context.knobs.boolean(label: 'isSelected', initialValue: false);
  final label = context.knobs
      .string(label: 'label', initialValue: expanded ? 'Inbox' : 'Inbox');
  final semantic =
      context.knobs.stringOrNull(label: 'semanticLabel', initialValue: 'Inbox');
  final labelBehavior =
      context.knobs.object.dropdown<NavigationRailM3ELabelBehavior>(
    label: 'labelBehavior',
    options: NavigationRailM3ELabelBehavior.values,
    initialOption: NavigationRailM3ELabelBehavior.alwaysShow,
    labelBuilder: (v) => v.name,
  );
  final badge = context.knobs.intOrNull.slider(
    label: 'badgeCount',
    initialValue: null,
    min: 0,
    max: 200,
    divisions: 20,
  );
  final suppressInk =
      context.knobs.boolean(label: 'suppressInk', initialValue: false);
  final useAltIcon =
      context.knobs.boolean(label: 'useAltIcon', initialValue: false);

  final icon = Icon(useAltIcon ? Icons.star : Icons.inbox_outlined);
  final selectedIcon = Icon(useAltIcon ? Icons.star : Icons.inbox);

  return Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: RailItemButtonM3E(
            icon: icon,
            selectedIcon: selectedIcon,
            isSelected: isSelected,
            onPressed: () => print('RailItemButtonM3E pressed'),
            expanded: expanded,
            labelBehavior: labelBehavior,
            label: label,
            semanticLabel: semantic,
            suppressInk: suppressInk,
            badgeCount: badge,
          ),
        ),
      ),
    ),
  );
}

@UseCase(name: 'collapsed', type: RailItemButtonM3E)
Widget buildRailItemButtonM3ECollapsedUseCase(BuildContext context) {
  return _buildRailItemButtonDemo(context, expanded: false);
}

@UseCase(name: 'expanded', type: RailItemButtonM3E)
Widget buildRailItemButtonM3EExpandedUseCase(BuildContext context) {
  return _buildRailItemButtonDemo(context, expanded: true);
}
