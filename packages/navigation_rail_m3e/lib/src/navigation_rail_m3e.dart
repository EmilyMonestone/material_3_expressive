import 'package:flutter/material.dart';

import 'enums.dart';
import 'rail_destination_m3e.dart';
import 'rail_tokens_adapter.dart';

class NavigationRailM3E extends StatelessWidget {
  const NavigationRailM3E({
    super.key,
    required this.destinations,
    this.selectedIndex = 0,
    this.onDestinationSelected,
    this.labelBehavior = RailLabelBehavior.onlySelected,
    this.size = RailSize.regular,
    this.shapeFamily = RailShapeFamily.round,
    this.density = RailDensity.regular,
    this.backgroundColor,
    this.elevation,
    this.indicatorStyle = RailIndicatorStyle.pill,
    this.indicatorColor,
    this.padding,
    this.groupAlignment,
    this.leading,
    this.trailing,
    this.extended = false,
    this.minExtendedWidth,
    this.useSafeArea = true,
    this.semanticLabel,
  });

  final List<RailDestinationM3E> destinations;
  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;

  final RailLabelBehavior labelBehavior;
  final RailSize size;
  final RailShapeFamily shapeFamily;
  final RailDensity density;

  final Color? backgroundColor;
  final double? elevation;

  final RailIndicatorStyle indicatorStyle;
  final Color? indicatorColor;

  final EdgeInsetsGeometry? padding;

  /// Aligns the group of destinations (-1 top .. 1 bottom).
  final double? groupAlignment;

  /// Optional leading and trailing widgets (e.g., FAB or menu).
  final Widget? leading;
  final Widget? trailing;

  /// Whether to show the rail in extended mode (icons + labels).
  final bool extended;

  /// Minimum width when extended.
  final double? minExtendedWidth;

  final bool useSafeArea;

  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    assert(destinations.isNotEmpty, 'Provide at least one destination');

    final tokens = RailTokensAdapter(context);
    final metrics = tokens.metrics(density);

    final width =
        size == RailSize.compact ? metrics.widthCompact : metrics.widthRegular;
    final bg = backgroundColor ?? tokens.containerColor();
    final shape = tokens.containerShape(shapeFamily);

    final rail = Material(
      color: bg,
      elevation: elevation ??
          0, // null means use theme default; avoids invalid zero assertion
      shape: shape,
      child: SizedBox(
        width:
            extended ? (minExtendedWidth ?? metrics.extendedMinWidth) : width,
        child: NavigationRail(
          backgroundColor: Colors.transparent,
          elevation: elevation, // pass through or null
          extended: extended,
          minExtendedWidth: minExtendedWidth ?? metrics.extendedMinWidth,
          selectedIndex: selectedIndex,
          groupAlignment: groupAlignment,
          leading: leading,
          trailing: trailing,
          labelType: switch (labelBehavior) {
            RailLabelBehavior.alwaysShow => NavigationRailLabelType.all,
            RailLabelBehavior.onlySelected => NavigationRailLabelType.selected,
            RailLabelBehavior.alwaysHide => NavigationRailLabelType.none,
          },
          useIndicator: indicatorStyle != RailIndicatorStyle.none,
          indicatorColor: indicatorColor ?? tokens.indicatorColor(),
          indicatorShape: switch (indicatorStyle) {
            RailIndicatorStyle.pill => tokens.indicatorShapePill(),
            RailIndicatorStyle.stripe =>
              const StadiumBorder(), // we'll fake stripe using decoration on selected icon
            RailIndicatorStyle.none => const StadiumBorder(),
          },
          selectedIconTheme: IconThemeData(
              color: tokens.selectedColor(), size: metrics.iconSize),
          unselectedIconTheme: IconThemeData(
              color: tokens.unselectedColor(), size: metrics.iconSize),
          selectedLabelTextStyle:
              tokens.labelStyle().copyWith(color: tokens.selectedColor()),
          unselectedLabelTextStyle:
              tokens.labelStyle().copyWith(color: tokens.unselectedColor()),
          destinations: List.generate(destinations.length, (i) {
            final d = destinations[i];
            return NavigationRailDestination(
              icon: _icon(context, false, d, metrics.iconSize),
              selectedIcon: _selectedIcon(
                  context, true, d, metrics.iconSize, tokens, indicatorStyle),
              label: Text(d.label),
              padding: metrics.itemPadding as EdgeInsets?,
            );
          }),
          onDestinationSelected: onDestinationSelected,
        ),
      ),
    );

    final padded = Padding(
      padding: padding ?? EdgeInsets.zero,
      child: rail,
    );

    if (!useSafeArea && semanticLabel == null) return padded;

    final wrapped = SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: false,
      child: padded,
    );

    if (semanticLabel == null) return wrapped;
    return Semantics(container: true, label: semanticLabel!, child: wrapped);
  }

  Widget _icon(BuildContext context, bool selected, RailDestinationM3E d,
      double iconSize) {
    return SizedBox(
      width: iconSize + 8,
      height: iconSize + 8,
      child: Center(child: d.buildIcon(selected)),
    );
  }

  Widget _selectedIcon(
    BuildContext context,
    bool selected,
    RailDestinationM3E d,
    double iconSize,
    RailTokensAdapter tokens,
    RailIndicatorStyle style,
  ) {
    final w = _icon(context, selected, d, iconSize);
    if (style != RailIndicatorStyle.stripe) return w;

    final metrics = tokens.metrics(density);
    final deco = tokens.stripeDecoration(
        tokens.indicatorColor(), metrics.stripeThickness);
    return DecoratedBox(
      decoration: deco,
      child: w,
    );
  }
}
