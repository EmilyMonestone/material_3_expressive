/// M3 Expressive types for the rail.
enum NavigationRailM3EType {
  /// Slim 96dp rail.
  collapsed,

  /// Slim 96dp rail with no button to expand.
  alwaysCollapse,

  /// Wide 220–360dp rail that replaces the drawer.
  expanded,

  /// Wide 220–360dp rail that replaces the drawer with no button to collapse.
  alwaysExpand,
}

/// Convenience extension for checking the current rail type.
extension NavigationRailM3ETypeX on NavigationRailM3EType {
  /// Whether this type equals [NavigationRailM3EType.collapsed].
  bool get isCollapsed => this == NavigationRailM3EType.collapsed;

  /// Whether this type equals [NavigationRailM3EType.expanded].
  bool get isExpanded => this == NavigationRailM3EType.expanded;
}

/// Controls how labels are shown for rail destinations when the rail is expanded.
///
/// - alwaysShow (default): show all labels (subject to width constraints).
/// - onlySelected: show the label only for the selected destination.
/// - alwaysHide: never show labels even when expanded.
enum NavigationRailM3ELabelBehavior {
  /// Always show labels (subject to width constraints).
  alwaysShow,

  /// Show the label only for the selected destination.
  onlySelected,

  /// Never show labels even when expanded.
  alwaysHide,
}
