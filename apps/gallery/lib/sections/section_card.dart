import 'package:flutter/material.dart';
import 'package:m3e_collection/m3e_collection.dart';

class SectionCard extends StatelessWidget {
  const SectionCard(
      {super.key, required this.title, this.subtitle, required this.child});

  final String title;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final m3e =
        theme.extension<M3ETheme>() ?? M3ETheme.defaults(theme.colorScheme);

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(title, style: theme.textTheme.titleLarge),
            subtitle: subtitle == null ? null : Text(subtitle!),
          ),
          Material(
            color: theme.colorScheme.surfaceContainerLow,
            borderRadius: m3e.shapes.round.lg,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
