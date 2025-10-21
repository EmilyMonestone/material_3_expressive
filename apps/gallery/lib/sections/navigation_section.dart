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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final m3e = theme.extension<M3ETheme>() ?? M3ETheme.defaults(theme.colorScheme);

    return SectionCard(
      title: 'Navigation',
      subtitle: 'Generated from enums: NavBar indicator styles and Rail indicator styles.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text('Navigation Bar', style: theme.textTheme.titleMedium),
          ),
          Wrap(
            runSpacing: 12,
            children: [
              for (final style in NavBarM3EIndicatorStyle.values)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text('indicator: ${style.name}', style: theme.textTheme.labelLarge),
                    ),
                    NavigationBarM3E(
                      selectedIndex: _barIndex,
                      onDestinationSelected: (i) => setState(() => _barIndex = i),
                      indicatorStyle: style,
                      destinations: const [
                        NavigationDestinationM3E(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
                        NavigationDestinationM3E(icon: Icon(Icons.search_outlined), selectedIcon: Icon(Icons.search), label: 'Search', badgeDot: true),
                        NavigationDestinationM3E(icon: Icon(Icons.favorite_outline), selectedIcon: Icon(Icons.favorite), label: 'Favorites', badgeCount: 2),
                        NavigationDestinationM3E(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text('Navigation Rail', style: theme.textTheme.titleMedium),
          ),
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: m3e.shapes.round.lg,
            ),
            height: 220,
            child: Row(
              children: [
                for (final style in RailIndicatorStyle.values) ...[
                  NavigationRailM3E(
                    selectedIndex: _railIndex,
                    onDestinationSelected: (i) => setState(() => _railIndex = i),
                    indicatorStyle: style,
                    destinations: const [
                      RailDestinationM3E(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: 'Dash'),
                      RailDestinationM3E(icon: Icon(Icons.analytics_outlined), selectedIcon: Icon(Icons.analytics), label: 'Reports'),
                      RailDestinationM3E(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Settings'),
                    ],
                  ),
                  const VerticalDivider(width: 1),
                ],
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
