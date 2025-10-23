import 'package:flutter/material.dart';
import 'package:icon_button_m3e/icon_button_m3e.dart';
import 'package:navigation_rail_m3e/navigation_rail_m3e.dart';

/// Internal button used by the NavigationRail item that can look like
/// an IconButton (collapsed) or a text button (expanded) without
/// switching widget types. This avoids animation hitches when the
/// rail animates between collapsed and expanded.
class RailItemButtonM3E extends StatelessWidget {
  const RailItemButtonM3E({
    super.key,
    required this.icon,
    this.selectedIcon,
    required this.isSelected,
    required this.onPressed,
    required this.expanded,
    required this.labelBehavior,
    required this.label,
    this.semanticLabel,
    this.suppressInk = false,
    this.badgeCount,
  });

  final Widget icon;
  final Widget? selectedIcon;
  final bool isSelected;
  final VoidCallback onPressed;
  final bool expanded;
  final NavigationRailM3ELabelBehavior labelBehavior;
  final String label;
  final String? semanticLabel;
  final bool suppressInk;
  final int? badgeCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NavigationRailM3ETheme>() ??
        const NavigationRailM3ETheme();
    final tokens = NavigationRailTokensAdapter(context);

    final double height = expanded ? theme.itemHeight : theme.itemHeight;
    final bool selected = isSelected;

    // Colors and shape per state.
    final Color fg =
        selected ? tokens.activeIconAndLabel : tokens.inactiveIconAndLabel;
    final Color bg =
        expanded && selected ? tokens.activeIndicatorColor : Colors.transparent;
    final ShapeBorder shape =
        expanded ? tokens.indicatorShapeFull : const RoundedRectangleBorder();

    // Content
    final Widget effectiveIcon =
        selected && selectedIcon != null ? selectedIcon! : icon;

    Widget content;
    if (expanded) {
      final textExpended = Flexible(
        child: DefaultTextStyle.merge(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          child: Text(label, semanticsLabel: semanticLabel ?? label),
        ),
      );

      content = Row(
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconTheme.merge(
                  data: IconThemeData(color: fg, size: theme.iconSize),
                  child: effectiveIcon,
                ),
                SizedBox(width: theme.iconLabelGap),
                textExpended,
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: theme.iconLabelGap),
            child: RailBadgeM3E(count: badgeCount),
          ),
        ],
      );
    } else {
      final textCollapsed = Flexible(
        child: DefaultTextStyle.merge(
          style: Theme.of(context).textTheme.labelMedium!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          child: Text(label, semanticsLabel: semanticLabel ?? label),
        ),
      );

      content = Column(
        children: [
          IconButtonM3E(
            icon: IconTheme.merge(
              data: IconThemeData(color: fg, size: theme.iconSize),
              child: effectiveIcon,
            ),
            width: IconButtonM3EWidth.wide,
            badgeValue: badgeCount,
            onPressed: onPressed,
            variant: isSelected
                ? IconButtonM3EVariant.tonal
                : IconButtonM3EVariant.standard,
            shape: IconButtonM3EShapeVariant.round,
          ),
          if (labelBehavior == NavigationRailM3ELabelBehavior.alwaysShow ||
              (isSelected == true &&
                  labelBehavior != NavigationRailM3ELabelBehavior.alwaysHide))
            textCollapsed,
        ],
      );
    }

    final Material material = Material(
      color: bg,
      shape: shape,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        splashFactory: expanded ? null : NoSplash.splashFactory,
        hoverColor: expanded ? null : Colors.transparent,
        highlightColor: expanded ? null : Colors.transparent,
        child: Padding(
          // Horizontal padding similar to ButtonM3E sm; for collapsed, none.
          padding: expanded
              ? EdgeInsetsDirectional.only(
                  start: theme.indicatorLeading,
                  end: theme.indicatorTrailing,
                )
              : EdgeInsets.zero,
          child: Align(
            alignment: expanded ? Alignment.centerLeft : Alignment.center,
            child: IconTheme.merge(
              data: IconThemeData(color: fg, size: theme.iconSize),
              child: content,
            ),
          ),
        ),
      ),
    );

    final Widget sized = ConstrainedBox(
      constraints: BoxConstraints(minHeight: height),
      child: material,
    );

    // Tooltip semantics for collapsed state.
    final Widget withTooltip = expanded
        ? sized
        : Tooltip(
            message: semanticLabel ?? label,
            preferBelow: false,
            child: sized,
          );

    return Semantics(
      button: true,
      selected: selected,
      label: expanded ? null : (semanticLabel ?? label),
      child: withTooltip,
    );
  }
}
