import 'package:app_bar_m3e/app_bar_m3e.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

// Helper: build a list of action buttons with informative prints
List<Widget> _buildActions(int count) {
  return List.generate(count, (i) {
    return IconButton(
      tooltip: 'Action \'${i + 1}\'',
      icon:
          Icon([Icons.search, Icons.tune, Icons.more_vert, Icons.share][i % 4]),
      onPressed: () => print('[AppBarM3E] action ${i + 1} pressed'),
    );
  });
}

@UseCase(name: 'default', type: AppBarM3E)
Widget buildAppBarM3EDefaultUseCase(BuildContext context) {
  final centerTitle =
      context.knobs.boolean(label: 'centerTitle', initialValue: false);
  final title = context.knobs.string(label: 'title', initialValue: 'App Bar');
  final bg = context.knobs.colorOrNull(label: 'backgroundColor');
  final fg = context.knobs.colorOrNull(label: 'foregroundColor');
  final elevation = context.knobs.doubleOrNull.input(label: 'elevation');
  final shapeFamily = context.knobs.object.dropdown<AppBarM3EShapeFamily>(
    label: 'shapeFamily',
    initialOption: AppBarM3EShapeFamily.round,
    options: const [AppBarM3EShapeFamily.round, AppBarM3EShapeFamily.square],
    labelBuilder: (v) => v.name,
  );
  final density = context.knobs.object.dropdown<AppBarM3EDensity>(
    label: 'density',
    initialOption: AppBarM3EDensity.regular,
    options: const [AppBarM3EDensity.regular, AppBarM3EDensity.compact],
    labelBuilder: (v) => v.name,
  );
  final toolbarHeight =
      context.knobs.doubleOrNull.input(label: 'toolbarHeight');
  final implyLeading = context.knobs
      .boolean(label: 'automaticallyImplyLeading', initialValue: true);
  final clip = context.knobs.object.dropdown<Clip>(
    label: 'clipBehavior',
    initialOption: Clip.none,
    options: const [
      Clip.none,
      Clip.hardEdge,
      Clip.antiAlias,
      Clip.antiAliasWithSaveLayer
    ],
    labelBuilder: (v) => v.name,
  );
  final actionsCount = context.knobs.int
      .slider(label: 'actions', initialValue: 1, min: 0, max: 5);

  return AppBarM3E(
    leading: IconButton(
      icon: const Icon(Icons.menu),
      onPressed: () => print('[AppBarM3E] leading pressed'),
    ),
    titleText: title,
    centerTitle: centerTitle,
    backgroundColor: bg,
    foregroundColor: fg,
    elevation: elevation,
    shapeFamily: shapeFamily,
    density: density,
    toolbarHeight: toolbarHeight,
    automaticallyImplyLeading: implyLeading,
    clipBehavior: clip,
    actions: _buildActions(actionsCount),
  );
}

@UseCase(name: 'with_icon', type: AppBarM3E)
Widget buildAppBarM3EWithIconUseCase(BuildContext context) {
  return AppBarM3E(
    leading: IconButton(
      icon: const Icon(Icons.menu),
      onPressed: () => print('[AppBarM3E] menu tapped'),
    ),
    titleText: context.knobs.string(label: 'title', initialValue: 'With icon'),
    actions: [
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () => print('[AppBarM3E] search tapped'),
      ),
    ],
  );
}

@UseCase(name: 'with_label', type: AppBarM3E)
Widget buildAppBarM3EWithLabelUseCase(BuildContext context) {
  return AppBarM3E(
    title: Text(
      context.knobs.string(label: 'label', initialValue: 'Title Widget'),
      overflow: TextOverflow.ellipsis,
    ),
    centerTitle:
        context.knobs.boolean(label: 'centerTitle', initialValue: true),
  );
}

@UseCase(name: 'without_label', type: AppBarM3E)
Widget buildAppBarM3EWithoutLabelUseCase(BuildContext context) {
  return AppBarM3E(
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => print('[AppBarM3E] back tapped'),
    ),
    actions: _buildActions(context.knobs.int
        .slider(label: 'actions', initialValue: 2, min: 0, max: 6)),
  );
}

@UseCase(name: 'small', type: AppBarM3E)
Widget buildAppBarM3ESmallUseCase(BuildContext context) {
  final h = context.knobs.double
      .slider(label: 'height', initialValue: 56, min: 40, max: 80);
  return AppBarM3E(
    titleText: 'Small',
    toolbarHeight: h,
  );
}

@UseCase(name: 'medium', type: AppBarM3E)
Widget buildAppBarM3EMediumUseCase(BuildContext context) {
  final h = context.knobs.double
      .slider(label: 'height', initialValue: 64, min: 48, max: 96);
  return AppBarM3E(
    titleText: 'Medium',
    toolbarHeight: h,
  );
}

@UseCase(name: 'large', type: AppBarM3E)
Widget buildAppBarM3ELargeUseCase(BuildContext context) {
  final h = context.knobs.double
      .slider(label: 'height', initialValue: 72, min: 56, max: 120);
  return AppBarM3E(
    titleText: 'Large',
    toolbarHeight: h,
  );
}

@UseCase(name: 'long_text', type: AppBarM3E)
Widget buildAppBarM3ELongTextUseCase(BuildContext context) {
  final repeat = context.knobs.int
      .slider(label: 'repeat', initialValue: 3, min: 1, max: 10);
  final base =
      context.knobs.string(label: 'base', initialValue: 'A very long title');
  return AppBarM3E(
    titleText: List.filled(repeat, base).join(' • '),
    centerTitle:
        context.knobs.boolean(label: 'centerTitle', initialValue: false),
  );
}

@UseCase(name: 'many_actions', type: AppBarM3E)
Widget buildAppBarM3EManyActionsUseCase(BuildContext context) {
  final count = context.knobs.int
      .slider(label: 'actions', initialValue: 4, min: 0, max: 10);
  return AppBarM3E(
    titleText: 'Many actions',
    actions: _buildActions(count),
  );
}

@UseCase(name: 'shape_family', type: AppBarM3E)
Widget buildAppBarM3EShapeFamilyUseCase(BuildContext context) {
  final family = context.knobs.object.dropdown<AppBarM3EShapeFamily>(
    label: 'shapeFamily',
    initialOption: AppBarM3EShapeFamily.round,
    options: const [AppBarM3EShapeFamily.round, AppBarM3EShapeFamily.square],
    labelBuilder: (v) => v.name,
  );
  return AppBarM3E(
    titleText: 'Shape: ${family.name}',
    shapeFamily: family,
  );
}

@UseCase(name: 'semantics_label', type: AppBarM3E)
Widget buildAppBarM3ESemanticsLabelUseCase(BuildContext context) {
  final label = context.knobs
      .string(label: 'semanticLabel', initialValue: 'Primary application bar');
  return AppBarM3E(
    titleText: 'Semantics',
    semanticLabel: label,
  );
}
