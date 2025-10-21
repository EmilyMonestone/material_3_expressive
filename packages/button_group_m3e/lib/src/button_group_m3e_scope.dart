import 'package:flutter/material.dart';
import 'button_group_m3e_enums.dart';

class ButtonGroupM3EScope extends InheritedWidget {
  const ButtonGroupM3EScope({
    super.key,
    required super.child,
    required this.type,
    required this.shape,
    required this.size,
    required this.density,
    required this.direction,
    required this.isConnected,
  });

  final ButtonGroupM3EType type;
  final ButtonGroupM3EShape shape;
  final ButtonGroupM3ESize size;
  final ButtonGroupM3EDensity density;
  final Axis direction;
  final bool isConnected;

  static ButtonGroupM3EScope? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ButtonGroupM3EScope>();
  static ButtonGroupM3EScope of(BuildContext context) =>
      maybeOf(context)!;

  @override
  bool updateShouldNotify(covariant ButtonGroupM3EScope oldWidget) =>
      type != oldWidget.type ||
      shape != oldWidget.shape ||
      size != oldWidget.size ||
      density != oldWidget.density ||
      direction != oldWidget.direction ||
      isConnected != oldWidget.isConnected;
}

class ButtonGroupM3EItemScope extends InheritedWidget {
  const ButtonGroupM3EItemScope({
    super.key,
    required super.child,
    required this.index,
    required this.count,
    required this.isFirst,
    required this.isLast,
  });

  final int index;
  final int count;
  final bool isFirst;
  final bool isLast;

  static ButtonGroupM3EItemScope? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ButtonGroupM3EItemScope>();
  static ButtonGroupM3EItemScope of(BuildContext context) =>
      maybeOf(context)!;

  @override
  bool updateShouldNotify(covariant ButtonGroupM3EItemScope oldWidget) =>
      index != oldWidget.index ||
      count != oldWidget.count ||
      isFirst != oldWidget.isFirst ||
      isLast != oldWidget.isLast;
}
