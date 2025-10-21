import 'package:flutter/material.dart';
import 'package:m3e_design/m3e_design.dart';

class RailBadgeM3E extends StatelessWidget {
  const RailBadgeM3E({
    super.key,
    required this.child,
    this.count,
    this.showDot = false,
    this.maxCount = 99,
    this.backgroundColor,
    this.foregroundColor,
    this.semanticLabel,
    this.offset = const Offset(8, -6),
  }) : assert(count == null || count >= 0);

  final Widget child;
  final int? count;
  final bool showDot;
  final int maxCount;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final String? semanticLabel;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final m3e = t.extension<M3ETheme>() ?? M3ETheme.defaults(t.colorScheme);
    final bg = backgroundColor ?? m3e.colors.errorContainer;
    final fg = foregroundColor ?? m3e.colors.onErrorContainer;

    final badge = showDot
        ? _dot(bg)
        : _label(bg, fg, count == null ? '' : _format(count!, maxCount));

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          right: offset.dx,
          top: offset.dy,
          child: Semantics(
            label: semanticLabel ?? (count != null ? 'Notifications: ${count!}' : 'Notifications'),
            child: badge,
          ),
        ),
      ],
    );
  }

  Widget _dot(Color bg) {
    return Container(
      width: 8, height: 8,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
    );
  }

  Widget _label(Color bg, Color fg, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
      child: DefaultTextStyle(
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
        child: Text(text, textAlign: TextAlign.center, style: TextStyle(color: fg)),
      ),
    );
  }

  String _format(int c, int max) => (c > max) ? '$max+' : '$c';
}
