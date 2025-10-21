import 'package:flutter/material.dart';
import 'package:m3e_collection/m3e_collection.dart';

import 'section_card.dart';

class IconButtonSection extends StatelessWidget {
  const IconButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'IconButtonM3E',
      subtitle: 'Generated from enums: variant × size (round shape, default width).',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final variant in IconButtonM3EVariant.values) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(variant.name, style: Theme.of(context).textTheme.titleMedium),
            ),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                for (final size in IconButtonM3ESize.values)
                  IconButtonM3E(
                    icon: const Icon(Icons.favorite),
                    variant: variant,
                    size: size,
                    onPressed: () {},
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
