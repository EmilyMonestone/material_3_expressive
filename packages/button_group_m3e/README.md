# button_group_m3e

Material 3 Expressive grouped button layout and overflow management.

## Current API (0.3.0)
`children` has been removed. Provide `actions: List<ButtonGroupM3EAction>`.

```dart
ButtonGroupM3E(
  actions: [
    ButtonGroupM3EAction(label: const Text('One'), onPressed: () {}),
    ButtonGroupM3EAction(label: const Text('Two'), onPressed: () {}),
    ButtonGroupM3EAction(label: const Text('Three'), onPressed: () {}),
  ],
  overflow: ButtonGroupM3EOverflow.menu, // default
)
```

## Actions
```dart
class ButtonGroupM3EAction {
  const ButtonGroupM3EAction({
    required Widget label,
    Widget? icon,
    VoidCallback? onPressed,
    bool enabled = true,
    ButtonM3EStyle style = ButtonM3EStyle.filled,
    bool toggleable = false,
    bool selected = false,
    ValueChanged<bool>? onSelectedChange,
    ButtonM3EShape? shape,
  });
}
```

## Group selection
Enable segmented styling:
```dart
int selectedIndex = 0;
ButtonGroupM3E(
  groupSelection: true,
  selectedIndex: selectedIndex,
  actions: [
    ButtonGroupM3EAction(label: const Text('Day'), onPressed: () => setState(() => selectedIndex = 0)),
    ButtonGroupM3EAction(label: const Text('Week'), onPressed: () => setState(() => selectedIndex = 1)),
    ButtonGroupM3EAction(label: const Text('Month'), onPressed: () => setState(() => selectedIndex = 2)),
  ],
)
```
Shape rules when `groupSelection` is true:
- Selected button: fully round.
- First & last (unselected): round.
- Middle unselected buttons: square.

## Overflow
- `menu` (default): shows what fits + overflow trigger with remaining actions in a bottom sheet.
- `scroll`: scrolls along main axis when constrained.
- `none`: no handling (may overflow if parent allows).

## Other parameters
- `type`: standard | connected (divider seams, zero spacing)
- `shape`: square | round (base shape family)
- `size`: xs | sm | md | lg | xl
- `density`: regular | compact
- Layout: `direction`, `wrap`, `spacing`, `runSpacing`, alignment options.
- `equalizeWidths`: enforce min widths per size for even visual rhythm.

## Versioning
0.3.0 – BREAKING: removed `children`. Use `actions`.

## License
See LICENSE.
