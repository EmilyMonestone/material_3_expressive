import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'enums.dart';
import 'tokens_adapter.dart';

class CircularProgressM3E extends StatefulWidget {
  const CircularProgressM3E({
    super.key,
    this.value,
    this.size = ProgressM3ESize.medium,
    this.emphasis = ProgressM3EEmphasis.primary,
    this.density = ProgressM3EDensity.regular,
    this.backgroundColor,
    this.strokeWidth,
    this.semanticLabel,
    this.showCenterLabel = false,
    this.centerLabelBuilder,
    this.shape = CircularBarShapeM3E.wavy,
    this.waveCount,
    this.waveAmplitude,
    this.rotateClockwise = true,
  });

  /// Determinate value (0..1). If null, renders indeterminate.
  final double? value;

  final ProgressM3ESize size;
  final ProgressM3EEmphasis emphasis;
  final ProgressM3EDensity density;

  final Color? backgroundColor;
  final double? strokeWidth;

  /// Optional semantics label.
  final String? semanticLabel;

  /// Show a label centered inside (e.g., percentage).
  final bool showCenterLabel;

  /// Builder for custom center label; if null and showCenterLabel==true, shows percentage text.
  final Widget Function(BuildContext context, double? value)?
      centerLabelBuilder;

  /// Expressive shape
  final CircularBarShapeM3E shape;
  final int? waveCount;
  final double? waveAmplitude;
  final bool rotateClockwise;

  @override
  State<CircularProgressM3E> createState() => _CircularProgressM3EState();
}

class _CircularProgressM3EState extends State<CircularProgressM3E>
    with SingleTickerProviderStateMixin {
  late final AnimationController _anim = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat();

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = ProgressTokensAdapter(context);
    final m = tokens.metrics(widget.density);
    final color = tokens.color(widget.emphasis);
    final bg = widget.backgroundColor ?? tokens.trackColor();

    final (diameter, stroke) = switch (widget.size) {
      ProgressM3ESize.small => (
          m.circularSmall,
          widget.strokeWidth ?? m.strokeSmall
        ),
      ProgressM3ESize.medium => (
          m.circularMedium,
          widget.strokeWidth ?? m.strokeMedium
        ),
      ProgressM3ESize.large => (
          m.circularLarge,
          widget.strokeWidth ?? m.strokeLarge
        ),
    };

    final indicator = SizedBox(
      width: diameter,
      height: diameter,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Track ring
          CustomPaint(
            size: Size.square(diameter),
            painter: _RingPainter(color: bg, stroke: stroke),
          ),
          // Progress
          if (widget.shape == CircularBarShapeM3E.flat) ...[
            CustomPaint(
              size: Size.square(diameter),
              painter: _ArcPainter(
                color: color,
                stroke: stroke,
                value: widget.value,
                clockwise: widget.rotateClockwise,
              ),
            ),
          ] else ...[
            AnimatedBuilder(
              animation: _anim,
              builder: (context, _) => CustomPaint(
                size: Size.square(diameter),
                painter: _WavyArcPainter(
                  color: color,
                  stroke: stroke,
                  value: widget.value,
                  waves: widget.waveCount ?? m.circularWavesPerCircle,
                  amplitude: (widget.waveAmplitude ??
                          (m.circularWaveAmplitudeFactor * stroke))
                      .clamp(0, stroke / 2),
                  phase:
                      (widget.value == null ? 2 * math.pi * _anim.value : 0) *
                          (widget.rotateClockwise ? 1 : -1),
                  clockwise: widget.rotateClockwise,
                ),
              ),
            ),
          ],
          if (widget.showCenterLabel)
            DefaultTextStyle(
              style: tokens.labelStyle().copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
              child: widget.centerLabelBuilder?.call(context, widget.value) ??
                  Text(widget.value != null
                      ? '${(widget.value! * 100).toStringAsFixed(0)}%'
                      : ''),
            ),
        ],
      ),
    );

    if (widget.semanticLabel == null) return indicator;
    return Semantics(
      label: widget.semanticLabel,
      value: widget.value != null
          ? '${(widget.value! * 100).toStringAsFixed(0)}%'
          : null,
      child: indicator,
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({required this.color, required this.stroke});
  final Color color;
  final double stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = (size.shortestSide - stroke) / 2;
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant _RingPainter old) =>
      old.color != color || old.stroke != stroke;
}

class _ArcPainter extends CustomPainter {
  _ArcPainter({
    required this.color,
    required this.stroke,
    required this.value,
    required this.clockwise,
  });

  final Color color;
  final double stroke;
  final double? value;
  final bool clockwise;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = (size.shortestSide - stroke) / 2;

    final start = -math.pi / 2;
    final sweep = (value ?? 0.25) * 2 * math.pi * (clockwise ? 1 : -1);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), start,
        sweep, false, paint);
    if (value == null) {
      // indeterminate - draw a moving arc; this painter is used only for determinate (flat)
    }
  }

  @override
  bool shouldRepaint(covariant _ArcPainter old) =>
      old.color != color ||
      old.stroke != stroke ||
      old.value != value ||
      old.clockwise != clockwise;
}

class _WavyArcPainter extends CustomPainter {
  _WavyArcPainter({
    required this.color,
    required this.stroke,
    required this.value,
    required this.waves,
    required this.amplitude,
    required this.phase,
    required this.clockwise,
  });

  final Color color;
  final double stroke;
  final double? value;
  final int waves;
  final double amplitude;
  final double phase;
  final bool clockwise;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = rect.center;
    final baseRadius = (size.shortestSide - stroke) / 2;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    final totalAngle = (value ?? 1.0) * 2 * math.pi * (clockwise ? 1 : -1);
    final start = -math.pi / 2;

    final path = Path();
    final steps = (200 * (value ?? 1.0)).clamp(40, 300).toInt(); // resolution
    for (int i = 0; i <= steps; i++) {
      final t = i / steps;
      final theta = start + totalAngle * t;
      final wave = math.sin((t * waves * 2 * math.pi) + phase);
      final r = baseRadius + amplitude * wave;
      final p = Offset(
          center.dx + r * math.cos(theta), center.dy + r * math.sin(theta));
      if (i == 0) {
        path.moveTo(p.dx, p.dy);
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _WavyArcPainter old) =>
      old.color != color ||
      old.stroke != stroke ||
      old.value != value ||
      old.waves != waves ||
      old.amplitude != amplitude ||
      old.phase != phase ||
      old.clockwise != clockwise;
}
