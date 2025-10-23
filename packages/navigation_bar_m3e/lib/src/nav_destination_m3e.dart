import 'package:flutter/material.dart';


import 'nav_badge_m3e.dart';

class NavigationDestinationM3E {
  const NavigationDestinationM3E({
    required this.icon,
    required this.label,
    this.selectedIcon,
    this.badgeCount,
    this.badgeDot = false,
    this.semanticLabel,
  });

  final Widget icon;
  final Widget? selectedIcon;
  final String label;

  /// Optional badgeValue counter
  final int? badgeCount;

  /// If true, show a small dot instead of a counter.
  final bool badgeDot;

  final String? semanticLabel;

  Widget buildIcon([bool selected = false]) {
    final base = selected && selectedIcon != null ? selectedIcon! : icon;
    if (badgeCount != null || badgeDot) {
      return NavBadgeM3E(
        child: base,
        count: badgeCount,
        showDot: badgeDot,
        semanticLabel: semanticLabel,
      );
    }
    return base;
  }
}
