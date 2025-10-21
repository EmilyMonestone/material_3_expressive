import 'package:flutter/material.dart';
import 'package:m3e_design/m3e_design.dart';

import 'enums.dart';
import 'extended_fab_m3e.dart';

class FabMenuItem {
  FabMenuItem({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.semanticLabel,
  });

  final Widget icon;
  final Widget label;
  final VoidCallback onPressed;
  final String? semanticLabel;
}

class FabMenuController extends ChangeNotifier {
  bool _open = false;
  bool get isOpen => _open;
  void open() {
    if (!_open) {
      _open = true;
      notifyListeners();
    }
  }

  void close() {
    if (_open) {
      _open = false;
      notifyListeners();
    }
  }

  void toggle() {
    _open = !_open;
    notifyListeners();
  }
}

class FabMenuM3E extends StatefulWidget {
  const FabMenuM3E({
    super.key,
    required this.primaryFab,
    required this.items,
    this.direction = FabMenuDirection.up,
    this.spacing,
    this.overlay = true,
    this.overlayColor,
    this.controller,
    this.alignment = Alignment.bottomRight,
    this.popOnItemTap = true,
    this.heroTag,
  });

  /// The FAB that toggles the menu (typically a primary FabM3E or ExtendedFabM3E).
  final Widget primaryFab;

  /// Menu items displayed when open.
  final List<FabMenuItem> items;

  /// Direction in which children expand.
  final FabMenuDirection direction;

  /// Spacing between items.
  final double? spacing;

  /// Show a scrim overlay behind the menu when open.
  final bool overlay;
  final Color? overlayColor;

  /// Optional external controller; if omitted, an internal one is created.
  final FabMenuController? controller;

  /// Alignment within the Stack (e.g., bottomRight in a Scaffold).
  final Alignment alignment;

  /// Whether to automatically close the menu when an item is tapped.
  final bool popOnItemTap;

  final Object? heroTag;

  @override
  State<FabMenuM3E> createState() => _FabMenuM3EState();
}

class _FabMenuM3EState extends State<FabMenuM3E>
    with SingleTickerProviderStateMixin {
  late final FabMenuController _controller =
      widget.controller ?? FabMenuController();
  late final AnimationController _anim = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
    reverseDuration: const Duration(milliseconds: 150),
  );
  late final Animation<double> _scale = CurvedAnimation(
      parent: _anim,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic);

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onChange);
  }

  @override
  void dispose() {
    _controller.removeListener(_onChange);
    if (widget.controller == null) _controller.dispose();
    _anim.dispose();
    super.dispose();
  }

  void _onChange() {
    if (_controller.isOpen) {
      _anim.forward();
    } else {
      _anim.reverse();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.m3e.spacing; // use spacing scale via context extension
    final gap = widget.spacing ?? sp.md;

    final children = <Widget>[];

    for (int i = 0; i < widget.items.length; i++) {
      final item = widget.items[i];
      final w = _buildMenuItem(context, item);
      final animatedChild = ScaleTransition(
        scale: _scale,
        child: FadeTransition(
          opacity: _scale,
          child: w,
        ),
      );
      // Ensure Positioned is a direct child of the Stack
      children.add(_positioned(animatedChild, i, gap));
    }

    final menu = Stack(
      alignment: widget.alignment,
      clipBehavior: Clip.none,
      children: [
        // Primary FAB
        Align(
          alignment: widget.alignment,
          child: _wrapToggle(widget.primaryFab),
        ),
        // Menu items
        ...children,
      ],
    );

    final overlay = widget.overlay && _controller.isOpen
        ? Positioned.fill(
            child: GestureDetector(
              onTap: _controller.toggle,
              child: ColoredBox(
                color:
                    widget.overlayColor ?? Colors.black.withValues(alpha: 0.25),
              ),
            ),
          )
        : const SizedBox.shrink();

    return Stack(
      children: [
        overlay,
        Positioned.fill(
            child: IgnorePointer(
                ignoring: !_controller.isOpen, child: Container())),
        menu,
      ],
    );
  }

  Widget _wrapToggle(Widget child) {
    final core = GestureDetector(
      onTap: _controller.toggle,
      behavior: HitTestBehavior.opaque,
      child: child,
    );

    if (widget.heroTag != null && context.findAncestorWidgetOfExactType<Hero>() == null) {
      return Hero(tag: widget.heroTag!, child: core);
    }
    return core;
  }

  Widget _positioned(Widget child, int index, double gap) {
    final offset = (index + 1) *
        (gap +
            56); // base step; extended affects height, but 56 is a practical default
    switch (widget.direction) {
      case FabMenuDirection.up:
        return Positioned(
          right: 0,
          bottom: offset,
          child: child,
        );
      case FabMenuDirection.down:
        return Positioned(
          right: 0,
          top: offset,
          child: child,
        );
      case FabMenuDirection.left:
        return Positioned(
          right: offset,
          bottom: 0,
          child: child,
        );
      case FabMenuDirection.right:
        return Positioned(
          left: offset,
          bottom: 0,
          child: child,
        );
    }
  }

  Widget _buildMenuItem(BuildContext context, FabMenuItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: ExtendedFabM3E(
        icon: item.icon,
        label: item.label,
        onPressed: () {
          item.onPressed();
          if (widget.popOnItemTap) _controller.close();
        },
        kind: FabM3EKind.surface,
        size: FabM3ESize.regular,
        density: FabM3EDensity.regular,
        semanticLabel: item.semanticLabel,
      ),
    );
  }
}
