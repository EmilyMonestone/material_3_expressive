import 'dart:ui' show FontFeature;
import 'package:flutter/material.dart';

import 'rail_tokens_adapter.dart';

/// Large numeric badge for rail items (0..999+). One class per file.
class RailBadgeM3E extends StatelessWidget {
  /// Creates a large numeric badge.
  const RailBadgeM3E({
    super.key,
    required this.count,
    this.maxDigits = 3,
    this.dense = false,
  });

  /// The numeric value to display in the badge.
  final int count;

  /// Maximum digits before showing a trailing '+' (e.g. 999+).
  final int maxDigits;

  /// Whether to use a denser (smaller padding) variant.
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final tokens = NavigationRailTokensAdapter(context);
    final String text = count > (10 * (pow10(maxDigits) - 1))
        ? '${pow10(maxDigits) - 1}+'
        : '$count';
    final double pad = dense ? 2 : 4;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: pad + 2, vertical: pad),
      decoration: BoxDecoration(
        color: tokens.badgeLargeBackground,
        borderRadius: BorderRadius.circular(999),
      ),
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.labelSmall!.copyWith(
          color: tokens.badgeLargeLabel,
          fontFeatures: const [FontFeature.tabularFigures()],
        ),
        child: Text(text, maxLines: 1),
      ),
    );
  }

  /// Returns 10 to the power of [n].
  static int pow10(int n) {
    var v = 1;
    for (var i = 0; i < n; i++) {
      v *= 10;
    }
    return v;
  }
}
