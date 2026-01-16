#!/usr/bin/env dart

import 'dart:io';

/// Documentation redundancy scanner
/// Identifies duplicate, outdated, and deprecated documentation files
void main() {
  print('=== VelocityUI Documentation Redundancy Scanner ===\n');

  final report = DocumentationScanner().scan();
  report.print();

  // Write report to file
  final reportFile = File('docs_redundancy_report.md');
  reportFile.writeAsStringSync(report.toMarkdown());
  print('\n✅ Report saved to: docs_redundancy_report.md');
}

class DocumentationScanner {
  final List<RedundancyIssue> issues = [];

  ScanReport scan() {
    print('📋 Scanning documentation files...\n');

    // Check for duplicate content between README.md and docs/
    _checkReadmeVsDocs();

    // Check for outdated API documentation
    _checkOutdatedApiDocs();

    // Check for deprecated usage guides
    _checkDeprecatedGuides();

    // Check for redundant migration reports
    _checkRedundantReports();

    // Check for analysis output files
    _checkAnalysisFiles();

    return ScanReport(issues);
  }

  void _checkReadmeVsDocs() {
    print('🔍 Checking README.md vs docs/ redundancy...');

    final readme = File('README.md');
    final docsIndex = File('docs/index.md');
    final docsGettingStarted = File('docs/getting-started/index.md');
    final docsInstallation = File('docs/getting-started/installation.md');
    final docsQuickStart = File('docs/getting-started/quick-start.md');

    if (readme.existsSync() && docsIndex.existsSync()) {
      final readmeContent = readme.readAsStringSync();
      final docsContent = docsIndex.readAsStringSync();

      // Check for significant overlap
      if (_hasSignificantOverlap(readmeContent, docsContent)) {
        issues.add(RedundancyIssue(
          type: IssueType.duplicate,
          files: ['README.md', 'docs/index.md'],
          description:
              'README.md and docs/index.md contain overlapping content. '
              'README should be a brief overview, while docs/index.md should be the detailed documentation homepage.',
          severity: Severity.medium,
          recommendation:
              'Keep README.md as a brief project overview with links to documentation. '
              'Move detailed content to docs/index.md.',
        ));
      }
    }

    // Check installation instructions duplication
    if (readme.existsSync() && docsInstallation.existsSync()) {
      final readmeContent = readme.readAsStringSync();
      if (readmeContent.contains('## 📦 安装指南') ||
          readmeContent.contains('## 安装')) {
        issues.add(RedundancyIssue(
          type: IssueType.duplicate,
          files: ['README.md', 'docs/getting-started/installation.md'],
          description:
              'Installation instructions are duplicated in both README.md and docs/getting-started/installation.md',
          severity: Severity.low,
          recommendation:
              'Keep brief installation steps in README.md, detailed instructions in docs/getting-started/installation.md',
        ));
      }
    }

    // Check quick start duplication
    if (readme.existsSync() && docsQuickStart.existsSync()) {
      final readmeContent = readme.readAsStringSync();
      if (readmeContent.contains('## 🚀 快速开始') ||
          readmeContent.contains('## 快速开始')) {
        issues.add(RedundancyIssue(
          type: IssueType.duplicate,
          files: ['README.md', 'docs/getting-started/quick-start.md'],
          description:
              'Quick start guide is duplicated in both README.md and docs/getting-started/quick-start.md',
          severity: Severity.low,
          recommendation:
              'Keep minimal quick start in README.md, comprehensive guide in docs/getting-started/quick-start.md',
        ));
      }
    }

    print('  ✓ Checked README vs docs redundancy\n');
  }

  void _checkOutdatedApiDocs() {
    print('🔍 Checking for outdated API documentation...');

    // Check if API docs reference non-existent files
    final apiDocs = Directory('docs/api');
    if (apiDocs.existsSync()) {
      for (final file in apiDocs.listSync().whereType<File>()) {
        if (file.path.endsWith('.md')) {
          final content = file.readAsStringSync();

          // Check for references to old file paths
          if (content.contains('lib/components/') &&
              !content.contains('lib/src/components/')) {
            issues.add(RedundancyIssue(
              type: IssueType.outdated,
              files: [file.path],
              description:
                  'API documentation references old file paths (lib/components/ instead of lib/src/components/)',
              severity: Severity.medium,
              recommendation:
                  'Update file path references to match current project structure',
            ));
          }

          // Check for references to deprecated APIs
          if (content.contains('ZephyrButton') || content.contains('Zephyr')) {
            issues.add(RedundancyIssue(
              type: IssueType.outdated,
              files: [file.path],
              description:
                  'API documentation references old "Zephyr" naming (should be "Velocity")',
              severity: Severity.high,
              recommendation: 'Update all references from Zephyr to Velocity',
            ));
          }
        }
      }
    }

    print('  ✓ Checked API documentation\n');
  }

