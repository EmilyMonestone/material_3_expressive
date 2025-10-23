# Material 3 Expressive – Flutter Monorepo (Starter)

This is a starter monorepo for **Material 3 Expressive (M3E)** Flutter packages.

- `packages/m3e_design` – design language core (tokens, ThemeExtension, motion)
- `packages/m3e_collection` – re-exports all component packages
- `packages/icon_button_m3e` – example component
- `packages/split_button_m3e` – example split button component
- `packages/app_bar_m3e`
- `packages/button_group_m3e`
- `packages/button_m3e`
- `packages/fab_m3e`
- `packages/loading_indicator_m3e`
- `packages/navigation_rail_m3e`
- `packages/navigation_bar_m3e`
- `packages/progress_indicator_m3e`
- `packages/slider_m3e`
- `packages/toolbar_m3e`
- `apps/gallery` – showcase app that consumes `m3e_collection`

## Quick start

```bash
dart pub global activate melos
melos bootstrap

# run the gallery
cd apps/gallery
flutter run
```

## Structure

See `melos.yaml`, `analysis_options.yaml`, and the package-level READMEs.


---

## Live demo (Gallery)

A web demo of the M3E components is published via GitHub Pages using the provided workflow in `.github/workflows/deploy-gallery-pages.yml`.

Open: https://emilymoonstone.github.io/material_3_expressive/

To run locally:

```sh
cd apps/gallery
flutter run -d chrome
```

_Last updated: 2025-10-23_
