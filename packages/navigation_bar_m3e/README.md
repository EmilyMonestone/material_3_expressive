# navigation_bar_m3e

Material 3 **Expressive** Navigation Bar for Flutter with badges, pill/underline indicators, and token-driven styling.

- `NavigationBarM3E` — wrapper around Flutter's `NavigationBar` with M3E tokens
- `NavigationDestinationM3E` — destination data (icon, selectedIcon, label, badge)
- `NavBadgeM3E` — small badge/dot utility for icons

All styling is driven by the `m3e_design` ThemeExtension (**M3ETheme**).

## Monorepo Layout

```
packages/
  m3e_design/
  navigation_bar_m3e/
```

`pubspec.yaml` references `../m3e_design`.

## Usage

```dart
import 'package:navigation_bar_m3e/navigation_bar_m3e.dart';

final items = [
  const NavigationDestinationM3E(
    icon: Icon(Icons.home_outlined),
    selectedIcon: Icon(Icons.home),
    label: 'Home',
  ),
  const NavigationDestinationM3E(
    icon: Icon(Icons.search),
    label: 'Search',
    badgeCount: 3,
  ),
  const NavigationDestinationM3E(
    icon: Icon(Icons.person),
    label: 'Profile',
    badgeDot: true,
  ),
];

NavigationBarM3E(
  destinations: items,
  selectedIndex: 0,
  onDestinationSelected: (i) {},
  labelBehavior: NavBarM3ELabelBehavior.onlySelected,
  indicatorStyle: NavBarM3EIndicatorStyle.pill, // pill | underline | none
  size: NavBarM3ESize.medium,
  density: NavBarM3EDensity.regular,
  shapeFamily: NavBarM3EShapeFamily.round,
);
```

## Tokens mapping

- **Container**: `surfaceContainerHigh`
- **Indicator**: `secondaryContainer` (color), pill shape by default; `underline` style uses a bottom border
- **Selected**: `onSecondaryContainer` (icon/label)
- **Unselected**: `onSurfaceVariant`
- **Label style**: `labelMedium`
- **Heights**: `small ≈64dp`, `medium ≈80dp`
- **Icon size**: `24dp`

## Badges

Use `badgeCount` for numeric badges or `badgeDot: true` for a small dot. Colors default to `errorContainer / onErrorContainer` and can be overridden via `NavBadgeM3E`.

## Accessibility

- Provide `semanticLabel` per destination (used as tooltip) or on the bar.
- Label behavior options: **alwaysShow**, **onlySelected**, or **alwaysHide**.

## License

MIT
