# Material 3 Expressive – Flutter Monorepo (Starter)

This is a starter monorepo for **Material 3 Expressive (M3E)** Flutter packages.

- `packages/m3e_design` – design language core (tokens, ThemeExtension, motion)
- `packages/m3e_collection` – re-exports all component packages
- `packages/icon_button_m3e` – example component (uses `m3e_design`)
- `packages/split_button_m3e` – example split button component
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
