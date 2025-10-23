# toolbar_m3e

Material 3 **Expressive** toolbar for Flutter – a compact action bar that can host a title/subtitle, leading widget, inline actions, and an overflow menu. All styling is driven by `m3e_design` tokens.

- `ToolbarM3E` — the main toolbar widget (`PreferredSizeWidget`) for use in `Scaffold` or as a standalone header
- `ToolbarActionM3E` — action model consumed by the toolbar
- Inline actions render as icon buttons; extra actions go into a `PopupMenuButton` overflow

## Monorepo Layout

```
packages/
  m3e_design/
  toolbar_m3e/
```

`pubspec.yaml` references `../m3e_design`.

## Usage

```dart
import 'package:toolbar_m3e/toolbar_m3e.dart';

final actions = [
  ToolbarActionM3E(
    icon: Icons.search,
    onPressed: () {},
    tooltip: 'Search',
  ),
  ToolbarActionM3E(
    icon: Icons.share_outlined,
    onPressed: () {},
    tooltip: 'Share',
  ),
  ToolbarActionM3E(
    icon: Icons.delete_outline,
    onPressed: () {},
    tooltip: 'Delete',
    isDestructive: true,
    label: 'Delete', // used in overflow
  ),
];

ToolbarM3E(
  leading: const BackButton(),
  titleText: 'Selection',
  subtitleText: '3 items',
  actions: actions,
  maxInlineActions: 2, // remaining actions go to overflow
  variant: ToolbarM3EVariant.tonal, // surface | tonal | primary
  size: ToolbarM3ESize.medium,      // small | medium | large
  density: ToolbarM3EDensity.regular,
  shapeFamily: ToolbarM3EShapeFamily.round,
  centerTitle: false,
);
```

## Tokens mapping

- **Container**: `surfaceContainerHigh` (surface) / `secondaryContainer` (tonal) / `primaryContainer` (primary)
- **Foreground**: `onSurface` / `onSecondaryContainer` / `onPrimaryContainer`
- **Shape**: uses M3E `round` / `square` set (`md` radius)
- **Heights**: small **≈40dp**, medium **≈48dp**, large **≈56dp**
- **Icon size**: **24dp**
- **Padding**: horizontal from tokens (`spacing.md`)

## Overflow

Set `maxInlineActions` to the number of actions that should stay inline. Any additional actions go to the overflow menu (labels pulled from `label` or `tooltip`/`semanticLabel`). Destructive actions can be highlighted by `isDestructive: true`.

## Accessibility

- Provide `semanticLabel` on the toolbar if useful.
- Actions expose `tooltip` and can set `semanticLabel` to improve assistive tech hints.

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
