import 'package:flutter/material.dart';
import 'package:m3e_collection/m3e_collection.dart';

import 'section_card.dart';

class ButtonGroupSection extends StatelessWidget {
  const ButtonGroupSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionCard(
          title: 'ButtonGroupM3E — basic (menu overflow default)',
          child: _demoBasic(context),
        ),
        SectionCard(
          title: 'ButtonGroupM3E — scroll overflow',
          child: _demoScroll(context),
        ),
        SectionCard(
          title: 'ButtonGroupM3E — wrap layout',
          child: _demoWrap(context),
        ),
        SectionCard(
          title: 'ButtonGroupM3E — connected',
          child: _demoConnected(context),
        ),
        SectionCard(
          title: 'ButtonGroupM3E — connected with selection',
          child: _demoConnectedSelection(context),
        ),
        SectionCard(
          title: 'ButtonGroupM3E — connected, menu overflow',
          child: _demoConnectedMenu(context),
        ),
        SectionCard(
          title: 'ButtonGroupM3E — vertical, menu overflow',
          child: _demoVertical(context),
        ),
      ],
    );
  }

  Widget _demoBasic(BuildContext context) {
    return SizedBox(
      width: 280,
      child: ButtonGroupM3E(
        actions: [
          for (final label in [
            'One',
            'Two',
            'Three',
            'Four',
            'Five Button',
            'Six'
          ])
            ButtonGroupM3EAction(label: Text(label), onPressed: () {}),
        ],
      ),
    );
  }

  Widget _demoScroll(BuildContext context) {
    return SizedBox(
      width: 280,
      child: ButtonGroupM3E(
        overflow: ButtonGroupM3EOverflow.scroll,
        actions: [
          for (final label in ['A', 'B', 'C', 'D', 'E', 'F'])
            ButtonGroupM3EAction(
              label: Text('Item $label'),
              onPressed: () {},
              style: ButtonM3EStyle.filled,
            ),
        ],
      ),
    );
  }

  Widget _demoWrap(BuildContext context) {
    return ButtonGroupM3E(
      wrap: true,
      spacing: 8,
      runSpacing: 8,
      actions: [
        for (final i in List.generate(10, (i) => i))
          ButtonGroupM3EAction(label: Text('Wrap $i'), onPressed: () {}),
      ],
    );
  }

  Widget _demoConnected(BuildContext context) {
    return SizedBox(
      width: 300,
      child: ButtonGroupM3E(
        type: ButtonGroupM3EType.connected,
        dividerColor: Theme.of(context).colorScheme.outlineVariant,
        style: ButtonM3EStyle.tonal,
        actions: [
          for (final label in ['Low', 'Med', 'High'])
            ButtonGroupM3EAction(
              label: Text(label),
              onPressed: () {},
            ),
        ],
      ),
    );
  }

  Widget _demoConnectedSelection(BuildContext context) {
    return SizedBox(
      width: 300,
      child: ButtonGroupM3E(
        type: ButtonGroupM3EType.connected,
        dividerColor: Theme.of(context).colorScheme.outlineVariant,
        style: ButtonM3EStyle.tonal,
        selection: true,
        actions: [
          for (final label in ['Low', 'Med', 'High'])
            ButtonGroupM3EAction(
              label: Text(label),
              onPressed: () {},
            ),
        ],
      ),
    );
  }

  Widget _demoConnectedMenu(BuildContext context) {
    return SizedBox(
      width: 300,
      child: ButtonGroupM3E(
        type: ButtonGroupM3EType.connected,
        dividerColor: Theme.of(context).colorScheme.outlineVariant,
        style: ButtonM3EStyle.tonal,
        actions: [
          for (final label in [
            'One',
            'Two',
            'Three',
            'Four',
            'Five Button',
            'Six'
          ])
            ButtonGroupM3EAction(
              label: Text(label),
              onPressed: () {},
            ),
        ],
      ),
    );
  }

  Widget _demoVertical(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ButtonGroupM3E(
        direction: Axis.vertical,
        actions: [
          for (final label in ['Top', 'Middle', 'Bottom', 'Extra'])
            ButtonGroupM3EAction(label: Text(label), onPressed: () {}),
        ],
      ),
    );
  }
}
