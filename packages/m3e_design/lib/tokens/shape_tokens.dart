import 'package:flutter/material.dart';

enum M3EShapeVariant { round, square }

@immutable
class M3EShapeSet {
  final BorderRadius xs;
  final BorderRadius sm;
  final BorderRadius md;
  final BorderRadius lg;
  final BorderRadius xl;
  const M3EShapeSet({required this.xs, required this.sm, required this.md, required this.lg, required this.xl});
}

@immutable
class M3EShapes {
  final M3EShapeSet round;
  final M3EShapeSet square;

  const M3EShapes({required this.round, required this.square});

  factory M3EShapes.expressive() => const M3EShapes(
        round: M3EShapeSet(
          xs: BorderRadius.all(Radius.circular(999)),
          sm: BorderRadius.all(Radius.circular(20)),
          md: BorderRadius.all(Radius.circular(28)),
          lg: BorderRadius.all(Radius.circular(44)),
          xl: BorderRadius.all(Radius.circular(64)),
        ),
        square: M3EShapeSet(
          xs: BorderRadius.all(Radius.circular(6)),
          sm: BorderRadius.all(Radius.circular(8)),
          md: BorderRadius.all(Radius.circular(12)),
          lg: BorderRadius.all(Radius.circular(16)),
          xl: BorderRadius.all(Radius.circular(20)),
        ),
      );

  static M3EShapes lerp(M3EShapes a, M3EShapes b, double t) => M3EShapes(
    round: _lerpSet(a.round, b.round, t),
    square: _lerpSet(a.square, b.square, t),
  );

  static M3EShapeSet _lerpSet(M3EShapeSet a, M3EShapeSet b, double t) => M3EShapeSet(
    xs: BorderRadius.lerp(a.xs, b.xs, t)!,
    sm: BorderRadius.lerp(a.sm, b.sm, t)!,
    md: BorderRadius.lerp(a.md, b.md, t)!,
    lg: BorderRadius.lerp(a.lg, b.lg, t)!,
    xl: BorderRadius.lerp(a.xl, b.xl, t)!,
  );
}
