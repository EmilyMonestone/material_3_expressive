import 'package:flutter/material.dart';
import 'enums.dart';
import 'button_theme_m3e.dart';

class ButtonM3E extends StatelessWidget {
  const ButtonM3E({
    super.key,
    this.onPressed,
    this.onLongPress,
    this.leading,
    this.trailing,
    this.label,
    this.labelText,
    this.expand = false,
    this.variant = ButtonM3EVariant.filled,
    this.size = ButtonM3ESize.medium,
    this.shapeFamily = ButtonM3EShapeFamily.round,
    this.density = ButtonM3EDensity.regular,
    this.semanticLabel,
  }) : assert(label != null || labelText != null, 'Provide either label or labelText');

  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final Widget? leading;
  final Widget? trailing;
  final Widget? label;
  final String? labelText;
  final bool expand;

  final ButtonM3EVariant variant;
  final ButtonM3ESize size;
  final ButtonM3EShapeFamily shapeFamily;
  final ButtonM3EDensity density;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final t = ButtonTokensAdapter(context);
    final m = t.metrics(density);
    final shape = t.shape(shapeFamily);

    final (minH, pad) = switch (size) {
      ButtonM3ESize.small => (m.heightSmall, m.paddingSmall),
      ButtonM3ESize.medium => (m.heightMedium, m.paddingMedium),
      ButtonM3ESize.large => (m.heightLarge, m.paddingLarge),
    };

    final style = _styleFor(context, t, shape, minH, pad);

    final childLabel = label ?? Text(labelText!, overflow: TextOverflow.ellipsis);
    final content = _buildContent(context, t, childLabel);

    final Widget btn = switch (variant) {
      ButtonM3EVariant.filled => FilledButton(style: style, onPressed: onPressed, onLongPress: onLongPress, child: content),
      ButtonM3EVariant.tonal => FilledButton.tonal(style: style, onPressed: onPressed, onLongPress: onLongPress, child: content),
      ButtonM3EVariant.outlined => OutlinedButton(style: style, onPressed: onPressed, onLongPress: onLongPress, child: content),
      ButtonM3EVariant.text => TextButton(style: style, onPressed: onPressed, onLongPress: onLongPress, child: content),
      ButtonM3EVariant.elevated => ElevatedButton(style: style, onPressed: onPressed, onLongPress: onLongPress, child: content),
    };

    if (!expand && semanticLabel == null) return btn;
    final wrapped = expand ? SizedBox(width: double.infinity, child: btn) : btn;
    if (semanticLabel == null) return wrapped;
    return Semantics(
      button: true,
      label: semanticLabel,
      child: wrapped,
    );
  }

  ButtonStyle _styleFor(BuildContext context, ButtonTokensAdapter t, OutlinedBorder shape, double minH, EdgeInsetsGeometry pad) {
    switch (variant) {
      case ButtonM3EVariant.filled:
        return FilledButton.styleFrom(
          backgroundColor: t.bgFilled(),
          foregroundColor: t.fgFilled(),
          textStyle: t.labelStyle(),
          minimumSize: Size(0, minH),
          padding: pad,
          shape: shape,
        );
      case ButtonM3EVariant.tonal:
        return FilledButton.styleFrom(
          backgroundColor: t.bgTonal(),
          foregroundColor: t.fgTonal(),
          textStyle: t.labelStyle(),
          minimumSize: Size(0, minH),
          padding: pad,
          shape: shape,
        );
      case ButtonM3EVariant.outlined:
        return OutlinedButton.styleFrom(
          foregroundColor: t.fgOutlined(),
          textStyle: t.labelStyle(),
          minimumSize: Size(0, minH),
          padding: pad,
          shape: shape,
          side: BorderSide(color: t.borderOutlined()),
        );
      case ButtonM3EVariant.text:
        return TextButton.styleFrom(
          foregroundColor: t.fgText(),
          textStyle: t.labelStyle(),
          minimumSize: Size(0, minH),
          padding: pad,
          shape: shape,
        );
      case ButtonM3EVariant.elevated:
        return ElevatedButton.styleFrom(
          backgroundColor: t.bgElevated(),
          foregroundColor: t.fgElevated(),
          textStyle: t.labelStyle(),
          minimumSize: Size(0, minH),
          padding: pad,
          shape: shape,
          elevation: _elevationFor(context, t),
        );
    }
  }

  double _elevationFor(BuildContext context, ButtonTokensAdapter t) {
    // Simple mapping; can be themed further via tokens.
    return 1.0;
  }

  Widget _buildContent(BuildContext context, ButtonTokensAdapter t, Widget childLabel) {
    final style = t.labelStyle();
    final text = DefaultTextStyle.merge(style: style, child: childLabel);
    final hasLeading = leading != null;
    final hasTrailing = trailing != null;

    if (!hasLeading && !hasTrailing) return text;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (hasLeading) ...[leading!, const SizedBox(width: 8)],
        Flexible(child: text),
        if (hasTrailing) ...[const SizedBox(width: 8), trailing!],
      ],
    );
  }
}
