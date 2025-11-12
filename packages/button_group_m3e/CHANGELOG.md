## 0.3.0
- Breaking: Removed legacy `children` parameter. Use `actions: List<ButtonGroupM3EAction>` instead.
- Breaking: Renamed `groupSelection` API to `selection` for clarity.
- Added `ButtonGroupM3EAction` as the sole way to define buttons in a group.
- Added connected selection corner logic: only outer ends round; inner corners use token square radius; selected buttons fully round.
- Added 2px gap between connected buttons (when `showDividers=false`) and before overflow trigger.
- Added per-corner shape application via new `cornerRadiusOverride` in `ButtonM3E` to support mixed rounded/square corners in groups.
- Added new anchored dropdown overflow menu (default) using `overflowMenuStyle: ButtonGroupM3EOverflowMenuStyle.dropdown`; bottom sheet alternative retained (`bottomSheet`).
- Overflow trigger now rendered as a `ButtonM3E` for visual consistency.
- Improved overflow fitting algorithm (exact iterative width packing + epsilon) to eliminate minor RenderFlex pixel overflows.
- Added right-alignment support: maps `crossAxisAlignment` for linear layouts and allows popup buttons to align right.
- Misc: Refined measurement pass; popup menu intrinsic width matches widest action; dismissal on outside tap.

## 0.2.0
- New: Overflow handling options for non-wrapping groups via `overflow` parameter:
  - `menu` (new default): show as many children as fit and place the rest in a bottom sheet opened by a trailing overflow icon.
  - `scroll`: allow scrolling along the axis under bounded constraints.
  - `none`: no special handling.
- Behavior: The default overflow changed from `scroll` to `menu` for a better UX in constrained layouts.
- Implementation: Converted `ButtonGroupM3E` to a StatefulWidget to measure child extents and avoid overflow.
- Tests: Added tests for scroll, wrap, vertical, and menu overflow scenarios.

## 0.1.2
- Prevent RenderFlex overflow in non-wrapping groups by auto-enabling scroll when axis constraints are bounded.
- Added widget tests covering horizontal/vertical bounded scenarios and wrap behavior.

## 0.1.1
- Minor internal adjustments.

## 0.1.0
- Changelog initialized.
