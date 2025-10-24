import 'package:flutter/material.dart';

import 'rail_destination_m3e.dart';

/// Section groups a header and a list of destinations. One class per file.
class NavigationRailM3ESection {
  /// Creates a [NavigationRailM3ESection].
  const NavigationRailM3ESection({
    required this.destinations,
    this.header,
  });

  /// Destinations shown in this section.
  final List<NavigationRailM3EDestination> destinations;

  /// Optional header widget displayed above the destinations.
  final Widget? header;
}
