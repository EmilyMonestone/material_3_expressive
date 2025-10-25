import 'package:flutter/material.dart';
import 'package:navigation_rail_m3e/navigation_rail_m3e.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Note: RailBadgeM3E shows nothing when count is null; dot when 0; count otherwise.

@widgetbook.UseCase(name: 'default', type: RailBadgeM3E)
Widget buildRailBadgeM3EDefaultUseCase(BuildContext context) {
  final count = context.knobs.intOrNull.slider(
    label: 'count',
    initialValue: 7,
    min: 0,
    max: 1200,
    divisions: 120,
  );
  final maxDigits = context.knobs.int.slider(
    label: 'maxDigits',
    initialValue: 3,
    min: 1,
    max: 4,
  );
  final dense = context.knobs.boolean(label: 'dense', initialValue: false);
  return Center(
    child: RailBadgeM3E(count: count, maxDigits: maxDigits, dense: dense),
  );
}

@widgetbook.UseCase(name: 'dot', type: RailBadgeM3E)
Widget buildRailBadgeM3EDotUseCase(BuildContext context) {
  return const Center(child: RailBadgeM3E(count: 0));
}

@widgetbook.UseCase(name: 'overflow_999+', type: RailBadgeM3E)
Widget buildRailBadgeM3EOverflowUseCase(BuildContext context) {
  return const Center(child: RailBadgeM3E(count: 1200, maxDigits: 3));
}

@widgetbook.UseCase(name: 'dense', type: RailBadgeM3E)
Widget buildRailBadgeM3EDenseUseCase(BuildContext context) {
  return const Center(child: RailBadgeM3E(count: 42, dense: true));
}
