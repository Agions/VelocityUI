#!/usr/bin/env dart

import 'dart:io';

/// Documentation integrity verifier
/// Checks for broken links and ensures documentation accuracy
void main() {
  print('=== VelocityUI Documentation Integrity Verification ===\n');

  final verifier = DocumentationVerifier();
  final report = verifier.verify();
  report.print();

  // Write report to file
  final reportFile = File('reports/docs_integrity_report.md');
  reportFile.writeAsStringSync(report.toMarkdown());
  print('\n✅ Report saved to: reports/docs_integrity_report.md');

  // Exit with error code if there are broken links
  if (report.brokenLinks.isNotEmpty) {
    exit(1);
  }
}

class DocumentationVerifier {
  final List<BrokenLink> brokenLinks = [];
  final List<String> verifiedFiles = [];
  final Set<String> checkedFiles = {};

  VerificationReport verify() {
    print('📋 Verifying documentation integrity...\n');

    // Check all markdown files in docs/
    _verifyDocsDirectory();

    // Check root documentation files
    _verifyRootDocs();

    // Check for common issues
    _checkCommonIssues();

    return VerificationReport(
      brokenLinks: brokenLinks,
      verifiedFiles: verifiedFiles,
      totalFiles: checkedFiles.length,
    );
  }

  void _verifyDocsDirectory() {
    print('🔍 Checking docs/ directory...');

    final docsDir = Directory('docs');
    if (!docsDir.existsSync()) {
      print('  ⚠️  docs/ directory not found\n');
      return;
    }

    _scanDirectory(docsDir);
    print('  ✓ Scanned docs/ directory\n');
  }

  void _verifyRootDocs() {
    print('🔍 Checking root documentation files...');

    final rootDocs = [
      'README.md',
      'CONTRIBUTING.md',
      'CODE_OF_CONDUCT.md',
      'SECURITY.md',
      'CHANGELOG.md',
    ];

    for (final filename in rootDocs) {
      final file = File(filename);
      if (file.existsSync()) {
        _verifyFile(file);
      }
    }

    print('  ✓ Checked root documentation\n');
  }

  void _scanDirectory(Directory dir) {
    for (final entity in dir.listSync(recursive: true)) {
      // Skip node_modules
      if (entity.path.contains('node_modules')) continue;

      if (entity is File && entity.path.endsWith('.md')) {
        _verifyFile(entity);
      }
    }
  }

  void _verifyFile(File file) {
    if (checkedFiles.contains(file.path)) return;
    checkedFiles.add(file.path);

    final content = file.readAsStringSync();
    final links = _extractLinks(content);

    var hasIssues = false;
    for (final link in links) {
      if (_isInternalLink(link)) {
        if (!_verifyInternalLink(link, file.path)) {
          brokenLinks.add(BrokenLink(
            sourceFile: file.path,
            link: link,
            type: LinkType.internal,
          ));
          hasIssues = true;
        }
      }
    }

    if (!hasIssues) {
      verifiedFiles.add(file.path);
    }
  }

  List<String> _extractLinks(String content) {
    final links = <String>[];

    // Match markdown links: [text](url)
    final linkPattern = RegExp(r'\[([^\]]+)\]\(([^\)]+)\)');
    final matches = linkPattern.allMatches(content);

    for (final match in matches) {
      final url = match.group(2);
      if (url != null) {
        links.add(url);
      }
    }

    return links;
  }

  bool _isInternalLink(String link) {
    // Internal links are relative paths, anchors, or VitePress absolute paths
    return !link.startsWith('http://') &&
        !link.startsWith('https://') &&
        !link.startsWith('mailto:');
  }

  bool _verifyInternalLink(String link, String sourceFile) {
    // Remove anchor
    final linkWithoutAnchor = link.split('#').first;
    if (linkWithoutAnchor.isEmpty) {
      // It's just an anchor, assume valid
      return true;
    }

    // Handle VitePress absolute paths (starting with /)
    if (linkWithoutAnchor.startsWith('/')) {
      // VitePress paths are relative to docs/ directory
      final vitepressPath = 'docs$linkWithoutAnchor';

      // Try with .md extension
      final mdFile = File('$vitepressPath.md');
      if (mdFile.existsSync()) return true;

      // Try as directory with index.md
      final indexFile = File('$vitepressPath/index.md');
      if (indexFile.existsSync()) return true;

      // Try as-is
      final asIsFile = File(vitepressPath);
      final asIsDir = Directory(vitepressPath);
      if (asIsFile.existsSync() || asIsDir.existsSync()) return true;

      return false;
    }

    // Resolve relative path
    final sourceDir = File(sourceFile).parent.path;
    final targetPath = _resolvePath(sourceDir, linkWithoutAnchor);

    // Check if file exists
    final targetFile = File(targetPath);
    final targetDir = Directory(targetPath);

    return targetFile.existsSync() || targetDir.existsSync();
  }

