import 'package:flutter/material.dart';
import 'package:m3e_design/m3e_design.dart';

class ButtonM3EWidget extends StatelessWidget {
  const ButtonM3EWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final m3e = context.m3e;
    return Container(
      padding: EdgeInsets.all(m3e.spacing.md),
      decoration: BoxDecoration(
        color: m3e.colors.surfaceStrong,
        borderRadius: m3e.shapes.square.md,
      ),
      child: Text('Button placeholder', style: m3e.typography.base.labelLarge),
    );
  }
}

String _pascal(String s) => s
    .split('_')
    .map((p) => p.isEmpty ? '' : (p[0].toUpperCase() + p.substring(1)))
    .join();
