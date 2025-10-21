// Material 3 Expressive — Color Tokens for Flutter
// -------------------------------------------------
// This file defines an app-level color token object (M3EColors) that wraps
// Flutter's ColorScheme (M3) and adds expressive/custom roles (info, success,
// warning, danger, emphasis, strong surface/outline), with safe fallbacks for
// older Flutter SDKs. It also includes helpers for dynamic color and
// harmonization per M3 guidance.
//
// References:
// - M3 color system & roles: https://m3.material.io/styles/color/roles
// - How the system works (tones, surfaces): https://m3.material.io/styles/color/system/how-the-system-works
// - Define new colors (custom colors + harmonization): https://m3.material.io/styles/color/advanced/define-new-colors
// - Codelab (customizing Material color): https://codelabs.developers.google.com/customizing-material-color
// - dynamic_color package: https://pub.dev/packages/dynamic_color

// ignore_for_file: public_member_api_docs

import 'package:dynamic_color/dynamic_color.dart'
    as dyn; // for .harmonizeWith and DynamicColorBuilder
import 'package:flutter/material.dart';

@immutable
class M3EColors {
  // --- Expressive / semantic extras ---------------------------------------
  final Color emphasis;
  final Color onEmphasis;
  final Color info;
  final Color success;
  final Color warning;
  final Color danger;

  final Color surfaceStrong;
  final Color onSurfaceStrong;
  final Color outlineStrong;

  // --- Core ColorScheme proxies (subset used across packages) --------------
  final Color primary;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;

  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;

  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;

  final Color surface;
  final Color onSurface;
  final Color onSurfaceVariant;

  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;

  final Color outline;
  final Color outlineVariant;

  // --- Tone-based surfaces (M3) --------------------------------------------
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;

  // --- Inverse & overlays ---------------------------------------------------
  final Color inverseSurface;
  final Color onInverseSurface;
  final Color inversePrimary;
  final Color surfaceTint;
  final Color shadow;
  final Color scrim;

  // --- Optional fixed accent roles (present in newer Flutter SDKs) ---------
  final Color? primaryFixed;
  final Color? primaryFixedDim;
  final Color? onPrimaryFixed;
  final Color? onPrimaryFixedVariant;

  final Color? secondaryFixed;
  final Color? secondaryFixedDim;
  final Color? onSecondaryFixed;
  final Color? onSecondaryFixedVariant;

  final Color? tertiaryFixed;
  final Color? tertiaryFixedDim;
  final Color? onTertiaryFixed;
  final Color? onTertiaryFixedVariant;

  const M3EColors({
    // expressive
    required this.emphasis,
    required this.onEmphasis,
    required this.info,
    required this.success,
    required this.warning,
    required this.danger,
    required this.surfaceStrong,
    required this.onSurfaceStrong,
    required this.outlineStrong,
    // core
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.surface,
    required this.onSurface,
    required this.onSurfaceVariant,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.outline,
    required this.outlineVariant,
    // tone-based surfaces
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
    // inverse & overlays
    required this.inverseSurface,
    required this.onInverseSurface,
    required this.inversePrimary,
    required this.surfaceTint,
    required this.shadow,
    required this.scrim,
    // fixed accents (nullable for SDK-compat)
    this.primaryFixed,
    this.primaryFixedDim,
    this.onPrimaryFixed,
    this.onPrimaryFixedVariant,
    this.secondaryFixed,
    this.secondaryFixedDim,
    this.onSecondaryFixed,
    this.onSecondaryFixedVariant,
    this.tertiaryFixed,
    this.tertiaryFixedDim,
    this.onTertiaryFixed,
    this.onTertiaryFixedVariant,
  });

