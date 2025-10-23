# split_button_m3e

Material 3 Expressive Split Button for Flutter. Two-segment control:
- Leading: primary action (icon, label, or both)
- Trailing: menu trigger (chevron)

All sizes, paddings, radii, and offsets are token-driven, aligned to measurement boards.

## Quick start

```dart
import 'package:split_button_m3e/split_button_m3e.dart';

SplitButtonM3E<String>(
  size: SplitButtonM3ESize.md,
  shape: SplitButtonM3EShape.round,
  emphasis: SplitButtonM3EEmphasis.tonal,
  label: 'Save',
  leadingIcon: Icons.save_outlined,
  onPressed: () => debugPrint('Primary pressed'),
  items: const [
    SplitButtonM3EItem<String>(value: 'draft', child: 'Save as draft'),
    SplitButtonM3EItem<String>(value: 'close', child: 'Save & close'),
  ],
  onSelected: (v) => debugPrint('Selected: $v'),
  // Optional tooltips help with semantics and tests
  leadingTooltip: 'Save',
  trailingTooltip: 'Open menu',
);
```

## Behavior and layout

- Two segments with a fixed inner gap of 2dp.
- Trailing chevron rotates 180° when the menu is open.
- Menu opens aligned to the trailing edge of the arrow button (right edge in LTR, left in RTL).
- Optical chevron offset is applied only in the unselected (closed) state for asymmetrical layout.
- Pressed/expanded shape morph follows the expressive M3 pattern:
  - MD/LG/XL: when shape = round and arrow is pressed or menu is open, the trailing segment morphs into a perfect circle (diameter = control height), no inner padding, no optical offset.
  - XS/SM: no circle morph in selected state. The selected trailing segment uses a fixed total width of 48dp with side paddings of 13dp.
- Each segment maintains a minimum touch target of 48dp.

## Tokens (by size)

Heights
- XS 32 · S 40 · M 56 · L 96 · XL 136

Trailing width (centered chevron)
- XS 22 · S 22 · M 26 · L 38 · XL 50

Inner gap (between segments)
- 2dp

Inner corner radius (facing edges)
- XS 4 · S 4 · M 4 · L 8 · XL 12

Icon sizes
- XS 20 · S 24 · M 24 · L 32 · XL 40

Optical chevron offset (unselected/resting)
- XS −1 · S −1 · M −2 · L −3 · XL −6

Asymmetrical (unselected) paddings and blocks
- XS: leadingIconBlock 20, leftOuter 12, gap icon→label 4, labelRight 10, trailingLeftInner 12, rightOuter 14
- S:  leadingIconBlock 20, leftOuter 16, gap 8, labelRight 12, trailingLeftInner 12, rightOuter 14
- M:  leadingIconBlock 24, leftOuter 24, gap 8, labelRight 24, trailingLeftInner 13, rightOuter 17
- L:  leadingIconBlock 32, leftOuter 48, gap 12, labelRight 48, trailingLeftInner 26, rightOuter 32
- XL: leadingIconBlock 40, leftOuter 64, gap 16, labelRight 64, trailingLeftInner 37, rightOuter 49

Symmetrical (selected) trailing segment
- Trailing width (centered chevron) + side padding ×2
- Side padding per size: XS 13 · S 13 · M 15 · L 29 · XL 43
- Special case: XS/SM selected total width is 48 (22 + 13 + 13) with 13dp side padding; no full rounding.

Pressed morph radii
- Per-size pressed radius tokens are applied to the pressed segment; when round and MD/LG/XL, trailing becomes a circle while pressed/open.

## API summary

Props
- size: SplitButtonM3ESize (xs, sm, md, lg, xl)
- shape: SplitButtonM3EShape (round, square)
- emphasis: SplitButtonM3EEmphasis (filled, tonal, elevated, outlined, text)
- label: String? (leading segment)
- leadingIcon: IconData? (leading segment icon)
- onPressed: VoidCallback? (leading action)
- items: List<SplitButtonM3EItem<T>>? (trailing menu items), or
- menuBuilder: List<PopupMenuEntry<T>> Function(BuildContext)?
- onSelected: ValueChanged<T>? (when an item is chosen)
- trailingAlignment: SplitButtonM3ETrailingAlignment (opticalCenter, geometricCenter)
- leadingTooltip, trailingTooltip: String? (for semantics/UX)
- enabled: bool (default true)

Items
```dart
const SplitButtonM3EItem<T>({
  required T value,
  required Object child, // plain string or Widget
  bool enabled = true,
});
```

## Accessibility
- Each segment is independently focusable; minimum 48×48dp hit target.
- Tooltips provide accessible names; you can supply copy like “Open menu”.
- Chevron rotation and selected state are conveyed via menu open/close.

## Example (menuBuilder)

```dart
SplitButtonM3E<int>(
  size: SplitButtonM3ESize.md,
  shape: SplitButtonM3EShape.square,
  label: 'More',
  leadingIcon: Icons.more_horiz,
  onPressed: () => debugPrint('Primary'),
  menuBuilder: (context) => [
    const PopupMenuItem<int>(value: 1, child: Text('Option 1')),
    const PopupMenuItem<int>(value: 2, child: Text('Option 2')),
  ],
  onSelected: (v) => debugPrint('Picked $v'),
  trailingAlignment: SplitButtonM3ETrailingAlignment.opticalCenter,
);
```

## Notes
- Menu aligns to the trailing arrow’s edge (LTR right, RTL left).
- Optical centering is applied only when the menu is closed (unselected asymmetrical state).
- When shape=round and size is MD/LG/XL, the trailing segment becomes a perfect circle while pressed/open; XS/SM remain rectangular with the selected geometry (48 total width, 13 side padding).

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
SplitButtonM3E: a two-part button with a primary action and a dropdown menu, with sizes, variants, shapes, and accessible minimum hit targets. Keyboard navigation supported.

### Installation
- Monorepo (local path): already configured alongside m3e_design.
- Pub (when published):
```yaml
dependencies:
  split_button_m3e: ^0.1.0
  m3e_design: ^0.1.0
```

Minimum SDK: Dart >=3.9.2; Flutter >=1.17.0.

### Dependencies
- flutter
- m3e_design

### Quick start
```dart
SplitButtonM3E(
  label: const Text('Share'),
  primaryAction: () { /* do default share */ },
  menuItems: const [
    SplitButtonItemM3E(label: Text('Copy link'), value: 'copy'),
    SplitButtonItemM3E(label: Text('Email'), value: 'email'),
  ],
  onSelected: (value) {
    // handle from menu
  },
)
```

### Key parameters
- label: Widget — Visible label next to the caret.
- primaryAction: VoidCallback — Action when the main segment is tapped.
- menuItems: List<SplitButtonItemM3E> — Menu options.
- onSelected: ValueChanged<T> — Callback when a menu item is chosen.
- variant/style: filled | tonal | elevated | outlined.
- size: xs | sm | md | lg | xl.
- shapeFamily: round | square.
- isExpanded: bool — Whether to take full width when allowed.

### Accessibility
- Both segments meet 48×48dp minimum size; keyboard and screen reader friendly.

### Links
- Repository: https://github.com/EmilyMoonstone/material_3_expressive/tree/main/packages/split_button_m3e
- Issue tracker: https://github.com/EmilyMonestone/material_3_expressive/issues
- Changelog: ./CHANGELOG.md
