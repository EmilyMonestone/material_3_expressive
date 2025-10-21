import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show RenderObject, RenderProxySliver;
import 'package:flutter/semantics.dart' show SemanticsConfiguration;

import '_tokens_adapter.dart';
import 'app_bar_m3e_enums.dart';

class SliverAppBarM3E extends StatelessWidget {
  const SliverAppBarM3E({
    super.key,
    this.leading,
    this.title,
    this.titleText,
    this.actions,
    this.centerTitle = false,
    this.backgroundColor,
    this.foregroundColor,
    this.pinned = true,
    this.floating = false,
    this.snap = false,
    this.shapeFamily = AppBarM3EShapeFamily.round,
    this.density = AppBarM3EDensity.regular,
    this.variant = AppBarM3EVariant.medium,
    this.semanticLabel,
  });

  final Widget? leading;
  final Widget? title;
  final String? titleText;
  final List<Widget>? actions;
  final bool centerTitle;

  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool pinned;
  final bool floating;
  final bool snap;
  final AppBarM3EShapeFamily shapeFamily;
  final AppBarM3EDensity density;
  final AppBarM3EVariant variant;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final metrics = metricsFor(context, density);
    final bg = backgroundColor ?? backgroundFor(context);
    final fg = foregroundColor ?? Theme.of(context).colorScheme.onSurface;
    final shape = shapeFor(context, shapeFamily);

    final collapsedStyle = titleStyleFor(context, collapsed: true);
    final expandedStyle = titleStyleFor(context, collapsed: false);

    final collapsed = metrics.collapsedHeight;
    final expanded = switch (variant) {
      AppBarM3EVariant.medium => metrics.mediumExpanded,
      AppBarM3EVariant.large => metrics.largeExpanded,
      AppBarM3EVariant.small => metrics.smallHeight,
    };

    final resolvedTitleWidget = title ??
        (titleText != null
            ? Text(titleText!,
                style: collapsedStyle, overflow: TextOverflow.ellipsis)
            : null);

    final bar = SliverAppBar(
      pinned: pinned,
      floating: floating,
      snap: snap && floating,
      backgroundColor: bg,
      foregroundColor: fg,
      collapsedHeight: collapsed,
      expandedHeight: expanded,
      centerTitle: centerTitle,
      leading: leading,
      title: resolvedTitleWidget,
      actions: actions,
      shape: shape,
      flexibleSpace: _buildFlexibleSpace(context, expandedStyle),
    );

    if (semanticLabel == null) return bar;
    return SliverSemantic(
      label: semanticLabel!,
      child: bar,
    );
  }

  Widget? _buildFlexibleSpace(BuildContext context, TextStyle expandedStyle) {
    switch (variant) {
      case AppBarM3EVariant.small:
        return null;
      case AppBarM3EVariant.medium:
      case AppBarM3EVariant.large:
        final t = title ??
            (titleText != null ? Text(titleText!, style: expandedStyle) : null);
        if (t == null) return null;
        return FlexibleSpaceBar(
          titlePadding:
              const EdgeInsetsDirectional.only(start: 16, bottom: 16, end: 16),
          title: DefaultTextStyle(
            style: expandedStyle.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            child: t,
          ),
          collapseMode: CollapseMode.pin,
          expandedTitleScale:
              1.0, // Typography already larger; avoid scale morph
        );
    }
  }
}

/// A helper to wrap a sliver with semantics label.
class SliverSemantic extends SingleChildRenderObjectWidget {
  const SliverSemantic({super.key, required this.label, required Widget child})
      : super(child: child);
  final String label;
  @override
  RenderObject createRenderObject(BuildContext context) =>
      _SliverSemanticRender(label);
  @override
  void updateRenderObject(
      BuildContext context, covariant _SliverSemanticRender renderObject) {
    renderObject.label = label;
  }
}

class _SliverSemanticRender extends RenderProxySliver {
  _SliverSemanticRender(this._label);
  String _label;
  set label(String v) {
    if (v == _label) return;
    _label = v;
    markNeedsSemanticsUpdate();
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    config.label = _label;
    config.isSemanticBoundary = true;
  }
}
