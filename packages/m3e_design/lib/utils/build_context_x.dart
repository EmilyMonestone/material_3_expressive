import 'package:flutter/material.dart';
import '../theme/m3e_theme.dart';

extension BuildContextM3EX on BuildContext {
  M3ETheme get m3e =>
      Theme.of(this).extension<M3ETheme>() ?? M3ETheme.defaults(Theme.of(this).colorScheme);
}
