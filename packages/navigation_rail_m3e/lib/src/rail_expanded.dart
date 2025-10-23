import 'package:fab_m3e/fab_m3e.dart';
import 'package:flutter/material.dart';
import 'package:icon_button_m3e/icon_button_m3e.dart';

import 'rail_destination_m3e.dart';
import 'rail_fab_slot.dart';
import 'rail_item.dart';
import 'rail_section_m3e.dart';
import 'rail_theme.dart';
import 'rail_tokens_adapter.dart';

/// Expanded rail (220–360dp). One class per file.
class ExpandedRail extends StatelessWidget {
  /// Creates the expanded rail variant.
  const ExpandedRail({
    super.key,
    required this.sections,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.isExpanded,
    this.onToggleType,
    this.fab,
    this.width,
    this.modal = false,
    this.onDismissModal,
  });

  /// Sections rendered in the rail.
  final List<NavigationRailM3ESection> sections;

  /// Currently selected destination index.
  final int selectedIndex;

  /// Callback when a destination is tapped.
  final ValueChanged<int> onDestinationSelected;

  /// Whether the current rail type is expanded.
  final bool isExpanded;

  /// Called when the user taps the built-in menu button to toggle type.
  final VoidCallback? onToggleType;

  /// Optional FAB/extended FAB slot.
  final NavigationRailM3EFabSlot? fab;

  /// Desired rail width (clamped to theme min/max) when expanded.
  final double? width;

  /// Whether the expanded rail is displayed as a modal overlay.
  final bool modal;

  /// Invoked to dismiss when [modal] is true.
  final VoidCallback? onDismissModal;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NavigationRailM3ETheme>() ??
        const NavigationRailM3ETheme();
    final tokens = NavigationRailTokensAdapter(context);

    final w = (width ?? theme.expandedMinWidth)
        .clamp(theme.expandedMinWidth, theme.expandedMaxWidth);

    final children = <Widget>[
      const SizedBox(height: 36),
      Padding(
        padding:
            const EdgeInsetsDirectional.only(start: 16, end: 16, bottom: 12),
        child: Align(
          alignment: Alignment.centerLeft,
          child: IconButtonM3E(
            icon: Icon(isExpanded ? Icons.menu_open : Icons.menu),
            tooltip: isExpanded ? 'Collapse' : 'Expand',
            onPressed: onToggleType,
          ),
        ),
      ),
      if (fab != null)
        Padding(
          padding:
              const EdgeInsetsDirectional.only(start: 16, end: 16, bottom: 12),
          child: ExtendedFabM3E(
            label: Text(fab!.label),
            icon: fab!.icon,
            onPressed: fab!.onPressed,
            tooltip: fab!.tooltip,
            heroTag: fab!.heroTag,
            kind: fab!.kind,
            size: fab!.size,
            shapeFamily: FabM3EShapeFamily.square,
            density: fab!.density,
            elevation: fab!.elevation,
            semanticLabel: fab!.semanticLabel,
          ),
        ),
    ];

    for (final section in sections) {
      if (section.header != null) {
        children.add(Padding(
          padding: EdgeInsetsDirectional.only(
            start: 16,
            end: 16,
            top: theme.sectionHeaderSpacingTop,
            bottom: theme.sectionHeaderSpacingBottom,
          ),
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant),
            child: section.header!,
          ),
        ));
      }
      for (final dest in section.destinations) {
        final index = _destinationIndex(sections, dest);
        children.add(Padding(
          padding: const EdgeInsetsDirectional.only(
              start: 16, end: 16, top: 8.0, bottom: 8.0),
          child: RailItem(
            destination: dest,
            selected: index == selectedIndex,
            onTap: () => onDestinationSelected(index),
            expanded: true,
          ),
        ));
      }
    }

    final rail = AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      width: w.toDouble(),
      decoration: BoxDecoration(color: tokens.containerColor),
      child: ListView(
        padding: EdgeInsets.zero,
        children: children,
      ),
    );

    if (!modal) return rail;

    // Modal overlay with scrim
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: onDismissModal,
            child: ColoredBox(
                color: Theme.of(context)
                    .colorScheme
                    .scrim
                    .withValues(alpha: 0.32)),
          ),
        ),
        Align(alignment: Alignment.centerLeft, child: rail),
      ],
    );
  }

  static int _destinationIndex(List<NavigationRailM3ESection> sections,
      NavigationRailM3EDestination dest) {
    var i = 0;
    for (final s in sections) {
      for (final d in s.destinations) {
        if (identical(d, dest)) return i;
        i++;
      }
    }
    return 0;
  }
}
