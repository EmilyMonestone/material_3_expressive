import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'enums.dart';

class CircularProgressIndicatorM3E extends StatelessWidget {
  const CircularProgressIndicatorM3E({
    super.key,
    this.value,
    this.size = CircularProgressM3ESize.m,
    this.shape = ProgressM3EShape.wavy,
    this.activeColor,
    this.trackColor,
    this.rotation = 0.0, // radians, for indeterminate rotation
  });

  final double? value; // 0..1 (null => indeterminate arc sweep)
  final CircularProgressM3ESize size;
  final ProgressM3EShape shape;
  final Color? activeColor;
  final Color? trackColor;
  final double rotation;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final active = activeColor ?? cs.primary;
    final track = trackColor ?? cs.onSurfaceVariant.withOpacity(0.24);
    final wantsWavy = shape == ProgressM3EShape.wavy;
    final diameter = wantsWavy ? size.diameterWavy : size.diameterFlat;
    return RepaintBoundary(
      child: SizedBox(
        width: diameter,
        height: diameter,
        child: CustomPaint(
          painter: wantsWavy
              ? _CircularWavyPainter(
                  value: value,
                  active: active,
                  track: track,
                  rotation: rotation)
              : _CircularFlatPainter(
                  value: value,
                  active: active,
                  track: track,
                  rotation: rotation,
                  size: size),
        ),
      ),
    );
  }
}

class _CircularFlatPainter extends CustomPainter {
  _CircularFlatPainter(
      {required this.value,
      required this.active,
      required this.track,
      required this.rotation,
      required this.size});

  final double? value;
  final Color active;
  final Color track;
  final double rotation;
  final CircularProgressM3ESize size;

  @override
  void paint(Canvas canvas, Size s) {
    final stroke = 4.0;
    final center = s.center(Offset.zero);
    final radius = (math.min(s.width, s.height) - stroke) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    // gap before active in dp -> angle
    final gapDp = 8.0;
    final gapAngle = gapDp / radius; // s = r * angle

    // active sweep
    final sweep =
        value == null ? math.pi * 1.5 : (value!.clamp(0.0, 1.0) * math.pi * 2);

    final start = -math.pi / 2 + rotation;
    final activeStart = start;
    final activeEnd = start + sweep;

    // TRACK: draw the rest of the ring, leaving a gap ahead of the active arc and no overlap.
    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..color = track;

    final total = math.pi * 2;
    final a1 = (activeEnd + gapAngle);
    final a2 = (activeStart - gapAngle);
    double sweep1 = (a2 - a1);
    while (sweep1 <= 0) sweep1 += total;
    canvas.drawArc(rect, a1, sweep1, false, trackPaint);

    // ACTIVE arc
    final activePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..color = active;
    canvas.drawArc(rect, activeStart, sweep, false, activePaint);
  }

  @override
  bool shouldRepaint(covariant _CircularFlatPainter old) =>
      value != old.value ||
      active != old.active ||
      track != old.track ||
      rotation != old.rotation ||
      size != old.size;
}

class _CircularWavyPainter extends CustomPainter {
  _CircularWavyPainter(
      {required this.value,
      required this.active,
      required this.track,
      required this.rotation});

  final double? value;
  final Color active;
  final Color track;
  final double rotation;

  @override
  void paint(Canvas canvas, Size s) {
    const stroke = 4.0;
    final center = s.center(Offset.zero);
    final baseRadius = (math.min(s.width, s.height) - stroke) / 2;

    // Squiggle clearance: 2dp (edge-to-edge). Approximate by insetting the squiggle centerline by 6dp.
    final clearance = 2.0;
    final squiggleRadius =
        baseRadius - (stroke / 2 + clearance + stroke / 2); // baseRadius - 6
    final amp = 2.0; // radial amplitude of squiggle
    final scallopLen = 18.0; // along-arc wavelength proxy (dp)

    // Active sweep
    final activeSweep =
        value == null ? math.pi * 1.5 : (value!.clamp(0.0, 1.0) * math.pi * 2);
    final start = -math.pi / 2 + rotation;
    final end = start + activeSweep;

    // Track ring with gap around active
    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..color = track;

    final gapAngle = 2.0 / baseRadius;
    final rect = Rect.fromCircle(center: center, radius: baseRadius);
    final total = math.pi * 2;
    final a1 = end + gapAngle;
    final a2 = start - gapAngle;
    double sweep1 = (a2 - a1);
    while (sweep1 <= 0) sweep1 += total;
    canvas.drawArc(rect, a1, sweep1, false, trackPaint);

    // Active squiggle path
    final steps = math.max(48, (s.width * 1.2).round());
    final path = Path();
    for (int i = 0; i <= steps; i++) {
      final t = i / steps;
      final ang = start + (end - start) * t;
      final arcLen = squiggleRadius * (ang - start);
      final r =
          squiggleRadius + amp * math.sin(arcLen / scallopLen * 2 * math.pi);
      final p =
          Offset(center.dx + r * math.cos(ang), center.dy + r * math.sin(ang));
      if (i == 0)
        path.moveTo(p.dx, p.dy);
      else
        path.lineTo(p.dx, p.dy);
    }
    final activePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..color = active;
    canvas.drawPath(path, activePaint);
  }

  @override
  bool shouldRepaint(covariant _CircularWavyPainter old) =>
      value != old.value ||
      active != old.active ||
      track != old.track ||
      rotation != old.rotation;
}
