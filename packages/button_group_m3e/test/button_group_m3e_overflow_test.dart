import 'package:button_group_m3e/button_group_m3e.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('does not overflow horizontally under bounded width by scrolling',
      (tester) async {
    final actions = List<ButtonGroupM3EAction>.generate(
      8,
      (i) => ButtonGroupM3EAction(
        label: SizedBox(width: 120, height: 40, child: Text('A$i')),
        onPressed: () {},
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width:
                  240, // force bounded width smaller than total children width
              child: ButtonGroupM3E(
                actions: actions,
                // wrap=false by default
                overflow: ButtonGroupM3EOverflow.scroll,
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull, reason: 'Should not overflow');
    expect(find.byType(SingleChildScrollView), findsOneWidget);
  });

  testWidgets('wrap=true uses Wrap and avoids overflow without scroll',
      (tester) async {
    final actions = List<ButtonGroupM3EAction>.generate(
      8,
      (i) => ButtonGroupM3EAction(
        label: SizedBox(width: 120, height: 40, child: Text('B$i')),
        onPressed: () {},
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 240,
              child: ButtonGroupM3E(
                wrap: true,
                runSpacing: 4,
                spacing: 4,
                actions: actions,
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull,
        reason: 'Wrap should avoid overflow');
    expect(find.byType(Wrap), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsNothing);
  });

  testWidgets('vertical direction scrolls when height is bounded',
      (tester) async {
    final actions = List<ButtonGroupM3EAction>.generate(
      8,
      (i) => ButtonGroupM3EAction(
        label: SizedBox(width: 100, height: 60, child: Text('C$i')),
        onPressed: () {},
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              height:
                  160, // bounded height smaller than sum of children heights
              child: ButtonGroupM3E(
                direction: Axis.vertical,
                actions: actions,
                overflow: ButtonGroupM3EOverflow.scroll,
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
  });

  testWidgets('scroll overflow prevents RenderFlex overflow', (tester) async {
    final actions = List<ButtonGroupM3EAction>.generate(
      8,
      (i) => ButtonGroupM3EAction(
        label: SizedBox(width: 120, height: 40, child: Text('D$i')),
        onPressed: () {},
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 240,
              child: ButtonGroupM3E(
                actions: actions,
                overflow: ButtonGroupM3EOverflow.scroll,
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
  });

  testWidgets('wrap=true uses Wrap and avoids scroll', (tester) async {
    final actions = List<ButtonGroupM3EAction>.generate(
      8,
      (i) => ButtonGroupM3EAction(
        label: SizedBox(width: 120, height: 40, child: Text('E$i')),
        onPressed: () {},
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 240,
              child: ButtonGroupM3E(
                wrap: true,
                runSpacing: 4,
                spacing: 4,
                actions: actions,
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.byType(Wrap), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsNothing);
  });

  testWidgets(
      'menu overflow shows trigger and opens sheet with remaining children',
      (tester) async {
    final actions = List<ButtonGroupM3EAction>.generate(
      6,
      (i) => ButtonGroupM3EAction(
        label: SizedBox(width: 100, height: 40, child: Text('M$i')),
        onPressed: () {},
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 250, // Should not fit all 6 at ~100 each
              child: ButtonGroupM3E(
                actions: actions,
                overflow: ButtonGroupM3EOverflow.menu,
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    // Overflow trigger should appear (IconButton default Icons.more_horiz)
    expect(find.byIcon(Icons.more_horiz), findsOneWidget);

    // Tap overflow trigger
    await tester.tap(find.byIcon(Icons.more_horiz));
    await tester.pumpAndSettle();

    // Bottom sheet should appear
    expect(find.byType(BottomSheet), findsOneWidget);
    // All items should be accessible either inline or in sheet (texts M0..M5)
    for (var i = 0; i < actions.length; i++) {
      expect(find.text('M$i'), findsWidgets);
    }
  });

  testWidgets('menu overflow does not appear if all children fit',
      (tester) async {
    final actions = List<ButtonGroupM3EAction>.generate(
      3,
      (i) => ButtonGroupM3EAction(
        label: SizedBox(width: 60, height: 40, child: Text('F$i')),
        onPressed: () {},
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 400, // Enough for all
              child: ButtonGroupM3E(
                actions: actions,
                overflow: ButtonGroupM3EOverflow.menu,
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.byIcon(Icons.more_horiz), findsNothing);
  });
}