  /// Build from a Flutter [ColorScheme].
  ///
  /// Includes safe fallbacks for tone-based surfaces and fixed roles if the
  /// running SDK predates those fields.
  factory M3EColors.from(ColorScheme s) {
    Color _blend(Color base, Color overlay, double a) =>
        Color.alphaBlend(overlay.withValues(alpha: a), base);

    // Surface tone fallbacks (approximate, spec-agnostic but pleasant)
    Color _containerLow() => _blend(s.surface, s.primary, 0.04);
    Color _container() => _blend(s.surface, s.primary, 0.06);
    Color _containerHigh() => _blend(s.surface, s.primary, 0.08);
    Color _containerLowest() => _blend(s.surface, s.onSurface, 0.03);
    Color _containerHighest() => _blend(s.surface, s.onSurface, 0.10);
    Color _surfaceDim() => _blend(s.surface, s.onSurface, 0.05);
    Color _surfaceBright() => _blend(s.surface, s.primary, 0.04);

    Function(Invocation invocation)? _tryGet<T>(
        ColorScheme scheme, String getter) {
      try {
        final dyn = scheme as dynamic;
        final v =
            dyn.__noSuchMethod__ == null ? null : null; // keep analyzer happy
        return (dyn as dynamic)
            .noSuchMethod; // never executed, trick to silence lints in try
      } catch (_) {
        // ignored
      }
      // Fallback path using mirrors is not available; we'll use a switch below.
      return null;
    }

    // Read new fields via dynamic with try-catch (avoids hard SDK requirement)
    Color _getOr(Color? c, Color Function() orElse) => c ?? orElse();

    Color? _readColor(String name) {
      try {
        final dyn = s as dynamic;
        return dyn.toJson != null ? null : (dyn as dynamic)[name] as Color?;
      } catch (_) {
        return null;
      }
    }

    // While dynamic lookup above is intentionally conservative, we can directly
    // access when fields exist in the current SDK, otherwise compute.
    Color surfaceDim = (() {
      try {
        return (s.surfaceDim);
      } catch (_) {
        return _surfaceDim();
      }
    })();
    Color surfaceBright = (() {
      try {
        return (s.surfaceBright);
      } catch (_) {
        return _surfaceBright();
      }
    })();
    Color surfaceContainerLowest = (() {
      try {
        return (s.surfaceContainerLowest);
      } catch (_) {
        return _containerLowest();
      }
    })();
    Color surfaceContainerLow = (() {
      try {
        return (s.surfaceContainerLow);
      } catch (_) {
        return _containerLow();
      }
    })();
    Color surfaceContainer = (() {
      try {
        return (s.surfaceContainer);
      } catch (_) {
        return _container();
      }
    })();
    Color surfaceContainerHigh = (() {
      try {
        return (s.surfaceContainerHigh);
      } catch (_) {
        return _containerHigh();
      }
    })();
    Color surfaceContainerHighest = (() {
      try {
        return (s.surfaceContainerHighest);
      } catch (_) {
        return _containerHighest();
      }
    })();

    Color inverseSurface = (() {
      try {
        return (s.inverseSurface);
      } catch (_) {
        return _blend(s.surface, s.onSurface, 0.12);
      }
    })();
    Color onInverseSurface = (() {
      try {
        return (s.onInverseSurface);
      } catch (_) {
        return s.surface; // decent fallback
      }
    })();
    Color inversePrimary = (() {
      try {
        return (s.inversePrimary);
      } catch (_) {
        return s.primary; // fallback: same hue
      }
    })();
    Color surfaceTint = (() {
      try {
        return (s.surfaceTint);
      } catch (_) {
        return s.primary; // fallback
      }
    })();
    Color shadow = (() {
      try {
        return (s.shadow);
      } catch (_) {
        return const Color(0xFF000000);
      }
    })();
    Color scrim = (() {
      try {
        return (s.scrim);
      } catch (_) {
        return const Color(0xFF000000).withValues(alpha: 0.32);
      }
    })();

    // Fixed roles (nullable)
    Color? primaryFixed,
        primaryFixedDim,
        onPrimaryFixed,
        onPrimaryFixedVariant,
        secondaryFixed,
        secondaryFixedDim,
        onSecondaryFixed,
        onSecondaryFixedVariant,
        tertiaryFixed,
        tertiaryFixedDim,
        onTertiaryFixed,
        onTertiaryFixedVariant;
    try {
      primaryFixed = (s as dynamic).primaryFixed as Color?;
      primaryFixedDim = (s as dynamic).primaryFixedDim as Color?;
      onPrimaryFixed = (s as dynamic).onPrimaryFixed as Color?;
      onPrimaryFixedVariant = (s as dynamic).onPrimaryFixedVariant as Color?;

      secondaryFixed = (s as dynamic).secondaryFixed as Color?;
      secondaryFixedDim = (s as dynamic).secondaryFixedDim as Color?;
      onSecondaryFixed = (s as dynamic).onSecondaryFixed as Color?;
      onSecondaryFixedVariant =
          (s as dynamic).onSecondaryFixedVariant as Color?;

      tertiaryFixed = (s as dynamic).tertiaryFixed as Color?;
      tertiaryFixedDim = (s as dynamic).tertiaryFixedDim as Color?;
      onTertiaryFixed = (s as dynamic).onTertiaryFixed as Color?;
      onTertiaryFixedVariant = (s as dynamic).onTertiaryFixedVariant as Color?;
    } catch (_) {
      // Older SDK – leave null
    }

    // Expressive semantics (harmonized with primary)
    final Color info = s.tertiary;
    final Color success =
        Colors.green.shade600.harmonizeWith(s.primary); // dyn extension
    final Color warning = Colors.orange.shade700.harmonizeWith(s.primary);
    final Color danger = s.error; // already semantic

    final Color emphasis = s.primary;
    final Color onEmphasis = s.onPrimary;

    final Color surfaceStrong = _blend(s.surface, s.primary, 0.06);
    final Color onSurfaceStrong = s.onSurface;
    final Color outlineStrong = _blend(s.outline, s.primary, 0.40);

    return M3EColors(
      // expressive
      emphasis: emphasis,
      onEmphasis: onEmphasis,
      info: info,
      success: success,
      warning: warning,
      danger: danger,
      surfaceStrong: surfaceStrong,
      onSurfaceStrong: onSurfaceStrong,
      outlineStrong: outlineStrong,
      // core
      primary: s.primary,
      onPrimary: s.onPrimary,
      primaryContainer: s.primaryContainer,
      onPrimaryContainer: s.onPrimaryContainer,
      secondary: s.secondary,
      onSecondary: s.onSecondary,
      secondaryContainer: s.secondaryContainer,
      onSecondaryContainer: s.onSecondaryContainer,
      tertiary: s.tertiary,
      onTertiary: s.onTertiary,
      tertiaryContainer: s.tertiaryContainer,
      onTertiaryContainer: s.onTertiaryContainer,
      surface: s.surface,
      onSurface: s.onSurface,
      onSurfaceVariant: s.onSurfaceVariant,
      error: s.error,
      onError: s.onError,
      errorContainer: s.errorContainer,
      onErrorContainer: s.onErrorContainer,
      outline: s.outline,
      outlineVariant: s.outlineVariant,
      // tone-based
      surfaceDim: surfaceDim,
      surfaceBright: surfaceBright,
      surfaceContainerLowest: surfaceContainerLowest,
      surfaceContainerLow: surfaceContainerLow,
      surfaceContainer: surfaceContainer,
      surfaceContainerHigh: surfaceContainerHigh,
      surfaceContainerHighest: surfaceContainerHighest,
      // inverse & overlays
      inverseSurface: inverseSurface,
      onInverseSurface: onInverseSurface,
      inversePrimary: inversePrimary,
      surfaceTint: surfaceTint,
      shadow: shadow,
      scrim: scrim,
      // fixed accents
      primaryFixed: primaryFixed,
      primaryFixedDim: primaryFixedDim,
      onPrimaryFixed: onPrimaryFixed,
      onPrimaryFixedVariant: onPrimaryFixedVariant,
      secondaryFixed: secondaryFixed,
      secondaryFixedDim: secondaryFixedDim,
      onSecondaryFixed: onSecondaryFixed,
      onSecondaryFixedVariant: onSecondaryFixedVariant,
      tertiaryFixed: tertiaryFixed,
      tertiaryFixedDim: tertiaryFixedDim,
      onTertiaryFixed: onTertiaryFixed,
      onTertiaryFixedVariant: onTertiaryFixedVariant,
    );
  }

