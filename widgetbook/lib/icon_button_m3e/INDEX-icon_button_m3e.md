# Widgetbook Index — icon_button_m3e

This index summarizes all Widgetbook use cases implemented for the `icon_button_m3e` package.

- Package path: `packages/icon_button_m3e`
- Component inventory:
  - IconButtonM3E

## IconButtonM3E — Variants

| Variant name         | Description |
|----------------------|-------------|
| default              | Baseline interactive demo with knobs for variant, size, shape, width, tooltip, selected, feedback, and badge. |
| disabled             | Disabled state across variants/sizes. |
| standard             | Visual style preset: standard. |
| filled               | Visual style preset: filled. |
| tonal                | Visual style preset: tonal. |
| outlined             | Visual style preset: outlined. |
| sizes                | Shows all sizes (xs/sm/md/lg/xl) for the selected style/shape/width. |
| with_badge           | Demonstrates numeric badges via knob (0 shows dot). |
| with_badge_string    | Demonstrates string badges such as "NEW". |
| badge_edge_cases     | Boundary cases: dot (0), small (1), large (99), very large (clamped). |
| with_tooltip         | Tooltip demo, including long tooltip text toggle. |
| shapes               | Round vs square shapes. |
| widths               | Narrow, default, wide widths (disabled for comparison). |
| selected             | Toggle selected state with alternate selectedIcon. |
| focused              | Autofocused control for focus visuals. |
| error_badge_type     | Error case: invalid `badgeValue` type (asserts in debug). |

## Notes
- Themes are provided globally by the Widgetbook app; use cases do not configure themes.
- Knobs are used for critical and visual parameters following `plan/guide.md`.
- Callbacks log informative messages with `debugPrint` to aid interactive testing.
- Complex objects use sensible defaults and include TODO notes when applicable.
