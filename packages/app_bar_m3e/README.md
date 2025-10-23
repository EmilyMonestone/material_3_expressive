# app_bar_m3e

Expressive **App Bar** for Flutter (Material 3 Expressive).  
Small (standard) bar for `Scaffold.appBar`, plus **Medium** & **Large** collapsing variants via a sliver.

> Uses `m3e_design` tokens for color, typography, spacing, and shapes.

## Monorepo Setup

Place alongside `m3e_design` in your repo:

```
packages/
  m3e_design/
  app_bar_m3e/
```

`pubspec.yaml` references `../m3e_design` by default.

## API

### Small App Bar

```dart
AppBarM3E(
  leading: IconButton(icon: const BackButtonIcon(), onPressed: () {}),
  titleText: 'Inbox',
  actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
  centerTitle: false,
  shapeFamily: AppBarM3EShapeFamily.round,
  density: AppBarM3EDensity.regular,
);
```

Use in a `Scaffold`:

```dart
Scaffold(
  appBar: const AppBarM3E(titleText: 'Inbox'),
  body: ...
);
```

### Sliver App Bar (Medium / Large)

```dart
CustomScrollView(
  slivers: [
    SliverAppBarM3E(
      variant: AppBarM3EVariant.large,
      titleText: 'Gallery',
      pinned: true,
    ),
    // ... content slivers
  ],
);
```

- `variant: medium` uses expanded height ≈112dp (collapses to ~64dp).
- `variant: large` uses expanded height ≈152dp (collapses to ~64dp).
- Colors, shapes, and typography come from `m3e_design`'s `M3ETheme` extension.

## Theme Integration

`app_bar_m3e` reads the `M3ETheme` extension from your `ThemeData`:

```dart
final m3e = Theme.of(context).extension<M3ETheme>() ??
            M3ETheme.defaults(Theme.of(context).colorScheme);
```

It uses:
- `m3e.colors.surfaceContainerHigh` for background
- `m3e.type.titleLarge` for collapsed titles
- `m3e.type.headlineSmallEmphasized` for expanded titles
- `m3e.shapes.round|square` for container shape
- `m3e.spacing.md` for horizontal padding

Override by supplying `backgroundColor`, `foregroundColor`, `toolbarHeight`, etc.

## Notes

- For collapsing behavior, use the sliver variant inside a `CustomScrollView`.
- `AppBarM3E` (small) is a `PreferredSizeWidget` suitable for `Scaffold.appBar`.
- Medium/Large variants rely on `FlexibleSpaceBar` for expanded titles.
- When `density: compact`, default heights reduce by ~8dp.

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
A family of Material 3 Expressive app bars:
- AppBarM3E — small/standard bar for Scaffold.appBar.
- SliverAppBarM3E — Medium and Large collapsing variants for CustomScrollView.

All variants are powered by m3e_design tokens for consistent color, typography, and shape.

### Installation
- Monorepo (local path): already configured in this repo. Ensure packages/m3e_design exists.
- Pub (when published): add to pubspec.yaml

```yaml
dependencies:
  app_bar_m3e: ^0.1.0
  m3e_design: ^0.1.0
```

Minimum SDK: Dart >=3.5.0; Flutter >=3.22.0.

### Dependencies
- flutter
- m3e_design

### Quick start
```dart
Scaffold(
  appBar: const AppBarM3E(
    titleText: 'Inbox',
  ),
  body: ...,
);
```

Medium/Large collapsing:
```dart
CustomScrollView(
  slivers: [
    SliverAppBarM3E(
      variant: AppBarM3EVariant.large, // or AppBarM3EVariant.medium
      titleText: 'Gallery',
      pinned: true,
    ),
    // content...
  ],
)
```

### Key parameters
- titleText: String? — Text title when you don't pass a custom title widget.
- title: Widget? — Custom title; overrides titleText.
- leading: Widget? — Leading widget (e.g. Back button).
- actions: List<Widget> — Trailing actions.
- centerTitle: bool — Centers the title on platforms that prefer it.
- backgroundColor / foregroundColor: Color? — Override token-driven colors.
- density: AppBarM3EDensity — compact/regular.
- shapeFamily: AppBarM3EShapeFamily — round or square corners.
- variant (SliverAppBarM3E): medium or large.
- pinned / floating / snap (Sliver): Standard sliver app bar behaviors.

### Theming with m3e_design
App bars read the M3ETheme extension from ThemeData. Example:
```dart
final base = ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal));
final m3e = M3ETheme.defaults(base.colorScheme);
final theme = base.copyWith(extensions: [m3e]);
```

### Accessibility
- Meets 48×48 dp minimum hit target recommendations via tokens.
- Proper contrast from token-driven color system.

### Links
- Repository: https://github.com/EmilyMoonstone/material_3_expressive/tree/main/packages/app_bar_m3e
- Issue tracker: https://github.com/EmilyMonestone/material_3_expressive/issues
- Changelog: ./CHANGELOG.md
