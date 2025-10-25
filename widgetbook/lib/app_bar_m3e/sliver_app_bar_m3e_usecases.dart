import 'package:app_bar_m3e/app_bar_m3e.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

List<Widget> _buildActions(int count) => List.generate(count, (i) {
      return IconButton(
        tooltip: 'Action \'${i + 1}\'',
        icon: Icon(
            [Icons.search, Icons.tune, Icons.more_vert, Icons.share][i % 4]),
        onPressed: () => print('[SliverAppBarM3E] action ${i + 1} pressed'),
      );
    });

Widget _demoScrollBody({required SliverAppBarM3E appBar}) {
  return CustomScrollView(
    slivers: [
      appBar,
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => ListTile(
            title: Text('Item #${index + 1}'),
            onTap: () => print('[Sliver] tapped item ${index + 1}'),
          ),
          childCount: 30,
        ),
      ),
    ],
  );
}

@UseCase(name: 'default', type: SliverAppBarM3E)
Widget buildSliverAppBarM3EDefaultUseCase(BuildContext context) {
  final title =
      context.knobs.string(label: 'title', initialValue: 'Sliver App Bar');
  final centerTitle =
      context.knobs.boolean(label: 'centerTitle', initialValue: false);
  final pinned = context.knobs.boolean(label: 'pinned', initialValue: true);
  final floating =
      context.knobs.boolean(label: 'floating', initialValue: false);
  final snap = context.knobs.boolean(label: 'snap', initialValue: false);
  final variant = context.knobs.object.dropdown<AppBarM3EVariant>(
    label: 'variant',
    initialOption: AppBarM3EVariant.medium,
    options: const [
      AppBarM3EVariant.small,
      AppBarM3EVariant.medium,
      AppBarM3EVariant.large
    ],
    labelBuilder: (v) => v.name,
  );
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
  final bg = context.knobs.colorOrNull(label: 'backgroundColor');
  final fg = context.knobs.colorOrNull(label: 'foregroundColor');
  final actionsCount = context.knobs.int
      .slider(label: 'actions', initialValue: 1, min: 0, max: 6);

  final appBar = SliverAppBarM3E(
    titleText: title,
    centerTitle: centerTitle,
    pinned: pinned,
    floating: floating,
    snap: snap,
    variant: variant,
    shapeFamily: shapeFamily,
    density: density,
    backgroundColor: bg,
    foregroundColor: fg,
    actions: _buildActions(actionsCount),
  );
  return _demoScrollBody(appBar: appBar);
}

@UseCase(name: 'small', type: SliverAppBarM3E)
Widget buildSliverAppBarM3ESmallUseCase(BuildContext context) {
  final appBar = SliverAppBarM3E(
    titleText: 'Small',
    variant: AppBarM3EVariant.small,
  );
  return _demoScrollBody(appBar: appBar);
}

@UseCase(name: 'medium', type: SliverAppBarM3E)
Widget buildSliverAppBarM3EMediumUseCase(BuildContext context) {
  final appBar = SliverAppBarM3E(
    titleText: 'Medium',
    variant: AppBarM3EVariant.medium,
  );
  return _demoScrollBody(appBar: appBar);
}

@UseCase(name: 'large', type: SliverAppBarM3E)
Widget buildSliverAppBarM3ELargeUseCase(BuildContext context) {
  final appBar = SliverAppBarM3E(
    titleText: 'Large',
    variant: AppBarM3EVariant.large,
  );
  return _demoScrollBody(appBar: appBar);
}

@UseCase(name: 'pinned', type: SliverAppBarM3E)
Widget buildSliverAppBarM3EPinnedUseCase(BuildContext context) {
  final appBar = SliverAppBarM3E(
    titleText: 'Pinned',
    pinned: true,
    floating: false,
    snap: false,
    variant: context.knobs.object.dropdown<AppBarM3EVariant>(
      label: 'variant',
      initialOption: AppBarM3EVariant.medium,
      options: const [
        AppBarM3EVariant.small,
        AppBarM3EVariant.medium,
        AppBarM3EVariant.large
      ],
      labelBuilder: (v) => v.name,
    ),
  );
  return _demoScrollBody(appBar: appBar);
}

