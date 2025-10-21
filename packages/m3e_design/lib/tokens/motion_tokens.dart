import 'package:flutter/material.dart';

@immutable
class M3EMotion {
  final SpringDescription spatialFast;
  final SpringDescription spatialMedium;
  final SpringDescription spatialGentle;

  final SpringDescription effectsFast;
  final SpringDescription effectsMedium;

  final Duration fast;
  final Duration medium;
  final Duration slow;

  const M3EMotion({
    required this.spatialFast,
    required this.spatialMedium,
    required this.spatialGentle,
    required this.effectsFast,
    required this.effectsMedium,
    required this.fast,
    required this.medium,
    required this.slow,
  });

  const M3EMotion.expressive()
      : spatialFast = const SpringDescription(mass: 1, stiffness: 500, damping: 30),
        spatialMedium = const SpringDescription(mass: 1, stiffness: 350, damping: 28),
        spatialGentle = const SpringDescription(mass: 1, stiffness: 220, damping: 24),
        effectsFast = const SpringDescription(mass: 1, stiffness: 420, damping: 32),
        effectsMedium = const SpringDescription(mass: 1, stiffness: 280, damping: 28),
        fast = const Duration(milliseconds: 150),
        medium = const Duration(milliseconds: 250),
        slow = const Duration(milliseconds: 400);

  static M3EMotion lerp(M3EMotion a, M3EMotion b, double t) => a;
}

class SpringDescription {
  final double mass, stiffness, damping;
  const SpringDescription({required this.mass, required this.stiffness, required this.damping});
}
