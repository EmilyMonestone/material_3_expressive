# loading_indicator_m3e

Material 3 **Expressive** Loading Indicator for Flutter — a morphing polygon that continuously rotates and morphs between shapes (ported from Android's Material3 `LoadingIndicator`).

Two configurations:
- **Default** — container uses `secondaryContainer`, active indicator uses `primary`
- **Contained** — container uses `primaryContainer`, active indicator uses `onPrimaryContainer`

Token-aligned sizes:
- Container: **48 × 48dp**
- Active indicator size: **38dp**
- Container shape: **full** (pill/circular) corners

## Usage

```dart
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';

// Default
const LoadingIndicatorM3E();

// Contained
const LoadingIndicatorM3E(variant: LoadingIndicatorM3EVariant.contained);

// Custom colors, custom polygon sequence
LoadingIndicatorM3E(
  color: Colors.teal,
  polygons: const [
    MaterialShapes.sunny,
    MaterialShapes.cookie9Sided,
    MaterialShapes.pill,
  ],
);
```

## Notes
- The inner morph sequence and animation timings match the Compose implementation:
  - Morph interval ~650ms, global rotation ~4666ms
  - Active size is scaled to ~38dp inside the 48dp container to avoid clipping while rotating
- Requires your monorepo `m3e_design` (for tokens) and `material_new_shapes` (for `RoundedPolygon` + `Morph` + `MaterialShapes`). The `pubspec.yaml` is set up with `path: ../...`.

## Monorepo Layout

```
packages/
  m3e_design/
  material_new_shapes/
  loading_indicator_m3e/
```

## Accessibility
Pass `semanticLabel` and `semanticValue` to announce loading status if needed.

## License
- Android/Compose implementation © Google, Apache-2.0
- This package MIT


---

## Live demo (Gallery)

Explore this component in the M3E Gallery (GitHub Pages):

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
Morphing polygon LoadingIndicatorM3E with Default and Contained variants, aligned with Material 3 Expressive motion and color tokens.

### Installation
- Monorepo (local path): already configured alongside m3e_design.
- Pub (when published):
```yaml
dependencies:
  loading_indicator_m3e: ^0.1.0
  m3e_design: ^0.1.0
```

Minimum SDK: Dart >=3.5.0; Flutter >=3.22.0.

### Dependencies
- flutter
- m3e_design
- material_new_shapes

### Quick start
```dart
// Default (indeterminate)
const LoadingIndicatorM3E()

// Contained variant (e.g., inside a container)
const LoadingIndicatorContainedM3E(width: 48, height: 48)
```

### Key parameters
- size / width / height: dimensions of the indicator.
- color: Color? — Override the token-driven color.
- semanticsLabel: String? — Describe what is loading for screen readers.

### Theming with m3e_design
Colors and easing come from tokens in M3ETheme; motion aligns with Material 3 Expressive guidelines.

### Accessibility
- Provide semanticsLabel to announce loading; avoid infinite animations for long periods.

### Links
- Repository: https://github.com/EmilyMoonstone/material_3_expressive/tree/main/packages/loading_indicator_m3e
- Issue tracker: https://github.com/EmilyMonestone/material_3_expressive/issues
- Changelog: ./CHANGELOG.md
