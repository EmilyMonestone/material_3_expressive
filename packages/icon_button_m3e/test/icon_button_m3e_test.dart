import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icon_button_m3e/icon_button_m3e.dart';

void main() {
  testWidgets('Semantics exposes label and selected state', (tester) async {
    const label = 'Favorite';
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: IconButtonM3E(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            isSelected: true,
            tooltip: label,
          ),
        ),
      ),
    );

    final semantics = tester.getSemantics(find.byType(IconButtonM3E));
    expect(semantics.flagsCollection.hasSelectedState, true);
    expect(semantics.label, label);
  });

  testWidgets('Hit target is at least 48x48 when visual is XS (32)', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: Center(
            child: IconButtonM3E(
              size: IconButtonM3ESize.xs,
              icon: Icon(Icons.mic),
            ),
          ),
        ),
      ),
    );

    final size = tester.getSize(find.byType(IconButtonM3E));
    expect(size.width, greaterThanOrEqualTo(48));
    expect(size.height, greaterThanOrEqualTo(48));
  });
}
