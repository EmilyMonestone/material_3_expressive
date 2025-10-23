import 'package:flutter/material.dart';
import 'package:material_new_shapes/material_new_shapes.dart';

import 'enums.dart';
import 'expressive_loading_indicator.dart';
import 'loading_tokens_adapter.dart';

/// Material 3 Expressive Loading Indicator
/// - Default: floating morphing shape on surface
/// - Contained: icon inside colored container (primary container) using onPrimaryContainer
class LoadingIndicatorM3E extends StatelessWidget {
  const LoadingIndicatorM3E({
    super.key,
    this.variant = LoadingIndicatorM3EVariant.defaultStyle,
    this.color,
    this.containerColor,
    this.polygons,
    this.constraints,
    this.padding,
    this.semanticLabel,
    this.semanticValue,
  });

  final LoadingIndicatorM3EVariant variant;
  final Color? color;
  final Color? containerColor;
  final List<RoundedPolygon>? polygons;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? padding;
  final String? semanticLabel;
  final String? semanticValue;

  @override
  Widget build(BuildContext context) {
    final tokens = LoadingTokensAdapter(context);
    final size = Size(tokens.containerWidth(), tokens.containerHeight());

    final cons = constraints ?? BoxConstraints.tight(size);

    final activeColor = switch (variant) {
      LoadingIndicatorM3EVariant.defaultStyle => color ?? tokens.activeColor(),
      LoadingIndicatorM3EVariant.contained =>
        color ?? tokens.containedActiveColor(),
    };

    final containerBg = switch (variant) {
      LoadingIndicatorM3EVariant.defaultStyle =>
        containerColor ?? tokens.containerColorDefault(),
      LoadingIndicatorM3EVariant.contained =>
        containerColor ?? tokens.containedContainerColor(),
    };

    final indicator = ExpressiveLoadingIndicator(
      color: activeColor,
      polygons: polygons,
      semanticsLabel: semanticLabel,
      semanticsValue: semanticValue,
      constraints: cons,
    );

    if (variant == LoadingIndicatorM3EVariant.defaultStyle) {
      // Default: subtle container (secondaryContainer)
      return DecoratedBox(
        decoration: BoxDecoration(
          color: containerBg,
          borderRadius: tokens.containerRadius(),
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(0),
          child: indicator,
        ),
      );
    }

    // Contained: stronger container (primaryContainer) and contrasting active indicator
    return DecoratedBox(
      decoration: BoxDecoration(
        color: containerBg,
        borderRadius: tokens.containerRadius(),
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(0),
        child: indicator,
      ),
    );
  }
}