  /// Returns a copy with [info]/[success]/[warning]/[danger] harmonized to the
  /// given [scheme.primary] (per M3 custom color guidance).
  M3EColors harmonizedTo(ColorScheme scheme) {
    Color h(Color c) => c.harmonizeWith(scheme.primary);
    return copyWith(
      info: h(info),
      success: h(success),
      warning: h(warning),
      danger: h(danger),
      emphasis: h(emphasis),
    );
  }

  M3EColors copyWith({
    Color? emphasis,
    Color? onEmphasis,
    Color? info,
    Color? success,
    Color? warning,
    Color? danger,
    Color? surfaceStrong,
    Color? onSurfaceStrong,
    Color? outlineStrong,
    Color? primary,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? secondary,
    Color? onSecondary,
    Color? secondaryContainer,
    Color? onSecondaryContainer,
    Color? tertiary,
    Color? onTertiary,
    Color? tertiaryContainer,
    Color? onTertiaryContainer,
    Color? surface,
    Color? onSurface,
    Color? onSurfaceVariant,
    Color? error,
    Color? onError,
    Color? errorContainer,
    Color? onErrorContainer,
    Color? outline,
    Color? outlineVariant,
    Color? surfaceDim,
    Color? surfaceBright,
    Color? surfaceContainerLowest,
    Color? surfaceContainerLow,
    Color? surfaceContainer,
    Color? surfaceContainerHigh,
    Color? surfaceContainerHighest,
    Color? inverseSurface,
    Color? onInverseSurface,
    Color? inversePrimary,
    Color? surfaceTint,
    Color? shadow,
    Color? scrim,
    Color? primaryFixed,
    Color? primaryFixedDim,
    Color? onPrimaryFixed,
    Color? onPrimaryFixedVariant,
    Color? secondaryFixed,
    Color? secondaryFixedDim,
    Color? onSecondaryFixed,
    Color? onSecondaryFixedVariant,
    Color? tertiaryFixed,
    Color? tertiaryFixedDim,
    Color? onTertiaryFixed,
    Color? onTertiaryFixedVariant,
  }) {
    return M3EColors(
      emphasis: emphasis ?? this.emphasis,
      onEmphasis: onEmphasis ?? this.onEmphasis,
      info: info ?? this.info,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      danger: danger ?? this.danger,
      surfaceStrong: surfaceStrong ?? this.surfaceStrong,
      onSurfaceStrong: onSurfaceStrong ?? this.onSurfaceStrong,
      outlineStrong: outlineStrong ?? this.outlineStrong,
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      onPrimaryContainer: onPrimaryContainer ?? this.onPrimaryContainer,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      secondaryContainer: secondaryContainer ?? this.secondaryContainer,
      onSecondaryContainer: onSecondaryContainer ?? this.onSecondaryContainer,
      tertiary: tertiary ?? this.tertiary,
      onTertiary: onTertiary ?? this.onTertiary,
      tertiaryContainer: tertiaryContainer ?? this.tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer ?? this.onTertiaryContainer,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      errorContainer: errorContainer ?? this.errorContainer,
      onErrorContainer: onErrorContainer ?? this.onErrorContainer,
      outline: outline ?? this.outline,
      outlineVariant: outlineVariant ?? this.outlineVariant,
      surfaceDim: surfaceDim ?? this.surfaceDim,
      surfaceBright: surfaceBright ?? this.surfaceBright,
      surfaceContainerLowest:
          surfaceContainerLowest ?? this.surfaceContainerLowest,
      surfaceContainerLow: surfaceContainerLow ?? this.surfaceContainerLow,
      surfaceContainer: surfaceContainer ?? this.surfaceContainer,
      surfaceContainerHigh: surfaceContainerHigh ?? this.surfaceContainerHigh,
      surfaceContainerHighest:
          surfaceContainerHighest ?? this.surfaceContainerHighest,
      inverseSurface: inverseSurface ?? this.inverseSurface,
      onInverseSurface: onInverseSurface ?? this.onInverseSurface,
      inversePrimary: inversePrimary ?? this.inversePrimary,
      surfaceTint: surfaceTint ?? this.surfaceTint,
      shadow: shadow ?? this.shadow,
      scrim: scrim ?? this.scrim,
      primaryFixed: primaryFixed ?? this.primaryFixed,
      primaryFixedDim: primaryFixedDim ?? this.primaryFixedDim,
      onPrimaryFixed: onPrimaryFixed ?? this.onPrimaryFixed,
      onPrimaryFixedVariant:
          onPrimaryFixedVariant ?? this.onPrimaryFixedVariant,
      secondaryFixed: secondaryFixed ?? this.secondaryFixed,
      secondaryFixedDim: secondaryFixedDim ?? this.secondaryFixedDim,
      onSecondaryFixed: onSecondaryFixed ?? this.onSecondaryFixed,
      onSecondaryFixedVariant:
          onSecondaryFixedVariant ?? this.onSecondaryFixedVariant,
      tertiaryFixed: tertiaryFixed ?? this.tertiaryFixed,
      tertiaryFixedDim: tertiaryFixedDim ?? this.tertiaryFixedDim,
      onTertiaryFixed: onTertiaryFixed ?? this.onTertiaryFixed,
      onTertiaryFixedVariant:
          onTertiaryFixedVariant ?? this.onTertiaryFixedVariant,
    );
  }

