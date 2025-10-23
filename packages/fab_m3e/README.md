# fab_m3e

Material 3 **Expressive** Floating Action Buttons for Flutter:

- **FabM3E**: circular FAB (small / regular / large)
- **ExtendedFabM3E**: pill-shaped FAB with label (and optional icon)
- **FabMenuM3E**: FAB menu (speed dial) with animated items (up/down/left/right)

All components read **M3E tokens** from `m3e_design` (ThemeExtension).

## Monorepo Layout

```
packages/
  m3e_design/
  fab_m3e/
```

This package's `pubspec.yaml` references `../m3e_design`.

## Usage

### FAB

```dart
import 'package:fab_m3e/fab_m3e.dart';

FabM3E(
  icon: const Icon(Icons.add),
  kind: FabM3EKind.primary,
  size: FabM3ESize.regular,
  onPressed: () {},
);
```

### Extended FAB

```dart
ExtendedFabM3E(
  icon: const Icon(Icons.edit),
  label: const Text('Compose'),
  kind: FabM3EKind.secondary,
  onPressed: () {},
);
```

### FAB Menu (Speed dial)

```dart
final controller = FabMenuController();

FabMenuM3E(
  controller: controller,
  alignment: Alignment.bottomRight,
  direction: FabMenuDirection.up,
  primaryFab: FabM3E(icon: const Icon(Icons.add), onPressed: controller.toggle),
  items: [
    FabMenuItem(
      icon: const Icon(Icons.photo),
      label: const Text('Photo'),
      onPressed: () {},
    ),
    FabMenuItem(
      icon: const Icon(Icons.note),
      label: const Text('Note'),
      onPressed: () {},
    ),
  ],
);
```

## Theming via `m3e_design`

- Background/foreground colors derive from kind:
  - `primary` → `primaryContainer` / `onPrimaryContainer`
  - `secondary` → `secondaryContainer` / `onSecondaryContainer`
  - `tertiary` → `tertiaryContainer` / `onTertiaryContainer`
  - `surface` → `surfaceContainerHigh` / `onSurface`
- Sizes: **small ≈40dp**, **regular ≈56dp**, **large ≈96dp**
- Extended FAB height ≈56dp
- Elevations: rest 6, hover 8, pressed 12 (tweak in code or via tokens)
- Shapes: `round`/`square` from `m3e_design.shapes` (extended uses StadiumBorder)

## Notes

- `FabM3E` uses `RawMaterialButton` to directly inject shape/elevation/colors with tokens.
- `ExtendedFabM3E` uses `Material` + `InkWell` with stadium shape and token paddings.
- `FabMenuM3E` stacks items near the primary FAB and animates **scale + fade**.
- Provide your own `Hero` tags if coordinating transitions across pages.

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
Material 3 Expressive Floating Action Buttons:
- FabM3E (standard)
- ExtendedFabM3E (icon + label)
- FabMenuM3E (expandable menu of FAB actions)

### Installation
- Monorepo (local path): already configured alongside m3e_design.
- Pub (when published):
```yaml
dependencies:
  fab_m3e: ^0.1.0
  m3e_design: ^0.1.0
```

Minimum SDK: Dart >=3.5.0; Flutter >=3.22.0.

### Dependencies
- flutter
- m3e_design

### Quick start
```dart
// Standard FAB
FabM3E(
  icon: const Icon(Icons.add),
  onPressed: () {},
)

// Extended FAB
ExtendedFabM3E(
  icon: const Icon(Icons.add),
  label: const Text('Add'),
  onPressed: () {},
)

// FAB Menu (example)
FabMenuM3E(
  children: [
    FabM3E(icon: const Icon(Icons.edit), onPressed: () {}),
    FabM3E(icon: const Icon(Icons.share), onPressed: () {}),
  ],
)
```

### Key parameters
- icon: Widget — Required for FabM3E and ExtendedFabM3E.
- label: Widget? — Text label for ExtendedFabM3E.
- onPressed: VoidCallback? — Action callback.
- tooltip / semanticsLabel: String? — A11y hints.
- shapeFamily: M3E shape family as exposed by tokens.
- heroTag: Object? — For hero transitions.
- mini: bool — Compact FAB sizing.

### Theming with m3e_design
Colors/elevation/shape are token-driven via M3ETheme.

### Accessibility
- 56dp standard, 40dp mini; high-contrast focus and pressed states.

### Links
- Repository: https://github.com/EmilyMoonstone/material_3_expressive/tree/main/packages/fab_m3e
- Issue tracker: https://github.com/EmilyMonestone/material_3_expressive/issues
- Changelog: ./CHANGELOG.md
