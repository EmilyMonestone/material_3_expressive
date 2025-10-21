import 'package:flutter/material.dart';
import 'rail_badge_m3e.dart';

class RailDestinationM3E {
  const RailDestinationM3E({
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

  /// Optional badge counter
  final int? badgeCount;

  /// If true, show a small dot instead of a counter.
  final bool badgeDot;

  final String? semanticLabel;

  Widget buildIcon([bool selected = false]) {
    final base = selected && selectedIcon != null ? selectedIcon! : icon;
    if (badgeCount != null || badgeDot) {
      return RailBadgeM3E(
        child: base,
        count: badgeCount,
        showDot: badgeDot,
        semanticLabel: semanticLabel,
      );
    }
    return base;
  }
}
