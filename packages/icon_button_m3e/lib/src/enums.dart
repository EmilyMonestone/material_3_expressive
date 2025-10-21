library m3e_iconbutton;

import 'package:flutter/material.dart';

part '_tokens_adapter.dart';

/// Visual scale labels (A–E in the spec).
enum IconButtonM3ESize { xs, sm, md, lg, xl }

/// Width variants of the button’s container (not the icon glyph).
enum IconButtonM3EWidth { defaultWidth, narrow, wide }

/// The two resting shape variants.
enum IconButtonM3EShapeVariant { round, square }

/// Visual variants (kept from previous API).
enum IconButtonM3EVariant { standard, filled, tonal, outlined }

/// Icon glyph size inside the button (reads tokens).
extension IconM3EGlyph on IconButtonM3ESize {
  double get icon => IconButtonM3ETokens.icon[this]!;
}

/// Visual (painted) size & target size helpers (read tokens).
extension IconButtonM3ESizes on IconButtonM3ESize {
  Size visual(IconButtonM3EWidth width) =>
      IconButtonM3ETokens.visual[this]![width]!;

  Size target(IconButtonM3EWidth width) =>
      IconButtonM3ETokens.target[this]![width]!;

  Size get defaultSize => visual(IconButtonM3EWidth.defaultWidth);
  Size get narrowSize => visual(IconButtonM3EWidth.narrow);
  Size get wideSize => visual(IconButtonM3EWidth.wide);
}

/// Shape resolution helpers: resting/pressed radii and toggle behavior.
class IconButtonM3EShapes {
  const IconButtonM3EShapes._();

  static IconButtonM3EShapeVariant restVariant({
    required bool isToggle,
    required bool isSelected,
    required IconButtonM3EShapeVariant baseVariant,
  }) {
    if (isToggle && isSelected) {
      return baseVariant == IconButtonM3EShapeVariant.round
          ? IconButtonM3EShapeVariant.square
          : IconButtonM3EShapeVariant.round;
    }
    return baseVariant;
  }

  static double restingRadius({
    required IconButtonM3ESize size,
    required IconButtonM3EShapeVariant variant,
  }) {
    return switch (variant) {
      IconButtonM3EShapeVariant.round =>
        IconButtonM3ETokens.radiusRestRound[size]!,
      IconButtonM3EShapeVariant.square =>
        IconButtonM3ETokens.radiusRestSquare[size]!,
    };
  }

  /// Effective corner radius for the given material states.
  /// Hover does not change the radius; Pressed uses the shared pressed radius.
  static double effectiveRadius({
    required IconButtonM3ESize size,
    required IconButtonM3EShapeVariant baseVariant,
    required bool isToggle,
    required bool isSelected,
    required Set<WidgetState> states,
  }) {
    final variant = restVariant(
      isToggle: isToggle,
      isSelected: isSelected,
      baseVariant: baseVariant,
    );

    if (states.contains(WidgetState.pressed)) {
      return IconButtonM3ETokens.radiusPressed[size]!;
    }
    return restingRadius(size: size, variant: variant);
  }
}
