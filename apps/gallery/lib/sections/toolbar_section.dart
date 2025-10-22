import 'package:flutter/material.dart';
import 'package:m3e_collection/m3e_collection.dart';

import 'section_card.dart';

class ToolbarSection extends StatelessWidget {
  const ToolbarSection({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      ToolbarActionM3E(icon: Icons.search, onPressed: () {}),
      ToolbarActionM3E(icon: Icons.share, onPressed: () {}),
      ToolbarActionM3E(
          icon: Icons.delete,
          onPressed: () {},
          isDestructive: true,
          label: 'Delete'),
      ToolbarActionM3E(
          icon: Icons.settings, onPressed: () {}, label: 'Settings'),
    ];

    return SectionCard(
      title: 'ToolbarM3E',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final variant in ToolbarM3EVariant.values) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(variant.name,
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            Wrap(
              runSpacing: 12,
              children: [
                for (final size in ToolbarM3ESize.values)
                  ToolbarM3E(
                    titleText: 'Toolbar',
                    subtitleText: 'size: ${size.name}',
                    actions: actions,
                    maxInlineActions: 2,
                    variant: variant,
                    size: size,
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
