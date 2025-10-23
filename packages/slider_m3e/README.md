# slider_m3e

Material 3 **Expressive** Sliders for Flutter. Single-value and range sliders, with token-driven colors, sizes, and shapes.

- `SliderM3E` — single-value slider, optional start/end icons, discrete or continuous
- `RangeSliderM3E` — range selection with the same styling
- `sliderThemeM3E(...)` — generate a `SliderThemeData` from **M3E** tokens

All styling reads the `M3ETheme` ThemeExtension from your `m3e_design` package.

## Monorepo Layout

```
packages/
  m3e_design/
  slider_m3e/
```

`pubspec.yaml` references `../m3e_design`.

## Usage

```dart
import 'package:slider_m3e/slider_m3e.dart';

// Single slider
SliderM3E(
  value: 0.35,
  onChanged: (v) {},
  divisions: 10, // discrete
  size: SliderM3ESize.large,
  emphasis: SliderM3EEmphasis.primary,
  shapeFamily: SliderM3EShapeFamily.round, // or square (expressive)
  startIcon: const Icon(Icons.volume_mute),
  endIcon: const Icon(Icons.volume_up),
);

// Range slider
RangeSliderM3E(
  values: const RangeValues(0.2, 0.8),
  onChanged: (r) {},
  divisions: 8,
  size: SliderM3ESize.medium,
  emphasis: SliderM3EEmphasis.secondary,
  shapeFamily: SliderM3EShapeFamily.square,
);
```

## Tokens mapping

- **Colors:**
  - Active: `primary` / `secondary` / `onSurface` (by emphasis)
  - Inactive track: `onSurface` @ 24% opacity
  - Overlay: active color @ 12% opacity
  - Value indicator: `secondaryContainer` with `onSecondaryContainer` text
- **Sizes:**
  - Track height: small **≈2dp**, medium **≈4dp**, large **≈6dp**
  - Thumb radius: small **≈10dp**, medium **≈12dp**, large **≈14dp**
- **Density:** `compact` slightly reduces track and thumb sizes
- **Shapes:** `round` uses round thumb, `square` uses a rounded-rect thumb for an expressive look

## Accessibility

- Set `semanticLabel` to announce values (percentage format by default).
- Discrete sliders (with `divisions`) will show value indicators when `showValueIndicator` is enabled (or `onlyForDiscrete` by default).

## License

MIT


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
SliderM3E and RangeSliderM3E that follow Material 3 Expressive tokens for colors, shapes, and density.

### Installation
- Monorepo (local path): already configured alongside m3e_design.
- Pub (when published):
```yaml
dependencies:
  slider_m3e: ^0.1.0
  m3e_design: ^0.1.0
```

Minimum SDK: Dart >=3.5.0; Flutter >=3.22.0.

### Dependencies
- flutter
- m3e_design

### Quick start
```dart
// Single-value slider
SliderM3E(
  value: value,
  onChanged: (v) => setState(() => value = v),
  min: 0,
  max: 100,
  divisions: 10,
  label: '$value',
)

// Range slider
RangeSliderM3E(
  values: range,
  onChanged: (r) => setState(() => range = r),
  min: 0,
  max: 100,
)
```

### Key parameters
- value: double — Current slider value (SliderM3E).
- values: RangeValues — Current range (RangeSliderM3E).
- onChanged: ValueChanged<double/RangeValues> — Callback for value changes.
- min / max / divisions: Configure value domain and discrete steps.
- label: String? — Optional value label.
- activeColor / inactiveColor / thumbColor: Color? overrides.

### Theming with m3e_design
Track shape, thickness, and colors follow M3E tokens; respects density.

### Accessibility
- Ensure sufficient contrast; provide semantics via labels when necessary.

### Links
- Repository: https://github.com/EmilyMoonstone/material_3_expressive/tree/main/packages/slider_m3e
- Issue tracker: https://github.com/EmilyMonestone/material_3_expressive/issues
- Changelog: ./CHANGELOG.md
