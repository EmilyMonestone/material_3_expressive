import 'package:fab_m3e/fab_m3e.dart';
import 'package:flutter/material.dart';
import 'package:icon_button_m3e/icon_button_m3e.dart';

import 'modality.dart';
import 'rail_destination_m3e.dart';
import 'rail_fab_slot.dart';
import 'rail_item.dart';
import 'rail_section_m3e.dart';
import 'rail_theme.dart';
import 'rail_tokens_adapter.dart';
import 'type.dart';

/// Material 3 Expressive Navigation Rail — single widget that animates between states.
class NavigationRailM3E extends StatefulWidget {
  /// Creates a Material 3 Expressive navigation rail.
  const NavigationRailM3E({
    super.key,
    required this.type,
    this.modality = NavigationRailM3EModality.standard,
    required this.sections,
    required this.selectedIndex,
    required this.onDestinationSelected,
    this.fab,
    this.hideWhenCollapsed = false,
    this.expandedWidth,
    this.onDismissModal,
    this.onTypeChanged,
  });

  /// Presentation type for the rail (collapsed or expanded).
  final NavigationRailM3EType type;

  /// How the rail is shown (standard or modal overlay).
  final NavigationRailM3EModality modality;

  /// Sections and destinations to display.
  final List<NavigationRailM3ESection> sections;

  /// Index of the currently selected destination.
  final int selectedIndex;

  /// Called when a destination is selected.
  final ValueChanged<int> onDestinationSelected;

  /// Optional FAB/extended FAB shown near the top cluster.
  final NavigationRailM3EFabSlot? fab;

  /// When [type] is collapsed and this is true, rail animates to width 0.
  final bool hideWhenCollapsed;

  /// Custom expanded width (220–360). Clamped to theme bounds.
  final double? expandedWidth;

  /// Called to dismiss when in modal mode.
  final VoidCallback? onDismissModal;

  /// Called when the built-in menu button toggles the rail type.
  final ValueChanged<NavigationRailM3EType>? onTypeChanged;

  @override
  State<NavigationRailM3E> createState() => _NavigationRailM3EState();
}

