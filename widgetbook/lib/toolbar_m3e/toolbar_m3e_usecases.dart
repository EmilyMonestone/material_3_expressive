import 'package:flutter/material.dart';
import 'package:toolbar_m3e/toolbar_m3e.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

// Helper to build a ToolbarM3E with comprehensive knobs per guide
Widget _buildToolbarDemo(
  BuildContext context, {
  ToolbarM3EVariant? forcedVariant,
  ToolbarM3ESize? forcedSize,
  ToolbarM3EDensity? forcedDensity,
  String? forcedTitle,
  bool withLeading = false,
  int? forcedActionCount,
  bool longTitle = false,
  bool centerTitle = false,
}) {
  final variant = forcedVariant ??
      context.knobs.object.dropdown<ToolbarM3EVariant>(
        label: 'variant',
        initialOption: ToolbarM3EVariant.surface,
        options: ToolbarM3EVariant.values,
        labelBuilder: (v) => v.name,
      );
  final size = forcedSize ??
      context.knobs.object.dropdown<ToolbarM3ESize>(
        label: 'size',
        initialOption: ToolbarM3ESize.medium,
        options: ToolbarM3ESize.values,
        labelBuilder: (v) => v.name,
      );
  final density = forcedDensity ??
      context.knobs.object.dropdown<ToolbarM3EDensity>(
        label: 'density',
        initialOption: ToolbarM3EDensity.regular,
        options: ToolbarM3EDensity.values,
        labelBuilder: (v) => v.name,
      );
  final shape = context.knobs.object.dropdown<ToolbarM3EShapeFamily>(
    label: 'shapeFamily',
    initialOption: ToolbarM3EShapeFamily.round,
    options: ToolbarM3EShapeFamily.values,
    labelBuilder: (v) => v.name,
  );

  final title = forcedTitle ??
      context.knobs.string(
        label: 'title',
        initialValue: longTitle
            ? 'An exceptionally long toolbar title that will likely overflow the available space'
            : 'Toolbar Title',
      );
  final hasSubtitle =
      context.knobs.boolean(label: 'subtitle?', initialValue: false);
  final subtitleText = hasSubtitle
      ? context.knobs.string(label: 'subtitle', initialValue: 'Subheading')
      : null;

  final actionCount = forcedActionCount ??
      context.knobs.int.slider(
        label: 'actions',
        initialValue: 3,
        min: 0,
        max: 8,
        divisions: 8,
      );

  final maxInline = context.knobs.int.slider(
    label: 'maxInlineActions',
    initialValue: 4,
    min: 1,
    max: 6,
    divisions: 5,
  );

  List<ToolbarActionM3E> buildActions(int count) {
    return List.generate(count, (i) {
      return ToolbarActionM3E(
        icon: i == count - 1 ? Icons.delete : Icons.more_horiz,
        isDestructive: i == count - 1,
        tooltip: 'Action #${i + 1}',
        label: 'Action #${i + 1}',
        onPressed: () =>
            print('Toolbar action pressed -> index=$i (of $count)'),
      );
    });
  }

  return Material(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ToolbarM3E(
          leading: withLeading
              ? IconButton(
                  onPressed: () => print('Leading pressed'),
                  icon: const Icon(Icons.menu),
                )
              : null,
          titleText: title,
          subtitleText: subtitleText,
          actions: buildActions(actionCount),
          maxInlineActions: maxInline,
          overflowIcon: const Icon(Icons.more_vert),
          centerTitle: centerTitle,
          variant: variant,
          size: size,
          density: density,
          shapeFamily: shape,
          // backgroundColor / foregroundColor left to tokens; can add knob if needed
          safeArea: false,
        ),
        // Some filler content to visualize elevation and background separation
        Container(
          height: 120,
          alignment: Alignment.center,
          child: const Text('Content area below the toolbar'),
        ),
      ],
    ),
  );
}

@UseCase(name: 'default', type: ToolbarM3E)
Widget buildToolbarM3EDefaultUseCase(BuildContext context) {
  return _buildToolbarDemo(context);
}

@UseCase(name: 'surface', type: ToolbarM3E)
Widget buildToolbarM3ESurfaceUseCase(BuildContext context) {
  return _buildToolbarDemo(context, forcedVariant: ToolbarM3EVariant.surface);
}

@UseCase(name: 'tonal', type: ToolbarM3E)
Widget buildToolbarM3ETonalUseCase(BuildContext context) {
  return _buildToolbarDemo(context, forcedVariant: ToolbarM3EVariant.tonal);
}

@UseCase(name: 'primary', type: ToolbarM3E)
Widget buildToolbarM3EPrimaryUseCase(BuildContext context) {
  return _buildToolbarDemo(context, forcedVariant: ToolbarM3EVariant.primary);
}

@UseCase(name: 'small', type: ToolbarM3E)
Widget buildToolbarM3ESmallUseCase(BuildContext context) {
  return _buildToolbarDemo(context, forcedSize: ToolbarM3ESize.small);
}

@UseCase(name: 'medium', type: ToolbarM3E)
Widget buildToolbarM3EMediumUseCase(BuildContext context) {
  return _buildToolbarDemo(context, forcedSize: ToolbarM3ESize.medium);
}

@UseCase(name: 'large', type: ToolbarM3E)
Widget buildToolbarM3ELargeUseCase(BuildContext context) {
  return _buildToolbarDemo(context, forcedSize: ToolbarM3ESize.large);
}

@UseCase(name: 'compact', type: ToolbarM3E)
Widget buildToolbarM3ECompactUseCase(BuildContext context) {
  return _buildToolbarDemo(context, forcedDensity: ToolbarM3EDensity.compact);
}

@UseCase(name: 'regular', type: ToolbarM3E)
Widget buildToolbarM3ERegularUseCase(BuildContext context) {
  return _buildToolbarDemo(context, forcedDensity: ToolbarM3EDensity.regular);
}

@UseCase(name: 'with_leading', type: ToolbarM3E)
Widget buildToolbarM3EWithLeadingUseCase(BuildContext context) {
  return _buildToolbarDemo(context, withLeading: true);
}

@UseCase(name: 'with_trailing_actions', type: ToolbarM3E)
Widget buildToolbarM3EWithActionsUseCase(BuildContext context) {
  return _buildToolbarDemo(context, forcedActionCount: 3);
}

@UseCase(name: 'with_overflow', type: ToolbarM3E)
Widget buildToolbarM3EWithOverflowUseCase(BuildContext context) {
  return _buildToolbarDemo(context, forcedActionCount: 8);
}

@UseCase(name: 'long_title', type: ToolbarM3E)
Widget buildToolbarM3ELongTitleUseCase(BuildContext context) {
  return _buildToolbarDemo(context, longTitle: true, centerTitle: false);
}

@UseCase(name: 'centered_title', type: ToolbarM3E)
Widget buildToolbarM3ECenteredTitleUseCase(BuildContext context) {
  return _buildToolbarDemo(context, longTitle: false, centerTitle: true);
}
