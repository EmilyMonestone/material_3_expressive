import 'package:flutter/material.dart';

/// Menu slot at the top of the rail (non-selectable). One class per file.
class NavigationRailM3EMenu extends StatelessWidget {
  /// Creates a [NavigationRailM3EMenu].
  const NavigationRailM3EMenu({super.key, required this.child});

  /// Content widget placed in the menu slot.
  final Widget child;

  @override
  Widget build(BuildContext context) => child;
}
