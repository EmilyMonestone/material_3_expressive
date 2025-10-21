import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'enums.dart';
import 'tokens_adapter.dart';

class LinearProgressM3E extends StatefulWidget {
  const LinearProgressM3E({
    super.key,
    this.value,
    this.bufferValue,
    this.variant = LinearProgressM3EVariant.determinate,
    this.size = ProgressM3ESize.medium,
    this.emphasis = ProgressM3EEmphasis.primary,
    this.density = ProgressM3EDensity.regular,
    this.backgroundColor,
    this.progressColor,
    this.bufferColor,
    this.semanticLabel,
    this.minWidth = double.infinity,
    this.strokeHeight,
    this.borderRadius,
    this.shape = LinearBarShapeM3E.wavy,
    this.wavelength,
    this.amplitude,
    this.leftRightInset,
  });

  final double? value;
  final double? bufferValue;
  final LinearProgressM3EVariant variant;
  final ProgressM3ESize size;
  final ProgressM3EEmphasis emphasis;
  final ProgressM3EDensity density;
  final Color? backgroundColor;
  final Color? progressColor;
  final Color? bufferColor;
  final String? semanticLabel;
  final double minWidth;
  final double? strokeHeight;
  final BorderRadius? borderRadius;
  final LinearBarShapeM3E shape;
  final double? wavelength;
  final double? amplitude;
  final double? leftRightInset;

  @override
  State<LinearProgressM3E> createState() => _LinearProgressM3EState();
}

class _LinearProgressM3EState extends State<LinearProgressM3E>
    with SingleTickerProviderStateMixin {
  late final AnimationController _anim = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
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

    final height = switch (widget.size) {
      ProgressM3ESize.small => widget.strokeHeight ?? m.linearThicknessSmall,
      ProgressM3ESize.medium => widget.strokeHeight ?? m.linearThicknessMedium,
      ProgressM3ESize.large => widget.strokeHeight ?? m.linearThicknessLarge,
    };

    final track = widget.backgroundColor ?? tokens.trackColor();
    final progress = widget.progressColor ?? tokens.color(widget.emphasis);
    final buffer = widget.bufferColor ?? tokens.bufferColor(progress);

    final borderRadius =
        widget.borderRadius ?? BorderRadius.circular(height / 2);
    final inset = widget.leftRightInset ?? m.horizontalInset;

    final content = Padding(
      padding: EdgeInsets.symmetric(horizontal: inset),
      child: _buildBar(
          context, height, borderRadius, track, progress, buffer, tokens),
    );

    final bar = ClipRRect(
      borderRadius: borderRadius,
      child: SizedBox(
        height: height,
        width: widget.minWidth == double.infinity ? null : widget.minWidth,
        child: content,
      ),
    );

    if (widget.semanticLabel == null) return bar;
    return Semantics(
      label: widget.semanticLabel,
      value: (widget.variant == LinearProgressM3EVariant.determinate &&
              widget.value != null)
          ? '${(widget.value!.clamp(0.0, 1.0) * 100).toStringAsFixed(0)}%'
          : null,
      child: bar,
    );
  }

  Widget _buildBar(
    BuildContext context,
    double height,
    BorderRadius borderRadius,
    Color track,
    Color progress,
    Color buffer,
    ProgressTokensAdapter tokens,
  ) {
    final variant = widget.variant;
    final shape = widget.shape;

    if (shape == LinearBarShapeM3E.flat) {
      // Use standard LinearProgressIndicator behaviors.
      if (variant == LinearProgressM3EVariant.indeterminate ||
          (variant == LinearProgressM3EVariant.determinate &&
              widget.value == null)) {
        return LinearProgressIndicator(
          color: progress,
          backgroundColor: track,
          minHeight: height,
        );
      } else if (variant == LinearProgressM3EVariant.query) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
          child: LinearProgressIndicator(
            color: progress,
            backgroundColor: track,
            minHeight: height,
          ),
        );
      } else if (variant == LinearProgressM3EVariant.buffer) {
        return _BufferBar(
          height: height,
          track: track,
          buffer: buffer,
          progress: progress,
          value: widget.value ?? 0.0,
          bufferValue: widget.bufferValue ?? 0.0,
        );
      } else {
        return LinearProgressIndicator(
          value: (widget.value ?? 0.0).clamp(0.0, 1.0),
          color: progress,
          backgroundColor: track,
          minHeight: height,
        );
      }
    }

    final wavelength =
        widget.wavelength ?? tokens.metrics(widget.density).wavyWavelength;
    final amplitude = widget.amplitude ??
        tokens.metrics(widget.density).wavyAmplitudeFactor * height;

    if (variant == LinearProgressM3EVariant.determinate &&
        widget.value != null) {
      return _WavyBar(
        value: widget.value!.clamp(0.0, 1.0),
        height: height,
        wavelength: wavelength,
        amplitude: amplitude.clamp(0.0, height / 2),
        track: track,
        fill: progress,
      );
    }

    // Indeterminate / query / missing value → animate phase
    return AnimatedBuilder(
      animation: _anim,
      builder: (context, _) {
        final phase = 2 * math.pi * _anim.value;
        final reverse = widget.variant == LinearProgressM3EVariant.query;
        return _WavyIndeterminateBar(
          height: height,
          wavelength: wavelength,
          amplitude: amplitude.clamp(0.0, height / 2),
          track: track,
          fill: progress,
          phase: reverse ? -phase : phase,
        );
      },
    );
  }
}

