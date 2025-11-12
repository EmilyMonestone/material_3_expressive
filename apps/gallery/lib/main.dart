import 'package:flutter/material.dart';
import 'package:m3e_collection/m3e_collection.dart';
import 'package:m3e_gallery/sections/button_group_section.dart';
import 'package:m3e_gallery/sections/button_section.dart';
import 'package:m3e_gallery/sections/fab_section.dart';
import 'package:m3e_gallery/sections/icon_button_section.dart';
import 'package:m3e_gallery/sections/loading_indicator_section.dart';
import 'package:m3e_gallery/sections/navigation_section.dart';
import 'package:m3e_gallery/sections/progress_section.dart';
import 'package:m3e_gallery/sections/section_card.dart';
import 'package:m3e_gallery/sections/slider_section.dart';
import 'package:m3e_gallery/sections/split_button_section.dart';
import 'package:m3e_gallery/sections/toolbar_section.dart';

void main() => runApp(const GalleryApp());

class GalleryApp extends StatefulWidget {
  const GalleryApp({super.key});

  @override
  State<GalleryApp> createState() => _GalleryAppState();
}

class _GalleryAppState extends State<GalleryApp> {
  ThemeMode _mode = ThemeMode.light;

  void _toggleMode() {
    setState(() {
      _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    final light = ColorScheme.fromSeed(
        seedColor: Colors.purple, brightness: Brightness.light);
    final dark = ColorScheme.fromSeed(
        seedColor: Colors.purple, brightness: Brightness.dark);
    return MaterialApp(
      title: 'M3E Gallery',
      theme: light.toM3EThemeData(),
      darkTheme: dark.toM3EThemeData(),
      themeMode: _mode,
      home: GalleryHome(
        isDark: _mode == ThemeMode.dark,
        onToggleBrightness: _toggleMode,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class GalleryHome extends StatefulWidget {
  const GalleryHome(
      {super.key, required this.isDark, required this.onToggleBrightness});

  final bool isDark;
  final VoidCallback onToggleBrightness;

  @override
  State<GalleryHome> createState() => _GalleryHomeState();
}

class _GalleryHomeState extends State<GalleryHome> {
  void onPressed() {
    // Placeholder function onPressed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarM3E(
        titleText: 'M3E Gallery',
        actions: [
          IconButton(
            tooltip:
                widget.isDark ? 'Switch to light mode' : 'Switch to dark mode',
            onPressed: widget.onToggleBrightness,
            icon: Icon(widget.isDark ? Icons.dark_mode : Icons.light_mode),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.search),
          const SizedBox(width: 8),
          const Icon(Icons.more_vert),
        ],
      ),
      body: const SectionedGallery(),
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

class SectionedGallery extends StatelessWidget {
  const SectionedGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const ButtonGroupSection(),
        const IconButtonSection(),
        const SplitButtonSection(),
        const ButtonSection(),
        const ToolbarSection(),
        const FabSection(),
        const LoadingIndicatorSection(),
        const ProgressSection(),
        const SliderSection(),
        const NavigationSection(),
        SectionCard(
          title: 'App bars',
          child: Align(
            alignment: Alignment.centerLeft,
            child: ButtonM3E(
              label: Text('Open SliverAppBarM3E Demo'),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_) => const _SliverAppBarDemoPage()),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
