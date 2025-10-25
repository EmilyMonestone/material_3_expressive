import 'package:flutter/material.dart';

import '../theme/m3e_theme.dart';

extension BuildContextM3EX on BuildContext {
  M3ETheme get m3e => Theme.of(this).m3e;
}
