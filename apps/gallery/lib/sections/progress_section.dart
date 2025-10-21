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
              for (final s in ProgressM3ESize.values) ...[
                CircularProgressM3E(
                  size: s,
                  value: 0.4,
                ),
                CircularProgressM3E(
                    size: s,
                    value: 0.6,
                    showCenterLabel: s != ProgressM3ESize.small),
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
              for (final s in ProgressM3ESize.values) ...[
                CircularProgressM3E(
                  size: s,
                  value: 0.4,
                  shape: CircularBarShapeM3E.flat,
                ),
                CircularProgressM3E(
                    size: s,
                    shape: CircularBarShapeM3E.flat,
                    value: 0.6,
                    showCenterLabel: s != ProgressM3ESize.small),
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
              for (final v in LinearProgressM3EVariant.values)
                LinearProgressM3E(
                  minWidth: 220,
                  variant: v,
                  value: v == LinearProgressM3EVariant.determinate ? 0.6 : null,
                  bufferValue:
                      v == LinearProgressM3EVariant.buffer ? 0.8 : null,
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
              for (final v in LinearProgressM3EVariant.values)
                LinearProgressM3E(
                  minWidth: 220,
                  variant: v,
                  shape: LinearBarShapeM3E.flat,
                  value: v == LinearProgressM3EVariant.determinate ? 0.6 : null,
                  bufferValue:
                      v == LinearProgressM3EVariant.buffer ? 0.8 : null,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
