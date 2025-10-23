import 'package:flutter/material.dart';
import 'package:m3e_design/m3e_design.dart';

import 'enums.dart';
import 'menu_items.dart';

/// Two-segment Material 3 Expressive split button.
///
/// - Leading segment: primary action (icon, label, or both)
/// - Trailing segment: menu trigger (chevron), opens a menu of alternatives
///
/// All numeric values (sizes, paddings, radii, durations) are pulled from
/// `tokens.dart` via the enums extension getters.
class SplitButtonM3E<T> extends StatefulWidget {
  const SplitButtonM3E({
    super.key,
    this.shape = SplitButtonM3EShape.round,
    this.size = SplitButtonM3ESize.sm,
    this.emphasis = SplitButtonM3EEmphasis.filled,
    this.label,
    this.leadingIcon,
    this.onPressed,
    required this.items,
    this.onSelected,
    this.trailingAlignment = SplitButtonM3ETrailingAlignment.opticalCenter,
    this.leadingTooltip,
    this.trailingTooltip,
    this.enabled = true,
    this.menuBuilder,
  }) : assert(
         items != null || menuBuilder != null,
         'Provide either `items` or `menuBuilder`.',
       );

  /// Size row (XS→XL).
  final SplitButtonM3ESize size;

  /// Resting outer shape (round/square). Pressed morph uses tokens.
  final SplitButtonM3EShape shape;

  /// Visual emphasis family.
  final SplitButtonM3EEmphasis emphasis;

  /// Leading segment content.
  final String? label;
  final IconData? leadingIcon;

  /// Leading action.
  final VoidCallback? onPressed;

  /// Trailing menu definition. Use either a static list...
  final List<SplitButtonM3EItem<T>>? items;

  /// ...or a builder that returns a list of PopupMenuEntries.
  final List<PopupMenuEntry<T>> Function(BuildContext)? menuBuilder;

  /// Called when a menu item is selected.
  final ValueChanged<T>? onSelected;

  /// Trailing chevron alignment strategy.
  final SplitButtonM3ETrailingAlignment trailingAlignment;

  /// Optional tooltips.
  final String? leadingTooltip;
  final String? trailingTooltip;

  /// Set to false to disable both segments.
  final bool enabled;

  @override
  State<SplitButtonM3E<T>> createState() => _SplitButtonM3EState<T>();
}

class _SplitButtonM3EState<T> extends State<SplitButtonM3E<T>> {
  bool _leadingPressed = false;
  bool _trailingPressed = false;
  bool _menuOpen = false;
  final GlobalKey _trailingKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final dir = Directionality.of(context);

    // Container/foreground colors per emphasis family
    final (
      Color cont,
      Color onCont,
      BorderSide? outlineSide,
      double? elevation,
    ) = _resolveColorsAndShapes(
      context,
    );

    final height = widget.size.height;
    const minTap = SplitButtonM3ETokens.minTapTarget;
    final outerRadius = switch (widget.shape) {
      SplitButtonM3EShape.round => widget.size.outerRoundRadius,
      SplitButtonM3EShape.square => widget.size.outerSquareRadius,
    };
    final pressedRadius = widget.size.pressedRadius;
    final innerRadius = widget.size.innerCornerRadius;
    const innerGap = SplitButtonM3ETokens.innerGap;
    final chevronTurns = _menuOpen
        ? SplitButtonM3ETokens.chevronOpenTurns
        : 0.0;

    // Build segments
    final leading = _SegmentContainer(
      height: height,
      minTapHeight: minTap,
      color: cont,
      onColor: onCont,
      elevation: elevation,
      outlineSide: outlineSide,
      pressed: _leadingPressed,
      radius: _leadingRadii(
        dir: dir,
        outer: outerRadius,
        inner: innerRadius,
        pressed: _leadingPressed ? pressedRadius : null,
      ),
      tooltip: widget.leadingTooltip,
      onHighlightChanged: (v) {
        if (!widget.enabled) return;
        setState(() => _leadingPressed = v);
      },
      onTap: widget.enabled ? widget.onPressed : null,
      child: _LeadingContent(
        size: widget.size,
        icon: widget.leadingIcon,
        label: widget.label,
        color: onCont,
      ),
    );

