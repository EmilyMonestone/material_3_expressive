# icon_button_m3e

Expressive Material 3 icon button for Flutter — `IconButtonM3E` — with
five sizes (XS–XL), four variants (standard, filled, tonal, outlined),
round/square shapes, toggle support, and guaranteed 48×48dp tap targets
(even when visual size is 32/40).

## Highlights

- Sizes: `M3EIconButtonSize` = XS, SM, MD, LG, XL
- Widths: `M3EIconButtonWidth` = default, narrow, wide
- Variants: standard, filled, tonal, outlined
- Shapes: round (pill) or square (rounded rect)
- Toggle: `isSelected` + `selectedIcon`
- A11y: min 48×48dp hit target; semantics label/selected state
- Tokens: centralized static values in `M3EIconButtonTokens` (no ThemeExtension)

## Install

```yaml
dependencies:
  icon_button_m3e:
    path: ../icon_button_m3e  # or from pub once published
```

## Quick Start

```dart
import 'package:icon_button_m3e/icon_button_m3e.dart';

IconButtonM3E(
  variant: IconButtonM3EVariant.filled,
  size: M3EIconButtonSize.md,
  width: M3EIconButtonWidth.defaultWidth,
  icon: const Icon(Icons.mic),
  tooltip: 'Start recording',
  onPressed: () {},
);
```

### Toggle

```dart
bool isFav = false;

IconButtonM3E(
  variant: IconButtonM3EVariant.tonal,
  isSelected: isFav,
  icon: const Icon(Icons.favorite_border),
  selectedIcon: const Icon(Icons.favorite),
  tooltip: isFav ? 'Remove from favorites' : 'Add to favorites',
  onPressed: () => setState(() => isFav = !isFav),
);
```

## Sizing

- Visual container sizes come from tokens: `M3EIconButtonTokens.visual[size][width]`.
- Minimum interactive target sizes come from `M3EIconButtonTokens.target[size][width]`.
  - XS/SM enforce at least 48×48; others match their visual sizes.
- Icon glyph sizes are in `M3EIconButtonTokens.icon[size]`.

For example (default width):
- XS: 32×32 visual, 48×48 target
- SM: 40×40 visual, 48×48 target (SM wide: 52×48)
- MD: 56×56
- LG: 96×96
- XL: 136×136

## Colors and shapes

- Colors are derived from your `ThemeData.colorScheme`:
  - standard: transparent bg, onSurfaceVariant fg (selected uses primary)
  - filled: primary bg, onPrimary fg
  - tonal: secondaryContainer bg, onSecondaryContainer fg
  - outlined: transparent bg, primary fg, outline border
- Shapes: `M3EIconButtonShapeVariant.round` (pill) or `.square` (rounded square).
  - Pressed state uses a shared, more-square radius per size.
  - If used as a toggle, selected state flips round/square for expressive feel.

## Example

Run the example app:

```sh
cd example
flutter run
```

## License

MIT
