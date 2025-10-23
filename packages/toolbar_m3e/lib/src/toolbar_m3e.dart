import 'package:flutter/material.dart';
import 'package:m3e_design/m3e_design.dart';

import 'enums.dart';
import 'toolbar_action_m3e.dart';
import 'toolbar_tokens_adapter.dart';

class ToolbarM3E extends StatelessWidget implements PreferredSizeWidget {
  const ToolbarM3E({
    super.key,
    this.leading,
    this.title,
    this.titleText,
    this.subtitle,
    this.subtitleText,
    this.actions = const <ToolbarActionM3E>[],
    this.maxInlineActions = 4,
    this.overflowIcon = const Icon(Icons.more_vert),
    this.centerTitle = false,
    this.variant = ToolbarM3EVariant.surface,
    this.size = ToolbarM3ESize.medium,
    this.density = ToolbarM3EDensity.regular,
    this.shapeFamily = ToolbarM3EShapeFamily.round,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.padding,
    this.safeArea = true,
    this.clipBehavior = Clip.none,
    this.semanticLabel,
  });

  final Widget? leading;
  final Widget? title;
  final String? titleText;
  final Widget? subtitle;
  final String? subtitleText;

  final List<ToolbarActionM3E> actions;
  final int maxInlineActions;
  final Widget overflowIcon;

  final bool centerTitle;

  final ToolbarM3EVariant variant;
  final ToolbarM3ESize size;
  final ToolbarM3EDensity density;
  final ToolbarM3EShapeFamily shapeFamily;

  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final EdgeInsetsGeometry? padding;
  final bool safeArea;
  final Clip clipBehavior;

  final String? semanticLabel;

  @override
  Size get preferredSize {
    // A rough default; actual height is resolved at build based on size/density.
    switch (size) {
      case ToolbarM3ESize.small:
        return const Size.fromHeight(40);
      case ToolbarM3ESize.medium:
        return const Size.fromHeight(48);
      case ToolbarM3ESize.large:
        return const Size.fromHeight(56);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = ToolbarTokensAdapter(context);
    final metrics = tokens.metrics(density);
    final m3e = Theme.of(context).extension<M3ETheme>() ??
        M3ETheme.defaults(Theme.of(context).colorScheme);

    final height = switch (size) {
      ToolbarM3ESize.small => metrics.heightSmall,
      ToolbarM3ESize.medium => metrics.heightMedium,
      ToolbarM3ESize.large => metrics.heightLarge,
    };

    final bg = backgroundColor ?? tokens.containerColor(variant);
    final fg = foregroundColor ?? tokens.foregroundOn(variant);
    final shape = tokens.shape(shapeFamily);
    final pad = padding ?? metrics.horizontalPadding;

    final resolvedTitle = title ??
        (titleText != null
            ? Text(titleText!,
                style: tokens.titleStyle().copyWith(color: fg),
                overflow: TextOverflow.ellipsis)
            : null);

    final resolvedSubtitle = subtitle ??
        (subtitleText != null
            ? Text(subtitleText!,
                style: tokens
                    .subtitleStyle()
                    .copyWith(color: fg.withValues(alpha: 0.8)),
                overflow: TextOverflow.ellipsis)
            : null);

    final toolbarRow = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (leading != null) leading!,
        if (leading != null) SizedBox(width: metrics.gap),
        Expanded(
          child: _TitleBlock(
            title: resolvedTitle,
            subtitle: resolvedSubtitle,
            center: centerTitle,
          ),
        ),
        SizedBox(width: metrics.gap),
        _ActionsRow(
          actions: actions,
          maxInline: maxInlineActions,
          overflowIcon: overflowIcon,
          iconColor: fg,
          iconSize: metrics.iconSize,
          m3e: m3e,
        ),
      ],
    );

    final bar = Material(
      color: bg,
      elevation: elevation ??
          (variant == ToolbarM3EVariant.surface
              ? metrics.elevationSurface
              : metrics.elevationProminent),
      shape: shape,
      clipBehavior: clipBehavior,
      child: SizedBox(
        height: height,
        child: Padding(
          padding: pad,
          child: IconTheme.merge(
            data: IconThemeData(color: fg, size: metrics.iconSize),
            child: DefaultTextStyle.merge(
                style: TextStyle(color: fg), child: toolbarRow),
          ),
        ),
      ),
    );

    final content = safeArea
        ? SafeArea(
            top: false, left: false, right: false, bottom: false, child: bar)
        : bar;

    if (semanticLabel == null) return content;
    return Semantics(container: true, label: semanticLabel!, child: content);
  }
}

class _TitleBlock extends StatelessWidget {
  const _TitleBlock(
      {required this.title, required this.subtitle, required this.center});
  final Widget? title;
  final Widget? subtitle;
  final bool center;

  @override
  Widget build(BuildContext context) {
    if (title == null && subtitle == null) return const SizedBox.shrink();

    final col = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment:
          center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        if (title != null)
          DefaultTextStyle.merge(
              style: Theme.of(context).textTheme.titleSmall!, child: title!),
        if (subtitle != null)
          DefaultTextStyle.merge(
              style: Theme.of(context).textTheme.bodySmall!, child: subtitle!),
      ],
    );

    if (center) {
      return Align(alignment: Alignment.center, child: col);
    }
    return col;
  }
}

class _ActionsRow extends StatelessWidget {
  const _ActionsRow({
    required this.actions,
    required this.maxInline,
    required this.overflowIcon,
    required this.iconColor,
    required this.iconSize,
    required this.m3e,
  });

  final List<ToolbarActionM3E> actions;
  final int maxInline;
  final Widget overflowIcon;
  final Color iconColor;
  final double iconSize;
  final M3ETheme m3e;

  @override
  Widget build(BuildContext context) {
    if (actions.isEmpty) return const SizedBox.shrink();
    final inline = actions.take(maxInline).toList(growable: false);
    final overflow = actions.length > maxInline
        ? actions.sublist(maxInline)
        : const <ToolbarActionM3E>[];

    final row = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final a in inline)
          ToolbarIconButtonM3E(action: a, color: iconColor, iconSize: iconSize),
        if (overflow.isNotEmpty)
          _OverflowMenu(
            actions: overflow,
            icon: overflowIcon,
            textStyle: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: m3e.colors.onSurface),
            destructiveColor: m3e.colors.error,
          ),
      ],
    );
    return row;
  }
}

class _OverflowMenu extends StatelessWidget {
  const _OverflowMenu({
    required this.actions,
    required this.icon,
    this.textStyle,
    this.destructiveColor,
  });

  final List<ToolbarActionM3E> actions;
  final Widget icon;
  final TextStyle? textStyle;
  final Color? destructiveColor;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      tooltip: 'More options',
      itemBuilder: (context) => [
        for (var i = 0; i < actions.length; i++)
          PopupMenuItem<int>(
            value: i,
            enabled: actions[i].enabled,
            child: DefaultTextStyle.merge(
              style: (actions[i].isDestructive
                      ? (textStyle?.copyWith(color: destructiveColor) ??
                          TextStyle(color: destructiveColor))
                      : textStyle) ??
                  const TextStyle(),
              child: Text(actions[i].label ??
                  actions[i].tooltip ??
                  actions[i].semanticLabel ??
                  'Action ${i + 1}'),
            ),
          ),
      ],
      onSelected: (index) => actions[index].onPressed(),
      child: icon,
    );
  }
}
