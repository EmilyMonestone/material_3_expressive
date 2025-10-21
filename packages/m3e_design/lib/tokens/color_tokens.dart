import 'package:flutter/material.dart';

@immutable
class M3EColors {
  final Color emphasis;
  final Color onEmphasis;
  final Color info;
  final Color success;
  final Color warning;
  final Color danger;

  final Color surfaceStrong;
  final Color onSurfaceStrong;
  final Color outlineStrong;

  // New: proxy common ColorScheme fields used across packages
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

  // New: container surface tokens not always present on older ColorScheme
  final Color surfaceContainerHigh;
  final Color surfaceContainerLowest;

  const M3EColors({
    required this.emphasis,
    required this.onEmphasis,
    required this.info,
    required this.success,
    required this.warning,
    required this.danger,
    required this.surfaceStrong,
    required this.onSurfaceStrong,
    required this.outlineStrong,
    // New fields
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
    required this.surfaceContainerHigh,
    required this.surfaceContainerLowest,
  });

  factory M3EColors.from(ColorScheme s) {
    // Compute container surface variants if not available on the ColorScheme version in use.
    // We prefer mild blends that work in both light/dark.
    Color computeSurfaceContainerHigh() =>
        Color.alphaBlend(s.primary.withValues(alpha: 0.12), s.surface);
    Color computeSurfaceContainerLowest() =>
        Color.alphaBlend(s.onSurface.withValues(alpha: 0.05), s.surface);

    return M3EColors(
      emphasis: s.primary,
      onEmphasis: s.onPrimary,
      info: s.tertiary,
      success: Color.alphaBlend(
          Colors.green.shade400.withValues(alpha: 0.2), s.primaryContainer),
      warning: Color.alphaBlend(
          Colors.orange.shade400.withValues(alpha: 0.2), s.secondaryContainer),
      danger: Color.alphaBlend(
          Colors.red.shade400.withValues(alpha: 0.2), s.errorContainer),
      surfaceStrong:
          Color.alphaBlend(s.primary.withValues(alpha: 0.06), s.surface),
      onSurfaceStrong: s.onSurface,
      outlineStrong:
          Color.alphaBlend(s.primary.withValues(alpha: 0.40), s.outlineVariant),
      // New fields mapped from ColorScheme
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
      surfaceContainerHigh: (() {
        // If the ColorScheme already has a matching field, prefer that via dynamic access; otherwise compute.
        try {
          final dynamic dyn = s;
          final c = dyn.surfaceContainerHigh as Color?;
          return c ?? computeSurfaceContainerHigh();
        } catch (_) {
          return computeSurfaceContainerHigh();
        }
      })(),
      surfaceContainerLowest: (() {
        try {
          final dynamic dyn = s;
          final c = dyn.surfaceContainerLowest as Color?;
          return c ?? computeSurfaceContainerLowest();
        } catch (_) {
          return computeSurfaceContainerLowest();
        }
      })(),
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
        // New fields
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
        surfaceContainerHigh:
            Color.lerp(a.surfaceContainerHigh, b.surfaceContainerHigh, t)!,
        surfaceContainerLowest:
            Color.lerp(a.surfaceContainerLowest, b.surfaceContainerLowest, t)!,
      );
}
