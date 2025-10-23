import 'package:flutter/material.dart';
import 'package:m3e_design/m3e_design.dart';

class FabM3EWidget extends StatelessWidget {
  const FabM3EWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final m3e = context.m3e;
    return Container(
      padding: EdgeInsets.all(m3e.spacing.md),
      decoration: BoxDecoration(
        color: m3e.colors.surfaceStrong,
        borderRadius: m3e.shapes.square.md,
      ),
      child: Text('Fab placeholder', style: m3e.typography.base.titleMedium),
    );
  }
}
