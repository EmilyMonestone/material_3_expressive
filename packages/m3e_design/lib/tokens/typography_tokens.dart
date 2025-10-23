import 'package:flutter/material.dart';

/// Expressive emphasis tweaks layered on top of baseline M3 type.
/// Keep line-height the same; only tune weight/letter-spacing for emphasis.
@immutable
class M3EEmphasized {
  final TextStyle display;
  final TextStyle headline;
  final TextStyle title;
  final TextStyle label;

  const M3EEmphasized({
    required this.display,
    required this.headline,
    required this.title,
    required this.label,
  });

  /// M3E guidance: slightly heavier weights and tighter tracking for large roles.
  static M3EEmphasized forBrightness(Brightness b) {
    // You could vary by brightness if desired; values below are neutral.
    return const M3EEmphasized(
      display: TextStyle(
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5, // subtle tightening on big sizes
      ),
      headline: TextStyle(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.25,
      ),
      title: TextStyle(
        fontWeight: FontWeight.w700,
      ),
      label: TextStyle(
        fontWeight: FontWeight.w700,
      ),
    );
  }

  static M3EEmphasized lerp(M3EEmphasized a, M3EEmphasized b, double t) =>
      M3EEmphasized(
        display: TextStyle.lerp(a.display, b.display, t)!,
        headline: TextStyle.lerp(a.headline, b.headline, t)!,
        title: TextStyle.lerp(a.title, b.title, t)!,
        label: TextStyle.lerp(a.label, b.label, t)!,
      );
}

/// Material 3 Expressive typography tokens.
/// - `base` starts from **M3 (Typography.material2021)**.
/// - Optionally remaps fonts: brand (UI) for display/headline/title/label
///   and plain (reading) for body.
/// - Adds an emphasized set (weight/tracking tweaks) for expressive hierarchy.
@immutable
class M3ETypography {
  final TextTheme base;
  final M3EEmphasized emphasized;

  const M3ETypography({required this.base, required this.emphasized});

  /// Build default M3E typography from M3.
  ///
  /// [brandFontFamily] is typically your UI/brand face (e.g., Roboto Flex).
  /// [plainFontFamily] is typically your reading face (e.g., Roboto Serif).
  /// If you pass neither, you’ll get pure M3 defaults (no family swap),
  /// but still keep the M3E emphasized set for optional use.
  factory M3ETypography.defaultFor(
    Brightness brightness, {
    String? brandFontFamily,
    String? plainFontFamily,
    TextTheme? baseOverride,
  }) {
    // 1) Start from Material 3 baseline type.
    final m3 = Typography.material2021();
    final TextTheme m3Base =
        baseOverride ?? (brightness == Brightness.dark ? m3.white : m3.black);

    // 2) Optionally map brand/plain families to role groups (M3E guidance).
    final TextTheme baseWithFamilies = _applyFamilies(
      m3Base,
      brand: brandFontFamily,
      plain: plainFontFamily,
    );

    // 3) Provide emphasized deltas (weights/tracking).
    return M3ETypography(
      base: baseWithFamilies,
      emphasized: M3EEmphasized.forBrightness(brightness),
    );
  }

  /// Lerp the full token set.
  static M3ETypography lerp(M3ETypography a, M3ETypography b, double t) =>
      M3ETypography(
        base: TextTheme.lerp(a.base, b.base, t),
        emphasized: M3EEmphasized.lerp(a.emphasized, b.emphasized, t),
      );

  /// Apply brand/plain families: brand → display/headline/title/label,
  /// plain → body. If a family is null, keep the original.
  static TextTheme _applyFamilies(
    TextTheme t, {
    String? brand,
    String? plain,
  }) {
    TextStyle? _withFam(TextStyle? s, String? fam) =>
        fam == null ? s : s?.copyWith(fontFamily: fam);

    return t.copyWith(
      // Brand / UI voice
      displayLarge: _withFam(t.displayLarge, brand),
      displayMedium: _withFam(t.displayMedium, brand),
      displaySmall: _withFam(t.displaySmall, brand),
      headlineLarge: _withFam(t.headlineLarge, brand),
      headlineMedium: _withFam(t.headlineMedium, brand),
      headlineSmall: _withFam(t.headlineSmall, brand),
      titleLarge: _withFam(t.titleLarge, brand),
      titleMedium: _withFam(t.titleMedium, brand),
      titleSmall: _withFam(t.titleSmall, brand),
      labelLarge: _withFam(t.labelLarge, brand),
      labelMedium: _withFam(t.labelMedium, brand),
      labelSmall: _withFam(t.labelSmall, brand),

      // Reading voice
      bodyLarge: _withFam(t.bodyLarge, plain),
      bodyMedium: _withFam(t.bodyMedium, plain),
      bodySmall: _withFam(t.bodySmall, plain),
    );
  }
}

@immutable
class ButtonFontSize {
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;

  const ButtonFontSize({
    this.xs = 14,
    this.sm = 14,
    this.md = 16,
    this.lg = 20,
    this.xl = 24,
  });
}

extension M3EButtonFontSizeExt on M3ETypography {
  ButtonFontSize get buttonFontSize => const ButtonFontSize();
}
