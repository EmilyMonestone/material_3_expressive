# m3e_design

Design language core for Material 3 Expressive (Flutter).
Provides ThemeExtension and token accessors for color, typography, shapes, spacing, motion.


---

## Live demo (Gallery)

Explore the components using this design system in the M3E Gallery (GitHub Pages):

https://<your-github-username>.github.io/material_3_expressive/

To run the Gallery locally:

```sh
cd apps/gallery
flutter run -d chrome
```

_Last updated: 2025-10-23_


---

## Detailed Guide

### What this package provides
The design language core for Material 3 Expressive:
- M3ETheme ThemeExtension providing tokens for color, typography, shapes, spacing, elevation, and motion.
- Utilities to derive expressive surfaces (e.g., surfaceContainer levels) and harmonize with dynamic colors.

### Installation
```yaml
dependencies:
  m3e_design: ^0.1.0
  dynamic_color: ^1.8.1
```

Minimum SDK: Dart >=3.5.0.

### Quick start: add M3ETheme to ThemeData
```dart
final base = ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal));
final m3e = M3ETheme.defaults(base.colorScheme);

return MaterialApp(
  theme: base.copyWith(extensions: [m3e]),
  home: const MyHomePage(),
);
```

With dynamic color (Android 12+):
```dart
DynamicColorBuilder(
  builder: (lightDynamic, darkDynamic) {
    final scheme = lightDynamic ?? ColorScheme.fromSeed(seedColor: Colors.teal);
    final base = ThemeData(colorScheme: scheme);
    final m3e = M3ETheme.defaults(base.colorScheme);
    return MaterialApp(theme: base.copyWith(extensions: [m3e]), home: const MyHomePage());
  },
)
```

### Token overview
- Colors: surface, onSurface, container tiers, primary/secondary/tertiary, outline, inverse, etc.
- Typography: headline/title/label/body scales incl. emphasized variants.
- Shapes: round/square families, radii by size category.
- Spacing: xs→xl ramps for consistent paddings.
- Motion: durations/easings for expressive transitions.

### Used by
All sibling packages in this monorepo use M3E tokens for consistent UI.

### Links
- Repository: https://github.com/EmilyMoonstone/material_3_expressive/tree/main/packages/m3e_design
- Issue tracker: https://github.com/EmilyMonestone/material_3_expressive/issues
- Changelog: ./CHANGELOG.md
