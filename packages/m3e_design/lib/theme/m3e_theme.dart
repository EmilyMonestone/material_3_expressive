import 'package:flutter/material.dart';

import '../tokens/color_tokens.dart';
import '../tokens/motion_tokens.dart';
import '../tokens/shape_tokens.dart';
import '../tokens/spacing_tokens.dart';
import '../tokens/typography_tokens.dart';

@immutable
class M3ETheme extends ThemeExtension<M3ETheme> {
  final M3EColors colors;
  final M3ETypography typography;
  final M3EShapes shapes;
  final M3ESpacing spacing;
  final M3EMotion motion;

  const M3ETheme({
    required this.colors,
    required this.typography,
    required this.shapes,
    required this.spacing,
    required this.motion,
  });

  // Convenience proxy for commonly used text styles in packages (m3e.type.*)
  _M3ETypeProxy get type => _M3ETypeProxy(typography);

  static M3ETheme defaults(ColorScheme scheme) => M3ETheme(
        colors: M3EColors.from(scheme),
        typography: M3ETypography.defaultFor(scheme.brightness),
        shapes: M3EShapes.expressive(),
        spacing: const M3ESpacing.regular(),
        motion: const M3EMotion.expressive(),
      );

  @override
  M3ETheme copyWith({
    M3EColors? colors,
    M3ETypography? typography,
    M3EShapes? shapes,
    M3ESpacing? spacing,
    M3EMotion? motion,
  }) =>
      M3ETheme(
        colors: colors ?? this.colors,
        typography: typography ?? this.typography,
        shapes: shapes ?? this.shapes,
        spacing: spacing ?? this.spacing,
        motion: motion ?? this.motion,
      );

  @override
  M3ETheme lerp(covariant M3ETheme? other, double t) {
    if (other == null) return this;
    return M3ETheme(
      colors: M3EColors.lerp(colors, other.colors, t),
      typography: M3ETypography.lerp(typography, other.typography, t),
      shapes: M3EShapes.lerp(shapes, other.shapes, t),
      spacing: M3ESpacing.lerp(spacing, other.spacing, t),
      motion: M3EMotion.lerp(motion, other.motion, t),
    );
  }
}

/// Inject (or replace) the M3ETheme extension on a ThemeData.
ThemeData withM3ETheme(ThemeData base, {M3ETheme? override}) {
  // Use any existing M3ETheme, else the provided override, else defaults.
  final current = base.extension<M3ETheme>();
  final next = override ?? current ?? M3ETheme.defaults(base.colorScheme);

  // Merge existing extensions (values) with our M3ETheme, replacing prior ones.
  final Iterable<ThemeExtension<dynamic>> existing = base.extensions.values;
  final List<ThemeExtension<dynamic>> merged = <ThemeExtension<dynamic>>[];
  for (final e in existing) {
    if (e is! M3ETheme) {
      merged.add(e);
    }
  }
  merged.add(next);

  return base.copyWith(extensions: merged);
}

// Internal proxy for typography shortcuts used by components.
class _M3ETypeProxy {
  const _M3ETypeProxy(this._t);
  final M3ETypography _t;

  TextStyle get _empty => const TextStyle();
  TextStyle get titleLarge => _t.base.titleLarge ?? _empty;
  TextStyle get titleSmall => _t.base.titleSmall ?? _empty;
  TextStyle get bodySmall => _t.base.bodySmall ?? _empty;
  TextStyle get labelLarge => _t.base.labelLarge ?? _empty;
  TextStyle get labelMedium => _t.base.labelMedium ?? _empty;
  TextStyle get labelSmall => _t.base.labelSmall ?? _empty;

  TextStyle get headlineSmallEmphasized =>
      (_t.base.headlineSmall ?? _empty).merge(_t.emphasized.headline);
}

// Accessors for getting the M3E theme from ThemeData via Theme.of(context).m3e
extension M3EThemeAccessors on ThemeData {
  // Returns the installed M3ETheme; in release builds falls back to defaults
  M3ETheme get m3e {
    final e = extension<M3ETheme>();
    assert(
      e != null,
      'M3ETheme is not installed on ThemeData. Wrap your app theme with withM3ETheme(...)',
    );
    return e ?? M3ETheme.defaults(colorScheme);
  }
}