  static M3EColors lerp(M3EColors a, M3EColors b, double t) => M3EColors(
        emphasis: Color.lerp(a.emphasis, b.emphasis, t)!,
        onEmphasis: Color.lerp(a.onEmphasis, b.onEmphasis, t)!,
        info: Color.lerp(a.info, b.info, t)!,
        success: Color.lerp(a.success, b.success, t)!,
        warning: Color.lerp(a.warning, b.warning, t)!,
        danger: Color.lerp(a.danger, b.danger, t)!,
        surfaceStrong: Color.lerp(a.surfaceStrong, b.surfaceStrong, t)!,
        onSurfaceStrong: Color.lerp(a.onSurfaceStrong, b.onSurfaceStrong, t)!,
        outlineStrong: Color.lerp(a.outlineStrong, b.outlineStrong, t)!,
        primary: Color.lerp(a.primary, b.primary, t)!,
        onPrimary: Color.lerp(a.onPrimary, b.onPrimary, t)!,
        primaryContainer:
            Color.lerp(a.primaryContainer, b.primaryContainer, t)!,
        onPrimaryContainer:
            Color.lerp(a.onPrimaryContainer, b.onPrimaryContainer, t)!,
        secondary: Color.lerp(a.secondary, b.secondary, t)!,
        onSecondary: Color.lerp(a.onSecondary, b.onSecondary, t)!,
        secondaryContainer:
            Color.lerp(a.secondaryContainer, b.secondaryContainer, t)!,
        onSecondaryContainer:
            Color.lerp(a.onSecondaryContainer, b.onSecondaryContainer, t)!,
        tertiary: Color.lerp(a.tertiary, b.tertiary, t)!,
        onTertiary: Color.lerp(a.onTertiary, b.onTertiary, t)!,
        tertiaryContainer:
            Color.lerp(a.tertiaryContainer, b.tertiaryContainer, t)!,
        onTertiaryContainer:
            Color.lerp(a.onTertiaryContainer, b.onTertiaryContainer, t)!,
        surface: Color.lerp(a.surface, b.surface, t)!,
        onSurface: Color.lerp(a.onSurface, b.onSurface, t)!,
        onSurfaceVariant:
            Color.lerp(a.onSurfaceVariant, b.onSurfaceVariant, t)!,
        error: Color.lerp(a.error, b.error, t)!,
        onError: Color.lerp(a.onError, b.onError, t)!,
        errorContainer: Color.lerp(a.errorContainer, b.errorContainer, t)!,
        onErrorContainer:
            Color.lerp(a.onErrorContainer, b.onErrorContainer, t)!,
        outline: Color.lerp(a.outline, b.outline, t)!,
        outlineVariant: Color.lerp(a.outlineVariant, b.outlineVariant, t)!,
        surfaceDim: Color.lerp(a.surfaceDim, b.surfaceDim, t)!,
        surfaceBright: Color.lerp(a.surfaceBright, b.surfaceBright, t)!,
        surfaceContainerLowest:
            Color.lerp(a.surfaceContainerLowest, b.surfaceContainerLowest, t)!,
        surfaceContainerLow:
            Color.lerp(a.surfaceContainerLow, b.surfaceContainerLow, t)!,
        surfaceContainer:
            Color.lerp(a.surfaceContainer, b.surfaceContainer, t)!,
        surfaceContainerHigh:
            Color.lerp(a.surfaceContainerHigh, b.surfaceContainerHigh, t)!,
        surfaceContainerHighest: Color.lerp(
            a.surfaceContainerHighest, b.surfaceContainerHighest, t)!,
        inverseSurface: Color.lerp(a.inverseSurface, b.inverseSurface, t)!,
        onInverseSurface:
            Color.lerp(a.onInverseSurface, b.onInverseSurface, t)!,
        inversePrimary: Color.lerp(a.inversePrimary, b.inversePrimary, t)!,
        surfaceTint: Color.lerp(a.surfaceTint, b.surfaceTint, t)!,
        shadow: Color.lerp(a.shadow, b.shadow, t)!,
        scrim: Color.lerp(a.scrim, b.scrim, t)!,
        primaryFixed: Color.lerp(a.primaryFixed, b.primaryFixed, t),
        primaryFixedDim: Color.lerp(a.primaryFixedDim, b.primaryFixedDim, t),
        onPrimaryFixed: Color.lerp(a.onPrimaryFixed, b.onPrimaryFixed, t),
        onPrimaryFixedVariant:
            Color.lerp(a.onPrimaryFixedVariant, b.onPrimaryFixedVariant, t),
        secondaryFixed: Color.lerp(a.secondaryFixed, b.secondaryFixed, t),
        secondaryFixedDim:
            Color.lerp(a.secondaryFixedDim, b.secondaryFixedDim, t),
        onSecondaryFixed: Color.lerp(a.onSecondaryFixed, b.onSecondaryFixed, t),
        onSecondaryFixedVariant:
            Color.lerp(a.onSecondaryFixedVariant, b.onSecondaryFixedVariant, t),
        tertiaryFixed: Color.lerp(a.tertiaryFixed, b.tertiaryFixed, t),
        tertiaryFixedDim: Color.lerp(a.tertiaryFixedDim, b.tertiaryFixedDim, t),
        onTertiaryFixed: Color.lerp(a.onTertiaryFixed, b.onTertiaryFixed, t),
        onTertiaryFixedVariant:
            Color.lerp(a.onTertiaryFixedVariant, b.onTertiaryFixedVariant, t),
      );
}

