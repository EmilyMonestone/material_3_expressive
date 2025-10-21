import 'package:flutter/material.dart';
import 'package:m3e_collection/m3e_collection.dart';

import 'section_card.dart';

class ProgressSection extends StatelessWidget {
  const ProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'ProgressIndicatorM3E',
      subtitle: 'Generated from enums: circular sizes and linear variants.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  value: 0.4,
                  shape: ProgressM3EShape.wavy,
                ),
                CircularProgressIndicatorM3E(
                  size: s,
                  value: 0.6,
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
                  value: 0.4,
                  shape: ProgressM3EShape.flat,
                ),
                CircularProgressIndicatorM3E(
                  size: s,
                  shape: ProgressM3EShape.flat,
                  value: 0.6,
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
                  value: null,
                  shape: ProgressM3EShape.wavy,
                ),
              ),
              SizedBox(
                width: 250,
                child: LinearProgressIndicatorM3E(
                  value: 0.6,
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
                  value: null,
                  shape: ProgressM3EShape.flat,
                ),
              ),
              SizedBox(
                width: 250,
                child: LinearProgressIndicatorM3E(
                  value: 0.6,
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
