import 'package:flutter/material.dart';
import 'package:m3e_collection/m3e_collection.dart';

void main() => runApp(const GalleryApp());

class GalleryApp extends StatelessWidget {
  const GalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData(useMaterial3: true, colorSchemeSeed: Colors.purple);
    return MaterialApp(
      title: 'M3E Gallery',
      theme: withM3ETheme(base),
      home: const GalleryHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class GalleryHome extends StatefulWidget {
  const GalleryHome({super.key});

  @override
  State<GalleryHome> createState() => _GalleryHomeState();
}

class _GalleryHomeState extends State<GalleryHome> {
  // Navigation examples
  int _navBarIndex = 0;
  int _railIndex = 0;

  // Slider examples
  double _sliderValue = 0.4;
  RangeValues _rangeValues = const RangeValues(0.25, 0.75);

  // Progress examples
  double _progressValue = 0.6;

  void onPressed() {
    // Placeholder function for button onPressed
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final m3e =
        Theme.of(context).extension<M3ETheme>() ?? M3ETheme.defaults(cs);
    return Scaffold(
      appBar: AppBarM3E(
        titleText: 'M3E Gallery',
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 8),
          Icon(Icons.more_vert),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Icon buttons
          Text('IconButtonM3E', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              IconButtonM3E(
                  icon: Icon(Icons.favorite),
                  variant: IconButtonM3EVariant.filled,
                  onPressed: onPressed),
              IconButtonM3E(
                  icon: Icon(Icons.favorite),
                  variant: IconButtonM3EVariant.tonal,
                  onPressed: onPressed),
              IconButtonM3E(
                  icon: Icon(Icons.favorite),
                  variant: IconButtonM3EVariant.outlined,
                  onPressed: onPressed),
              IconButtonM3E(
                  icon: Icon(Icons.favorite),
                  variant: IconButtonM3EVariant.standard,
                  onPressed: onPressed),
            ],
          ),

          const SizedBox(height: 24),
          // Split Button
          Text('SplitButtonM3E', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              SplitButtonM3E<String>(
                label: 'Primary',
                onPressed: () {},
                items: const [
                  SplitButtonM3EItem<String>(value: 'one', child: 'One'),
                  SplitButtonM3EItem<String>(value: 'two', child: 'Two'),
                ],
              ),
              SplitButtonM3E<String>(
                label: 'Tonal',
                emphasis: SplitButtonM3EEmphasis.tonal,
                onPressed: () {},
                items: const [
                  SplitButtonM3EItem<String>(value: 'one', child: 'One'),
                  SplitButtonM3EItem<String>(value: 'two', child: 'Two'),
                ],
              ),
              SplitButtonM3E<String>(
                label: 'Outlined',
                emphasis: SplitButtonM3EEmphasis.outlined,
                onPressed: () {},
                items: const [
                  SplitButtonM3EItem<String>(value: 'one', child: 'One'),
                  SplitButtonM3EItem<String>(value: 'two', child: 'Two'),
                ],
              ),
              SplitButtonM3E<String>(
                label: 'Text',
                emphasis: SplitButtonM3EEmphasis.text,
                onPressed: () {},
                items: const [
                  SplitButtonM3EItem<String>(value: 'one', child: 'One'),
                  SplitButtonM3EItem<String>(value: 'two', child: 'Two'),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),
          // Buttons
          Text('ButtonM3E', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          Wrap(spacing: 12, runSpacing: 12, children: [
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ButtonM3E(
                    labelText: 'Filled',
                    variant: ButtonM3EVariant.filled,
                    onPressed: onPressed),
                ButtonM3E(
                    labelText: 'Tonal',
                    variant: ButtonM3EVariant.tonal,
                    onPressed: onPressed),
                ButtonM3E(
                    labelText: 'Outlined',
                    variant: ButtonM3EVariant.outlined,
                    onPressed: onPressed),
                ButtonM3E(
                    labelText: 'Text',
                    variant: ButtonM3EVariant.text,
                    onPressed: onPressed),
                ButtonM3E(
                    labelText: 'Elevated',
                    variant: ButtonM3EVariant.elevated,
                    onPressed: onPressed),
              ],
            ),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ButtonM3E(
                    labelText: 'Filled',
                    variant: ButtonM3EVariant.filled,
                    shapeFamily: ButtonM3EShapeFamily.square,
                    onPressed: onPressed),
                ButtonM3E(
                    labelText: 'Tonal',
                    variant: ButtonM3EVariant.tonal,
                    shapeFamily: ButtonM3EShapeFamily.square,
                    onPressed: onPressed),
                ButtonM3E(
                    labelText: 'Outlined',
                    variant: ButtonM3EVariant.outlined,
                    shapeFamily: ButtonM3EShapeFamily.square,
                    onPressed: onPressed),
                ButtonM3E(
                    labelText: 'Text',
                    variant: ButtonM3EVariant.text,
                    shapeFamily: ButtonM3EShapeFamily.square,
                    onPressed: onPressed),
                ButtonM3E(
                    labelText: 'Elevated',
                    variant: ButtonM3EVariant.elevated,
                    shapeFamily: ButtonM3EShapeFamily.square,
                    onPressed: onPressed),
              ],
            ),
          ]),

          const SizedBox(height: 24),
          // Button groups
          Text('ButtonGroupM3E', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          // Standard group, round, md
          ButtonGroupM3E(
            type: ButtonGroupM3EType.standard,
            shape: ButtonGroupM3EShape.round,
            size: ButtonGroupM3ESize.md,
            children: const [
              IconButtonM3E(icon: Icon(Icons.skip_previous)),
              IconButtonM3E(icon: Icon(Icons.play_arrow)),
              IconButtonM3E(icon: Icon(Icons.skip_next)),
            ],
          ),
          const SizedBox(height: 12),
          // Connected group with divider and clipping for outer corners
          ButtonGroupM3E(
            type: ButtonGroupM3EType.connected,
            shape: ButtonGroupM3EShape.round,
            size: ButtonGroupM3ESize.lg,
            showDividers: true,
            clipBehavior: Clip.hardEdge,
            equalizeWidths: true,
            semanticLabel: 'Actions',
            children: [
              SplitButtonM3E<String>(
                label: 'Primary',
                onPressed: () {},
                items: const [
                  SplitButtonM3EItem<String>(value: 'one', child: 'One'),
                  SplitButtonM3EItem<String>(value: 'two', child: 'Two'),
                ],
              ),
              SplitButtonM3E<String>(
                label: 'Tonal',
                emphasis: SplitButtonM3EEmphasis.tonal,
                onPressed: () {},
                items: const [
                  SplitButtonM3EItem<String>(value: 'one', child: 'One'),
                  SplitButtonM3EItem<String>(value: 'two', child: 'Two'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Square, compact, vertical wrap
          ButtonGroupM3E(
            type: ButtonGroupM3EType.standard,
            shape: ButtonGroupM3EShape.square,
            size: ButtonGroupM3ESize.sm,
            density: ButtonGroupM3EDensity.compact,
            direction: Axis.vertical,
            children: const [
              IconButtonM3E(icon: Icon(Icons.view_agenda_outlined)),
              IconButtonM3E(icon: Icon(Icons.table_rows_outlined)),
              IconButtonM3E(icon: Icon(Icons.grid_view_outlined)),
            ],
          ),

          const SizedBox(height: 24),
          // Toolbar
          Text('ToolbarM3E', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          ToolbarM3E(
            titleText: 'Toolbar Title',
            subtitleText: 'Subtitle',
            actions: [
              ToolbarActionM3E(icon: Icons.search, onPressed: () {}),
              ToolbarActionM3E(icon: Icons.share, onPressed: () {}),
              ToolbarActionM3E(
                  icon: Icons.delete,
                  onPressed: () {},
                  isDestructive: true,
                  label: 'Delete'),
              ToolbarActionM3E(
                  icon: Icons.settings, onPressed: () {}, label: 'Settings'),
            ],
            maxInlineActions: 2,
          ),

          const SizedBox(height: 24),
          // FABs
          Text('FabM3E', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const [
              FabM3E(icon: Icon(Icons.add)),
              FabM3E(icon: Icon(Icons.edit), kind: FabM3EKind.secondary),
              FabM3E(icon: Icon(Icons.share), kind: FabM3EKind.tertiary),
              FabM3E(icon: Icon(Icons.more_horiz), kind: FabM3EKind.surface),
              FabM3E(icon: Icon(Icons.add), size: FabM3ESize.small),
              FabM3E(icon: Icon(Icons.add), size: FabM3ESize.large),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const [
              ExtendedFabM3E(label: Text('Create'), icon: Icon(Icons.add)),
              ExtendedFabM3E(
                  label: Text('Edit'),
                  icon: Icon(Icons.edit),
                  kind: FabM3EKind.secondary),
              ExtendedFabM3E(
                  label: Text('Share'),
                  icon: Icon(Icons.share),
                  kind: FabM3EKind.tertiary),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 180,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: m3e.shapes.round.lg,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FabMenuM3E(
                    primaryFab: const FabM3E(icon: Icon(Icons.menu)),
                    items: [
                      FabMenuItem(
                          icon: const Icon(Icons.image),
                          label: const Text('Image'),
                          onPressed: () {}),
                      FabMenuItem(
                          icon: const Icon(Icons.camera_alt),
                          label: const Text('Camera'),
                          onPressed: () {}),
                      FabMenuItem(
                          icon: const Icon(Icons.file_upload),
                          label: const Text('Upload'),
                          onPressed: () {}),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          // Loading indicators
          Text('LoadingIndicatorM3E',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: const [
              LoadingIndicatorM3E(
                  variant: LoadingIndicatorM3EVariant.defaultStyle),
              LoadingIndicatorM3E(
                  variant: LoadingIndicatorM3EVariant.contained),
            ],
          ),

          const SizedBox(height: 24),
          // Progress indicators
          Text('ProgressIndicatorM3E',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const CircularProgressM3E(),
              const CircularProgressM3E(size: ProgressM3ESize.small),
              CircularProgressM3E(
                  size: ProgressM3ESize.large,
                  value: _progressValue,
                  showCenterLabel: true),
              const LinearProgressM3E(minWidth: 200),
              LinearProgressM3E(minWidth: 200, value: _progressValue),
              const LinearProgressM3E(
                  minWidth: 200,
                  variant: LinearProgressM3EVariant.indeterminate),
              const LinearProgressM3E(
                  minWidth: 200, variant: LinearProgressM3EVariant.query),
              const LinearProgressM3E(
                  minWidth: 200,
                  variant: LinearProgressM3EVariant.buffer,
                  bufferValue: 0.8,
                  value: 0.4),
            ],
          ),

          const SizedBox(height: 24),
          // Sliders
          Text('SliderM3E', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          SliderM3E(
            value: _sliderValue,
            onChanged: (v) => setState(() => _sliderValue = v),
            min: 0,
            max: 100,
            label: '${_sliderValue.toStringAsFixed(0)}',
            startIcon: const Icon(Icons.volume_mute),
            endIcon: const Icon(Icons.volume_up),
          ),
          const SizedBox(height: 8),
          RangeSliderM3E(
            values: _rangeValues,
            onChanged: (v) => setState(() => _rangeValues = v),
            min: 0,
            max: 100,
            labels: RangeLabels(
              _rangeValues.start.toStringAsFixed(0),
              _rangeValues.end.toStringAsFixed(0),
            ),
          ),

          const SizedBox(height: 24),
          // Navigation Bar
          Text('NavigationBarM3E',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          NavigationBarM3E(
            selectedIndex: _navBarIndex,
            onDestinationSelected: (i) => setState(() => _navBarIndex = i),
            indicatorStyle: NavBarM3EIndicatorStyle.pill,
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
                  badgeCount: 3),
              NavigationDestinationM3E(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person),
                  label: 'Profile'),
            ],
          ),

          const SizedBox(height: 24),
          // Navigation Rail
          Text('NavigationRailM3E',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: m3e.shapes.round.lg,
            ),
            height: 180,
            child: Row(
              children: [
                NavigationRailM3E(
                  selectedIndex: _railIndex,
                  onDestinationSelected: (i) => setState(() => _railIndex = i),
                  indicatorStyle: RailIndicatorStyle.pill,
                  destinations: const [
                    RailDestinationM3E(
                        icon: Icon(Icons.dashboard_outlined),
                        selectedIcon: Icon(Icons.dashboard),
                        label: 'Dashboard'),
                    RailDestinationM3E(
                        icon: Icon(Icons.analytics_outlined),
                        selectedIcon: Icon(Icons.analytics),
                        label: 'Reports'),
                    RailDestinationM3E(
                        icon: Icon(Icons.settings_outlined),
                        selectedIcon: Icon(Icons.settings),
                        label: 'Settings'),
                  ],
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: Center(
                    child: Text('Selected: $_railIndex'),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          // Sliver App Bar demo route
          Text('App bars', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            children: [
              const ButtonM3E(labelText: 'Open SliverAppBarM3E Demo'),
              // Use GestureDetector to navigate when tapping the button label area
            ]
                .map((w) => GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const _SliverAppBarDemoPage()),
                      ),
                      child: w,
                    ))
                .toList(),
          ),

          const SizedBox(height: 48),
          // Theming surface example remains
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: m3e.colors.surfaceStrong,
              borderRadius: m3e.shapes.square.lg,
            ),
            child: Text('Surface strong example',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: cs.onSurface)),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDemoPage extends StatelessWidget {
  const _SliverAppBarDemoPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBarM3E(
            titleText: 'SliverAppBarM3E',
            pinned: true,
            floating: false,
            variant: AppBarM3EVariant.large,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                title: Text('Item #$index'),
              ),
              childCount: 30,
            ),
          ),
        ],
      ),
    );
  }
}
