import 'package:flutter/material.dart';

import 'enums.dart';
import 'fab_theme_m3e.dart';

class ExtendedFabM3E extends StatelessWidget {
  const ExtendedFabM3E({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.tooltip,
    this.heroTag,
    this.kind = FabM3EKind.primary,
    this.size = FabM3ESize.regular,
    this.shapeFamily = FabM3EShapeFamily.round,
    this.density = FabM3EDensity.regular,
    this.elevation,
    this.expand = false,
    this.semanticLabel,
  });

  final Widget label;
  final Widget? icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final Object? heroTag;
  final FabM3EKind kind;
  final FabM3ESize size;
  final FabM3EShapeFamily shapeFamily;
  final FabM3EDensity density;
  final double? elevation;
  final bool expand;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final tokens = FabTokensAdapter(context);
    final m = tokens.metrics(density);
    final bg = tokens.bg(kind);
    final fg = tokens.fg(kind);
    final shape = tokens.shape(shapeFamily, size);

    final minH = m.extendedHeight;
    final child = DefaultTextStyle.merge(
      style: tokens.labelStyle().copyWith(color: fg),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            IconTheme.merge(
                data: IconThemeData(color: fg, size: m.iconSize), child: icon!),
            const SizedBox(width: 12)
          ],
          Flexible(child: label),
        ],
      ),
    );

    final btn = ConstrainedBox(
      constraints: BoxConstraints(minHeight: minH),
      child: Material(
        shape: shape,
        color: bg,
        elevation: elevation ?? m.elevationRest,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          onHover: (_) {},
          child: Padding(
            padding: m.extendedPadding,
            child: Align(alignment: Alignment.center, child: child),
          ),
        ),
      ),
    );

    final core = Tooltip(
      message: tooltip ?? '',
      preferBelow: false,
      child: expand ? SizedBox(width: double.infinity, child: btn) : btn,
    );

    Widget wrapped = core;
    if (heroTag != null &&
        context.findAncestorWidgetOfExactType<Hero>() == null) {
      wrapped = Hero(tag: heroTag!, child: core);
    }

    if (semanticLabel == null) return wrapped;
    return Semantics(button: true, label: semanticLabel, child: wrapped);
  }
}