@UseCase(name: 'floating', type: SliverAppBarM3E)
Widget buildSliverAppBarM3EFloatingUseCase(BuildContext context) {
  final snap = context.knobs.boolean(label: 'snap', initialValue: false);
  final appBar = SliverAppBarM3E(
    titleText: 'Floating',
    pinned: false,
    floating: true,
    snap: snap,
    variant: context.knobs.object.dropdown<AppBarM3EVariant>(
      label: 'variant',
      initialOption: AppBarM3EVariant.medium,
      options: const [
        AppBarM3EVariant.small,
        AppBarM3EVariant.medium,
        AppBarM3EVariant.large
      ],
      labelBuilder: (v) => v.name,
    ),
  );
  return _demoScrollBody(appBar: appBar);
}

@UseCase(name: 'snap', type: SliverAppBarM3E)
Widget buildSliverAppBarM3ESnapUseCase(BuildContext context) {
  final appBar = SliverAppBarM3E(
    titleText: 'Snap',
    pinned: false,
    floating: true,
    snap: true,
    variant: context.knobs.object.dropdown<AppBarM3EVariant>(
      label: 'variant',
      initialOption: AppBarM3EVariant.medium,
      options: const [
        AppBarM3EVariant.small,
        AppBarM3EVariant.medium,
        AppBarM3EVariant.large
      ],
      labelBuilder: (v) => v.name,
    ),
  );
  return _demoScrollBody(appBar: appBar);
}

@UseCase(name: 'long_text', type: SliverAppBarM3E)
Widget buildSliverAppBarM3ELongTextUseCase(BuildContext context) {
  final repeat = context.knobs.int
      .slider(label: 'repeat', initialValue: 3, min: 1, max: 10);
  final base =
      context.knobs.string(label: 'base', initialValue: 'A very long title');
  final appBar = SliverAppBarM3E(
    titleText: List.filled(repeat, base).join(' • '),
    variant: context.knobs.object.dropdown<AppBarM3EVariant>(
      label: 'variant',
      initialOption: AppBarM3EVariant.medium,
      options: const [
        AppBarM3EVariant.small,
        AppBarM3EVariant.medium,
        AppBarM3EVariant.large
      ],
      labelBuilder: (v) => v.name,
    ),
  );
  return _demoScrollBody(appBar: appBar);
}

@UseCase(name: 'many_actions', type: SliverAppBarM3E)
Widget buildSliverAppBarM3EManyActionsUseCase(BuildContext context) {
  final count = context.knobs.int
      .slider(label: 'actions', initialValue: 4, min: 0, max: 10);
  final appBar = SliverAppBarM3E(
    titleText: 'Many actions',
    actions: _buildActions(count),
  );
  return _demoScrollBody(appBar: appBar);
}

@UseCase(name: 'shape_family', type: SliverAppBarM3E)
Widget buildSliverAppBarM3EShapeFamilyUseCase(BuildContext context) {
  final family = context.knobs.object.dropdown<AppBarM3EShapeFamily>(
    label: 'shapeFamily',
    initialOption: AppBarM3EShapeFamily.round,
    options: const [AppBarM3EShapeFamily.round, AppBarM3EShapeFamily.square],
    labelBuilder: (v) => v.name,
  );
  final appBar = SliverAppBarM3E(
    titleText: 'Shape: ' + family.name,
    shapeFamily: family,
  );
  return _demoScrollBody(appBar: appBar);
}

@UseCase(name: 'density', type: SliverAppBarM3E)
Widget buildSliverAppBarM3EDensityUseCase(BuildContext context) {
  final density = context.knobs.object.dropdown<AppBarM3EDensity>(
    label: 'density',
    initialOption: AppBarM3EDensity.regular,
    options: const [AppBarM3EDensity.regular, AppBarM3EDensity.compact],
    labelBuilder: (v) => v.name,
  );
  final appBar = SliverAppBarM3E(
    titleText: 'Density: ' + density.name,
    density: density,
  );
  return _demoScrollBody(appBar: appBar);
}

@UseCase(name: 'semantics_label', type: SliverAppBarM3E)
Widget buildSliverAppBarM3ESemanticsLabelUseCase(BuildContext context) {
  final label = context.knobs
      .string(label: 'semanticLabel', initialValue: 'Scrollable app bar');
  final appBar = SliverAppBarM3E(
    titleText: 'Semantics',
    semanticLabel: label,
  );
  return _demoScrollBody(appBar: appBar);
}
