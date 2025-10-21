part of 'enums.dart';

/// All numeric tokens & constants for M3 Expressive IconButton.
/// No business logic here—just data.
class IconButtonM3ETokens {
  const IconButtonM3ETokens._();

  // ----------------------------
  // Icon glyph sizes (dp)
  // ----------------------------
  static const Map<IconButtonM3ESize, double> icon = {
    IconButtonM3ESize.xs: 20.0, // A
    IconButtonM3ESize.sm: 24.0, // B
    IconButtonM3ESize.md: 24.0, // C
    IconButtonM3ESize.lg: 32.0, // D
    IconButtonM3ESize.xl: 40.0, // E
  };

  // ----------------------------
  // Visual container sizes (dp)
  // width × height
  // ----------------------------
  static const Map<IconButtonM3ESize, Map<IconButtonM3EWidth, Size>> visual = {
    IconButtonM3ESize.xs: {
      IconButtonM3EWidth.defaultWidth: Size(32, 32),
      IconButtonM3EWidth.narrow: Size(28, 32),
      IconButtonM3EWidth.wide: Size(40, 32),
    },
    IconButtonM3ESize.sm: {
      IconButtonM3EWidth.defaultWidth: Size(40, 40),
      IconButtonM3EWidth.narrow: Size(32, 40),
      IconButtonM3EWidth.wide: Size(52, 40),
    },
    IconButtonM3ESize.md: {
      IconButtonM3EWidth.defaultWidth: Size(56, 56),
      IconButtonM3EWidth.narrow: Size(48, 56),
      IconButtonM3EWidth.wide: Size(72, 56),
    },
    IconButtonM3ESize.lg: {
      IconButtonM3EWidth.defaultWidth: Size(96, 96),
      IconButtonM3EWidth.narrow: Size(64, 96),
      IconButtonM3EWidth.wide: Size(128, 96),
    },
    IconButtonM3ESize.xl: {
      IconButtonM3EWidth.defaultWidth: Size(136, 136),
      IconButtonM3EWidth.narrow: Size(104, 136),
      IconButtonM3EWidth.wide: Size(184, 136),
    },
  };

  // ----------------------------
  // Minimum interactive target sizes (dp)
  // XS/SM must be ≥48×48 (SM wide = 52×48); others equal visual.
  // ----------------------------
  static const Map<IconButtonM3ESize, Map<IconButtonM3EWidth, Size>> target = {
    IconButtonM3ESize.xs: {
      IconButtonM3EWidth.defaultWidth: Size(48, 48),
      IconButtonM3EWidth.narrow: Size(48, 48),
      IconButtonM3EWidth.wide: Size(48, 48),
    },
    IconButtonM3ESize.sm: {
      IconButtonM3EWidth.defaultWidth: Size(48, 48),
      IconButtonM3EWidth.narrow: Size(48, 48),
      IconButtonM3EWidth.wide: Size(52, 48),
    },
    // MD/LG/XL already meet or exceed 48×48 – use visual sizes as targets.
    IconButtonM3ESize.md: {
      IconButtonM3EWidth.defaultWidth: Size(56, 56),
      IconButtonM3EWidth.narrow: Size(48, 56),
      IconButtonM3EWidth.wide: Size(72, 56),
    },
    IconButtonM3ESize.lg: {
      IconButtonM3EWidth.defaultWidth: Size(96, 96),
      IconButtonM3EWidth.narrow: Size(64, 96),
      IconButtonM3EWidth.wide: Size(128, 96),
    },
    IconButtonM3ESize.xl: {
      IconButtonM3EWidth.defaultWidth: Size(136, 136),
      IconButtonM3EWidth.narrow: Size(104, 136),
      IconButtonM3EWidth.wide: Size(184, 136),
    },
  };

  // ----------------------------
  // Corner radii (dp)
  // Pressed radius is shared by both variants at the same size and
  // is more square than the square resting radius.
  // Values are consistent, scalable defaults; tune to match your spec.
  // ----------------------------
  static const Map<IconButtonM3ESize, double> radiusRestRound = {
    // Half of the default height → circular/pill look
    IconButtonM3ESize.xs: 16.0, // 32/2
    IconButtonM3ESize.sm: 20.0, // 40/2
    IconButtonM3ESize.md: 28.0, // 56/2
    IconButtonM3ESize.lg: 48.0, // 96/2
    IconButtonM3ESize.xl: 68.0, // 136/2
  };

  static const Map<IconButtonM3ESize, double> radiusRestSquare = {
    // Rounded-square feel (~25% of height)
    IconButtonM3ESize.xs: 8.0, // ≈32*0.25
    IconButtonM3ESize.sm: 10.0, // ≈40*0.25
    IconButtonM3ESize.md: 14.0, // ≈56*0.25
    IconButtonM3ESize.lg: 24.0, // ≈96*0.25
    IconButtonM3ESize.xl: 34.0, // ≈136*0.25
  };

  static const Map<IconButtonM3ESize, double> radiusPressed = {
    // More square than the square resting radius (~20% of height)
    IconButtonM3ESize.xs: 6.0, // ≈32*0.20
    IconButtonM3ESize.sm: 8.0, // ≈40*0.20
    IconButtonM3ESize.md: 11.0, // ≈56*0.20
    IconButtonM3ESize.lg: 19.0, // ≈96*0.20
    IconButtonM3ESize.xl: 27.0, // ≈136*0.20
  };

  // ----------------------------
  // Motion tokens for shape morph (optional, but handy)
  // ----------------------------
  static const Duration morphDuration = Duration(milliseconds: 120);
  static const Curve morphCurve = Curves.easeOut;
}
