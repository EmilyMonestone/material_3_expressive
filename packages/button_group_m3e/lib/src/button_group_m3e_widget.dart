import 'package:button_m3e/button_m3e.dart';
import 'package:flutter/material.dart';

import '_tokens_adapter.dart';
import 'button_group_m3e_enums.dart';
import 'button_group_m3e_scope.dart';

/// Controls how ButtonGroupM3E handles overflow when wrap=false.
enum ButtonGroupM3EOverflow {
  /// Do not handle overflow specially (may overflow if parent allows),
  /// essentially keeps the original Row/Column with mainAxisSize.min.
  none,

  /// Allow scrolling along the layout axis when constraints are bounded.
  scroll,

  /// Replace overflow with a trailing overflow menu button that contains
  /// the remaining children.
  menu,
}

/// Style for the overflow menu when [overflow] == menu.
enum ButtonGroupM3EOverflowMenuStyle { dropdown, bottomSheet }

/// Declarative action description used by [ButtonGroupM3E] when building its buttons.
class ButtonGroupM3EAction {
  const ButtonGroupM3EAction({
    required this.label,
    this.icon,
    this.onPressed,
    this.enabled = true,
    this.style,
    this.toggleable = false,
    this.selected = false,
    this.onSelectedChange,
    this.shape, // optional override shape per action
  });

  final Widget label;
  final Widget? icon;
  final VoidCallback? onPressed;
  final bool enabled;
  final ButtonM3EStyle? style;
  final bool toggleable;
  final bool selected;
  final ValueChanged<bool>? onSelectedChange;
  final ButtonM3EShape? shape; // if null group decides

  ButtonGroupM3EAction copyWith({
    Widget? label,
    Widget? icon,
    VoidCallback? onPressed,
    bool? enabled,
    ButtonM3EStyle? style,
    bool? toggleable,
    bool? selected,
    ValueChanged<bool>? onSelectedChange,
    ButtonM3EShape? shape,
  }) =>
      ButtonGroupM3EAction(
        label: label ?? this.label,
        icon: icon ?? this.icon,
        onPressed: onPressed ?? this.onPressed,
        enabled: enabled ?? this.enabled,
        style: style ?? this.style,
        toggleable: toggleable ?? this.toggleable,
        selected: selected ?? this.selected,
        onSelectedChange: onSelectedChange ?? this.onSelectedChange,
        shape: shape ?? this.shape,
      );
}

class ButtonGroupM3E extends StatefulWidget {
  const ButtonGroupM3E({
    super.key,
    this.actions = const <ButtonGroupM3EAction>[],
    this.type = ButtonGroupM3EType.standard,
    this.shape = ButtonGroupM3EShape.square,
    this.size = ButtonGroupM3ESize.sm,
    this.style = ButtonM3EStyle.filled,
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
    this.overflow = ButtonGroupM3EOverflow.menu,
    this.overflowIcon,
    this.overflowSheetTitle,
    this.selection = false,
    this.selectedIndex,
    this.overflowMenuStyle = ButtonGroupM3EOverflowMenuStyle.dropdown,
  });

  /// Declarative actions to build buttons. Overrides [children] when not empty.
  final List<ButtonGroupM3EAction> actions;

  final ButtonGroupM3EType type;
  final ButtonGroupM3EShape shape;
  final ButtonGroupM3ESize size;
  final ButtonM3EStyle style;
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

  /// Overflow management behavior when [wrap] is false.
  final ButtonGroupM3EOverflow overflow;

  /// Icon for the overflow menu trigger when [overflow] == menu.
  final Widget? overflowIcon;

  /// Optional title shown at the top of the overflow sheet.
  final Widget? overflowSheetTitle;

  /// Enables group selection styling behavior.
  /// When true: by default inner buttons are square, outer (first & last) have round outer ends.
  /// When a button is selected (via [selectedIndex] or action.selected) it becomes fully round.
  final bool selection;

  /// Index of selected button when [selection] true (external control).
  /// If null will use each action's [selected] flag (toggle groups).
  final int? selectedIndex;

  /// How to display the overflow menu when [overflow] == menu. Defaults to dropdown.
  final ButtonGroupM3EOverflowMenuStyle overflowMenuStyle;

  bool get _connected => type == ButtonGroupM3EType.connected;

