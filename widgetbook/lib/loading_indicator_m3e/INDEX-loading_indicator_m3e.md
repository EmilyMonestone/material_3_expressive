# Widgetbook Index — loading_indicator_m3e

This index lists all components in loading_indicator_m3e and their Widgetbook use case variants.

Component inventory:
- LoadingIndicatorM3E
- ExpressiveLoadingIndicator

## LoadingIndicatorM3E (lib/src/loading_indicator_m3e.dart)
Use case file: lib/widgetbook/loading_indicator_m3e_usecases.dart
- default — Default style with token-based colors and sizing
- contained — Contained visual variant
- sizes — Small/Medium/Large/Tiny via constraints knob
- custom_colors — Active and container colors via color knobs
- with_padding — Padding and size knobs
- with_semantics — semanticsLabel and semanticsValue knobs
- custom_polygons — Choose polygon set and size via knobs

## ExpressiveLoadingIndicator (lib/src/expressive_loading_indicator.dart)
Use case file: lib/widgetbook/expressive_loading_indicator_usecases.dart
- default — Defaults from ProgressIndicatorTheme and widget internals
- sizes — Small/Medium/Large/Tiny via constraints knob
- custom_polygons — Choose polygon set and size
- color_and_semantics — Color and semantics knobs
- edge: invalid polygons (debug assert) — Toggle to provide a single polygon (asserts in debug)

Notes:
- Themes are injected globally by the Widgetbook app; no theme provided here.
- Knobs follow the Comprehensive Knobs API suggested in plan/guide.md.
