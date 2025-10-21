# navigation_rail_m3e

Material 3 **Expressive** Navigation Rail for Flutter with badges, pill/stripe indicators, and token-driven styling.

- `NavigationRailM3E` — wrapper around Flutter's `NavigationRail` with M3E tokens
- `RailDestinationM3E` — destination data (icon, selectedIcon, label, badge)
- `RailBadgeM3E` — small badge/dot utility for icons

All styling is driven by the `m3e_design` ThemeExtension (**M3ETheme**).

## Monorepo Layout

```
packages/
  m3e_design/
  navigation_rail_m3e/
```

`pubspec.yaml` references `../m3e_design`.

## Usage

```dart
import 'package:navigation_rail_m3e/navigation_rail_m3e.dart';

final items = [
  const RailDestinationM3E(
    icon: Icon(Icons.inbox_outlined),
    selectedIcon: Icon(Icons.inbox),
    label: 'Inbox',
  ),
  const RailDestinationM3E(
    icon: Icon(Icons.chat_bubble_outline),
    label: 'Chat',
    badgeCount: 5,
  ),
  const RailDestinationM3E(
    icon: Icon(Icons.settings_outlined),
    label: 'Settings',
    badgeDot: true,
  ),
];

NavigationRailM3E(
  destinations: items,
  selectedIndex: 0,
  onDestinationSelected: (i) {},
  labelBehavior: RailLabelBehavior.onlySelected, // none | onlySelected | alwaysShow
  indicatorStyle: RailIndicatorStyle.pill,       // pill | stripe | none
  size: RailSize.regular,                        // compact | regular
  density: RailDensity.regular,                  // regular | compact
  shapeFamily: RailShapeFamily.round,            // round | square
  extended: false,                               // true to show labels permanently (wide rail)
  groupAlignment: -1.0,                          // -1 top .. 1 bottom
  leading: const Padding(
    padding: EdgeInsets.all(8.0),
    child: FlutterLogo(size: 24),
  ),
);
```

## Tokens mapping

- **Container**: `surfaceContainerHigh`
- **Indicator**: `secondaryContainer` (color). `pill` uses NavigationRail's indicator; `stripe` draws a left border on the selected icon.
- **Selected**: `onSecondaryContainer` (icon/label)
- **Unselected**: `onSurfaceVariant`
- **Label style**: `labelMedium`
- **Widths**: compact **≈64dp**, regular **≈80dp**, extended min **≈256dp**
- **Icon size**: **24dp**
- **Item padding**: from `spacing.sm/md`

## Badges

Use `badgeCount` for numeric badges or `badgeDot: true` for a small dot. Colors default to `errorContainer / onErrorContainer` and can be overridden via `RailBadgeM3E`.

## Accessibility

- Provide `semanticLabel` per destination (used as tooltip) or on the rail (`semanticLabel` on the widget).
- Choose the label behavior to balance density with readability.

## License

MIT
