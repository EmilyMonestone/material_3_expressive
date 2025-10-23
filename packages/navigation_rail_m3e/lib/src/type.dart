import 'package:flutter/foundation.dart';

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