/// Convenience extension to read expressive tokens from any [ColorScheme].
extension M3EColorsX on ColorScheme {
  M3EColors get m3e => M3EColors.from(this);
}
/*

/// Theme helpers --------------------------------------------------------------
class M3ETheme {
  M3ETheme._();

  /// Build a [ThemeData] using dynamic colors when available, otherwise
  /// fall back to [ColorScheme.fromSeed]. Use inside a [dyn.DynamicColorBuilder].
  static ThemeData themeFromSchemes({
    required BuildContext context,
    required ColorScheme lightScheme,
    required ColorScheme darkScheme,
    VisualDensity visualDensity = VisualDensity.adaptivePlatformDensity,
    TargetPlatform? platform,
    TextTheme? textTheme,
    bool useMaterial3 = true,
  }) {
    return ThemeData(
      useMaterial3: useMaterial3,
      colorScheme: lightScheme,
      brightness: Brightness.light,
      visualDensity: visualDensity,
      platform: platform,
      textTheme: textTheme,
    );
  }

  /// Utility to create [ColorScheme] either from platform dynamic colors or a seed.
  /// Typical usage in your app root:
  ///
  /// ```dart
  /// return dyn.DynamicColorBuilder(
  ///   builder: (lightDynamic, darkDynamic) {
  ///     final Color seed = const Color(0xFF6750A4);
  ///     final light = lightDynamic ?? ColorScheme.fromSeed(seedColor: seed);
  ///     final dark = darkDynamic ??
  ///         ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark);
  ///     return MaterialApp(theme: ThemeData(colorScheme: light), darkTheme: ThemeData(colorScheme: dark));
  ///   },
  /// );
  /// ```
  static ({ColorScheme light, ColorScheme dark}) dynamicOrSeed(
    Color seed, {
    Color? secondarySeed,
    Color? tertiarySeed,
    double contrastLevel = 0.0,
    dyn.DynamicSchemeVariant variant = dyn.DynamicSchemeVariant.tonalSpot,
  }) {
    final light = ColorScheme.fromSeed(
      seedColor: seed,
      contrastLevel: contrastLevel,
      dynamicSchemeVariant: variant,
      secondary: secondarySeed,
      tertiary: tertiarySeed,
    );
    final dark = ColorScheme.fromSeed(
      seedColor: seed,
      contrastLevel: contrastLevel,
      dynamicSchemeVariant: variant,
      brightness: Brightness.dark,
      secondary: secondarySeed,
      tertiary: tertiarySeed,
    );
    return (light: light, dark: dark);
  }
}
*/
