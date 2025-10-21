import 'package:flutter/material.dart';

import 'enums.dart';

/// Material 3 Expressive Icon Button
///
/// - Visual sizes are defined by [IconButtonM3ETokens.visual] (per size × width)
/// - Tap target respects [IconButtonM3ETokens.target] with a minimum of 48×48 on XS/SM
/// - Variants: standard, filled, tonal, outlined
/// - Shapes: round (pill) or square (rounded rect). Toggle can flip shape when selected.
/// - Widths: default, narrow, wide
/// - Toggle: [isSelected] + [selectedIcon]
class IconButtonM3E extends StatelessWidget {
  const IconButtonM3E({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.semanticLabel,
    this.variant = IconButtonM3EVariant.standard,
    this.size = IconButtonM3ESize.sm,
    this.shape = IconButtonM3EShapeVariant.round,
    this.width = IconButtonM3EWidth.defaultWidth,
    this.isSelected,
    this.selectedIcon,
    this.enableFeedback,
  });

  final Widget icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final String? semanticLabel;
  final IconButtonM3EVariant variant;
  final IconButtonM3ESize size;
  final IconButtonM3EShapeVariant shape;
  final IconButtonM3EWidth width;
  final bool? isSelected;
  final Widget? selectedIcon;
  final bool? enableFeedback;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final Size visual = size.visual(width);
    final Size target = size.target(width);
    final double iconPx = size.icon;

    final bool selected = isSelected ?? false;
    // Consider it a toggle control if selection can be represented.
    final bool isToggle = isSelected != null || selectedIcon != null;

    // Colors per variant (selected tint for standard).
    Color bg;
    Color fg;
    BorderSide? side;
    switch (variant) {
      case IconButtonM3EVariant.standard:
        bg = Colors.transparent;
        fg = selected ? scheme.primary : scheme.onSurfaceVariant;
        side = null;
        break;
      case IconButtonM3EVariant.filled:
        bg = scheme.primary;
        fg = scheme.onPrimary;
        side = null;
        break;
      case IconButtonM3EVariant.tonal:
        bg = scheme.secondaryContainer;
        fg = scheme.onSecondaryContainer;
        side = null;
        break;
      case IconButtonM3EVariant.outlined:
        bg = Colors.transparent;
        fg = scheme.primary;
        side = BorderSide(color: scheme.outline, width: 1);
        break;
    }

    // Resolve shape radius based on states (pressed) and toggle/selection.
    OutlinedBorder shapeFor(Set<WidgetState> states) {
      final r = IconButtonM3EShapes.effectiveRadius(
        size: size,
        baseVariant: shape,
        isToggle: isToggle,
        isSelected: selected,
        states: states,
      );
      return RoundedRectangleBorder(borderRadius: BorderRadius.circular(r));
    }

    final Widget innerIcon = IconTheme.merge(
      data: IconThemeData(size: iconPx, color: fg),
      child: (selected && selectedIcon != null) ? selectedIcon! : icon,
    );

    final Widget button = IconButton(
      onPressed: onPressed,
      isSelected: isSelected,
      selectedIcon: selectedIcon,
      icon: innerIcon,
      tooltip: tooltip,
      enableFeedback: enableFeedback,
      style: ButtonStyle(
        // Visual (painted) size
        fixedSize: WidgetStateProperty.all(visual),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        shape: WidgetStateProperty.resolveWith(shapeFor),
        backgroundColor: WidgetStateProperty.all(bg),
        foregroundColor: WidgetStateProperty.resolveWith((_) => fg),
        side: WidgetStateProperty.resolveWith((_) => side),
        // Animate pressed shape morph a bit.
        animationDuration: IconButtonM3ETokens.morphDuration,
        visualDensity: VisualDensity.standard,
      ),
    );

    // Compose into an outer box sized to the minimum interactive target.
    final Widget core = SizedBox(
      width: target.width,
      height: target.height,
      child: Center(
        child: SizedBox(
          width: visual.width,
          height: visual.height,
          child: button,
        ),
      ),
    );

    final semanticsText = semanticLabel ?? tooltip;
    return Semantics(
      button: true,
      selected: selected,
      label: semanticsText,
      child: core,
    );
  }
}
