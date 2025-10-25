import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

/// Theme extension for NavigationRailM3E token values.
class NavigationRailM3ETheme extends ThemeExtension<NavigationRailM3ETheme> {
  /// Creates a [NavigationRailM3ETheme] with default token values.
  const NavigationRailM3ETheme({
    this.collapsedWidth = 96.0,
    this.expandedMinWidth = 220.0,
    this.expandedMaxWidth = 360.0,
    this.itemExpandedHeight = 40.0,
    this.itemCollapsedHeight = 56.0,
    this.iconSize = 24.0,
    this.indicatorLeading = 16.0,
    this.indicatorTrailing = 16.0,
    this.iconLabelGap = 8.0,
    this.itemVerticalGap = 6.0,
    this.headerMinSpace = 40.0,
    this.sectionHeaderSpacingTop = 12.0,
    this.sectionHeaderSpacingBottom = 8.0,
  });

  /// Width of the rail when collapsed.
  final double collapsedWidth;

  /// Minimum width of the rail when expanded.
  final double expandedMinWidth;

  /// Maximum width of the rail when expanded.
  final double expandedMaxWidth;

  /// Default height of an item.
  final double itemExpandedHeight;

  /// Short item height variant.
  final double itemCollapsedHeight;

  /// Default icon size used for items.
  final double iconSize;

  /// Leading inset for the active indicator in expanded mode.
  final double indicatorLeading;

  /// Trailing inset for the active indicator in expanded mode.
  final double indicatorTrailing;

  /// Gap between icon and label.
  final double iconLabelGap;

  /// Vertical gap between items.
  final double itemVerticalGap;

  /// Minimum spacing between the top and the first header.
  final double headerMinSpace;

  /// Top spacing around a section header.
  final double sectionHeaderSpacingTop;

  /// Bottom spacing around a section header.
  final double sectionHeaderSpacingBottom;

  @override
  NavigationRailM3ETheme copyWith({
    double? collapsedWidth,
    double? expandedMinWidth,
    double? expandedMaxWidth,
    double? itemHeight,
    double? itemShortHeight,
    double? iconSize,
    double? indicatorLeading,
    double? indicatorTrailing,
    double? iconLabelGap,
    double? itemVerticalGap,
    double? headerMinSpace,
    double? sectionHeaderSpacingTop,
    double? sectionHeaderSpacingBottom,
  }) {
    return NavigationRailM3ETheme(
      collapsedWidth: collapsedWidth ?? this.collapsedWidth,
      expandedMinWidth: expandedMinWidth ?? this.expandedMinWidth,
      expandedMaxWidth: expandedMaxWidth ?? this.expandedMaxWidth,
      itemExpandedHeight: itemHeight ?? this.itemExpandedHeight,
      itemCollapsedHeight: itemShortHeight ?? this.itemCollapsedHeight,
      iconSize: iconSize ?? this.iconSize,
      indicatorLeading: indicatorLeading ?? this.indicatorLeading,
      indicatorTrailing: indicatorTrailing ?? this.indicatorTrailing,
      iconLabelGap: iconLabelGap ?? this.iconLabelGap,
      itemVerticalGap: itemVerticalGap ?? this.itemVerticalGap,
      headerMinSpace: headerMinSpace ?? this.headerMinSpace,
      sectionHeaderSpacingTop:
          sectionHeaderSpacingTop ?? this.sectionHeaderSpacingTop,
      sectionHeaderSpacingBottom:
          sectionHeaderSpacingBottom ?? this.sectionHeaderSpacingBottom,
    );
  }

  @override
  ThemeExtension<NavigationRailM3ETheme> lerp(
      ThemeExtension<NavigationRailM3ETheme>? other, double t) {
    if (other is! NavigationRailM3ETheme) return this;
    return NavigationRailM3ETheme(
      collapsedWidth: lerpDouble(collapsedWidth, other.collapsedWidth, t)!,
      expandedMinWidth:
          lerpDouble(expandedMinWidth, other.expandedMinWidth, t)!,
      expandedMaxWidth:
          lerpDouble(expandedMaxWidth, other.expandedMaxWidth, t)!,
      itemExpandedHeight:
          lerpDouble(itemExpandedHeight, other.itemExpandedHeight, t)!,
      itemCollapsedHeight:
          lerpDouble(itemCollapsedHeight, other.itemCollapsedHeight, t)!,
      iconSize: lerpDouble(iconSize, other.iconSize, t)!,
      indicatorLeading:
          lerpDouble(indicatorLeading, other.indicatorLeading, t)!,
      indicatorTrailing:
          lerpDouble(indicatorTrailing, other.indicatorTrailing, t)!,
      iconLabelGap: lerpDouble(iconLabelGap, other.iconLabelGap, t)!,
      itemVerticalGap: lerpDouble(itemVerticalGap, other.itemVerticalGap, t)!,
      headerMinSpace: lerpDouble(headerMinSpace, other.headerMinSpace, t)!,
      sectionHeaderSpacingTop: lerpDouble(
          sectionHeaderSpacingTop, other.sectionHeaderSpacingTop, t)!,
      sectionHeaderSpacingBottom: lerpDouble(
          sectionHeaderSpacingBottom, other.sectionHeaderSpacingBottom, t)!,
    );
  }
}
