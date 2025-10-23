import 'package:flutter/material.dart';

/// Model for a navigation destination. One class per file.
class NavigationRailM3EDestination {
  const NavigationRailM3EDestination({
    required this.icon,
    this.selectedIcon,
    required this.label,
    this.badgeCount,
    this.semanticLabel,
    this.short = false,
  });

  final Widget icon;
  final Widget? selectedIcon;
  final String label;
  final int? badgeCount;
  final String? semanticLabel;

  /// If true, uses short item height (56dp) instead of 64dp.
  final bool short;
}
