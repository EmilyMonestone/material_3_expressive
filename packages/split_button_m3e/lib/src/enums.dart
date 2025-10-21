import 'package:flutter/material.dart';

part '_tokens_adapter.dart';

/// 5-step size scale (rows 1–5 in the spec).
enum SplitButtonM3ESize { xs, sm, md, lg, xl }

/// Base silhouette for the outer corners in resting state.
/// (Pressed state morphs using tokens regardless of the base.)
enum SplitButtonM3EShape { round, square }

/// Emphasis family (choose container/elevation per theme).
enum SplitButtonM3EEmphasis { filled, tonal, elevated, outlined, text }

/// Trailing icon alignment:
/// - opticalCenter → apply per-size negative offset in resting (menu closed) state
/// - geometricCenter → no offset, purely geometric center
enum SplitButtonM3ETrailingAlignment { opticalCenter, geometricCenter }

/// Public helpers to access tokens without exposing numbers.
extension SplitButtonM3ETokensX on SplitButtonM3ESize {
  double get height => SplitButtonM3ETokens.height[this]!;
  double get trailingWidthCentered =>
      SplitButtonM3ETokens.trailingSegmentWidth[this]!;
  double get innerCornerRadius => SplitButtonM3ETokens.innerCornerRadius[this]!;
  double get innerPadding => SplitButtonM3ETokens.innerPadding[this]!;
  double get menuIconOffsetUnselected =>
      SplitButtonM3ETokens.menuIconOffsetUnselected[this]!;
  double get iconPx => SplitButtonM3ETokens.icon[this]!;
  double get outerRoundRadius => SplitButtonM3ETokens.outerRadiusRound[this]!;
  double get outerSquareRadius => SplitButtonM3ETokens.outerRadiusSquare[this]!;
  double get pressedRadius => SplitButtonM3ETokens.pressedRadius[this]!;

  // New layout getters (per spec tables)
  double get leadingIconBlockWidth =>
      SplitButtonM3ETokens.leadingIconBlockWidth[this]!;
  double get leftOuterPadding => SplitButtonM3ETokens.leftOuterPadding[this]!;
  double get gapIconToLabel => SplitButtonM3ETokens.gapIconToLabel[this]!;
  double get labelRightPaddingBeforeDivider =>
      SplitButtonM3ETokens.labelRightPaddingBeforeDivider[this]!;
  double get trailingLeftInnerPadding =>
      SplitButtonM3ETokens.trailingLeftInnerPadding[this]!;
  double get rightOuterPadding => SplitButtonM3ETokens.rightOuterPadding[this]!;
  double get sidePaddingSelected =>
      SplitButtonM3ETokens.sidePaddingSelected[this]!;
}
