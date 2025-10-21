import 'dart:io';

String _pascal(String s) => s
    .split('_')
    .map((p) => p.isEmpty ? '' : (p[0].toUpperCase() + p.substring(1)))
    .join();

void _ensureCollectionExport(String pkg) {
  final path = 'packages/m3e_collection/lib/m3e_collection.dart';
  final file = File(path);
  if (!file.existsSync()) return;
  final content = file.readAsStringSync();
  final exportLine = "export 'package:$pkg/$pkg.dart';";
  if (content.contains(exportLine)) return;

  // Append the export line at the end, preserving a trailing newline.
  final updated = content.trimRight() + '\n' + exportLine + '\n';
  file.writeAsStringSync(updated);
}

void _ensureCollectionDependency(String pkg) {
  final path = 'packages/m3e_collection/pubspec.yaml';
  final file = File(path);
  if (!file.existsSync()) return;
  final content = file.readAsStringSync();

  // If dependency already present, skip.
  final keyPattern =
      RegExp(r'^\s*' + RegExp.escape(pkg) + r'\s*:', multiLine: true);
  if (keyPattern.hasMatch(content)) return;

  // Ensure we are within dependencies block. If the file contains a dependencies: section,
  // we can safely append additional two-space indented entries at EOF since there is no
  // subsequent top-level section in the current file structure.
  if (!content.contains(RegExp(r'^dependencies:\s*$', multiLine: true))) {
    stderr.writeln(
        'Warning: packages/m3e_collection/pubspec.yaml has no dependencies section; skipping adding $pkg.');
    return;
  }

  final addition = '  $pkg:\n    path: ../$pkg\n';
  final updated = content.trimRight() + '\n' + addition + '\n';
  file.writeAsStringSync(updated);
}

void _ensureCollectionOverride(String pkg) {
  final path = 'packages/m3e_collection/pubspec_overrides.yaml';
  final file = File(path);
  if (!file.existsSync()) return;
  var content = file.readAsStringSync();

  // If override already present, skip.
  final keyPattern =
      RegExp(r'^\s*' + RegExp.escape(pkg) + r'\s*:', multiLine: true);
  if (keyPattern.hasMatch(content)) return;

  // Update the melos managed header list if present.
  final headerRe = RegExp(r'^(#\s*melos_managed_dependency_overrides:\s*)(.*)$',
      multiLine: true);
  content = content.replaceFirstMapped(headerRe, (m) {
    final prefix = m.group(1)!;
    final list = m.group(2)!.trim();
    if (list.isEmpty) return '${prefix}$pkg';
    final items = list.split(',').map((s) => s.trim()).toList();
    if (!items.contains(pkg)) {
      items.add(pkg);
    }
    return prefix + items.join(',');
  });

  // Ensure dependency_overrides: section exists; if not, create it.
  if (!content
      .contains(RegExp(r'^dependency_overrides:\s*$', multiLine: true))) {
    if (!content.endsWith('\n')) content += '\n';
    content += 'dependency_overrides:\n';
  }

  // Append our override using Windows-style path to match existing file style.
  final addition = '  $pkg:\n    path: ..\\$pkg\n';
  content = content.trimRight() + '\n' + addition + '\n';
  file.writeAsStringSync(content);
}

void main(List<String> args) async {
  final nameArg =
      args.firstWhere((a) => a.startsWith('name='), orElse: () => 'name=');
  final name = nameArg.split('=').last;
  if (name.isEmpty) {
    stderr.writeln(
        'Usage: melos run create -- name=<component> (_m3e suffix added automatically)');
    exit(64);
  }
  final pkg = '${name}_m3e';
  final dir = Directory('packages/$pkg');
  if (dir.existsSync()) {
    stderr.writeln('Package $pkg already exists.');
    exit(1);
  }
  dir.createSync(recursive: true);

  File('packages/$pkg/pubspec.yaml').writeAsStringSync('''
name: $pkg
description: $name (Material 3 Expressive)
version: 0.1.0
publish_to: none

environment:
  sdk: ">=3.5.0 <4.0.0"

dependencies:
  flutter:
    sdk: flutter
  m3e_design:
    path: ../m3e_design

dev_dependencies:
  flutter_test:
    sdk: flutter
''');

  Directory('packages/$pkg/lib').createSync();
  File('packages/$pkg/lib/$pkg.dart').writeAsStringSync('''
library $pkg;

// TODO: implement $name M3E widget
export 'src/${name}_m3e_widget.dart';
''');

  Directory('packages/$pkg/lib/src').createSync();
  File('packages/$pkg/lib/src/${name}_m3e_widget.dart').writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:m3e_design/m3e_design.dart';

class ${_pascal(name)}M3EWidget extends StatelessWidget {
  const ${_pascal(name)}M3EWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final m3e = context.m3e;
    return Container(
      padding: EdgeInsets.all(m3e.spacing.md),
      decoration: BoxDecoration(
        color: m3e.colors.surfaceStrong,
        borderRadius: m3e.shapes.square.md,
      ),
      child: Text('${_pascal(name)} placeholder', style: m3e.typography.base.titleMedium),
    );
  }
}

String _pascal(String s) => s.split('_').map((p) => p.isEmpty ? '' : (p[0].toUpperCase() + p.substring(1))).join();
''');

  Directory('packages/$pkg/test').createSync();
  File('packages/$pkg/test/${name}_m3e_test.dart').writeAsStringSync('''
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('placeholder', () {
    expect(1 + 1, 2);
  });
}
''');

  // Also add this new package to the aggregated collection package.
  _ensureCollectionExport(pkg);
  _ensureCollectionDependency(pkg);
  _ensureCollectionOverride(pkg);

  stdout.writeln(
      'Created packages/$pkg and updated m3e_collection to include it.');
}