    final trailingIconOffsetBase =
        (widget.trailingAlignment ==
                SplitButtonM3ETrailingAlignment.opticalCenter &&
            !_menuOpen)
        ? widget.size.menuIconOffsetUnselected
        : 0.0;

    // Trailing segment total width per state (asymmetrical vs symmetrical)
    final trailingWidthUnselected =
        widget.size.trailingLeftInnerPadding +
        widget.size.trailingWidthCentered +
        widget.size.rightOuterPadding;
    final trailingWidthSelected =
        widget.size.sidePaddingSelected * 2 + widget.size.trailingWidthCentered;

    // When round + pressed/open, morph trailing into a perfect circle
    final bool allowCircle =
        widget.size == SplitButtonM3ESize.md ||
        widget.size == SplitButtonM3ESize.lg ||
        widget.size == SplitButtonM3ESize.xl;
    final bool circleTrailing =
        widget.shape == SplitButtonM3EShape.round &&
        allowCircle &&
        (_trailingPressed || _menuOpen);

    // XS/SM selected: fully rounded (capsule), not a circle
    final bool smallSelectedCapsule =
        widget.shape == SplitButtonM3EShape.round &&
        (widget.size == SplitButtonM3ESize.xs ||
            widget.size == SplitButtonM3ESize.sm) &&
        _menuOpen;

    final trailingFixedWidth = circleTrailing
        ? height
        : (_menuOpen ? trailingWidthSelected : trailingWidthUnselected);

    final trailingLeftPad = circleTrailing
        ? 0.0
        : (_menuOpen
              ? widget.size.sidePaddingSelected
              : widget.size.trailingLeftInnerPadding);
    final trailingRightPad = circleTrailing
        ? 0.0
        : (_menuOpen
              ? widget.size.sidePaddingSelected
              : widget.size.rightOuterPadding);

    final trailingChevronDx = circleTrailing ? 0.0 : trailingIconOffsetBase;

    final trailingRadius = circleTrailing
        ? _CornerRadii(
            topStart: height / 2,
            bottomStart: height / 2,
            topEnd: height / 2,
            bottomEnd: height / 2,
          )
        : smallSelectedCapsule
        ? _CornerRadii(
            topStart: height / 2,
            bottomStart: height / 2,
            topEnd: height / 2,
            bottomEnd: height / 2,
          )
        : _trailingRadii(
            dir: dir,
            outer: outerRadius,
            inner: innerRadius,
            pressed: (_trailingPressed || _menuOpen) ? pressedRadius : null,
          );

