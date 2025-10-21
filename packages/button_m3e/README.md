# button_m3e

Material 3 **Expressive** Buttons for Flutter, built on top of Flutter's buttons but styled via **M3E** tokens.

Variants: **filled**, **tonal**, **outlined**, **text**, **elevated**  
Sizes: **small**, **medium**, **large**  
Shape families: **round**, **square**  
Density: **regular**, **compact**

> Depends on `m3e_design` (ThemeExtension with colors/typography/spacing/shapes).

## Monorepo Layout

```
packages/
  m3e_design/
  button_m3e/
```

In `pubspec.yaml` this package references `../m3e_design`.

## Usage

```dart
import 'package:button_m3e/button_m3e.dart';

ButtonM3E(
  variant: ButtonM3EVariant.filled,
  size: ButtonM3ESize.medium,
  labelText: 'Continue',
  leading: const Icon(Icons.arrow_forward),
  onPressed: () {},
);
```

Full-width button:

```dart
const ButtonM3E(
  variant: ButtonM3EVariant.tonal,
  size: ButtonM3ESize.large,
  labelText: 'Buy now',
  expand: true,
);
```

Outlined/Text/Elevated work similarly.

## Theming via `m3e_design`

`button_m3e` reads tokens from your theme:

- `m3e.colors.*` for background/foreground/border/disabled
- `m3e.type.labelLarge` for the button label
- `m3e.shapes.round|square` (uses `.lg` radius for buttons)
- `m3e.spacing` for horizontal paddings (`sm`, `md`, `lg`)

If the extension is not present, it falls back to `M3ETheme.defaults(ColorScheme)`.  
You can still override `ThemeData.colorScheme` to influence defaults globally.

## Notes

- Label can be provided as `labelText` (String) or `label` (Widget).
- `leading`/`trailing` are optional helpers for icons.
- `expand: true` makes the button take full width.
- `density: compact` slightly reduces height for each size.

## License

MIT
