# Widgetbook Index — m3e_design

This package (m3e_design) provides the design system core for Material 3 Expressive: ThemeExtension(s), tokens (colors, typography, spacing, shapes, motion), and utilities. It does not expose standalone user-facing Widgets.

Therefore, no component use cases are generated for this package. If downstream packages want to showcase tokens visually, they should do so in their own Widgetbook contexts using this design system.

## Discovery (Components)

- Scanned packages/m3e_design/lib for public Widgets (classes extending StatelessWidget/StatefulWidget).
- Result: none found — only ThemeExtension, token data classes, and helpers.

```
[ ] Component inventory:
    - [ ] (none)
```

## Summary Table

| Component | Variants |
|---|---|
| — No direct widgets in this package — | — |

## Notes

- Themes are globally injected in consuming apps; no themes are provided here for use cases.
- Optional previews (typography, palette, spacing, shapes, motion) could be created as internal demo widgets under widgetbook/ if desired. Not included to keep this package lean and avoid exporting demo-only code.

_Last updated: 2025-10-25_
