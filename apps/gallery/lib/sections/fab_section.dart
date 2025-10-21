import 'package:flutter/material.dart';
import 'package:m3e_collection/m3e_collection.dart';

import 'section_card.dart';

class FabSection extends StatelessWidget {
  const FabSection({super.key});

  @override
  Widget build(BuildContext context) {
    void onPressed() {
      // Placeholder function onPressed
    }

    return SectionCard(
      title: 'FabM3E',
      subtitle:
          'Generated from enums: kind × size. Includes Extended FAB examples.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              for (final kind in FabM3EKind.values)
                for (final size in FabM3ESize.values)
                  FabM3E(
                      icon: const Icon(Icons.add),
                      kind: kind,
                      size: size,
                      onPressed: onPressed),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ExtendedFabM3E(
                  label: Text('Create'),
                  icon: Icon(Icons.add),
                  onPressed: onPressed),
              ExtendedFabM3E(
                  label: Text('Edit'),
                  icon: Icon(Icons.edit),
                  kind: FabM3EKind.secondary,
                  onPressed: onPressed),
              ExtendedFabM3E(
                  label: Text('Share'),
                  icon: Icon(Icons.share),
                  kind: FabM3EKind.tertiary,
                  onPressed: onPressed),
            ],
          ),
        ],
      ),
    );
  }
}
