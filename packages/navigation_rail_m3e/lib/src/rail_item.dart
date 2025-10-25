import 'package:flutter/material.dart';
import 'package:navigation_rail_m3e/navigation_rail_m3e.dart';

/// Single rail item (private to package). One class per file.
class RailItem extends StatelessWidget {
  /// Creates a single navigation rail item.
  const RailItem({
    super.key,
    required this.destination,
    required this.selected,
    required this.onTap,
    required this.expanded,
    required this.labelBehavior,
    this.suppressInk = false,
  });

  /// Destination data driving this item.
  final NavigationRailM3EDestination destination;

  /// Whether this item is currently selected.
  final bool selected;

  /// Called when the item is tapped.
  final VoidCallback onTap;

  /// Whether the rail is expanded (shows label and badges inline).
  final bool expanded;

  /// Whether this item's label should be visible.
  final NavigationRailM3ELabelBehavior labelBehavior;

  /// When true, disables splash/hover/highlight effects to prevent flicker during transitions.
  final bool suppressInk;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NavigationRailM3ETheme>() ??
        const NavigationRailM3ETheme();
    final height = destination.short
        ? theme.itemCollapsedHeight
        : theme.itemExpandedHeight;

    final Widget button = RailItemButtonM3E(
      icon: destination.icon,
      selectedIcon: destination.selectedIcon,
      isSelected: selected,
      onPressed: onTap,
      expanded: expanded,
      labelBehavior: labelBehavior,
      label: destination.label,
      semanticLabel: destination.semanticLabel,
      suppressInk: suppressInk,
      badgeCount: destination.badgeCount,
    );

    Widget core;
    if (!expanded) {
      // Collapsed: left-aligned icon-only button with 48x48 tap target.
      core = SizedBox(
        height: height,
        child: Align(alignment: Alignment.centerLeft, child: button),
      );
    } else {
      core = ConstrainedBox(
        constraints: BoxConstraints(minHeight: height),
        child: Row(
          children: [
            Expanded(child: button),
          ],
        ),
      );
    }

    return Semantics(
      selected: selected,
      button: true,
      child: core,
    );
  }
}
