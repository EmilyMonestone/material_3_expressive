
# button_m3e

Material 3 **Expressive Buttons** for Flutter — sizes XS→XL, round/square shapes,
toggle selection, and 5 styles (filled/tonal/elevated/outlined/text).

See `lib/src/button_tokens_adapter.dart` for measurements & color mapping.


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
Material 3 Expressive buttons with 5 variants (filled, tonal, elevated, outlined, text), sizes XS–XL, round/square shapes, and optional toggle selection.

### Installation
- Monorepo (local path): already configured in this repo alongside m3e_design.
- Pub (when published):
```yaml
dependencies:
  button_m3e: ^0.1.0
  m3e_design: ^0.1.0
```

Minimum SDK: Dart >=3.5.0; Flutter >=3.19.0.

### Dependencies
- flutter
- m3e_design

### Quick start
```dart
ButtonM3E.filled(
  onPressed: () {},
  label: const Text('Save'),
  icon: const Icon(Icons.save),
  size: ButtonM3ESize.md,
  shapeFamily: ButtonM3EShapeFamily.round,
);
```

### Key parameters
- onPressed / onLongPress: callbacks for activation/long-press.
- label: Widget? — Button label; omit for icon-only variants.
- icon: Widget? — Optional leading icon.
- isSelected: bool — Toggle selection state (for toggleable styles).
- variant/style: ButtonM3EVariant — filled | tonal | elevated | outlined | text.
- size: ButtonM3ESize — xs | sm | md | lg | xl.
- shapeFamily: ButtonM3EShapeFamily — round or square.
- tooltip / semanticsLabel: String? — Accessibility hints.
- enabled: bool — Whether the button is interactive.

### Theming with m3e_design
Buttons take colors, shapes, and spacing from M3ETheme. Override via properties or ThemeData when needed.

### Accessibility
- Ensures minimum 48×48 dp tap target size via layout tokens.
- Focus, hover, and pressed states follow Material 3 guidance.

### Links
- Repository: https://github.com/EmilyMoonstone/material_3_expressive/tree/main/packages/button_m3e
- Issue tracker: https://github.com/EmilyMonestone/material_3_expressive/issues
- Changelog: ./CHANGELOG.md