  void _checkDeprecatedGuides() {
    print('🔍 Checking for deprecated usage guides...');

    // Check for old guide files that might be deprecated
    final deprecatedPaths = [
      'doc/getting-started.md',
      'doc/guides/project-structure.md',
      'doc/guides/setup.md',
      'doc/guides/design-system.md',
      'doc/guides/theming.md',
      'doc/guides/responsive-design.md',
      'doc/guides/accessibility.md',
      'doc/guides/performance.md',
      'doc/guides/coding-standards.md',
      'doc/guides/testing.md',
      'doc/guides/deployment.md',
      'doc/api/components.md',
      'doc/api/themes.md',
      'doc/api/utils.md',
      'doc/api/types.md',
      'doc/VelocityUI_Component_Development_Standards.md',
    ];

    for (final path in deprecatedPaths) {
      final file = File(path);
      if (file.existsSync()) {
        issues.add(RedundancyIssue(
          type: IssueType.deprecated,
          files: [path],
          description:
              'Old documentation file exists in deprecated location (doc/ instead of docs/)',
          severity: Severity.high,
          recommendation:
              'Remove this file if content has been migrated to docs/ directory, or migrate if not yet done',
        ));
      }
    }

    print('  ✓ Checked for deprecated guides\n');
  }

  void _checkRedundantReports() {
    print('🔍 Checking for redundant reports...');

    // Check for temporary/generated reports that should be cleaned up
    final reportFiles = [
      'component_migration_report.md',
      'test_coverage_summary.md',
      'analysis.txt',
    ];

    for (final path in reportFiles) {
      final file = File(path);
      if (file.existsSync()) {
        issues.add(RedundancyIssue(
          type: IssueType.redundant,
          files: [path],
          description:
              'Generated report file in root directory (should be in reports/ or removed after review)',
          severity: Severity.low,
          recommendation:
              'Move to a reports/ directory or remove if no longer needed',
        ));
      }
    }

    print('  ✓ Checked for redundant reports\n');
  }

  void _checkAnalysisFiles() {
    print('🔍 Checking for analysis output files...');

    final analysisFile = File('analysis.txt');
    if (analysisFile.existsSync()) {
      final content = analysisFile.readAsStringSync();
      if (content.contains('error •') || content.contains('warning •')) {
        issues.add(RedundancyIssue(
          type: IssueType.outdated,
          files: ['analysis.txt'],
          description:
              'Analysis output file contains errors/warnings and should be addressed or removed',
          severity: Severity.medium,
          recommendation:
              'Fix the analysis issues or remove the file after addressing them',
        ));
      }
    }

    print('  ✓ Checked analysis files\n');
  }

  bool _hasSignificantOverlap(String content1, String content2) {
    // Simple heuristic: check if more than 30% of lines are similar
    final lines1 =
        content1.split('\n').where((l) => l.trim().isNotEmpty).toList();
    final lines2 =
        content2.split('\n').where((l) => l.trim().isNotEmpty).toList();

    int similarLines = 0;
    for (final line1 in lines1) {
      if (line1.length < 20) continue; // Skip short lines
      for (final line2 in lines2) {
        if (_areSimilar(line1, line2)) {
          similarLines++;
          break;
        }
      }
    }

    final overlapRatio = similarLines / lines1.length;
    return overlapRatio > 0.3;
  }

  bool _areSimilar(String line1, String line2) {
    // Simple similarity check
    final normalized1 = line1.trim().toLowerCase();
    final normalized2 = line2.trim().toLowerCase();

    if (normalized1 == normalized2) return true;
    if (normalized1.contains(normalized2) ||
        normalized2.contains(normalized1)) {
      return true;
    }

    return false;
  }
}

enum IssueType {
  duplicate,
  outdated,
  deprecated,
  redundant,
}

enum Severity {
  low,
  medium,
  high,
}

class RedundancyIssue {
  final IssueType type;
  final List<String> files;
  final String description;
  final Severity severity;
  final String recommendation;

  RedundancyIssue({
    required this.type,
    required this.files,
    required this.description,
    required this.severity,
    required this.recommendation,
  });
}

