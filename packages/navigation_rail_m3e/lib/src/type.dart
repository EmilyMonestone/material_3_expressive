/// M3 Expressive types for the rail.
enum NavigationRailM3EType {
  /// Slim 96dp rail.
  collapsed,

  /// Wide 220–360dp rail that replaces the drawer.
  expanded,
}

extension NavigationRailM3ETypeX on NavigationRailM3EType {
  bool get isCollapsed => this == NavigationRailM3EType.collapsed;
  bool get isExpanded => this == NavigationRailM3EType.expanded;
}

/// Controls how labels are shown for rail destinations when the rail is expanded.
///
/// - alwaysShow (default): show all labels (subject to width constraints).
/// - onlySelected: show the label only for the selected destination.
/// - alwaysHide: never show labels even when expanded.
enum NavigationRailM3ELabelBehavior {
  alwaysShow,
  onlySelected,
  alwaysHide,
}
