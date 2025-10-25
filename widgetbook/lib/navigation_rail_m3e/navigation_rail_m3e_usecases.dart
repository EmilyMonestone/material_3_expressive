import 'package:flutter/material.dart';
import 'package:navigation_rail_m3e/navigation_rail_m3e.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

List<NavigationRailM3ESection> _buildSections(
  BuildContext context, {
  required int sectionCount,
  required int itemsPerSection,
  required bool withBadges,
  required bool useShortItems,
}) {
  final icons = <IconData>[
    Icons.inbox_outlined,
    Icons.send_outlined,
    Icons.star_outline,
    Icons.archive_outlined,
    Icons.delete_outline,
    Icons.settings_outlined,
  ];

  return List.generate(sectionCount, (s) {
    final destinations = List.generate(itemsPerSection, (i) {
      final idx = (s * itemsPerSection + i) % icons.length;
      return NavigationRailM3EDestination(
        icon: Icon(icons[idx]),
        selectedIcon: Icon(
            icons[idx].codePoint == Icons.inbox_outlined.codePoint
                ? Icons.inbox
                : icons[idx]),
        label: 'Item ${s + 1}.${i + 1}',
        semanticLabel: 'Item ${s + 1}.${i + 1}',
        badgeCount: withBadges
            ? ((i % 3 == 0)
                ? 0
                : (i % 4 == 0)
                    ? 1001
                    : (i + 1) * (s + 1))
            : null,
        short: useShortItems && (i % 2 == 0),
      );
    });
    return NavigationRailM3ESection(
      header: Text('Section ${s + 1}'),
      destinations: destinations,
    );
  });
}

Widget _buildRailDemo(
  BuildContext context, {
  NavigationRailM3EType? forcedType,
  NavigationRailM3EModality? forcedModality,
}) {
  // Content knobs
  final sectionsCount = context.knobs.int.slider(
    label: 'sections',
    initialValue: 2,
    min: 1,
    max: 3,
  );
  final itemsPerSection = context.knobs.int.slider(
    label: 'items per section',
    initialValue: 3,
    min: 1,
    max: 6,
  );
  final withBadges =
      context.knobs.boolean(label: 'with badges', initialValue: true);
  final useShortItems =
      context.knobs.boolean(label: 'use short items', initialValue: false);

  final sections = _buildSections(
    context,
    sectionCount: sectionsCount,
    itemsPerSection: itemsPerSection,
    withBadges: withBadges,
    useShortItems: useShortItems,
  );
  final totalItems =
      sections.fold<int>(0, (sum, s) => sum + s.destinations.length);

  // Behavior knobs
  final type = forcedType ??
      context.knobs.object.dropdown<NavigationRailM3EType>(
        label: 'type',
        options: NavigationRailM3EType.values,
        initialOption: NavigationRailM3EType.expanded,
        labelBuilder: (v) => v.name,
      );
  final modality = forcedModality ??
      context.knobs.object.dropdown<NavigationRailM3EModality>(
        label: 'modality',
        options: NavigationRailM3EModality.values,
        initialOption: NavigationRailM3EModality.standard,
        labelBuilder: (v) => v.name,
      );
  final labelBehavior =
      context.knobs.object.dropdown<NavigationRailM3ELabelBehavior>(
    label: 'labelBehavior',
    options: NavigationRailM3ELabelBehavior.values,
    initialOption: NavigationRailM3ELabelBehavior.alwaysShow,
    labelBuilder: (v) => v.name,
  );
  final hideWhenCollapsed = context.knobs.boolean(
    label: 'hideWhenCollapsed',
    initialValue: false,
  );
  final scrollable = context.knobs.boolean(
    label: 'scrollable',
    initialValue: true,
  );
  final expandedWidth = context.knobs.double.slider(
    label: 'expandedWidth',
    initialValue: 280,
    min: 220,
    max: 360,
    divisions: 14,
  );
  final selectedIndex = context.knobs.int.slider(
    label: 'selectedIndex',
    initialValue: 0,
    min: 0,
    max: (totalItems == 0 ? 0 : totalItems - 1),
  );

  // Slots knobs
  final withFab = context.knobs.boolean(label: 'with FAB', initialValue: true);
  final withTrailing =
      context.knobs.boolean(label: 'with trailing', initialValue: false);
  final trailingAtBottom =
      context.knobs.boolean(label: 'trailingAtBottom', initialValue: true);

  final fab = withFab
      ? NavigationRailM3EFabSlot(
          icon: const Icon(Icons.add),
          label: 'Create',
          onPressed: () => print('Rail FAB pressed'),
          tooltip: 'Create',
        )
      : null;

  final trailing = withTrailing
      ? IconButton(
          tooltip: 'Settings',
          onPressed: () => print('Trailing pressed'),
          icon: const Icon(Icons.settings_outlined),
        )
      : null;

  return Row(
    children: [
      NavigationRailM3E(
        type: type,
        modality: modality,
        sections: sections,
        selectedIndex: selectedIndex.clamp(0, (totalItems - 1).clamp(0, 9999)),
        onDestinationSelected: (i) => print('Selected index: $i'),
        fab: fab,
        hideWhenCollapsed: hideWhenCollapsed,
        expandedWidth: expandedWidth,
        onDismissModal: () => print('Dismiss modal'),
        onTypeChanged: (t) => print('Type changed -> ${t.name}'),
        labelBehavior: labelBehavior,
        scrollable: scrollable,
        trailing: trailing,
        trailingAtBottom: trailingAtBottom,
      ),
      // Fake content area to the right
      Expanded(
        child: Container(
          height: double.infinity,
          color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.2),
          alignment: Alignment.center,
          child: const Text('Content area'),
        ),
      )
    ],
  );
}

@UseCase(name: 'default', type: NavigationRailM3E)
Widget buildNavigationRailM3EDefaultUseCase(BuildContext context) {
  return _buildRailDemo(context);
}

@UseCase(name: 'collapsed_standard', type: NavigationRailM3E)
Widget buildNavigationRailM3ECollapsedStandardUseCase(BuildContext context) {
  return _buildRailDemo(
    context,
    forcedType: NavigationRailM3EType.collapsed,
    forcedModality: NavigationRailM3EModality.standard,
  );
}

@UseCase(name: 'expanded_modal', type: NavigationRailM3E)
Widget buildNavigationRailM3EExpandedModalUseCase(BuildContext context) {
  return _buildRailDemo(
    context,
    forcedType: NavigationRailM3EType.expanded,
    forcedModality: NavigationRailM3EModality.modal,
  );
}