class ScanReport {
  final List<RedundancyIssue> issues;

  ScanReport(this.issues);

  void print() {
    stdout.writeln('=== Scan Results ===\n');

    if (issues.isEmpty) {
      stdout.writeln('✅ No redundancy issues found!');
      return;
    }

    stdout.writeln('Found ${issues.length} issue(s):\n');

    final byType = <IssueType, List<RedundancyIssue>>{};
    for (final issue in issues) {
      byType.putIfAbsent(issue.type, () => []).add(issue);
    }

    for (final type in IssueType.values) {
      final typeIssues = byType[type] ?? [];
      if (typeIssues.isEmpty) continue;

      stdout.writeln('## ${_typeToString(type)} (${typeIssues.length})');
      stdout.writeln();

      for (var i = 0; i < typeIssues.length; i++) {
        final issue = typeIssues[i];
        stdout.writeln(
            '${i + 1}. [${_severityToString(issue.severity)}] ${issue.description}');
        stdout.writeln('   Files: ${issue.files.join(", ")}');
        stdout.writeln('   Recommendation: ${issue.recommendation}');
        stdout.writeln();
      }
    }

    // Summary
    final high = issues.where((i) => i.severity == Severity.high).length;
    final medium = issues.where((i) => i.severity == Severity.medium).length;
    final low = issues.where((i) => i.severity == Severity.low).length;

    stdout.writeln('Summary:');
    stdout.writeln('  High priority: $high');
    stdout.writeln('  Medium priority: $medium');
    stdout.writeln('  Low priority: $low');
  }

  String toMarkdown() {
    final buffer = StringBuffer();
    buffer.writeln('# Documentation Redundancy Report');
    buffer.writeln();
    buffer.writeln('Generated: ${DateTime.now().toIso8601String()}');
    buffer.writeln();

    if (issues.isEmpty) {
      buffer.writeln('✅ No redundancy issues found!');
      return buffer.toString();
    }

    buffer.writeln('## Summary');
    buffer.writeln();
    buffer.writeln('Total issues found: ${issues.length}');
    buffer.writeln();

    final high = issues.where((i) => i.severity == Severity.high).length;
    final medium = issues.where((i) => i.severity == Severity.medium).length;
    final low = issues.where((i) => i.severity == Severity.low).length;

    buffer.writeln('| Severity | Count |');
    buffer.writeln('|----------|-------|');
    buffer.writeln('| High     | $high |');
    buffer.writeln('| Medium   | $medium |');
    buffer.writeln('| Low      | $low |');
    buffer.writeln();

    final byType = <IssueType, List<RedundancyIssue>>{};
    for (final issue in issues) {
      byType.putIfAbsent(issue.type, () => []).add(issue);
    }

    for (final type in IssueType.values) {
      final typeIssues = byType[type] ?? [];
      if (typeIssues.isEmpty) continue;

      buffer.writeln('## ${_typeToString(type)}');
      buffer.writeln();

      for (var i = 0; i < typeIssues.length; i++) {
        final issue = typeIssues[i];
        buffer.writeln('### ${i + 1}. ${issue.description}');
        buffer.writeln();
        buffer.writeln('**Severity:** ${_severityToString(issue.severity)}');
        buffer.writeln();
        buffer.writeln('**Files:**');
        for (final file in issue.files) {
          buffer.writeln('- `$file`');
        }
        buffer.writeln();
        buffer.writeln('**Recommendation:** ${issue.recommendation}');
        buffer.writeln();
      }
    }

    buffer.writeln('## Next Steps');
    buffer.writeln();
    buffer.writeln('1. Review high-priority issues first');
    buffer.writeln('2. Address medium-priority issues');
    buffer.writeln('3. Clean up low-priority issues');
    buffer.writeln('4. Verify all internal links after cleanup');
    buffer.writeln('5. Update references in remaining documentation');

    return buffer.toString();
  }

  String _typeToString(IssueType type) {
    switch (type) {
      case IssueType.duplicate:
        return 'Duplicate Documentation';
      case IssueType.outdated:
        return 'Outdated Documentation';
      case IssueType.deprecated:
        return 'Deprecated Files';
      case IssueType.redundant:
        return 'Redundant Files';
    }
  }

  String _severityToString(Severity severity) {
    switch (severity) {
      case Severity.high:
        return '🔴 HIGH';
      case Severity.medium:
        return '🟡 MEDIUM';
      case Severity.low:
        return '🟢 LOW';
    }
  }
}
