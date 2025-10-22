import 'package:flutter/material.dart';
import 'package:m3e_collection/m3e_collection.dart';

import 'section_card.dart';

class SliderSection extends StatefulWidget {
  const SliderSection({super.key});

  @override
  State<SliderSection> createState() => _SliderSectionState();
}

class _SliderSectionState extends State<SliderSection> {
  double _value = 40;
  RangeValues _range = const RangeValues(25, 75);

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'SliderM3E',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final size in SliderM3ESize.values) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text('size: ${size.name}',
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            Wrap(
              runSpacing: 12,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SliderM3E(
                        value: _value,
                        onChanged: (v) => setState(() => _value = v),
                        min: 0,
                        max: 100,
                        label: _value.toStringAsFixed(0),
                        size: size,
                        emphasis: SliderM3EEmphasis.primary,
                        startIcon: const Icon(Icons.volume_mute),
                        endIcon: const Icon(Icons.volume_up),
                      ),
                      RangeSliderM3E(
                        values: _range,
                        onChanged: (v) => setState(() => _range = v),
                        min: 0,
                        max: 100,
                        size: size,
                        emphasis: SliderM3EEmphasis.primary,
                        labels: RangeLabels(
                          _range.start.toStringAsFixed(0),
                          _range.end.toStringAsFixed(0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
