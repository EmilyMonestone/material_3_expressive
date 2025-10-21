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
