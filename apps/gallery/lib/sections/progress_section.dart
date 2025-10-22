import 'package:flutter/material.dart';
import 'package:m3e_collection/m3e_collection.dart';

import 'section_card.dart';

class ProgressSection extends StatefulWidget {
  const ProgressSection({super.key});

  @override
  State<ProgressSection> createState() => _ProgressSectionState();
}

class _ProgressSectionState extends State<ProgressSection>
    with SingleTickerProviderStateMixin {
  double? _value = 0.6;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2400))
      ..repeat();
    _controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'ProgressIndicatorM3E',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Value: $_value (set 0 for null)'),
          SliderM3E(
            value: _value ?? 0,
            onChanged: (v) => setState(
              () => _value = v == 0 ? null : v,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text('Circular - Wavy',
                style: Theme.of(context).textTheme.titleMedium),
          ),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              for (final s in CircularProgressM3ESize.values) ...[
                CircularProgressIndicatorM3E(
                  size: s,
                  value: _value,
                  shape: ProgressM3EShape.wavy,
                ),
                CircularProgressIndicatorM3E(
                  size: s,
                  value: _value,
                  shape: ProgressM3EShape.wavy,
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text('Circular - Flat',
                style: Theme.of(context).textTheme.titleMedium),
          ),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              for (final s in CircularProgressM3ESize.values) ...[
                CircularProgressIndicatorM3E(
                  size: s,
                  value: _value,
                  shape: ProgressM3EShape.flat,
                ),
                CircularProgressIndicatorM3E(
                  size: s,
                  shape: ProgressM3EShape.flat,
                  value: _value,
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text('Linear - Wavy',
                style: Theme.of(context).textTheme.titleMedium),
          ),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              SizedBox(
                width: 250,
                child: LinearProgressIndicatorM3E(
                  value: _value,
                  size: LinearProgressM3ESize.s,
                  shape: ProgressM3EShape.wavy,
                ),
              ),
              SizedBox(
                width: 250,
                child: LinearProgressIndicatorM3E(
                  value: _value,
                  size: LinearProgressM3ESize.m,
                  shape: ProgressM3EShape.wavy,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text('Linear - Flat',
                style: Theme.of(context).textTheme.titleMedium),
          ),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              SizedBox(
                width: 250,
                child: LinearProgressIndicatorM3E(
                  value: _value,
                  size: LinearProgressM3ESize.s,
                  shape: ProgressM3EShape.flat,
                ),
              ),
              SizedBox(
                width: 250,
                child: LinearProgressIndicatorM3E(
                  value: _value,
                  size: LinearProgressM3ESize.m,
                  shape: ProgressM3EShape.flat,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
