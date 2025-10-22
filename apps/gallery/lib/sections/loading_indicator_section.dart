import 'package:flutter/material.dart';
import 'package:m3e_collection/m3e_collection.dart';

import 'section_card.dart';

class LoadingIndicatorSection extends StatelessWidget {
  const LoadingIndicatorSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'LoadingIndicatorM3E',
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          for (final v in LoadingIndicatorM3EVariant.values)
            LoadingIndicatorM3E(variant: v),
        ],
      ),
    );
  }
}
