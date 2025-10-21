import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:m3e_design/m3e_design.dart';

import '_tokens.dart';
import 'enums.dart';

/// Linear indicator that renders two **separate lanes** (active above, track below)
/// with a fixed vertical gap. Lanes never overlap.
class LinearProgressIndicatorM3E extends StatelessWidget {
  const LinearProgressIndicatorM3E({
    super.key,
    this.value, // null => indeterminate; animate phase externally
    this.size = LinearProgressM3ESize.m,
    this.shape = ProgressM3EShape.wavy,
    this.activeColor,
    this.trackColor,
    this.phase = 0.0, // radians for wavy animation
    this.inset = 4.0, // horizontal left inset
  });

  final double? value;
  final LinearProgressM3ESize size;
  final ProgressM3EShape shape;
  final Color? activeColor;
  final Color? trackColor;
  final double phase;
  final double inset;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final m3e =
        theme.extension<M3ETheme>() ?? M3ETheme.defaults(theme.colorScheme);

    // Farben aus m3e_design beziehen (überschreibbar per Props)
    final active = activeColor ?? m3e.colors.primary;
    final track = trackColor ?? m3e.colors.surfaceContainerHighest;

    final spec = specForLinear(size: size, shape: shape);

    // Total height = active lane height (trackHeight or wavyHeight) + gap + trackHeight
    final activeHeight = spec.isWavy
        ? (spec.trackHeight + 2 * spec.waveAmplitude)
        : spec.trackHeight;
    final totalHeight = activeHeight + spec.gap + spec.trackHeight;

    return RepaintBoundary(
      child: SizedBox(
        height: totalHeight,
        width: double.infinity,
        child: CustomPaint(
          painter: _LinearPainter(
            value: value,
            spec: spec,
            active: activeColor ?? active,
            track: trackColor ?? track,
            phase: phase,
            inset: inset,
          ),
        ),
      ),
    );
  }
}

class _LinearPainter extends CustomPainter {
  _LinearPainter({
    required this.value,
    required this.spec,
    required this.active,
    required this.track,
    required this.phase,
    required this.inset,
  });

  final double? value;
  final LinearSpec spec;
  final Color active;
  final Color track;
  final double phase;
  final double inset;

  @override
  void paint(Canvas canvas, Size size) {
    final left = inset;
    final right = size.width - spec.trailingMargin;
    final width = math.max(0.0, right - left);

    // lane centers: active on top, track on bottom
    final trackCy = size.height - spec.trackHeight / 2;
    final activeHeight = spec.isWavy
        ? (spec.trackHeight + 2 * spec.waveAmplitude)
        : spec.trackHeight;
    final activeCy =
        trackCy - (spec.trackHeight / 2 + spec.gap + activeHeight / 2);

    // --- Draw track lane (flat pill) ---
    final base = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = spec.trackHeight
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    canvas.drawLine(
        Offset(left, trackCy), Offset(right, trackCy), base..color = track);

    // --- Active lane ---
    final double p = (value ?? 0).clamp(0.0, 1.0);
    if (spec.isWavy) {
      // wavy centerline
      final start = left;
      final end = value == null ? right : (left + width * p);
      final path = Path();
      const step = 1.5;
      final k = 2 * math.pi / spec.wavePeriod;

      double x = start;
      double y =
          activeCy + spec.waveAmplitude * math.sin(phase + (x - start) * k);
      path.moveTo(x, y);
      for (x = start + step; x <= end; x += step) {
        y = activeCy + spec.waveAmplitude * math.sin(phase + (x - start) * k);
        path.lineTo(x, y);
      }
      // precise end point
      y = activeCy + spec.waveAmplitude * math.sin(phase + (end - start) * k);
      path.lineTo(end, y);

      canvas.drawPath(
          path,
          base
            ..color = active
            ..strokeWidth = spec.trackHeight);

      // end dot (non-overlapping, placed slightly before end)
      final dotCenterX = math.max(start, end - spec.dotOffset);
      canvas.drawCircle(
          Offset(dotCenterX, y), spec.dotDiameter / 2, Paint()..color = active);
    } else {
      // flat active pill + end dot
      final start = left;
      final end = value == null ? right : (left + width * p);
      canvas.drawLine(
          Offset(start, activeCy),
          Offset(end, activeCy),
          base
            ..color = active
            ..strokeWidth = spec.trackHeight);
      final dotCenterX = math.max(start, end - spec.dotOffset);
      canvas.drawCircle(Offset(dotCenterX, activeCy), spec.dotDiameter / 2,
          Paint()..color = active);
    }
  }

  @override
  bool shouldRepaint(covariant _LinearPainter old) =>
      value != old.value ||
      spec != old.spec ||
      active != old.active ||
      track != old.track ||
      phase != old.phase ||
      inset != old.inset;
}
