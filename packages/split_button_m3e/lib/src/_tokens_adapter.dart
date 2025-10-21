part of 'enums.dart';

/// Token bucket for SplitButtonM3E (dp, ms, turns, etc.).
class SplitButtonM3ETokens {
  const SplitButtonM3ETokens._();

  // Control heights per size
  static const Map<SplitButtonM3ESize, double> height = {
    SplitButtonM3ESize.xs: 32,
    SplitButtonM3ESize.sm: 40,
    SplitButtonM3ESize.md: 56,
    SplitButtonM3ESize.lg: 96,
    SplitButtonM3ESize.xl: 136,
  };

  // Trailing segment width
  static const Map<SplitButtonM3ESize, double> trailingSegmentWidth = {
    SplitButtonM3ESize.xs: 22,
    SplitButtonM3ESize.sm: 22,
    SplitButtonM3ESize.md: 26,
    SplitButtonM3ESize.lg: 38,
    SplitButtonM3ESize.xl: 50,
  };

  // Inner “gap” between segments
  static const double innerGap = 2.0;

  // Inner corner radius (both facing edges)
  static const Map<SplitButtonM3ESize, double> innerCornerRadius = {
    SplitButtonM3ESize.xs: 4,
    SplitButtonM3ESize.sm: 4,
    SplitButtonM3ESize.md: 4,
    SplitButtonM3ESize.lg: 8,
    SplitButtonM3ESize.xl: 12,
  };

  // Inner padding (from inner edge to content)
  static const Map<SplitButtonM3ESize, double> innerPadding = {
    SplitButtonM3ESize.xs: 4,
    SplitButtonM3ESize.sm: 4,
    SplitButtonM3ESize.md: 4,
    SplitButtonM3ESize.lg: 8,
    SplitButtonM3ESize.xl: 12,
  };

  // Menu chevron optical offset (unselected/resting; negative = shift left)
  static const Map<SplitButtonM3ESize, double> menuIconOffsetUnselected = {
    SplitButtonM3ESize.xs: -1,
    SplitButtonM3ESize.sm: -1,
    SplitButtonM3ESize.md: -2,
    SplitButtonM3ESize.lg: -3,
    SplitButtonM3ESize.xl: -6,
  };

  // Icon glyph size (for both segments)
  static const Map<SplitButtonM3ESize, double> icon = {
    SplitButtonM3ESize.xs: 20.0,
    SplitButtonM3ESize.sm: 24.0,
    SplitButtonM3ESize.md: 24.0,
    SplitButtonM3ESize.lg: 32.0,
    SplitButtonM3ESize.xl: 40.0,
  };

  // Minimum touch target per segment
  static const double minTapTarget = 48.0;

  // Shape radii (outer corners) and pressed morph
  // round = half height; square ≈ 25% height; pressed ≈ 20% height
  static const Map<SplitButtonM3ESize, double> outerRadiusRound = {
    SplitButtonM3ESize.xs: 16,
    SplitButtonM3ESize.sm: 20,
    SplitButtonM3ESize.md: 28,
    SplitButtonM3ESize.lg: 48,
    SplitButtonM3ESize.xl: 68,
  };

  static const Map<SplitButtonM3ESize, double> outerRadiusSquare = {
    SplitButtonM3ESize.xs: 8,
    SplitButtonM3ESize.sm: 10,
    SplitButtonM3ESize.md: 14,
    SplitButtonM3ESize.lg: 24,
    SplitButtonM3ESize.xl: 34,
  };

  static const Map<SplitButtonM3ESize, double> pressedRadius = {
    SplitButtonM3ESize.xs: 6,
    SplitButtonM3ESize.sm: 8,
    SplitButtonM3ESize.md: 11,
    SplitButtonM3ESize.lg: 19,
    SplitButtonM3ESize.xl: 27,
  };

  // Layout: Asymmetrical (optically centered trailing; unselected)
  static const Map<SplitButtonM3ESize, double> leadingIconBlockWidth = {
    SplitButtonM3ESize.xs: 20,
    SplitButtonM3ESize.sm: 20,
    SplitButtonM3ESize.md: 24,
    SplitButtonM3ESize.lg: 32,
    SplitButtonM3ESize.xl: 40,
  };

  static const Map<SplitButtonM3ESize, double> leftOuterPadding = {
    SplitButtonM3ESize.xs: 12,
    SplitButtonM3ESize.sm: 16,
    SplitButtonM3ESize.md: 24,
    SplitButtonM3ESize.lg: 48,
    SplitButtonM3ESize.xl: 64,
  };

  static const Map<SplitButtonM3ESize, double> gapIconToLabel = {
    SplitButtonM3ESize.xs: 4,
    SplitButtonM3ESize.sm: 8,
    SplitButtonM3ESize.md: 8,
    SplitButtonM3ESize.lg: 12,
    SplitButtonM3ESize.xl: 16,
  };

  static const Map<SplitButtonM3ESize, double> labelRightPaddingBeforeDivider =
      {
    SplitButtonM3ESize.xs: 10,
    SplitButtonM3ESize.sm: 12,
    SplitButtonM3ESize.md: 24,
    SplitButtonM3ESize.lg: 48,
    SplitButtonM3ESize.xl: 64,
  };

  static const Map<SplitButtonM3ESize, double> trailingLeftInnerPadding = {
    SplitButtonM3ESize.xs: 12,
    SplitButtonM3ESize.sm: 12,
    SplitButtonM3ESize.md: 13,
    SplitButtonM3ESize.lg: 26,
    SplitButtonM3ESize.xl: 37,
  };

  static const Map<SplitButtonM3ESize, double> rightOuterPadding = {
    SplitButtonM3ESize.xs: 14,
    SplitButtonM3ESize.sm: 14,
    SplitButtonM3ESize.md: 17,
    SplitButtonM3ESize.lg: 32,
    SplitButtonM3ESize.xl: 49,
  };

  // Layout: Symmetrical (trailing centered; selected)
  static const Map<SplitButtonM3ESize, double> sidePaddingSelected = {
    SplitButtonM3ESize.xs: 13,
    SplitButtonM3ESize.sm: 13,
    SplitButtonM3ESize.md: 15,
    SplitButtonM3ESize.lg: 29,
    SplitButtonM3ESize.xl: 43,
  };

  // Animation
  static const Duration morphDuration = Duration(milliseconds: 120);
  static const Curve morphCurve = Curves.easeOut;
  static const double chevronOpenTurns = 0.5; // 180°
  static const Duration chevronDuration = Duration(milliseconds: 120);

  // Focus ring
  static const double focusStrokeWidth = 2.0;
}
