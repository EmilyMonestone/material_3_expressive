import 'package:flutter/material.dart';

extension SemanticsX on Widget {
  Widget withLabel(String label) => Semantics(label: label, child: this);
}
