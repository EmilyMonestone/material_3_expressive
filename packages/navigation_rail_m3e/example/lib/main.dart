import 'package:flutter/material.dart';
import 'package:navigation_rail_m3e/navigation_rail_m3e.dart';

void main() {
  runApp(const DemoApp());
}

class DemoApp extends StatefulWidget {
  const DemoApp({super.key});
  @override
  State<DemoApp> createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  var type = NavigationRailM3EType.expanded;
  var modality = NavigationRailM3EModality.standard;
  int index = 0;

  List<NavigationRailM3ESection> get sections => [
        const NavigationRailM3ESection(
          header: Text('Main'),
          destinations: [
            NavigationRailM3EDestination(
              icon: Icon(Icons.edit_outlined),
              selectedIcon: Icon(Icons.edit),
              label: 'Edit',
            ),
            NavigationRailM3EDestination(
              icon: Icon(Icons.star_outline),
              selectedIcon: Icon(Icons.star),
              label: 'Starred',
              smallBadge: true,
            ),
            NavigationRailM3EDestination(
              icon: Icon(Icons.inbox_outlined),
              selectedIcon: Icon(Icons.inbox),
              label: 'Inbox',
              largeBadgeCount: 3,
            ),
          ],
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('NavigationRailM3E Demo'),
          actions: [
            IconButton(
              onPressed: () => setState(() {
                type = type == NavigationRailM3EType.expanded
                    ? NavigationRailM3EType.collapsed
                    : NavigationRailM3EType.expanded;
              }),
              icon: const Icon(Icons.swap_horiz),
              tooltip: 'Toggle type',
            ),
            IconButton(
              onPressed: () => setState(() {
                modality = modality == NavigationRailM3EModality.standard
                    ? NavigationRailM3EModality.modal
                    : NavigationRailM3EModality.standard;
              }),
              icon: const Icon(Icons.layers),
              tooltip: 'Toggle modality',
            ),
          ],
        ),
        body: Row(
          children: [
            NavigationRailM3E(
              type: type,
              modality: modality,
              sections: sections,
              selectedIndex: index,
              onDestinationSelected: (i) => setState(() => index = i),
              onTypeChanged: (t) => setState(() => type = t),
              fab: NavigationRailM3EFabSlot(
                icon: const Icon(Icons.add),
                label: 'New',
                onPressed: () {},
              ),
              hideWhenCollapsed: false,
              expandedWidth: 280,
              onDismissModal: () =>
                  setState(() => modality = NavigationRailM3EModality.standard),
            ),
            Expanded(
              child: Center(
                child: Text('Selected index: $index'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
