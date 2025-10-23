# button_group_m3e

Wrapper-only **Button Group** for Material 3 Expressive (M3E).  
Arranges arbitrary action buttons and applies **group-level presentation**: type (standard/connected), shape family (round/square), size (XS–XL), density, and layout (axis, wrap).

> Buttons themselves remain independent (no selection logic). Use your own M3E buttons (`icon_button_m3e`, `split_button_m3e`, etc.).

## Install (in monorepo)

Place this folder alongside `m3e_design`:

```
packages/
  m3e_design/
  button_group_m3e/
```

`pubspec.yaml` already expects `m3e_design` at `../m3e_design`.

## API

```dart
class ButtonGroupM3E extends StatelessWidget {
  const ButtonGroupM3E({
    required List<Widget> children,
    ButtonGroupM3EType type = ButtonGroupM3EType.standard,
    ButtonGroupM3EShape shape = ButtonGroupM3EShape.round,
    ButtonGroupM3ESize size = ButtonGroupM3ESize.md,
    ButtonGroupM3EDensity density = ButtonGroupM3EDensity.regular,
    Axis direction = Axis.horizontal,
    bool wrap = false,
    double? spacing,
    double? runSpacing,
    WrapAlignment alignment = WrapAlignment.start,
    WrapAlignment runAlignment = WrapAlignment.start,
    WrapCrossAlignment crossAxisAlignment = WrapCrossAlignment.center,
    bool showDividers = false,
    Color? dividerColor,
    double? dividerThickness,
    bool equalizeWidths = false,
    String? semanticLabel,
    Clip clipBehavior = Clip.none,
  });
}
```

Enums:
```dart
enum ButtonGroupM3EType { standard, connected }
enum ButtonGroupM3EShape { round, square }
enum ButtonGroupM3ESize { xs, sm, md, lg, xl }
enum ButtonGroupM3EDensity { regular, compact }
```

## Scope for cooperative buttons

The group exposes: `ButtonGroupM3EScope` and `ButtonGroupM3EItemScope`:

```dart
final g = ButtonGroupM3EScope.of(context);
final i = ButtonGroupM3EItemScope.of(context);
// g.size, g.shape, g.isConnected, g.direction ...
// i.index, i.count, i.isFirst, i.isLast ...
```

Buttons can read these to adopt **height, corner radii (outer vs inner), compact paddings**, etc.

## Defaults (recommended)

- type: `standard`
- shape: `round`
- size: `md`
- density: `regular`
- direction: `Axis.horizontal`
- wrap: `false`
- standard spacing: token-based (≈8dp at md)
- connected spacing: `0`
- dividers: `false` by default (connected only)
- dividerThickness: `1dp` (hairline)

## Notes

- In **wrap** mode, connected **dividers** are not auto-drawn per run (Flutter Wrap lacks per-run hooks). Use standard type, or accept flush seams.
- `equalizeWidths` uses min-widths by size (40, 56, 72, 96, 120). For true equalization per run, implement a custom multi-pass layout if needed.
- The widget does **not** clip children unless `clipBehavior` is set. Prefer cooperative styling via scope.

## Example

```dart
ButtonGroupM3E(
  type: ButtonGroupM3EType.connected,
  shape: ButtonGroupM3EShape.round,
  size: ButtonGroupM3ESize.lg,
  showDividers: true,
  semanticLabel: 'Playback controls',
  children: [
    // Your M3E buttons here...
  ],
)
```


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
A layout-only ButtonGroupM3E that propagates size/shape to its child buttons and ensures consistent spacing and overflow behavior for Material 3 Expressive buttons.

### Installation
- Monorepo (local path): already configured alongside m3e_design and button_m3e.
- Pub (when published):
```yaml
dependencies:
  button_group_m3e: ^0.1.0
  m3e_design: ^0.1.0
  button_m3e: ^0.1.0
```

Minimum SDK: Dart >=3.5.0.

### Dependencies
- flutter
- m3e_design

### Quick start
```dart
ButtonGroupM3E(
  size: ButtonM3ESize.md,
  shapeFamily: ButtonM3EShapeFamily.round,
  children: [
    ButtonM3E.filled(onPressed: () {}, label: const Text('One')),
    ButtonM3E.outlined(onPressed: () {}, label: const Text('Two')),
    ButtonM3E.text(onPressed: () {}, label: const Text('Three')),
  ],
)
```

### Key parameters
- children: List<Widget> — Typically ButtonM3E instances.
- size: ButtonM3ESize — xs | sm | md | lg | xl. Propagated to children when possible.
- shapeFamily: ButtonM3EShapeFamily — round | square.
- spacing: double? — Horizontal/vertical gap between children.
- direction / wrap: Axis or wrap behavior depending on implementation.

### Theming with m3e_design
Spacing/shape defaults are derived from M3ETheme tokens; you can override explicitly per group or per button.

### Accessibility
- Maintains minimum tap targets for grouped buttons and preserves focus order.

### Links
- Repository: https://github.com/EmilyMoonstone/material_3_expressive/tree/main/packages/button_group_m3e
- Issue tracker: https://github.com/EmilyMonestone/material_3_expressive/issues
- Changelog: ./CHANGELOG.md
