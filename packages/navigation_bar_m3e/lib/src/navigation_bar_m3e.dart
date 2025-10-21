import 'package:flutter/material.dart';
import 'package:m3e_design/m3e_design.dart';
import 'enums.dart';
import 'nav_tokens_adapter.dart';
import 'nav_destination_m3e.dart';

class NavigationBarM3E extends StatelessWidget {
  const NavigationBarM3E({
    super.key,
    required this.destinations,
    this.selectedIndex = 0,
    this.onDestinationSelected,
    this.labelBehavior = NavBarM3ELabelBehavior.onlySelected,
    this.size = NavBarM3ESize.medium,
    this.shapeFamily = NavBarM3EShapeFamily.round,
    this.density = NavBarM3EDensity.regular,
    this.backgroundColor,
    this.elevation,
    this.indicatorStyle = NavBarM3EIndicatorStyle.pill,
    this.indicatorColor,
    this.padding,
    this.safeArea = true,
    this.semanticLabel,
  });

  final List<NavigationDestinationM3E> destinations;
  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;

  final NavBarM3ELabelBehavior labelBehavior;
  final NavBarM3ESize size;
  final NavBarM3EShapeFamily shapeFamily;
  final NavBarM3EDensity density;

  final Color? backgroundColor;
  final double? elevation;

  final NavBarM3EIndicatorStyle indicatorStyle;
  final Color? indicatorColor;

  final EdgeInsetsGeometry? padding;
  final bool safeArea;

  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    assert(destinations.isNotEmpty, 'Provide at least one destination');

    final tokens = NavTokensAdapter(context);
    final metrics = tokens.metrics(density);
    final m3e = Theme.of(context).extension<M3ETheme>() ?? M3ETheme.defaults(Theme.of(context).colorScheme);

    final height = size == NavBarM3ESize.small ? metrics.heightSmall : metrics.heightMedium;
    final bg = backgroundColor ?? tokens.containerColor();
    final shape = tokens.containerShape(shapeFamily);

    final nav = Material(
      color: bg,
      elevation: elevation ?? 0,
      shape: shape,
      child: SizedBox(
        height: height,
        child: NavigationBar(
          height: height,
          elevation: elevation ?? 0,
          indicatorColor: indicatorStyle == NavBarM3EIndicatorStyle.none
              ? Colors.transparent
              : (indicatorColor ?? tokens.indicatorColor()),
          indicatorShape: switch (indicatorStyle) {
            NavBarM3EIndicatorStyle.pill => tokens.indicatorShapePill(),
            NavBarM3EIndicatorStyle.underline => const StadiumBorder(), // we'll fake underline via decoration below
            NavBarM3EIndicatorStyle.none => const StadiumBorder(),
          },
          backgroundColor: Colors.transparent, // outer Material supplies bg + shape
          labelBehavior: switch (labelBehavior) {
            NavBarM3ELabelBehavior.alwaysShow => NavigationDestinationLabelBehavior.alwaysShow,
            NavBarM3ELabelBehavior.onlySelected => NavigationDestinationLabelBehavior.onlyShowSelected,
            NavBarM3ELabelBehavior.alwaysHide => NavigationDestinationLabelBehavior.alwaysHide,
          },
          selectedIndex: selectedIndex,
          destinations: List.generate(destinations.length, (i) {
            final d = destinations[i];
            return NavigationDestination(
              icon: _icon(context, false, d, metrics.iconSize),
              selectedIcon: _selectedIcon(context, true, d, metrics.iconSize, tokens, indicatorStyle),
              label: d.label,
              tooltip: d.semanticLabel,
            );
          }),
          onDestinationSelected: onDestinationSelected,
        ),
      ),
    );

    final padded = Padding(
      padding: padding ?? EdgeInsets.zero,
      child: nav,
    );

    final content = DefaultTextStyle.merge(
      style: tokens.labelStyle().copyWith(
        color: m3e.colors.onSurfaceVariant,
      ),
      child: IconTheme.merge(
        data: IconThemeData(size: metrics.iconSize, color: m3e.colors.onSurfaceVariant),
        child: padded,
      ),
    );

    if (!safeArea && semanticLabel == null) return content;
    final wrapped = SafeArea(top: false, left: false, right: false, bottom: safeArea, child: content);

    if (semanticLabel == null) return wrapped;
    return Semantics(container: true, label: semanticLabel!, child: wrapped);
  }

  Widget _icon(BuildContext context, bool selected, NavigationDestinationM3E d, double iconSize) {
    return SizedBox(
      width: iconSize + 8, // give a little space for underline
      height: iconSize + 8,
      child: Center(child: d.buildIcon(selected)),
    );
  }

  Widget _selectedIcon(
    BuildContext context,
    bool selected,
    NavigationDestinationM3E d,
    double iconSize,
    NavTokensAdapter tokens,
    NavBarM3EIndicatorStyle style,
  ) {
    final w = _icon(context, selected, d, iconSize);
    if (style != NavBarM3EIndicatorStyle.underline) return w;

    final metrics = tokens.metrics(density);
    final deco = tokens.underlineDecoration(tokens.indicatorColor(), metrics.indicatorThickness);
    return DecoratedBox(
      decoration: deco,
      child: w,
    );
  }
}
