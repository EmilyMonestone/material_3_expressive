import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:split_button_m3e/split_button_m3e.dart';

void main() {
  testWidgets('Semantics: primary and trigger have labels', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: Material(
          child: SplitButtonM3E<String>(
            size: SplitButtonM3ESize.md,
            shape: SplitButtonM3EShape.round,
            label: 'Download',
            leadingIcon: Icons.download_outlined,
            onPressed: () {},
            items: const [
              SplitButtonM3EItem<String>(
                value: 'zip',
                child: 'Download as ZIP',
              ),
              SplitButtonM3EItem<String>(
                value: 'pdf',
                child: 'Download as PDF',
              ),
            ],
            trailingTooltip: 'Open menu',
            // Optional leading tooltip to also tag the primary segment semantics
            leadingTooltip: 'Download',
          ),
        ),
      ),
    );

    // Primary labeled as 'Download'
    expect(find.bySemanticsLabel('Download'), findsWidgets);
    // Trigger labeled as 'Open menu'
    expect(find.bySemanticsLabel('Open menu'), findsOneWidget);
  });

  testWidgets('Hit targets are >= 48 when size is XS', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: Material(
          child: Center(
            child: SplitButtonM3E<String>(
              size: SplitButtonM3ESize.xs,
              shape: SplitButtonM3EShape.round,
              label: 'Edit',
              leadingIcon: Icons.edit_outlined,
              onPressed: () {},
              items: const [
                SplitButtonM3EItem<String>(value: 'rename', child: 'Rename'),
              ],
              // Use tooltips to ensure we measure the segment containers (not just Text)
              leadingTooltip: 'Edit',
              trailingTooltip: 'Open menu',
            ),
          ),
        ),
      ),
    );

    final primary = find.bySemanticsLabel('Edit');
    final trigger = find.bySemanticsLabel('Open menu');
    expect(tester.getSize(primary).height, greaterThanOrEqualTo(48));
    expect(tester.getSize(trigger).height, greaterThanOrEqualTo(48));
  });
}
