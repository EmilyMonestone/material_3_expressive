import 'package:flutter/material.dart';
import 'package:m3e_collection/m3e_collection.dart';

import 'section_card.dart';

class NavigationSection extends StatefulWidget {
  const NavigationSection({super.key});

  @override
  State<NavigationSection> createState() => _NavigationSectionState();
}

class _NavigationSectionState extends State<NavigationSection> {
  int _barIndex = 0;
  int _railIndex = 0;

  // Controls for the rail demo
  NavigationRailM3EType _railType = NavigationRailM3EType.expanded;
  NavigationRailM3EModality _modality = NavigationRailM3EModality.standard;
  bool _hideWhenCollapsed = false;

  double _navigationBarWidth = 450;

  List<NavigationRailM3ESection> get _railSections => const [
        NavigationRailM3ESection(
          header: Text('Main'),
          destinations: [
            NavigationRailM3EDestination(
              icon: Icon(Icons.dashboard_outlined),
              selectedIcon: Icon(Icons.dashboard),
              label: 'Dash',
            ),
            NavigationRailM3EDestination(
              icon: Icon(Icons.analytics_outlined),
              selectedIcon: Icon(Icons.analytics),
              label: 'Reports',
              badgeCount: 0,
            ),
            NavigationRailM3EDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: 'Settings',
              badgeCount: 2,
            ),
          ],
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final m3e =
        theme.extension<M3ETheme>() ?? M3ETheme.defaults(theme.colorScheme);

    return SectionCard(
      title: 'Navigation',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text('Navigation Bar', style: theme.textTheme.titleMedium),
          ),
          Wrap(
            runSpacing: 12,
            spacing: 12,
            children: [
              for (final style in NavBarM3EIndicatorStyle.values)
                SizedBox(
                  width: _navigationBarWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text('indicator: ${style.name}',
                            style: theme.textTheme.labelLarge),
                      ),
                      NavigationBarM3E(
                        selectedIndex: _barIndex,
                        onDestinationSelected: (i) =>
                            setState(() => _barIndex = i),
                        indicatorStyle: style,
                        destinations: const [
                          NavigationDestinationM3E(
                              icon: Icon(Icons.home_outlined),
                              selectedIcon: Icon(Icons.home),
                              label: 'Home'),
                          NavigationDestinationM3E(
                              icon: Icon(Icons.search_outlined),
                              selectedIcon: Icon(Icons.search),
                              label: 'Search',
                              badgeDot: true),
                          NavigationDestinationM3E(
                              icon: Icon(Icons.favorite_outline),
                              selectedIcon: Icon(Icons.favorite),
                              label: 'Favorites',
                              badgeCount: 2),
                          NavigationDestinationM3E(
                              icon: Icon(Icons.person_outline),
                              selectedIcon: Icon(Icons.person),
                              label: 'Profile'),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text('Navigation Rail', style: theme.textTheme.titleMedium),
          ),
          // Options for the rail demo (e.g., modality)
          Wrap(
            spacing: 12,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Modality:', style: theme.textTheme.labelLarge),
                  const SizedBox(width: 8),
                  DropdownButton<NavigationRailM3EModality>(
                    value: _modality,
                    onChanged: (v) => setState(() => _modality = v!),
                    items: NavigationRailM3EModality.values
                        .map((m) => DropdownMenuItem(
                              value: m,
                              child: Text(m.name),
                            ))
                        .toList(),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Hide when collapsed',
                      style: theme.textTheme.labelLarge),
                  Switch(
                    value: _hideWhenCollapsed,
                    onChanged: (v) => setState(() => _hideWhenCollapsed = v),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: m3e.shapes.round.lg,
            ),
            height: 600,
            child: Row(
              children: [
                NavigationRailM3E(
                  type: _railType,
                  modality: _modality,
                  sections: _railSections,
                  selectedIndex: _railIndex,
                  onDestinationSelected: (i) => setState(() => _railIndex = i),
                  onTypeChanged: (t) => setState(() => _railType = t),
                  fab: NavigationRailM3EFabSlot(
                    icon: const Icon(Icons.add),
                    label: 'New',
                    onPressed: () {},
                  ),
                  hideWhenCollapsed: _hideWhenCollapsed,
                  onDismissModal: () => setState(
                    () => _modality = NavigationRailM3EModality.standard,
                  ),
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: Center(child: Text('Selected: $_railIndex')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