class _NavigationRailM3EState extends State<NavigationRailM3E>
    with TickerProviderStateMixin {
  OverlayEntry? _modalEntry;

  bool get _isExpanded => widget.type == NavigationRailM3EType.expanded;
  bool get _isModal => widget.modality == NavigationRailM3EModality.modal;
  bool get _needsOverlay => _isModal;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _syncOverlay());
  }

  @override
  void didUpdateWidget(covariant NavigationRailM3E oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) => _syncOverlay());
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _syncOverlay() {
    if (!mounted) return;
    if (_needsOverlay) {
      if (_modalEntry == null) {
        _insertOverlay();
      } else {
        _modalEntry!.markNeedsBuild();
      }
    } else {
      _removeOverlay();
    }
  }

  void _insertOverlay() {
    final overlay = Overlay.of(context, rootOverlay: true);
    if (overlay == null) return;
    _modalEntry = OverlayEntry(builder: (ctx) => _buildModalOverlay(ctx));
    overlay.insert(_modalEntry!);
  }

  void _removeOverlay() {
    _modalEntry?.remove();
    _modalEntry = null;
  }

  Widget _buildModalOverlay(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: IgnorePointer(
            ignoring: !_isExpanded,
            child: GestureDetector(
              onTap: widget.onDismissModal,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeOutCubic,
                color: Theme.of(context)
                    .colorScheme
                    .scrim
                    .withValues(alpha: _isExpanded ? 0.32 : 0.0),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Material(
            type: MaterialType.transparency,
            child: _buildRailCore(context),
          ),
        ),
      ],
    );
  }

  double _targetWidth(BuildContext context) {
    final theme = Theme.of(context).extension<NavigationRailM3ETheme>() ??
        const NavigationRailM3ETheme();
    final isExpanded = _isExpanded;
    return isExpanded
        ? (widget.expandedWidth ?? theme.expandedMinWidth)
            .clamp(theme.expandedMinWidth, theme.expandedMaxWidth)
            .toDouble()
        : (widget.hideWhenCollapsed ? 0.0 : theme.collapsedWidth);
  }

  Widget _buildMenuButton(BuildContext context,
      {required Alignment alignment}) {
    final isExpanded = _isExpanded;
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 16, end: 16, bottom: 12),
      child: Align(
        alignment: alignment,
        child: IconButtonM3E(
          icon: Icon(isExpanded ? Icons.menu_open : Icons.menu),
          tooltip: isExpanded ? 'Collapse' : 'Expand',
          onPressed: widget.onTypeChanged == null
              ? null
              : () => widget.onTypeChanged!(
                    isExpanded
                        ? NavigationRailM3EType.collapsed
                        : NavigationRailM3EType.expanded,
                  ),
        ),
      ),
    );
  }

  Widget? _buildFab(BuildContext context) {
    final fab = widget.fab;
    if (fab == null) return null;
    final isExpanded = _isExpanded;
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 16, end: 16, bottom: 12),
      child: isExpanded
          ? ExtendedFabM3E(
              label: Text(fab.label),
              icon: fab.icon,
              onPressed: fab.onPressed,
              tooltip: fab.tooltip,
              heroTag: fab.heroTag,
              kind: fab.kind,
              size: fab.size,
              shapeFamily: FabM3EShapeFamily.square,
              density: fab.density,
              elevation: fab.elevation,
              semanticLabel: fab.semanticLabel,
            )
          : FabM3E(
              icon: fab.icon,
              onPressed: fab.onPressed,
              tooltip: fab.tooltip,
              heroTag: fab.heroTag,
              kind: fab.kind,
              size: fab.size,
              shapeFamily: FabM3EShapeFamily.square,
              density: fab.density,
              elevation: fab.elevation,
              semanticLabel: fab.semanticLabel,
            ),
    );
  }

  List<Widget> _buildChildren(BuildContext context) {
    final theme = Theme.of(context).extension<NavigationRailM3ETheme>() ??
        const NavigationRailM3ETheme();
    final isExpanded = _isExpanded;

    final children = <Widget>[];
    children.add(const SizedBox(height: 36));
    children.add(_buildMenuButton(context,
        alignment: isExpanded ? Alignment.centerLeft : Alignment.center));
    final fabWidget = _buildFab(context);
    if (fabWidget != null) children.add(fabWidget);

    if (isExpanded) {
      for (final section in widget.sections) {
        if (section.header != null) {
          children.add(Padding(
            padding: EdgeInsetsDirectional.only(
              start: 16,
              end: 16,
              top: theme.sectionHeaderSpacingTop,
              bottom: theme.sectionHeaderSpacingBottom,
            ),
            child: DefaultTextStyle(
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
              child: section.header!,
            ),
          ));
        }
        for (final dest in section.destinations) {
          final index = _destinationIndex(widget.sections, dest);
          children.add(Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 16, end: 16, top: 8.0, bottom: 8.0),
            child: RailItem(
              destination: dest,
              selected: index == widget.selectedIndex,
              onTap: () => widget.onDestinationSelected(index),
              expanded: true,
            ),
          ));
        }
      }
    } else {
      final all = widget.sections.expand((s) => s.destinations).toList();
      for (int i = 0; i < all.length; i++) {
        children.add(Padding(
          padding: const EdgeInsetsDirectional.only(
              start: 16.0, end: 16.0, top: 8.0, bottom: 8.0),
          child: RailItem(
            destination: all[i],
            selected: i == widget.selectedIndex,
            onTap: () => widget.onDestinationSelected(i),
            expanded: false,
          ),
        ));
      }
    }
    return children;
  }

  Widget _buildRailCore(BuildContext context) {
    final tokens = NavigationRailTokensAdapter(context);
    final width = _targetWidth(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
      width: width,
      decoration: BoxDecoration(color: tokens.containerColor),
      child: ListView(
        padding: EdgeInsets.zero,
        children: _buildChildren(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Keep overlay in sync after build completes to avoid layout side-effects.
    WidgetsBinding.instance.addPostFrameCallback((_) => _syncOverlay());

    if (_needsOverlay) {
      // When showing modal via overlay, render nothing in the layout slot so
      // content underneath can occupy the width. The overlay covers it.
      return const SizedBox.shrink();
    }

    return _buildRailCore(context);
  }

  static int _destinationIndex(List<NavigationRailM3ESection> sections,
      NavigationRailM3EDestination dest) {
    var i = 0;
    for (final s in sections) {
      for (final d in s.destinations) {
        if (identical(d, dest)) return i;
        i++;
      }
    }
    return 0;
  }
}
