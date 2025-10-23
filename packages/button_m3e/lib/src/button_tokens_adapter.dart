import 'package:flutter/material.dart';
import 'package:m3e_design/m3e_design.dart';

import 'enums.dart';

@immutable
class ButtonMeasurements {
  const ButtonMeasurements({
    required this.height,
    required this.hPadding,
    required this.iconSize,
    required this.iconGap,
  });
  final double height;
  final double hPadding;
  final double iconSize;
  final double iconGap;
}

@immutable
class ButtonTokensAdapter {
  const ButtonTokensAdapter(this.context,
      {this.smallPaddingDeprecated24 = false});
  final BuildContext context;
  final bool smallPaddingDeprecated24;

  M3ETheme get _m3e {
    final t = Theme.of(context);
    return t.extension<M3ETheme>() ?? M3ETheme.defaults(t.colorScheme);
  }

  Color container(ButtonM3EStyle style) {
    final c = _m3e.colors;
    switch (style) {
      case ButtonM3EStyle.filled:
        return c.primary;
      case ButtonM3EStyle.tonal:
        return c.secondaryContainer;
      case ButtonM3EStyle.elevated:
        return c.surface;
      case ButtonM3EStyle.outlined:
      case ButtonM3EStyle.text:
        return Colors.transparent;
    }
  }

  Color foreground(ButtonM3EStyle style) {
    final c = _m3e.colors;
    switch (style) {
      case ButtonM3EStyle.filled:
        return c.onPrimary;
      case ButtonM3EStyle.tonal:
        return c.onSecondaryContainer;
      case ButtonM3EStyle.elevated:
      case ButtonM3EStyle.outlined:
      case ButtonM3EStyle.text:
        return c.primary;
    }
  }

  Color outline() => _m3e.colors.outline;

  double elevation(ButtonM3EStyle style, Set<WidgetState> states) {
    final hovered = states.contains(WidgetState.hovered);
    final pressed = states.contains(WidgetState.pressed);
    final disabled = states.contains(WidgetState.disabled);
    if (disabled) return 0;
    switch (style) {
      case ButtonM3EStyle.elevated:
        return pressed
            ? 0
            : hovered
                ? 3
                : 1;
      case ButtonM3EStyle.filled:
      case ButtonM3EStyle.tonal:
        return pressed
            ? 0
            : hovered
                ? 1
                : 0;
      case ButtonM3EStyle.outlined:
      case ButtonM3EStyle.text:
        return 0;
    }
  }

  double squareRadius(ButtonM3ESize size) {
    switch (size) {
      case ButtonM3ESize.xs:
        return 8;
      case ButtonM3ESize.sm:
        return 8;
      case ButtonM3ESize.md:
        return 12;
      case ButtonM3ESize.lg:
        return 16;
      case ButtonM3ESize.xl:
        return 20;
    }
  }

  double pressedRadius(ButtonM3ESize size) =>
      (squareRadius(size) * 0.6).clamp(6, 18);

  ButtonMeasurements measurements(ButtonM3ESize size) {
    switch (size) {
      case ButtonM3ESize.xs:
        return const ButtonMeasurements(
            height: 32, hPadding: 12, iconSize: 20, iconGap: 4);
      case ButtonM3ESize.sm:
        return ButtonMeasurements(
          height: 40,
          hPadding: smallPaddingDeprecated24 ? 24 : 16,
          iconSize: 20,
          iconGap: 8,
        );
      case ButtonM3ESize.md:
        return const ButtonMeasurements(
            height: 56, hPadding: 24, iconSize: 24, iconGap: 8);
      case ButtonM3ESize.lg:
        return const ButtonMeasurements(
            height: 96, hPadding: 48, iconSize: 32, iconGap: 12);
      case ButtonM3ESize.xl:
        return const ButtonMeasurements(
            height: 136, hPadding: 64, iconSize: 40, iconGap: 16);
    }
  }
}