    final trailing = KeyedSubtree(
      key: _trailingKey,
      child: _SegmentContainer(
        height: height,
        minTapHeight: minTap,
        fixedWidth: trailingFixedWidth,
        color: cont,
        onColor: onCont,
        elevation: elevation,
        outlineSide: outlineSide,
        pressed: _trailingPressed || _menuOpen,
        radius: trailingRadius,
        tooltip: widget.trailingTooltip,
        onHighlightChanged: (v) {
          if (!widget.enabled) return;
          setState(() => _trailingPressed = v);
        },
        onTap: widget.enabled ? () => _openMenu(context) : null,
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: trailingLeftPad,
            end: trailingRightPad,
          ),
          child: SizedBox(
            width: circleTrailing ? height : widget.size.trailingWidthCentered,
            child: Center(
              child: _TrailingChevron(
                color: onCont,
                size: widget.size.iconPx,
                turns: chevronTurns,
                dxOffset: trailingChevronDx,
              ),
            ),
          ),
        ),
      ),
    );

    return FocusTraversalGroup(
      policy: ReadingOrderTraversalPolicy(),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: minTap),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          textDirection: dir,
          children: [
            leading,
            const SizedBox(width: innerGap),
            trailing,
          ],
        ),
      ),
    );
  }

  (Color, Color, BorderSide?, double?) _resolveColorsAndShapes(
    BuildContext context,
  ) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    switch (widget.emphasis) {
      case SplitButtonM3EEmphasis.filled:
        return (cs.primary, cs.onPrimary, null, null);
      case SplitButtonM3EEmphasis.tonal:
        return (cs.secondaryContainer, cs.onSecondaryContainer, null, null);
      case SplitButtonM3EEmphasis.elevated:
        return (
          theme.colorScheme.surfaceContainerHigh,
          cs.onSurface,
          null,
          1.0,
        );
      case SplitButtonM3EEmphasis.outlined:
        final side = BorderSide(color: cs.outline);
        return (Colors.transparent, cs.primary, side, null);
      case SplitButtonM3EEmphasis.text:
        return (Colors.transparent, cs.primary, null, null);
    }
  }

  _CornerRadii _leadingRadii({
    required TextDirection dir,
    required double outer,
    required double inner,
    double? pressed,
  }) {
    final o = pressed ?? outer;
    final i = pressed ?? inner;
    // Leading segment: outer = start corners, inner = end corners
    return _CornerRadii(topStart: o, bottomStart: o, topEnd: i, bottomEnd: i);
  }

  _CornerRadii _trailingRadii({
    required TextDirection dir,
    required double outer,
    required double inner,
    double? pressed,
  }) {
    final o = pressed ?? outer;
    final i = pressed ?? inner;
    // Trailing segment: inner = start corners, outer = end corners
    return _CornerRadii(topStart: i, bottomStart: i, topEnd: o, bottomEnd: o);
  }

  Future<void> _openMenu(BuildContext context) async {
    if (widget.menuBuilder != null) {
      setState(() => _menuOpen = true);
      final res = await showMenu<T>(
        context: context,
        position: _menuPosition(context),
        items: widget.menuBuilder!(context),
      );
      if (mounted) {
        setState(() => _menuOpen = false);
        if (res != null && widget.onSelected != null) widget.onSelected!(res);
      }
      return;
    }

    // Convert simple items to PopupMenuEntries
    final items = widget.items!;
    setState(() => _menuOpen = true);
    final res = await showMenu<T>(
      context: context,
      position: _menuPosition(context),
      items: items
          .map(
            (e) => PopupMenuItem<T>(
              value: e.value,
              enabled: e.enabled,
              child: e.child is Widget ? e.child as Widget : Text('${e.child}'),
            ),
          )
          .toList(),
    );
    if (!mounted) return;
    setState(() => _menuOpen = false);
    if (res != null && widget.onSelected != null) widget.onSelected!(res);
  }

  RelativeRect _menuPosition(BuildContext context) {
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final textDir = Directionality.of(context);

    // Default to whole control if trailing key is missing
    RenderBox? tb;
    Offset tTopLeft = Offset.zero;
    Size tSize = Size.zero;
    final tCtx = _trailingKey.currentContext;
    if (tCtx != null) {
      tb = tCtx.findRenderObject() as RenderBox?;
    }
    if (tb != null) {
      tTopLeft = tb.localToGlobal(Offset.zero);
      tSize = tb.size;
    } else {
      final box = context.findRenderObject() as RenderBox?;
      if (box != null) {
        tTopLeft = box.localToGlobal(Offset.zero);
        tSize = box.size;
      }
    }

    final top = tTopLeft.dy + tSize.height;

    late double left;
    late double right;

    if (textDir == TextDirection.ltr) {
      final endX = tTopLeft.dx + tSize.width; // right edge
      left = endX;
      right = overlay.size.width - endX;
    } else {
      final startX = tTopLeft.dx; // left edge is trailing in RTL
      left = startX;
      right = overlay.size.width - startX;
    }

    return RelativeRect.fromLTRB(left, top, right, overlay.size.height - top);
  }
}

/// --- Internal: segment container ------------------------------------------------

class _SegmentContainer extends StatelessWidget {
  const _SegmentContainer({
    required this.height,
    required this.minTapHeight,
    required this.color,
    required this.onColor,
    this.fixedWidth,
    this.elevation,
    this.outlineSide,
    required this.pressed,
    required this.radius,
    required this.child,
    required this.onHighlightChanged,
    required this.onTap,
    this.tooltip,
  });

