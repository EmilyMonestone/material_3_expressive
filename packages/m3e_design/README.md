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

_Last updated: 2025-10-25_


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

### Quick start: one-liner theme
```dart
Widget buildApp() {
  return MaterialApp(
    theme: ColorScheme.fromSeed(seedColor: Colors.teal).toM3EThemeData(),
    home: const MyHomePage(),
  );
}
```

With dynamic color (Android 12+), setting both light and dark themes:
```dart
Widget buildDynamicApp() {
  return DynamicColorBuilder(
    builder: (lightDynamic, darkDynamic) {
      final light = lightDynamic ?? ColorScheme.fromSeed(seedColor: Colors.teal);
      final dark = darkDynamic ??
          ColorScheme.fromSeed(seedColor: Colors.teal, brightness: Brightness.dark);
      return MaterialApp(
        theme: light.toM3EThemeData(),
        darkTheme: dark.toM3EThemeData(),
        home: const MyHomePage(),
      );
    },
  );
}
```

### Alternative approach: withM3ETheme
The alternative approach is to use the withM3ETheme ThemeExtension, which is a convenience wrapper around the ThemeData constructor.
``` dart
Widget build(BuildContext context) {
  return MaterialApp(
    theme: withM3ETheme(
      ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
    ),
    home: const MyHomePage(),
    );
}
```

``` dart
Widget build(BuildContext context) {
      child: DynamicColorBuilder(
        builder: (lightDynamic, darkDynamic) {
          return MaterialApp(
            theme: withM3ETheme(
              ThemeData(
                colorScheme: lightDynamic ?? App._defaultLightColorScheme,
                useMaterial3: true,
              ),
            ),
            darkTheme: withM3ETheme(
              ThemeData(
                colorScheme: darkDynamic ?? App._defaultDarkColorScheme,
                useMaterial3: true,
                brightness: Brightness.dark,
              ),
            ),
            home: const MyHomePage(),
          );
        },
      ),
    }   
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
