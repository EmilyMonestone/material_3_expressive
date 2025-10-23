# m3e_collection

Single import that re-exports all M3E component packages plus `m3e_design`.

The packages `material_new_shapes` by [ulims](https://github.com/ulims) and `expressive_refresh` by [alvaronp](https://github.com/alvaronp) are reexported to complete the collection.

---

## Packages in this collection

- [m3e_design](../m3e_design) — Material 3 Expressive design language for Flutter (tokens, ThemeExtension, motion).
- [app_bar_m3e](../app_bar_m3e) — Expressive App Bar (Material 3 Expressive) with small/medium/large variants and Sliver integration.
- [button_m3e](../button_m3e) — Material 3 Expressive Buttons for Flutter with 5 styles, 5 sizes, round/square shapes, and toggle selection.
- [button_group_m3e](../button_group_m3e) — Wrapper-only Button Group for Material 3 Expressive (layout, shape, size propagation).
- [fab_m3e](../fab_m3e) — Material 3 Expressive Floating Action Button (FAB), Extended FAB, and FAB Menu for Flutter using M3E tokens.
- [icon_button_m3e](../icon_button_m3e) — Material 3 Expressive IconButton with sizes, variants, shapes, toggle, and accessible hit targets.
- [loading_indicator_m3e](../loading_indicator_m3e) — Material 3 Expressive Loading Indicator (morphing polygons) for Flutter, with Default and Contained variants.
- [progress_indicator_m3e](../progress_indicator_m3e) — Material 3 Expressive progress indicators.
- [navigation_bar_m3e](../navigation_bar_m3e) — Material 3 Expressive Navigation Bar for Flutter with token-driven colors, shapes, and badges.
- [navigation_rail_m3e](../navigation_rail_m3e) — Material 3 Expressive navigation rail (collapsed & expanded) with modal/standard modes, badges, sections, and m3e_design token integration.
- [slider_m3e](../slider_m3e) — Material 3 Expressive Sliders (single & range) for Flutter, powered by M3E tokens.
- [split_button_m3e](../split_button_m3e) — Material 3 Expressive Split Button with sizes, variants, shapes, a11y, and menu.
- [toolbar_m3e](../toolbar_m3e) — Material 3 Expressive Toolbars for Flutter with token-driven colors, shapes, density, and overflow handling.

### External re-exports

- material_new_shapes — Extra Material shapes (e.g., RoundedPolygon) used by M3E components. Author: [ulims](https://github.com/ulims).
- expressive_refresh — Expressive pull-to-refresh component. Author: [alvaronp](https://github.com/alvaronp).

---

## Live demo (Gallery)

Explore the components in the M3E Gallery (GitHub Pages):

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
A convenience package that re-exports all Material 3 Expressive components and design tokens so you can depend on one package and import everything you need.

### Installation
- Monorepo (local path): already configured in this repo.
- Pub (when published):
```yaml
dependencies:
  m3e_collection: ^0.1.0
```

Minimum SDK: Dart >=3.5.0.

### Dependencies (via this collection)
- m3e_design, icon_button_m3e, split_button_m3e, button_group_m3e, app_bar_m3e, button_m3e, fab_m3e,
  loading_indicator_m3e, progress_indicator_m3e, navigation_bar_m3e, navigation_rail_m3e, slider_m3e, toolbar_m3e.

### Quick start
```dart
import 'package:m3e_collection/m3e_collection.dart';

// Use any M3E widget, e.g. a filled button
ButtonM3E.filled(label: const Text('Continue'), onPressed: () {})
```

### Notes
- Keep versions of individual packages aligned; this collection pins compatible versions.

### Links
- Repository: https://github.com/EmilyMoonstone/material_3_expressive/tree/main/packages/m3e_collection
- Issue tracker: https://github.com/EmilyMonestone/material_3_expressive/issues
- Changelog: ./CHANGELOG.md