class _BufferBar extends StatelessWidget {
  const _BufferBar({
    required this.height,
    required this.track,
    required this.buffer,
    required this.progress,
    required this.value,
    required this.bufferValue,
  });

  final double height;
  final Color track;
  final Color buffer;
  final Color progress;
  final double value;
  final double bufferValue;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final w = constraints.maxWidth;
      final pv = (w.isFinite ? w : 0) * value.clamp(0.0, 1.0);
      final bv = (w.isFinite ? w : 0) * bufferValue.clamp(0.0, 1.0);

      Widget seg(double width, Color color) => Align(
            alignment: Alignment.centerLeft,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              width: width,
              height: height,
              color: color,
            ),
          );

      return Stack(
        fit: StackFit.passthrough,
        children: [
          ColoredBox(color: track),
          seg(bv, buffer),
          seg(pv, progress),
        ],
      );
    });
  }
}

class _WavyBar extends StatelessWidget {
  const _WavyBar({
    required this.value,
    required this.height,
    required this.wavelength,
    required this.amplitude,
    required this.track,
    required this.fill,
  });

  final double value;
  final double height;
  final double wavelength;
  final double amplitude;
  final Color track;
  final Color fill;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _WavyPainter(
        value: value,
        height: height,
        wavelength: wavelength,
        amplitude: amplitude,
        track: track,
        fill: fill,
        phase: 0,
        indeterminate: false,
      ),
    );
  }
}

class _WavyIndeterminateBar extends StatelessWidget {
  const _WavyIndeterminateBar({
    required this.height,
    required this.wavelength,
    required this.amplitude,
    required this.track,
    required this.fill,
    required this.phase,
  });

  final double height;
  final double wavelength;
  final double amplitude;
  final Color track;
  final Color fill;
  final double phase;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _WavyPainter(
        value: 0.6,
        height: height,
        wavelength: wavelength,
        amplitude: amplitude,
        track: track,
        fill: fill,
        phase: phase,
        indeterminate: true,
      ),
    );
  }
}

class _WavyPainter extends CustomPainter {
  _WavyPainter({
    required this.value,
    required this.height,
    required this.wavelength,
    required this.amplitude,
    required this.track,
    required this.fill,
    required this.phase,
    required this.indeterminate,
  });

  final double value;
  final double height;
  final double wavelength;
  final double amplitude;
  final Color track;
  final Color fill;
  final double phase;
  final bool indeterminate;

  @override
  void paint(Canvas canvas, Size size) {
    final paintTrack = Paint()..color = track;
    final paintFill = Paint()..color = fill;

    final r = RRect.fromRectAndRadius(
        Offset.zero & Size(size.width, height), Radius.circular(height / 2));
    canvas.drawRRect(r, paintTrack);

    final w = size.width;
    final progressW = indeterminate ? w : (w * value.clamp(0.0, 1.0));

    final centerY = height / 2;
    final path = Path()..moveTo(0, height);
    path.lineTo(0, centerY);

    final k = 2 * math.pi / wavelength;
    final step = 2.0;
    double x = 0;
    while (x <= progressW) {
      final y = centerY - amplitude * math.sin(k * x + phase);
      path.lineTo(x, y);
      x += step;
    }
    path.lineTo(progressW, height);
    path.close();

    canvas.save();
    final clip = Path()..addRRect(r);
    canvas.clipPath(clip);
    canvas.drawPath(path, paintFill);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _WavyPainter old) {
    return old.value != value ||
        old.height != height ||
        old.wavelength != wavelength ||
        old.amplitude != amplitude ||
        old.phase != phase ||
        old.track != track ||
        old.fill != fill ||
        old.indeterminate != indeterminate;
  }
}
