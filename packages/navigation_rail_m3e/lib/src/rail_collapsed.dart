import 'package:fab_m3e/fab_m3e.dart';
import 'package:flutter/material.dart';
import 'package:icon_button_m3e/icon_button_m3e.dart';

import 'rail_fab_slot.dart';
import 'rail_item.dart';
import 'rail_section_m3e.dart';
import 'rail_theme.dart';
import 'rail_tokens_adapter.dart';

/// Collapsed (96dp) rail. One class per file.
class CollapsedRail extends StatelessWidget {
  const CollapsedRail({
    super.key,
    required this.sections,
    required this.selectedIndex,
    required this.onDestinationSelected,
    this.fab,
    this.hideWhenCollapsed = false,
    required this.isExpanded,
    this.onToggleType,
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

  /// When true and rail is collapsed, animate width to zero.
  final bool hideWhenCollapsed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NavigationRailM3ETheme>() ??
        const NavigationRailM3ETheme();
    final tokens = NavigationRailTokensAdapter(context);

    final width = hideWhenCollapsed ? 0.0 : theme.collapsedWidth;
    final allDestinations = sections.expand((s) => s.destinations).toList();

    final Widget content = ListView(
      padding: EdgeInsets.zero,
      children: [
        const SizedBox(height: 36),
        Padding(
          padding: const EdgeInsetsDirectional.only(
              start: 16.0, end: 16.0, bottom: 12.0),
          child: Align(
            alignment: Alignment.center,
            child: IconButtonM3E(
              icon: Icon(isExpanded ? Icons.menu_open : Icons.menu),
              tooltip: isExpanded ? 'Collapse' : 'Expand',
              onPressed: onToggleType,
            ),
          ),
        ),
        if (fab != null)
          Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 16.0, end: 16.0, bottom: 12.0),
            child: FabM3E(
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
        for (int i = 0; i < allDestinations.length; i++) ...[
          Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 16.0, end: 16.0, top: 8.0, bottom: 8.0),
            child: RailItem(
              destination: allDestinations[i],
              selected: i == selectedIndex,
              onTap: () => onDestinationSelected(i),
              expanded: false,
            ),
          ),
        ],
      ],
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      width: width,
      decoration: BoxDecoration(color: tokens.containerColor),
      child: content,
    );
  }
}
