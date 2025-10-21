import 'package:flutter/material.dart';
import 'enums.dart';
import 'tokens_adapter.dart';
import 'linear_progress_m3e.dart';

class ProgressWithLabelM3E extends StatelessWidget {
  const ProgressWithLabelM3E({
    super.key,
    required this.progress,
    this.position = ProgressLabelPosition.trailing,
    this.label,
    this.spacing,
    this.textStyle,
  });

  final LinearProgressM3E progress;
  final ProgressLabelPosition position;
  final Widget? label;
  final double? spacing;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    if (position == ProgressLabelPosition.none) return progress;

    final tokens = ProgressTokensAdapter(context);
    final style = textStyle ?? tokens.labelStyle().copyWith(
      color: Theme.of(context).colorScheme.onSurface,
    );
    final gap = spacing ?? 8.0;

    final value = progress.value;
    final builtLabel = label ?? Text(
      value != null ? '${(value * 100).toStringAsFixed(0)}%' : '',
      style: style,
    );

    switch (position) {
      case ProgressLabelPosition.leading:
      case ProgressLabelPosition.trailing:
        final children = <Widget>[
          if (position == ProgressLabelPosition.leading) builtLabel,
          if (position == ProgressLabelPosition.leading) SizedBox(width: gap),
          Expanded(child: progress),
          if (position == ProgressLabelPosition.trailing) SizedBox(width: gap),
          if (position == ProgressLabelPosition.trailing) builtLabel,
        ];
        return Row(children: children);
      case ProgressLabelPosition.top:
      case ProgressLabelPosition.bottom:
        final children = <Widget>[
          if (position == ProgressLabelPosition.top) builtLabel,
          if (position == ProgressLabelPosition.top) SizedBox(height: gap),
          progress,
          if (position == ProgressLabelPosition.bottom) SizedBox(height: gap),
          if (position == ProgressLabelPosition.bottom) builtLabel,
        ];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        );
      case ProgressLabelPosition.center:
        return Stack(
          alignment: Alignment.center,
          children: [
            progress,
            builtLabel,
          ],
        );
      case ProgressLabelPosition.none:
        return progress;
    }
  }
}
