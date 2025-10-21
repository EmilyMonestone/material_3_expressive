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
