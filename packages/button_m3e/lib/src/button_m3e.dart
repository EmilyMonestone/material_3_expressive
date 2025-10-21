import 'package:flutter/material.dart';

import 'button_tokens_adapter.dart';
import 'enums.dart';

class ButtonM3E extends StatefulWidget {
  const ButtonM3E({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.style = ButtonM3EStyle.filled,
    this.size = ButtonM3ESize.sm,
    this.shape = ButtonM3EShape.round,
    this.selected = false,
    this.toggleable = false,
    this.onSelectedChange,
    this.smallPaddingDeprecated24 = false,
    this.enabled = true,
    this.statesController,
  });

  final VoidCallback? onPressed;
  final Widget label;
  final Widget? icon;
  final ButtonM3EStyle style;
  final ButtonM3ESize size;
  final ButtonM3EShape shape;
  final bool selected;
  final bool toggleable;
  final ValueChanged<bool>? onSelectedChange;
  final bool smallPaddingDeprecated24;
  final bool enabled;
  final WidgetStatesController? statesController;

  @override
  State<ButtonM3E> createState() => _ButtonM3EState();
}

class _ButtonM3EState extends State<ButtonM3E> {
  late WidgetStatesController _statesController;

  @override
  void initState() {
    super.initState();
    _statesController = widget.statesController ?? WidgetStatesController();
    _syncSelectedToController();
  }

  @override
  void didUpdateWidget(covariant ButtonM3E oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected != widget.selected && widget.toggleable) {
      _syncSelectedToController();
    }
  }

  void _syncSelectedToController() {
    _statesController.update(WidgetState.selected, widget.selected);
  }

  @override
  Widget build(BuildContext context) {
    final tokens = ButtonTokensAdapter(context,
        smallPaddingDeprecated24: widget.smallPaddingDeprecated24);
    final m = tokens.measurements(widget.size);
    final style = _resolveStyle(tokens, m);

    final onPressed = widget.enabled
        ? () {
            if (widget.toggleable) {
              final newVal = !widget.selected;
              widget.onSelectedChange?.call(newVal);
              if (widget.onSelectedChange == null) {
                _statesController.update(WidgetState.selected, newVal);
                setState(() {});
              }
            }
            widget.onPressed?.call();
          }
        : null;

    final child = _buildContent(m);

    switch (widget.style) {
      case ButtonM3EStyle.filled:
        return FilledButton(
          style: style,
          onPressed: onPressed,
          statesController: _statesController,
          child: child,
        );
      case ButtonM3EStyle.tonal:
        return FilledButton.tonal(
          style: style,
          onPressed: onPressed,
          statesController: _statesController,
          child: child,
        );
      case ButtonM3EStyle.elevated:
        return ElevatedButton(
          style: style,
          onPressed: onPressed,
          statesController: _statesController,
          child: child,
        );
      case ButtonM3EStyle.outlined:
        return OutlinedButton(
          style: style.copyWith(
            side: WidgetStateProperty.resolveWith((states) {
              final disabled = states.contains(WidgetState.disabled);
              return BorderSide(
                  color:
                      tokens.outline().withValues(alpha: disabled ? 0.12 : 1),
                  width: 1);
            }),
          ),
          onPressed: onPressed,
          statesController: _statesController,
          child: child,
        );
      case ButtonM3EStyle.text:
        return TextButton(
          style: style,
          onPressed: onPressed,
          statesController: _statesController,
          child: child,
        );
    }
  }

  Widget _buildContent(ButtonMeasurements m) {
    final text = DefaultTextStyle.merge(child: widget.label);
    if (widget.icon == null) return text;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconTheme.merge(
          data: IconThemeData(size: m.iconSize),
          child: widget.icon!,
        ),
        SizedBox(width: m.iconGap),
        text,
      ],
    );
  }

  OutlinedBorder _shapeFor(
      Set<WidgetState> states, ButtonTokensAdapter tokens) {
    final selected = states.contains(WidgetState.selected) || widget.selected;
    final pressed = states.contains(WidgetState.pressed);

    OutlinedBorder round = const StadiumBorder();
    OutlinedBorder square = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(tokens.squareRadius(widget.size)),
    );
    OutlinedBorder pressedSquare = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(tokens.pressedRadius(widget.size)),
    );

    OutlinedBorder base = widget.shape == ButtonM3EShape.round ? round : square;
    OutlinedBorder alt = widget.shape == ButtonM3EShape.round ? square : round;

    if (selected && pressed) {
      return OutlinedBorder.lerp(alt, pressedSquare, 0.5)!;
    } else if (selected) {
      return alt;
    } else if (pressed) {
      return OutlinedBorder.lerp(base, pressedSquare, 0.7)!;
    }
    return base;
  }

  ButtonStyle _resolveStyle(ButtonTokensAdapter tokens, ButtonMeasurements m) {
    final fg = WidgetStateProperty.resolveWith<Color?>((states) {
      final disabled = states.contains(WidgetState.disabled);
      final color = tokens.foreground(widget.style);
      return disabled ? color.withValues(alpha: 0.38) : color;
    });

    final bg = WidgetStateProperty.resolveWith<Color?>((states) {
      final disabled = states.contains(WidgetState.disabled);
      final color = tokens.container(widget.style);
      if (widget.style == ButtonM3EStyle.outlined ||
          widget.style == ButtonM3EStyle.text) {
        return Colors.transparent;
      }
      return disabled ? color.withValues(alpha: .12) : color;
    });

    final elevation = WidgetStateProperty.resolveWith<double>((states) {
      return tokens.elevation(widget.style, states);
    });

    final shape = WidgetStateProperty.resolveWith<OutlinedBorder>((states) {
      return _shapeFor(states, tokens);
    });

    return ButtonStyle(
      minimumSize: WidgetStateProperty.all(Size(48, m.height)),
      padding:
          WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: m.hPadding)),
      foregroundColor: fg,
      backgroundColor: bg,
      shape: shape,
      elevation: elevation,
      animationDuration: const Duration(milliseconds: 140),
      visualDensity: VisualDensity.standard,
      splashFactory: InkRipple.splashFactory,
    );
  }
}
