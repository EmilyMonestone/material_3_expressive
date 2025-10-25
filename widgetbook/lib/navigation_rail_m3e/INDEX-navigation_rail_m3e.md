# INDEX — navigation_rail_m3e

This index summarizes Widgetbook use cases for the `navigation_rail_m3e` package.

## Components and Variants

- NavigationRailM3E
  - default
  - collapsed
  - always_collapsed
  - always_expanded
  - modal
  - labels_only_selected
  - labels_always_hide
  - three_destinations
  - five_destinations_with_badges
  - with_fab_slot
  - with_trailing

- RailItemButtonM3E
  - default
  - expanded
  - selected
  - with_badge

- RailBadgeM3E
  - default
  - dot
  - overflow_999+
  - dense

Notes
- All use cases are placed under: `packages/navigation_rail_m3e/lib/src/widgetbook/`.
- Use cases follow plan/guide.md: `@UseCase(name: '...', type: ComponentType)` and method names `build[Component][Variant]UseCase`.
- Critical parameters are exposed via knobs; callbacks print useful messages.
