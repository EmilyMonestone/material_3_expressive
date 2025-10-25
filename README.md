# Material 3 Expressive – Flutter Monorepo (Starter)

This is a starter monorepo for **Material 3 Expressive (M3E)** Flutter packages.

- `packages/m3e_design` – design language core (tokens, ThemeExtension, motion)
- `packages/m3e_collection` – re-exports all component packages
- `packages/icon_button_m3e` – example component
- `packages/split_button_m3e` – example split button component
- `packages/app_bar_m3e`
- `packages/button_group_m3e`
- `packages/button_m3e`
- `packages/fab_m3e`
- `packages/loading_indicator_m3e`
- `packages/navigation_rail_m3e`
- `packages/navigation_bar_m3e`
- `packages/progress_indicator_m3e`
- `packages/slider_m3e`
- `packages/toolbar_m3e`
- `apps/gallery` – showcase app that consumes `m3e_collection`

## Quick start

```bash
dart pub global activate melos
melos bootstrap

# run the gallery
cd apps/gallery
flutter run
```

## Structure

See `melos.yaml`, `analysis_options.yaml`, and the package-level READMEs.

## Using the M3E Theme

The design tokens and helpers live in the `m3e_design` package. Import it once in files where you access the theme:

```dart
import 'package:m3e_design/m3e_design.dart';
```

- Install the theme once at the app level (one-liner):

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ColorScheme.fromSeed(seedColor: Colors.teal).toM3EThemeData(),
      home: const MyHomePage(),
    );
  }
}
```

- With dynamic color (Android 12+), setting both light and dark themes:

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

- Access M3E tokens anywhere using the new ThemeData accessor:

```dart
final m3e = Theme.of(context).m3e; // ThemeData extension

// Examples
final br = m3e.shapes.round.sm;                 // BorderRadius
final pad = EdgeInsets.all(m3e.spacing.md);      // Spacing scale
final bg = m3e.colors.surfaceContainerHigh;      // Colors mapped to ColorScheme
final curve = m3e.motion.emphasized;             // Motion/curves
final title = m3e.typography.base.titleLarge;    // Typography
```

- Apply a rounded shape to a widget:

```dart
Widget roundedExample(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: Theme.of(context).m3e.shapes.round.sm,
    ),
  );
}
```

- Optional context sugar if you prefer:

```dart
// Provided by BuildContext extension in m3e_design
final m3e = context.m3e;
```

Notes:
- In debug, accessing `Theme.of(context).m3e` asserts if the extension isn't installed, helping catch setup issues.
- In release, it safely falls back to sensible defaults derived from the active `ColorScheme`.

---

## Live demo (Gallery)

A web demo of the M3E components is published via GitHub Pages using the provided workflow in `.github/workflows/deploy-gallery-pages.yml`.

Open: https://emilymoonstone.github.io/material_3_expressive/

To run locally:

```sh
cd apps/gallery
flutter run -d chrome
```

_Last updated: 2025-10-25_
