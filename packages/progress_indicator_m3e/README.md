# progress_indicators_m3e

Material 3 **Expressive** progress indicators for Flutter:

- `LinearProgressM3E` — determinate, indeterminate, **buffer**, **query**, with **flat** or **wavy** shape
- `CircularProgressM3E` — determinate & indeterminate, **flat** or **wavy** stroke (animated for indeterminate)
- `ProgressWithLabelM3E` — compose a linear bar with inline/top/bottom/center labels

All widgets read **M3E tokens** (`m3e_design`) for color, sizing, and typography.

## Defaults (from the spec illustrations)

- Linear: default thickness 4dp; configurable via `size` or `strokeHeight`
- Linear (wavy): `wavelength=40dp`, `amplitude≈height/3`, **4dp** left/right inset
- Circular: small/medium/large diameters ≈ 24/32/48 with stroke ≈ 3/4/6
- Circular (wavy): default **10 waves** around the circle, amplitude ≈ 35% of stroke

## Quick start

```dart
import 'package:progress_indicators_m3e/progress_indicators_m3e.dart';

// Linear (wavy, determinate)
LinearProgressM3E(
  value: 0.62,
  shape: LinearBarShapeM3E.wavy,
);

// Circular (wavy, indeterminate)
const CircularProgressM3E(
  shape: CircularBarShapeM3E.wavy,
);

// Linear (buffer) flat
LinearProgressM3E(
  variant: LinearProgressM3EVariant.buffer,
  value: 0.3,
  bufferValue: 0.6,
);

// Circular (flat) with center label
CircularProgressM3E(
  value: 0.5,
  showCenterLabel: true,
);
```

## Monorepo layout

```
packages/
  m3e_design/
  progress_indicators_m3e/
```

`pubspec.yaml` references `../m3e_design`.

## Accessibility

- Provide `semanticLabel` and (for determinate) the widgets expose a numeric **value** for screen readers.
- Indeterminate wavy animations use modest motion; gate the speed with a future `m3e_design.motion` flag if you support "reduce motion".

## License

MIT
