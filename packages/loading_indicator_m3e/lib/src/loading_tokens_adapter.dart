import 'package:flutter/material.dart';
import 'package:m3e_design/m3e_design.dart';

@immutable
class LoadingTokensAdapter {
  const LoadingTokensAdapter(this.context);
  final BuildContext context;

  M3ETheme get _m3e {
    final t = Theme.of(context);
    return t.extension<M3ETheme>() ?? M3ETheme.defaults(t.colorScheme);
  }

  // Active indicator color (Default variant)
  Color activeColor() => _m3e.colors.primary;

  // Container color (Default variant -> transparent background)
  Color containerColorDefault() => Colors.transparent;

  // Contained variant colors
  Color containedContainerColor() => _m3e.colors.primaryContainer;
  Color containedActiveColor() => _m3e.colors.onPrimaryContainer;

  // Size tokens (from spec)
  double containerWidth() => 48; // container height/width
  double containerHeight() => 48;
  double activeIndicatorSize() => 38;

  // Shape: full corners
  BorderRadius containerRadius() => BorderRadius.circular(999);
}
