import 'package:fab_m3e/fab_m3e.dart'
    show FabM3EKind, FabM3ESize, FabM3EShapeFamily, FabM3EDensity;
import 'package:flutter/material.dart';

/// Configuration for the rail's built-in FAB.
///
/// The rail renders:
/// - a FabM3E when collapsed
/// - an ExtendedFabM3E when expanded
///
/// Consumers provide values (icon, label, onPressed, etc.) instead of a widget.
@immutable
class NavigationRailM3EFabSlot {
  /// Creates a [NavigationRailM3EFabSlot].
  const NavigationRailM3EFabSlot({
    required this.icon,
    required this.label,
    this.onPressed,
    this.tooltip,
    this.heroTag,
    this.kind = FabM3EKind.primary,
    this.size = FabM3ESize.regular,
    this.shapeFamily = FabM3EShapeFamily.round,
    this.density = FabM3EDensity.regular,
    this.elevation,
    this.semanticLabel,
  });

  /// Icon widget shown inside the FAB (collapsed) and leading icon (expanded).
  final Widget icon;

  /// Text label for the extended FAB (expanded rail variant).
  final String label;

  /// Tap callback for the FAB.
  final VoidCallback? onPressed;

  /// Tooltip text for hover/long-press.
  final String? tooltip;

  /// Optional Hero tag for FAB transitions.
  final Object? heroTag;

  /// Visual kind (primary, surface, tertiary, etc.).
  final FabM3EKind kind;

  /// Size of the FAB button.
  final FabM3ESize size;

  /// Shape family (round/square).
  final FabM3EShapeFamily shapeFamily;

  /// Density (affects metrics like size and padding).
  final FabM3EDensity density;

  /// Elevation override.
  final double? elevation;

  /// Optional semantic label for accessibility.
  final String? semanticLabel;
}
