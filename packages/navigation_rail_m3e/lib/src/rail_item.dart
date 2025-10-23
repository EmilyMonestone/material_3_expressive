import 'package:flutter/material.dart';

import 'rail_badge_m3e.dart';
import 'rail_destination_m3e.dart';
import 'rail_theme.dart';
import 'rail_tokens_adapter.dart';

/// Single rail item (private to package). One class per file.
class RailItem extends StatelessWidget {
  /// Creates a single navigation rail item.
  const RailItem({
    super.key,
    required this.destination,
    required this.selected,
    required this.onTap,
    required this.expanded,
  });

  /// Destination data driving this item.
  final NavigationRailM3EDestination destination;
  /// Whether this item is currently selected.
  final bool selected;
  /// Called when the item is tapped.
  final VoidCallback onTap;
  /// Whether the rail is expanded (shows label and badges inline).
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NavigationRailM3ETheme>() ??
        const NavigationRailM3ETheme();
    final tokens = NavigationRailTokensAdapter(context);
    final height = destination.short ? theme.itemShortHeight : theme.itemHeight;

    final icon = IconTheme.merge(
      data: IconThemeData(
        size: theme.iconSize,
        color:
            selected ? tokens.activeIconAndLabel : tokens.inactiveIconAndLabel,
      ),
      child: selected
          ? (destination.selectedIcon ?? destination.icon)
          : destination.icon,
    );

    final label = DefaultTextStyle(
      style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: selected
                ? tokens.activeIconAndLabel
                : tokens.inactiveIconAndLabel,
          ),
      child: Text(
        destination.label,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        semanticsLabel: destination.semanticLabel ?? destination.label,
      ),
    );

    final badges = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (destination.largeBadgeCount != null &&
            destination.largeBadgeCount! > 0)
          Padding(
            padding: EdgeInsets.only(left: theme.iconLabelGap),
            child: RailBadgeM3E(count: destination.largeBadgeCount!),
          ),
        if (destination.smallBadge)
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 6.0),
            child: _SmallDot(color: tokens.badgeSmallDot),
          ),
      ],
    );

    final content = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      height: height,
      decoration: ShapeDecoration(
        color: selected ? tokens.activeIndicatorColor : Colors.transparent,
        shape: const StadiumBorder(), // Full corner per spec
      ),
      padding: EdgeInsetsDirectional.only(
        start: theme.indicatorLeading,
        end: theme.indicatorTrailing,
      ),
      child: Row(
        children: [
          icon,
          SizedBox(width: theme.iconLabelGap),
          if (expanded) Expanded(child: label) else const SizedBox.shrink(),
          if (expanded) badges,
        ],
      ),
    );

    // Full-width hit target
    return Semantics(
      selected: selected,
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: content,
      ),
    );
  }
}

class _SmallDot extends StatelessWidget {
  const _SmallDot({required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
