import 'package:flutter/material.dart';

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

  static M3EEmphasized forBrightness(Brightness b) {
    return const M3EEmphasized(
      display: TextStyle(fontWeight: FontWeight.w800, letterSpacing: -0.5),
      headline: TextStyle(fontWeight: FontWeight.w700, letterSpacing: -0.25),
      title: TextStyle(fontWeight: FontWeight.w700),
      label: TextStyle(fontWeight: FontWeight.w700),
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

@immutable
class M3ETypography {
  final TextTheme base;
  final M3EEmphasized emphasized;

  const M3ETypography({required this.base, required this.emphasized});

  factory M3ETypography.defaultFor(Brightness b) {
    // Use a minimal baseline; app's ThemeData will provide fuller TextTheme.
    const textTheme = TextTheme();
    return M3ETypography(
        base: textTheme, emphasized: M3EEmphasized.forBrightness(b));
  }

  static M3ETypography lerp(M3ETypography a, M3ETypography b, double t) =>
      M3ETypography(
        base: TextTheme.lerp(a.base, b.base, t),
        emphasized: M3EEmphasized.lerp(a.emphasized, b.emphasized, t),
      );
}
