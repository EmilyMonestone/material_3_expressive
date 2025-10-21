import 'package:flutter/material.dart';

import 'enums.dart';
import 'fab_theme_m3e.dart';

class FabM3E extends StatelessWidget {
  const FabM3E({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.heroTag,
    this.kind = FabM3EKind.primary,
    this.size = FabM3ESize.regular,
    this.shapeFamily = FabM3EShapeFamily.round,
    this.density = FabM3EDensity.regular,
    this.elevation,
    this.focusNode,
    this.autofocus = false,
    this.isPrimaryAction = true,
    this.semanticLabel,
  });

  final Widget icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final Object? heroTag;
  final FabM3EKind kind;
  final FabM3ESize size;
  final FabM3EShapeFamily shapeFamily;
  final FabM3EDensity density;
  final double? elevation;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool isPrimaryAction;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final tokens = FabTokensAdapter(context);
    final m = tokens.metrics(density);
    final bg = tokens.bg(kind);
    final fg = tokens.fg(kind);
    final shape = tokens.shape(shapeFamily, size);
    final double dim = switch (size) {
      FabM3ESize.small => m.small,
      FabM3ESize.regular => m.regular,
      FabM3ESize.large => m.large,
    };

    final button = SizedBox(
      width: dim,
      height: dim,
      child: RawMaterialButton(
        onPressed: onPressed,
        fillColor: bg,
        elevation: elevation ?? m.elevationRest,
        hoverElevation: m.elevationHover,
        highlightElevation: m.elevationPressed,
        focusElevation: m.elevationHover,
        shape: shape,
        focusNode: focusNode,
        autofocus: autofocus,
        clipBehavior: Clip.antiAlias,
        child: IconTheme.merge(
          data: IconThemeData(color: fg, size: m.iconSize),
          child: icon,
        ),
      ),
    );

    final core = Tooltip(
      message: tooltip ?? '',
      preferBelow: false,
      child: button,
    );

    // Only wrap with Hero when an explicit tag is provided and there is no ancestor hero.
    Widget wrapped = core;
    if (heroTag != null &&
        context.findAncestorWidgetOfExactType<Hero>() == null) {
      wrapped = Hero(tag: heroTag!, child: core);
    }

    if (semanticLabel == null) return wrapped;
    return Semantics(button: true, label: semanticLabel, child: wrapped);
  }
}
