import 'package:flutter/material.dart';
import 'package:m3e_design/m3e_design.dart';
import 'button_group_m3e_enums.dart';
import '_tokens_adapter.dart';
import 'button_group_m3e_scope.dart';

class ButtonGroupM3E extends StatelessWidget {
  const ButtonGroupM3E({
    super.key,
    required this.children,
    this.type = ButtonGroupM3EType.standard,
    this.shape = ButtonGroupM3EShape.round,
    this.size = ButtonGroupM3ESize.md,
    this.density = ButtonGroupM3EDensity.regular,
    this.direction = Axis.horizontal,
    this.wrap = false,
    this.spacing,
    this.runSpacing,
    this.alignment = WrapAlignment.start,
    this.runAlignment = WrapAlignment.start,
    this.crossAxisAlignment = WrapCrossAlignment.center,
    this.showDividers = false,
    this.dividerColor,
    this.dividerThickness,
    this.equalizeWidths = false,
    this.semanticLabel,
    this.clipBehavior = Clip.none,
  });

  final List<Widget> children;

  final ButtonGroupM3EType type;
  final ButtonGroupM3EShape shape;
  final ButtonGroupM3ESize size;
  final ButtonGroupM3EDensity density;

  final Axis direction;
  final bool wrap;
  final double? spacing;
  final double? runSpacing;
  final WrapAlignment alignment;
  final WrapAlignment runAlignment;
  final WrapCrossAlignment crossAxisAlignment;

  final bool showDividers;
  final Color? dividerColor;
  final double? dividerThickness;
  final bool equalizeWidths;

  final String? semanticLabel;
  final Clip clipBehavior;

  bool get _connected => type == ButtonGroupM3EType.connected;

  @override
  Widget build(BuildContext context) {
    final tokens = metricsFor(context, size, density);
    final cs = Theme.of(context).colorScheme;
    final dividerClr = dividerColor ?? cs.outlineVariant.withValues(alpha: 0.6);
    final dividerThk = (dividerThickness ?? tokens.dividerThickness).clamp(0.5, 2.0);

    final effSpacing = _connected ? 0.0 : (spacing ?? tokens.spacing);
    final effRunSpacing = wrap ? (runSpacing ?? tokens.runSpacing) : 0.0;

    final group = ButtonGroupM3EScope(
      type: type,
      shape: shape,
      size: size,
      density: density,
      direction: direction,
      isConnected: _connected,
      child: _buildContent(context, effSpacing, effRunSpacing, dividerClr, dividerThk),
    );

    final semantics = Semantics(
      container: true,
      label: semanticLabel,
      child: group,
    );

    if (clipBehavior == Clip.none) return semantics;
    return ClipRRect(
      clipBehavior: clipBehavior,
      borderRadius: radiusFor(context, shape, size),
      child: semantics,
    );
  }

  Widget _buildContent(BuildContext context, double spacing, double runSpacing,
      Color dividerColor, double dividerThickness) {
    if (children.isEmpty) return const SizedBox.shrink();

    if (wrap) {
      return _wrapLayout(context, spacing, runSpacing);
    }

    final list = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      final isFirst = i == 0;
      final isLast = i == children.length - 1;

      final child = _wrapItemScope(
        context,
        index: i,
        count: children.length,
        isFirst: isFirst,
        isLast: isLast,
        child: _maybeEqualized(children[i]),
      );

      list.add(child);

      final isBetween = i < children.length - 1;
      if (!isBetween) continue;

      if (_connected) {
        if (showDividers) {
          list.add(_buildDivider(dividerColor, dividerThickness));
        }
      } else {
        list.add(_spacer(spacing));
      }
    }

    return direction == Axis.horizontal
        ? Row(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: list)
        : Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: list);
  }

  Widget _wrapLayout(BuildContext context, double spacing, double runSpacing) {
    final wrapped = List<Widget>.generate(children.length, (i) {
      final isFirst = i == 0;
      final isLast = i == children.length - 1;
      return _wrapItemScope(
        context,
        index: i,
        count: children.length,
        isFirst: isFirst,
        isLast: isLast,
        child: _maybeEqualized(children[i]),
      );
    });

    return Wrap(
      direction: direction,
      spacing: spacing,
      runSpacing: runSpacing,
      alignment: alignment,
      runAlignment: runAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: wrapped,
    );
  }

  Widget _wrapItemScope(BuildContext context,
      {required int index, required int count, required bool isFirst, required bool isLast, required Widget child}) {
    return ButtonGroupM3EItemScope(
      index: index,
      count: count,
      isFirst: isFirst,
      isLast: isLast,
      child: child,
    );
  }

  Widget _spacer(double spacing) =>
      direction == Axis.horizontal ? SizedBox(width: spacing) : SizedBox(height: spacing);

  Widget _buildDivider(Color color, double thickness) {
    return direction == Axis.horizontal
        ? Container(width: thickness, height: 24, color: color)
        : Container(height: thickness, width: 24, color: color);
  }

  Widget _maybeEqualized(Widget child) {
    if (!equalizeWidths) return child;
    final minW = switch (size) {
      ButtonGroupM3ESize.xs => 40.0,
      ButtonGroupM3ESize.sm => 56.0,
      ButtonGroupM3ESize.md => 72.0,
      ButtonGroupM3ESize.lg => 96.0,
      ButtonGroupM3ESize.xl => 120.0,
    };
    return ConstrainedBox(constraints: BoxConstraints(minWidth: minW), child: child);
  }
}