  @override
  State<ButtonGroupM3E> createState() => _ButtonGroupM3EState();
}

class _ButtonGroupM3MItemMeasure {
  const _ButtonGroupM3MItemMeasure(this.mainExtent);
  final double mainExtent; // width for horizontal, height for vertical
}

class _ButtonGroupM3EState extends State<ButtonGroupM3E> {
  // Measurement keys for each child to derive main-axis extents.
  late List<GlobalKey> _childKeys;
  final GlobalKey _overflowKey = GlobalKey();
  final LayerLink _overflowLink = LayerLink();
  OverlayEntry? _overflowEntry;

  // Last measured extents for children and overflow trigger.
  List<_ButtonGroupM3MItemMeasure>? _measuredChildren;
  double? _measuredOverflowExtent;
  double? _lastMaxMainExtent;

  List<ButtonGroupM3EAction> get _effectiveActions => widget.actions;

  @override
  void initState() {
    super.initState();
    _initKeys();
  }

  @override
  void didUpdateWidget(covariant ButtonGroupM3E oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.actions.length != widget.actions.length) {
      _initKeys();
      _measuredChildren = null;
      _measuredOverflowExtent = null;
    }
  }

  void _initKeys() {
    _childKeys =
        List<GlobalKey>.generate(_effectiveActions.length, (_) => GlobalKey());
  }

  @override
  Widget build(BuildContext context) {
    final tokens = metricsFor(context, widget.size, widget.density);
    final cs = Theme.of(context).colorScheme;
    final dividerClr =
        widget.dividerColor ?? cs.outlineVariant.withValues(alpha: 0.6);
    final dividerThk =
        (widget.dividerThickness ?? tokens.dividerThickness).clamp(0.5, 2.0);

    final group = ButtonGroupM3EScope(
      type: widget.type,
      shape: widget.shape,
      size: widget.size,
      density: widget.density,
      direction: widget.direction,
      isConnected: widget._connected,
      child: _buildContent(
        context,
        /* spacing/run */ (widget._connected
            ? 0.0
            : (widget.spacing ?? tokens.spacing)),
        (widget.wrap ? (widget.runSpacing ?? tokens.runSpacing) : 0.0),
        /* div */ dividerClr,
        dividerThk,
      ),
    );

    final semantics = Semantics(
      container: true,
      label: widget.semanticLabel,
      child: group,
    );

    if (widget.clipBehavior == Clip.none) return semantics;
    return ClipRRect(
      clipBehavior: widget.clipBehavior,
      borderRadius: radiusFor(context, widget.shape, widget.size),
      child: semantics,
    );
  }

  Widget _buildContent(
    BuildContext context,
    double spacing,
    double runSpacing,
    Color dividerColor,
    double dividerThickness,
  ) {
    if (_effectiveActions.isEmpty) return const SizedBox.shrink();

    if (widget.wrap) {
      return _wrapLayout(context, spacing, runSpacing);
    }

    // Overflow handling when wrap=false
    switch (widget.overflow) {
      case ButtonGroupM3EOverflow.none:
        return _linearCore(context, spacing, dividerColor, dividerThickness);
      case ButtonGroupM3EOverflow.scroll:
        return _linearScrollable(
            context, spacing, dividerColor, dividerThickness);
      case ButtonGroupM3EOverflow.menu:
        return _linearWithOverflowMenu(
          context,
          spacing,
          runSpacing,
          dividerColor,
          dividerThickness,
        );
    }
  }

  // Original linear layout (no overflow management)
  Widget _linearCore(BuildContext context, double spacing, Color dividerColor,
      double dividerThickness) {
    final list = _buildItemList(
        context, spacing, dividerColor, dividerThickness,
        count: _effectiveActions.length);
    return widget.direction == Axis.horizontal
        ? Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: _mapCross(widget.crossAxisAlignment),
            children: list,
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: _mapCross(widget.crossAxisAlignment),
            children: list,
          );
  }

  // Scrollable variant used previously to prevent RenderFlex overflow.
  Widget _linearScrollable(BuildContext context, double spacing,
      Color dividerColor, double dividerThickness) {
    final list = _buildItemList(
        context, spacing, dividerColor, dividerThickness,
        count: _effectiveActions.length);
    return LayoutBuilder(
      builder: (context, constraints) {
        final isBounded = widget.direction == Axis.horizontal
            ? constraints.hasBoundedWidth
            : constraints.hasBoundedHeight;

        final core = widget.direction == Axis.horizontal
            ? Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: _mapCross(widget.crossAxisAlignment),
                children: list,
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: _mapCross(widget.crossAxisAlignment),
                children: list,
              );

        if (isBounded) {
          return SingleChildScrollView(
            scrollDirection: widget.direction,
            primary: false,
            clipBehavior: Clip.hardEdge,
            child: core,
          );
        }
        return core;
      },
    );
  }

  // Overflow menu variant: shows visible children that fit, plus a trailing overflow trigger.
  Widget _linearWithOverflowMenu(
    BuildContext context,
    double spacing,
    double runSpacing,
    Color dividerColor,
    double dividerThickness,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxMain = widget.direction == Axis.horizontal
            ? constraints.maxWidth
            : constraints.maxHeight;
        if (!maxMain.isFinite) {
          if (_lastMaxMainExtent != maxMain || _measuredChildren == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) return;
              setState(() {
                _lastMaxMainExtent = maxMain;
                _measuredChildren = null;
                _measuredOverflowExtent = null;
              });
            });
          }
          return _linearCore(context, spacing, dividerColor, dividerThickness);
        }
        // Schedule measurement pass
        WidgetsBinding.instance
            .addPostFrameCallback((_) => _measureChildrenMainExtents());

        final sizes = _measuredChildren;
        final fallbackChild = _defaultChildMainExtent();
        final overflowTriggerExtent =
            _measuredOverflowExtent ?? _defaultOverflowExtent();
        const double eps = 0.75; // safety margin

        // Build list of child main extents
        final childExtents = <double>[];
        for (var i = 0; i < _effectiveActions.length; i++) {
          final e = (sizes != null && i < sizes.length)
              ? sizes[i].mainExtent
              : fallbackChild;
          childExtents.add(e);
        }

        double sepBetweenItems(int indexBefore) {
          if (widget._connected) {
            return widget.showDividers
                ? dividerThickness
                : 2.0; // gap or divider
          }
          return spacing;
        }

        double sepBeforeOverflow(int visibleCount) {
          if (visibleCount == 0) return 0; // no gap if overflow trigger first
          return widget._connected
              ? (widget.showDividers ? dividerThickness : 2.0)
              : spacing;
        }

        double widthForFirstN(int n) {
          double total = 0;
          for (int i = 0; i < n; i++) {
            if (i > 0) total += sepBetweenItems(i - 1);
            total += childExtents[i];
          }
          return total;
        }

        int totalCount = childExtents.length;
        int visible = totalCount;
        bool needsOverflow = false;

        // Try exact fit from all down to 0
        for (int n = totalCount; n >= 0; n--) {
          final itemsWidth = widthForFirstN(n);
          if (n == totalCount) {
            if (itemsWidth <= maxMain - eps) {
              visible = n;
              needsOverflow = false;
              break;
            }
            // else continue testing smaller n with overflow
          } else {
            final overflowGap = sepBeforeOverflow(n);
            final totalNeeded =
                itemsWidth + overflowGap + overflowTriggerExtent;
            if (totalNeeded <= maxMain - eps) {
              visible = n;
              needsOverflow = true;
              break;
            }
          }
        }

        final visibleList = _buildItemList(
          context,
          spacing,
          dividerColor,
          dividerThickness,
          count: visible,
        );
        if (needsOverflow) {
          if (visibleList.isNotEmpty) {
            final gap = widget._connected
                ? (widget.showDividers ? dividerThickness : 2.0)
                : spacing;
            if (widget._connected && widget.showDividers) {
              visibleList.add(_buildDivider(dividerColor, dividerThickness));
            } else if (gap > 0) {
              visibleList.add(_spacer(gap));
            }
          }
          visibleList.add(_buildOverflowTrigger(
            context,
            spacing,
            dividerColor,
            dividerThickness,
            startIndex: visible,
          ));
        }

        final coreChildren = visibleList;
        final core = widget.direction == Axis.horizontal
            ? ClipRect(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: _mapCross(widget.crossAxisAlignment),
                  children: coreChildren,
                ),
              )
            : ClipRect(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: _mapCross(widget.crossAxisAlignment),
                  children: coreChildren,
                ),
              );

        final measurer = Offstage(
          offstage: true,
          child: _buildMeasurer(
              spacing, runSpacing, dividerColor, dividerThickness),
        );
        return Stack(children: [core, measurer]);
      },
    );
  }

  // Builds a hidden Wrap that lays out all children (with the same child wrappers),
  // so we can measure their main-axis extents safely without overflow.
  Widget _buildMeasurer(double spacing, double runSpacing, Color dividerColor,
      double dividerThickness) {
    final wrapped = List<Widget>.generate(_effectiveActions.length, (i) {
      final isFirst = i == 0;
      final isLast = i == _effectiveActions.length - 1;
      final child = _wrapItemScope(
        context,
        index: i,
        count: _effectiveActions.length,
        isFirst: isFirst,
        isLast: isLast,
        child: _maybeEqualized(_buildButtonForAction(i, _effectiveActions[i])),
      );
      return KeyedSubtree(key: _childKeys[i], child: child);
    });

    return Directionality(
      textDirection: Directionality.of(context),
      child: ConstrainedBox(
        constraints: const BoxConstraints(),
        child: Wrap(
          direction: widget.direction,
          spacing: spacing,
          runSpacing: runSpacing,
          alignment: widget.alignment,
          runAlignment: widget.runAlignment,
          crossAxisAlignment: widget.crossAxisAlignment,
          children: wrapped,
        ),
      ),
    );
  }

  void _measureChildrenMainExtents() {
    if (!mounted) return;
    final newMeasures = <_ButtonGroupM3MItemMeasure>[];
    for (var i = 0; i < _childKeys.length; i++) {
      final ctx = _childKeys[i].currentContext;
      final render = ctx?.findRenderObject() as RenderBox?;
      if (render != null && render.hasSize) {
        final size = render.size;
        final main =
            widget.direction == Axis.horizontal ? size.width : size.height;
        newMeasures.add(_ButtonGroupM3MItemMeasure(main));
      } else {
        // fallback fill
        final fallback = _defaultChildMainExtent();
        newMeasures.add(_ButtonGroupM3MItemMeasure(fallback));
      }
    }

    // Measure overflow trigger extent
    final octx = _overflowKey.currentContext;
    final orender = octx?.findRenderObject() as RenderBox?;
    double? overflowExtent;
    if (orender != null && orender.hasSize) {
      final sz = orender.size;
      overflowExtent =
          widget.direction == Axis.horizontal ? sz.width : sz.height;
    }

    final changed = _measuredChildren == null ||
        _measuredChildren!.length != newMeasures.length ||
        !_listAlmostEqual(_measuredChildren!, newMeasures);

    if (changed ||
        (_measuredOverflowExtent == null && overflowExtent != null)) {
      setState(() {
        _measuredChildren = newMeasures;
        if (overflowExtent != null) _measuredOverflowExtent = overflowExtent;
      });
    }
  }

  bool _listAlmostEqual(
      List<_ButtonGroupM3MItemMeasure> a, List<_ButtonGroupM3MItemMeasure> b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if ((a[i].mainExtent - b[i].mainExtent).abs() > 0.5) return false;
    }
    return true;
  }

  double _defaultChildMainExtent() {
    // Conservative fallbacks to avoid first-frame overflow before measurement.
    if (widget.direction == Axis.horizontal) {
      switch (widget.size) {
        case ButtonGroupM3ESize.xs:
          return 56.0;
        case ButtonGroupM3ESize.sm:
          return 80.0;
        case ButtonGroupM3ESize.md:
          return 100.0;
        case ButtonGroupM3ESize.lg:
          return 120.0;
        case ButtonGroupM3ESize.xl:
          return 140.0;
      }
    } else {
      return _buttonHeightForSize();
    }
  }

  double _defaultOverflowExtent() {
    // Approximate minimal icon button size along main axis (Material min is 48)
    return widget.direction == Axis.horizontal ? 48.0 : _buttonHeightForSize();
  }

  double _buttonHeightForSize() {
    switch (widget.size) {
      case ButtonGroupM3ESize.xs:
        return 28.0;
      case ButtonGroupM3ESize.sm:
        return 32.0;
      case ButtonGroupM3ESize.md:
        return 40.0;
      case ButtonGroupM3ESize.lg:
        return 48.0;
      case ButtonGroupM3ESize.xl:
        return 56.0;
    }
  }

  List<Widget> _buildItemList(
    BuildContext context,
    double spacing,
    Color dividerColor,
    double dividerThickness, {
    required int count,
  }) {
    final list = <Widget>[];
    final capped = count.clamp(0, _effectiveActions.length);
    for (var i = 0; i < capped; i++) {
      final isFirst = i == 0;
      final isLast = i == capped - 1;
      final action = _effectiveActions[i];

      final button =
          _buildButtonForAction(i, action, isFirst: isFirst, isLast: isLast);

      final child = _wrapItemScope(
        context,
        index: i,
        count: capped,
        isFirst: isFirst,
        isLast: isLast,
        child: _maybeEqualized(button),
      );
      list.add(child);

      final isBetween = i < capped - 1;
      if (!isBetween) continue;

      if (widget._connected) {
        if (widget.showDividers) {
          list.add(_buildDivider(dividerColor, dividerThickness));
        } else {
          // connected small gap between items
          list.add(_spacer(2.0));
        }
      } else {
        list.add(_spacer(spacing));
      }
    }
    return list;
  }

  Widget _buildButtonForAction(int index, ButtonGroupM3EAction action,
      {bool isFirst = false, bool isLast = false}) {
    final selected = widget.selectedIndex != null
        ? widget.selectedIndex == index
        : action.selected;

    ButtonM3EShape shapeOut;
    BorderRadius? perCorner;
    if (!widget.selection) {
      shapeOut = action.shape ?? _mapGroupShape(widget.shape);
    } else {
      if (selected) {
        shapeOut = ButtonM3EShape.round; // selected always fully round
      } else {
        if (widget._connected) {
          // Connected + selection: interior corners should have square token radius; outer ends rounded.
          shapeOut = ButtonM3EShape.square;
          // Obtain square base radius from button tokens for inner corners.
          final squareRadiusVal = ButtonTokensAdapter(context)
              .squareRadius(_mapGroupSize(widget.size));
          final innerRadius = Radius.circular(squareRadiusVal);
          // Obtain round radius set for outer corners.
          final roundSet =
              radiusFor(context, ButtonGroupM3EShape.round, widget.size);
          if (widget.direction == Axis.horizontal) {
            if (isFirst) {
              perCorner = BorderRadius.only(
                topLeft: roundSet.topLeft,
                bottomLeft: roundSet.bottomLeft,
                topRight: innerRadius,
                bottomRight: innerRadius,
              );
            } else if (isLast) {
              perCorner = BorderRadius.only(
                topLeft: innerRadius,
                bottomLeft: innerRadius,
                topRight: roundSet.topRight,
                bottomRight: roundSet.bottomRight,
              );
            } else {
              // Middle buttons: all corners square token radius
              perCorner = BorderRadius.all(innerRadius);
            }
          } else {
            // Vertical direction
            if (isFirst) {
              perCorner = BorderRadius.only(
                topLeft: roundSet.topLeft,
                topRight: roundSet.topRight,
                bottomLeft: innerRadius,
                bottomRight: innerRadius,
              );
            } else if (isLast) {
              perCorner = BorderRadius.only(
                topLeft: innerRadius,
                topRight: innerRadius,
                bottomLeft: roundSet.bottomLeft,
                bottomRight: roundSet.bottomRight,
              );
            } else {
              perCorner = BorderRadius.all(innerRadius);
            }
          }
        } else {
          // Non-connected selection: ends fully round, inner square token radius.
          if (isFirst || isLast) {
            shapeOut = ButtonM3EShape.round;
            perCorner = null; // round shape handles corners
          } else {
            shapeOut = ButtonM3EShape.square;
            final squareRadiusVal = ButtonTokensAdapter(context)
                .squareRadius(_mapGroupSize(widget.size));
            perCorner = BorderRadius.all(Radius.circular(squareRadiusVal));
          }
        }
      }
    }

    return ButtonM3E(
      onPressed: action.onPressed,
      label: action.label,
      icon: action.icon,
      style: action.style ?? widget.style,
      size: _mapGroupSize(widget.size),
      shape: shapeOut,
      selected: selected,
      toggleable: action.toggleable || widget.selectedIndex != null,
      onSelectedChange: (val) {
        action.onSelectedChange?.call(val);
        if (widget.selectedIndex == null && action.onSelectedChange == null) {
          setState(() {
            widget.actions[index] = action.copyWith(selected: val);
          });
        } else {
          setState(() {});
        }
      },
      enabled: action.enabled,
      cornerRadiusOverride: perCorner,
    );
  }

  ButtonM3ESize _mapGroupSize(ButtonGroupM3ESize s) => switch (s) {
        ButtonGroupM3ESize.xs => ButtonM3ESize.xs,
        ButtonGroupM3ESize.sm => ButtonM3ESize.sm,
        ButtonGroupM3ESize.md => ButtonM3ESize.md,
        ButtonGroupM3ESize.lg => ButtonM3ESize.lg,
        ButtonGroupM3ESize.xl => ButtonM3ESize.xl,
      };
  ButtonM3EShape _mapGroupShape(ButtonGroupM3EShape s) =>
      s == ButtonGroupM3EShape.round
          ? ButtonM3EShape.round
          : ButtonM3EShape.square;

  CrossAxisAlignment _mapCross(WrapCrossAlignment w) {
    switch (w) {
      case WrapCrossAlignment.start:
        return CrossAxisAlignment.start;
      case WrapCrossAlignment.end:
        return CrossAxisAlignment.end;
      case WrapCrossAlignment.center:
        return CrossAxisAlignment.center;
    }
  }

  Widget _buildOverflowTrigger(
    BuildContext context,
    double spacing,
    Color dividerColor,
    double dividerThickness, {
    required int startIndex,
  }) {
    final icon = widget.overflowIcon ?? const Icon(Icons.more_horiz);

    // Build trigger as a ButtonM3E to look like other buttons.
    final triggerButton = ButtonM3E(
      key: _overflowKey,
      onPressed: () => _showOverflow(context, startIndex),
      label: icon,
      style: widget.style,
      size: _mapGroupSize(widget.size),
      shape: _mapGroupShape(widget.shape),
      enabled: true,
    );

    final target = CompositedTransformTarget(
      link: _overflowLink,
      child: ConstrainedBox(
        constraints: widget.direction == Axis.horizontal
            ? const BoxConstraints(minWidth: 40)
            : BoxConstraints(minHeight: _buttonHeightForSize()),
        child: triggerButton,
      ),
    );

    return ButtonGroupM3EItemScope(
      index: startIndex,
      count: _effectiveActions.length,
      isFirst: startIndex == 0,
      isLast: startIndex == _effectiveActions.length - 1,
      child: target,
    );
  }

  Future<void> _showOverflow(BuildContext context, int startIndex) async {
    switch (widget.overflowMenuStyle) {
      case ButtonGroupM3EOverflowMenuStyle.dropdown:
        return _showOverflowDropdown(context, startIndex);
      case ButtonGroupM3EOverflowMenuStyle.bottomSheet:
        return _showOverflowBottomSheet(context, startIndex);
    }
  }

  Future<void> _showOverflowDropdown(
      BuildContext context, int startIndex) async {
    // Build actions that close the dropdown before invoking onPressed
    final actions = <ButtonGroupM3EAction>[];
    for (var i = startIndex; i < _effectiveActions.length; i++) {
      final a = _effectiveActions[i];
      actions.add(a.copyWith(onPressed: () {
        _removeOverflowEntry();
        a.onPressed?.call();
      }));
    }
    if (actions.isEmpty) return;

    // Remove any existing entry
    _removeOverflowEntry();

    final overlay = Overlay.of(context, rootOverlay: true);
    if (overlay == null) return;

    _overflowEntry = OverlayEntry(
      builder: (ctx) {
        return Stack(
          children: [
            // Tapping outside dismisses the dropdown
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _removeOverflowEntry,
              ),
            ),
            CompositedTransformFollower(
              link: _overflowLink,
              showWhenUnlinked: false,
              targetAnchor: Alignment.bottomRight,
              followerAnchor: Alignment.topRight,
              offset: const Offset(0, 4), // small vertical gap
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(8),
                clipBehavior: Clip.antiAlias,
                child: IntrinsicWidth(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 6,
                    ),
                    child: ButtonGroupM3E(
                      type: widget.type,
                      shape: widget.shape,
                      size: widget.size,
                      style: widget.style,
                      density: widget.density,
                      direction: Axis.vertical,
                      wrap: false,
                      spacing: 6,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment:
                          WrapCrossAlignment.end, // right align buttons
                      showDividers: false,
                      equalizeWidths: true,
                      clipBehavior: Clip.none,
                      overflow: ButtonGroupM3EOverflow.none,
                      selection: false,
                      actions: actions,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    overlay.insert(_overflowEntry!);
  }

  Future<void> _showOverflowBottomSheet(
      BuildContext context, int startIndex) async {
    final overflowActions = <ButtonGroupM3EAction>[];
    for (var i = startIndex; i < _effectiveActions.length; i++) {
      overflowActions.add(_effectiveActions[i]);
    }

    if (overflowActions.isEmpty) return;

    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (widget.overflowSheetTitle != null) ...[
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.titleMedium!,
                    child: widget.overflowSheetTitle!,
                  ),
                  const SizedBox(height: 12),
                ],
                ButtonGroupM3E(
                  type: widget.type,
                  shape: widget.shape,
                  size: widget.size,
                  density: widget.density,
                  direction: widget.direction,
                  wrap: true,
                  spacing: widget.spacing,
                  runSpacing: widget.runSpacing,
                  alignment: widget.alignment,
                  runAlignment: widget.runAlignment,
                  crossAxisAlignment: widget.crossAxisAlignment,
                  showDividers: widget.showDividers,
                  dividerColor: widget.dividerColor,
                  dividerThickness: widget.dividerThickness,
                  equalizeWidths: widget.equalizeWidths,
                  clipBehavior: widget.clipBehavior,
                  overflow: ButtonGroupM3EOverflow.none,
                  selection: widget.selection,
                  selectedIndex: widget.selectedIndex,
                  actions: overflowActions,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _wrapLayout(BuildContext context, double spacing, double runSpacing) {
    final wrapped = List<Widget>.generate(_effectiveActions.length, (i) {
      final isFirst = i == 0;
      final isLast = i == _effectiveActions.length - 1;
      return _wrapItemScope(
        context,
        index: i,
        count: _effectiveActions.length,
        isFirst: isFirst,
        isLast: isLast,
        child: _maybeEqualized(_buildButtonForAction(i, _effectiveActions[i])),
      );
    });

    return Wrap(
      direction: widget.direction,
      spacing: spacing,
      runSpacing: runSpacing,
      alignment: widget.alignment,
      runAlignment: widget.runAlignment,
      crossAxisAlignment: widget.crossAxisAlignment,
      children: wrapped,
    );
  }

  Widget _wrapItemScope(BuildContext context,
      {required int index,
      required int count,
      required bool isFirst,
      required bool isLast,
      required Widget child}) {
    return ButtonGroupM3EItemScope(
      index: index,
      count: count,
      isFirst: isFirst,
      isLast: isLast,
      child: child,
    );
  }

  @override
  void dispose() {
    _removeOverflowEntry();
    super.dispose();
  }

  void _removeOverflowEntry() {
    _overflowEntry?.remove();
    _overflowEntry = null;
  }

  Widget _spacer(double spacing) => widget.direction == Axis.horizontal
      ? SizedBox(width: spacing)
      : SizedBox(height: spacing);

  Widget _buildDivider(Color color, double thickness) {
    return widget.direction == Axis.horizontal
        ? Container(width: thickness, height: 24, color: color)
        : Container(height: thickness, width: 24, color: color);
  }

  Widget _maybeEqualized(Widget child) {
    if (!widget.equalizeWidths) return child;
    final minW = switch (widget.size) {
      ButtonGroupM3ESize.xs => 40.0,
      ButtonGroupM3ESize.sm => 56.0,
      ButtonGroupM3ESize.md => 72.0,
      ButtonGroupM3ESize.lg => 96.0,
      ButtonGroupM3ESize.xl => 120.0,
    };
    return ConstrainedBox(
        constraints: BoxConstraints(minWidth: minW), child: child);
  }
}
