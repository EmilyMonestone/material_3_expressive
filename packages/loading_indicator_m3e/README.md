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
