import 'package:flutter/material.dart';
import 'package:m3e_collection/m3e_collection.dart';

import 'section_card.dart';

class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'ButtonM3E',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final shape in ButtonM3EShape.values) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text('${shape.name} shape',
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            for (final size in ButtonM3ESize.values) ...[
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 4),
                child: Text('size: ${size.name}',
                    style: Theme.of(context).textTheme.labelLarge),
              ),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  for (final variant in ButtonM3EStyle.values)
                    ButtonM3E(
                      label: Text(variant.name),
                      style: variant,
                      size: size,
                      shape: shape,
                      onPressed: () {},
                    ),
                ],
              ),
            ],
          ],
        ],
      ),
    );
  }
}
