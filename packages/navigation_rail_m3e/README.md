# navigation_rail_m3e

Material 3 **Expressive** Navigation Rail for Flutter — featuring **collapsed** & **expanded** variants,
**modal** and **standard** presentation, **sections**, **badges**, **menu** and **FAB** slots, and smooth
**expand/collapse transitions**. Built to match the M3 Expressive spec and integrate with the `m3e_design`
token package.

<img src="https://raw.githubusercontent.com/EmilyMonestone/material_3_expressive/main/.github/images/nav_rail_m3e_cover.png" width="980"/>

## Highlights

- Collapsed (96 dp) and Expanded (220–360 dp) rails with animated transition
- Expanded **modal** presentation with scrim
- Optional menu and FAB/Extended FAB slots
- Item badges (large numeric & small dot)
- Sections with headers; full-width hit targets
- Token-driven colors, typography & shapes via `m3e_design` (with safe fallbacks)

## Quick start

```dart
NavigationRailM3E(
  type: NavigationRailM3EType.expanded,
  modality: NavigationRailM3EModality.standard,
  selectedIndex: 0,
  onDestinationSelected: (i) => setState(() => _index = i),
  onTypeChanged: (t) => setState(() => type = t),
  fab: NavigationRailM3EFabSlot(icon: const Icon(Icons.add), label: 'New', onPressed: () {}),
  sections: [
    NavigationRailM3ESection(
      header: const Text('Main'),
      destinations: [
        NavigationRailM3EDestination(
          icon: const Icon(Icons.edit_outlined),
          selectedIcon: const Icon(Icons.edit),
          label: 'Edit',
          largeBadgeCount: 0,
        ),
        NavigationRailM3EDestination(
          icon: const Icon(Icons.star_outline),
          selectedIcon: const Icon(Icons.star),
          label: 'Starred',
          smallBadge: true,
        ),
      ],
    ),
  ],
);
```

See the `/example` app for a runnable demo.

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
