import 'package:flutter/material.dart';
import 'package:split_button_m3e/split_button_m3e.dart';

void main() => runApp(const DemoApp());

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SplitButtonM3E Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const DemoHome(),
    );
  }
}

class DemoHome extends StatelessWidget {
  const DemoHome({super.key});

  void _snack(BuildContext ctx, String msg) {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    const sizes = SplitButtonM3ESize.values;
    const variants = SplitButtonM3EEmphasis.values;

    return Scaffold(
      appBar: AppBar(title: const Text('SplitButtonM3E Demo')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Basic usage',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SplitButtonM3E<String>(
            label: 'Save',
            leadingIcon: Icons.save_outlined,
            onPressed: () => _snack(context, 'Save pressed'),
            items: const [
              SplitButtonM3EItem<String>(
                  value: 'draft', child: 'Save as draft'),
              SplitButtonM3EItem<String>(value: 'close', child: 'Save & close'),
            ],
            onSelected: (v) => _snack(context, 'Selected: $v'),
          ),
          const SizedBox(height: 24),
          const Text('Variants × Sizes (round)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          for (final v in variants) ...[
            Text(v.toString().split('.').last.toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                for (final s in sizes)
                  SplitButtonM3E<String>(
                    label: 'Action',
                    leadingIcon: Icons.play_arrow,
                    onPressed: () => _snack(context, 'Primary: $v/$s'),
                    items: const [
                      SplitButtonM3EItem<String>(value: 'alt1', child: 'Alt 1'),
                      SplitButtonM3EItem<String>(value: 'alt2', child: 'Alt 2'),
                    ],
                    onSelected: (v) => _snack(context, 'Selected: $v ($s)'),
                    emphasis: v,
                    size: s,
                    shape: SplitButtonM3EShape.round,
                  ),
              ],
            ),
            const SizedBox(height: 16),
          ],
          const SizedBox(height: 24),
          const Text('Square shape',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              for (final v in variants)
                SplitButtonM3E<String>(
                  label: 'Share',
                  leadingIcon: Icons.share,
                  onPressed: () => _snack(context, 'Share primary'),
                  items: const [
                    SplitButtonM3EItem<String>(
                        value: 'link', child: 'Copy link'),
                    SplitButtonM3EItem<String>(value: 'email', child: 'Email'),
                  ],
                  onSelected: (v) => _snack(context, 'Selected: $v'),
                  emphasis: v,
                  size: SplitButtonM3ESize.md,
                  shape: SplitButtonM3EShape.square,
                ),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