  String _resolvePath(String baseDir, String relativePath) {
    // Simple path resolution
    final parts = <String>[];

    // Start with base directory parts
    parts.addAll(baseDir.split('/'));

    // Process relative path
    for (final part in relativePath.split('/')) {
      if (part == '..') {
        if (parts.isNotEmpty) parts.removeLast();
      } else if (part != '.' && part.isNotEmpty) {
        parts.add(part);
      }
    }

    return parts.join('/');
  }

  void _checkCommonIssues() {
    print('🔍 Checking for common issues...');

    // Check if key documentation files exist
    final requiredFiles = [
      'README.md',
      'CONTRIBUTING.md',
      'LICENSE',
      'docs/index.md',
      'docs/getting-started/index.md',
      'docs/getting-started/installation.md',
      'docs/getting-started/quick-start.md',
    ];

    for (final path in requiredFiles) {
      final file = File(path);
      if (!file.existsSync()) {
        print('  ⚠️  Missing required file: $path');
      }
    }

    print('  ✓ Checked common issues\n');
  }
}

enum LinkType {
  internal,
  external,
}

class BrokenLink {
  BrokenLink({
    required this.sourceFile,
    required this.link,
    required this.type,
  });
  final String sourceFile;
  final String link;
  final LinkType type;
}

class VerificationReport {
  VerificationReport({
    required this.brokenLinks,
    required this.verifiedFiles,
    required this.totalFiles,
  });
  final List<BrokenLink> brokenLinks;
  final List<String> verifiedFiles;
  final int totalFiles;

  void print() {
    stdout.writeln('=== Verification Results ===\n');

    stdout.writeln('Files checked: $totalFiles');
    stdout.writeln('Files verified: ${verifiedFiles.length}');
    stdout.writeln('Broken links found: ${brokenLinks.length}\n');

    if (brokenLinks.isEmpty) {
      stdout.writeln('✅ No broken links found!');
      return;
    }

    stdout.writeln('❌ Broken links:\n');

    final byFile = <String, List<BrokenLink>>{};
    for (final link in brokenLinks) {
      byFile.putIfAbsent(link.sourceFile, () => []).add(link);
    }

    for (final entry in byFile.entries) {
      stdout.writeln('${entry.key}:');
      for (final link in entry.value) {
        stdout.writeln('  - ${link.link}');
      }
      stdout.writeln('');
    }
  }

  String toMarkdown() {
    final buffer = StringBuffer();
    buffer.writeln('# Documentation Integrity Report');
    buffer.writeln();
    buffer.writeln('Generated: ${DateTime.now().toIso8601String()}');
    buffer.writeln();

    buffer.writeln('## Summary');
    buffer.writeln();
    buffer.writeln('| Metric | Count |');
    buffer.writeln('|--------|-------|');
    buffer.writeln('| Files Checked | $totalFiles |');
    buffer.writeln('| Files Verified | ${verifiedFiles.length} |');
    buffer.writeln('| Broken Links | ${brokenLinks.length} |');
    buffer.writeln();

    if (brokenLinks.isEmpty) {
      buffer.writeln('✅ **All documentation links are valid!**');
      buffer.writeln();
      buffer.writeln('## Verified Files');
      buffer.writeln();
      for (final file in verifiedFiles) {
        buffer.writeln('- `$file`');
      }
    } else {
      buffer.writeln('❌ **Found broken links**');
      buffer.writeln();
      buffer.writeln('## Broken Links');
      buffer.writeln();

      final byFile = <String, List<BrokenLink>>{};
      for (final link in brokenLinks) {
        byFile.putIfAbsent(link.sourceFile, () => []).add(link);
      }

      for (final entry in byFile.entries) {
        buffer.writeln('### ${entry.key}');
        buffer.writeln();
        for (final link in entry.value) {
          buffer.writeln('- `${link.link}`');
        }
        buffer.writeln();
      }

      buffer.writeln('## Action Required');
      buffer.writeln();
      buffer.writeln('Please fix the broken links listed above.');
    }

    return buffer.toString();
  }
}
