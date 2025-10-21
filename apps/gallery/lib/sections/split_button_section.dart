import 'package:flutter/material.dart';
import 'package:m3e_collection/m3e_collection.dart';

import 'section_card.dart';

class SplitButtonSection extends StatelessWidget {
  const SplitButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = const [
      SplitButtonM3EItem<String>(value: 'one', child: 'One'),
      SplitButtonM3EItem<String>(value: 'two', child: 'Two'),
      SplitButtonM3EItem<String>(value: 'three', child: 'Three'),
    ];

    return SectionCard(
      title: 'SplitButtonM3E',
      subtitle: 'Generated from enums: emphasis × size (round shape).',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final emphasis in SplitButtonM3EEmphasis.values) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(emphasis.name, style: Theme.of(context).textTheme.titleMedium),
            ),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                for (final size in SplitButtonM3ESize.values)
                  SplitButtonM3E<String>(
                    label: emphasis.name,
                    size: size,
                    emphasis: emphasis,
                    onPressed: () {},
                    items: items,
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