  final double height;
  final double minTapHeight;
  final double? fixedWidth;
  final Color color;
  final Color onColor;
  final double? elevation;
  final BorderSide? outlineSide;
  final bool pressed;
  final _CornerRadii radius;
  final Widget child;
  final ValueChanged<bool> onHighlightChanged;
  final VoidCallback? onTap;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: radius.toBorderRadius(Directionality.of(context)),
      side: outlineSide ?? BorderSide.none,
    );

    final button = Center(
      child: Material(
        color: color,
        elevation: elevation ?? 0,
        shape: shape,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          onHighlightChanged: onHighlightChanged,
          customBorder: shape,
          child: SizedBox(
            height: height,
            width: fixedWidth,
            child: Center(child: child),
          ),
        ),
      ),
    );

    final cont = ConstrainedBox(
      constraints: BoxConstraints(minWidth: 0, minHeight: minTapHeight),
      child: button,
    );

    if (tooltip == null) return cont;
    return Tooltip(message: tooltip!, child: cont);
  }
}

/// --- Internal: leading content --------------------------------------------------

class _LeadingContent extends StatelessWidget {
  const _LeadingContent({
    required this.size,
    required this.icon,
    required this.label,
    required this.color,
  });

  final SplitButtonM3ESize size;
  final IconData? icon;
  final String? label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final m3e = context.m3e;
    final iconSize = size.iconPx;
    final lp = size.leftOuterPadding;
    final rp = size.labelRightPaddingBeforeDivider;
    final iconBlock = size.leadingIconBlockWidth;
    final gap = size.gapIconToLabel;

    // Scale label font-size with button size (xs/s unchanged).
    final bfs = m3e.typography.buttonFontSize;
    final double? labelFontSize = switch (size) {
      SplitButtonM3ESize.xs => bfs.xs,
      SplitButtonM3ESize.sm => bfs.sm,
      SplitButtonM3ESize.md => bfs.md,
      SplitButtonM3ESize.lg => bfs.lg,
      SplitButtonM3ESize.xl => bfs.xl,
    };

    Widget content;
    if (icon != null && (label?.isNotEmpty ?? false)) {
      content = Padding(
        padding: EdgeInsetsDirectional.only(start: lp, end: rp),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: iconBlock,
              child: Center(
                child: Icon(icon, size: iconSize, color: color),
              ),
            ),
            SizedBox(width: gap),
            Flexible(
              child: Text(
                label!,
                overflow: TextOverflow.ellipsis,
                style: m3e.typography.base.labelLarge?.copyWith(
                  color: color,
                  fontSize: labelFontSize,
                ),
              ),
            ),
          ],
        ),
      );
    } else if (icon != null) {
      content = Padding(
        padding: EdgeInsetsDirectional.only(start: lp, end: rp),
        child: SizedBox(
          width: iconBlock,
          child: Center(
            child: Icon(icon, size: iconSize, color: color),
          ),
        ),
      );
    } else {
      content = Padding(
        padding: EdgeInsetsDirectional.only(start: lp, end: rp),
        child: Text(
          label ?? '',
          overflow: TextOverflow.ellipsis,
          style: DefaultTextStyle.of(
            context,
          ).style.copyWith(color: color, fontSize: labelFontSize),
        ),
      );
    }
    return content;
  }
}

/// --- Internal: trailing chevron -------------------------------------------------

class _TrailingChevron extends StatelessWidget {
  const _TrailingChevron({
    required this.color,
    required this.size,
    required this.turns,
    required this.dxOffset,
  });

  final Color color;
  final double size;
  final double turns;
  final double dxOffset;

  @override
  Widget build(BuildContext context) {
    final icon = Icon(Icons.keyboard_arrow_down, size: size, color: color);

    return AnimatedRotation(
      duration: SplitButtonM3ETokens.chevronDuration,
      turns: turns,
      curve: SplitButtonM3ETokens.morphCurve,
      child: Transform.translate(offset: Offset(dxOffset, 0.0), child: icon),
    );
  }
}

/// --- Internal: corner radii helper (private to this file) -----------------------

class _CornerRadii {
  const _CornerRadii({
    required this.topStart,
    required this.bottomStart,
    required this.topEnd,
    required this.bottomEnd,
  });

  final double topStart, bottomStart, topEnd, bottomEnd;

  BorderRadius toBorderRadius(TextDirection direction) {
    return BorderRadiusDirectional.only(
      topStart: Radius.circular(topStart),
      bottomStart: Radius.circular(bottomStart),
      topEnd: Radius.circular(topEnd),
      bottomEnd: Radius.circular(bottomEnd),
    ).resolve(direction);
  }
}
