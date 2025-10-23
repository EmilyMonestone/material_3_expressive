import 'package:flutter/material.dart';

import 'enums.dart';
import 'slider_tokens_adapter.dart';

SliderThemeData sliderThemeM3E(
  BuildContext context, {
  SliderM3ESize size = SliderM3ESize.medium,
  SliderM3EEmphasis emphasis = SliderM3EEmphasis.primary,
  SliderM3EShapeFamily shapeFamily = SliderM3EShapeFamily.round,
  SliderM3EDensity density = SliderM3EDensity.regular,
  bool showValueIndicator = false,
}) {
  final t = SliderTokensAdapter(context);
  final m = t.metrics(density);

  final trackHeight = switch (size) {
    SliderM3ESize.small => m.trackSmall,
    SliderM3ESize.medium => m.trackMedium,
    SliderM3ESize.large => m.trackLarge,
  };

  final thumbRadius = switch (size) {
    SliderM3ESize.small => m.thumbSmall,
    SliderM3ESize.medium => m.thumbMedium,
    SliderM3ESize.large => m.thumbLarge,
  };

  final thumbShape = shapeFamily == SliderM3EShapeFamily.round
      ? RoundSliderThumbShape(enabledThumbRadius: thumbRadius)
      : _SquareThumbShape(side: thumbRadius * 2);

  return SliderTheme.of(context).copyWith(
    trackHeight: trackHeight,
    activeTrackColor: t.activeColor(emphasis),
    inactiveTrackColor: t.inactiveColor(),
    disabledActiveTrackColor: t.inactiveColor(),
    disabledInactiveTrackColor: t.inactiveColor(),
    activeTickMarkColor: t.tickColorActive(emphasis),
    inactiveTickMarkColor: t.tickColorInactive(),
    thumbColor: t.thumbColor(emphasis),
    disabledThumbColor: t.inactiveColor(),
    overlayColor: t.overlayColor(emphasis),
    valueIndicatorColor: t.valueIndicatorColor(),
    valueIndicatorTextStyle: t.valueIndicatorTextStyle(),
    showValueIndicator: showValueIndicator
        ? ShowValueIndicator.onDrag
        : ShowValueIndicator.onlyForDiscrete,
    thumbShape: thumbShape,
    overlayShape: RoundSliderOverlayShape(overlayRadius: m.overlayRadius),
    rangeThumbShape: shapeFamily == SliderM3EShapeFamily.round
        ? const RoundRangeSliderThumbShape()
        : const _SquareRangeThumbShape(),
    rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
    rangeValueIndicatorShape: const PaddleRangeSliderValueIndicatorShape(),
    valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
  );
}

class _SquareThumbShape extends SliderComponentShape {
  const _SquareThumbShape({required this.side});
  final double side;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size.square(side);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter? labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;
    final rect = Rect.fromCenter(center: center, width: side, height: side);
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(4));
    final paint = Paint()..color = sliderTheme.thumbColor ?? Colors.blue;
    canvas.drawRRect(rrect, paint);
  }
}

class _SquareRangeThumbShape extends RangeSliderThumbShape {
  const _SquareRangeThumbShape();

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => const Size(24, 24);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = true,
    bool isOnTop = false,
    bool isPressed = false,
    required SliderThemeData sliderTheme,
    TextDirection textDirection = TextDirection.ltr,
    Thumb thumb = Thumb.start,
  }) {
    final canvas = context.canvas;
    final side = 24.0;
    final rect = Rect.fromCenter(center: center, width: side, height: side);
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(4));
    final paint = Paint()..color = sliderTheme.thumbColor ?? Colors.blue;
    canvas.drawRRect(rrect, paint);
  }
}
