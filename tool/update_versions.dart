import 'dart:io';

/// Usage examples:
///   dart run tool/update_versions.dart -- version=1.2.3
///   melos run set-version -- version=1.2.3
void main(List<String> args) {
  final versionArg = args.firstWhere(
    (a) => a.startsWith('version='),
    orElse: () => 'version=',
  );
  final version = versionArg.split('=', 2).last.trim();
  if (version.isEmpty) {
    stderr.writeln('Usage: dart run tool/update_versions.dart -- version=<semver>');
    exit(64);
  }

  final packagesDir = Directory('packages');
  if (!packagesDir.existsSync()) {
    stderr.writeln("No 'packages' directory found at repo root.");
    exit(1);
  }

  final pubspecFiles = packagesDir
      .listSync(recursive: false)
      .whereType<Directory>()
      .map((d) => File('${d.path}\\pubspec.yaml'))
      .where((f) => f.existsSync())
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));

  if (pubspecFiles.isEmpty) {
    stderr.writeln('No pubspec.yaml files found in packages/*');
    exit(1);
  }

  int updated = 0;
  final updatedPkgs = <String>[];
  for (final file in pubspecFiles) {
    final content = file.readAsStringSync();

    // Skip if it's clearly an app (heuristic): has 'flutter:' and 'uses-material-design:' at top-level
    // but the requirement is to update all packages under packages/*. We will proceed regardless.

    final nameMatch = RegExp(r'^name:\s*(.+)$', multiLine: true).firstMatch(content);
    final pkgName = nameMatch != null ? nameMatch.group(1)!.trim() : file.parent.path.split('\\').last;

    String updatedContent;
    final versionRe = RegExp(r'^version:\s*.*$', multiLine: true);
    if (versionRe.hasMatch(content)) {
      updatedContent = content.replaceFirstMapped(versionRe, (_) => 'version: $version');
    } else {
      // Insert after description if present, otherwise after name.
      final descRe = RegExp(r'^(description:.*)$', multiLine: true);
      if (descRe.hasMatch(content)) {
        updatedContent = content.replaceFirstMapped(descRe, (m) => '${m.group(1)}\nversion: $version');
      } else {
        final nameRe = RegExp(r'^(name:.*)$', multiLine: true);
        if (nameRe.hasMatch(content)) {
          updatedContent = content.replaceFirstMapped(nameRe, (m) => '${m.group(1)}\nversion: $version');
        } else {
          // If neither present, prepend version at top.
          updatedContent = 'version: $version\n$content';
        }
      }
    }

    if (updatedContent != content) {
      file.writeAsStringSync(updatedContent);
      updated++;
      updatedPkgs.add(pkgName);
    }
  }

  stdout.writeln('Updated version to $version in $updated package(s).');
  for (final p in updatedPkgs) {
    stdout.writeln(' - $p');
  }
}
