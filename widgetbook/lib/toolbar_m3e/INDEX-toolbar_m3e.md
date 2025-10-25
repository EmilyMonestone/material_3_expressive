# Widgetbook Index — toolbar_m3e

This file summarizes the Widgetbook use cases for the `toolbar_m3e` package.

Component inventory:
- ToolbarM3E — primary toolbar component
- ToolbarIconButtonM3E — wrapper for toolbar action icon buttons
- ToolbarM3EWidget — internal placeholder/demo (not exported); no use cases generated

## ToolbarM3E
Variants implemented:
- default
- surface
- tonal
- primary
- small
- medium
- large
- compact
- regular
- with_leading
- with_trailing_actions
- with_overflow
- long_title
- centered_title

Notes:
- Critical parameters (variant, size, density, shapeFamily, titles, action count) are exposed via knobs.
- Callbacks print informative messages to console.
- Theme is assumed to be injected globally by the host app.

## ToolbarIconButtonM3E
Variants implemented:
- default
- destructive
- custom_color_and_size

Notes:
- Knobs include enabled, iconSize, and color where applicable.
- Destructive variant showcases error-colored action.

## ToolbarM3EWidget
- Not exported by the package; treated as internal. Skipped for widgetbook use cases.
