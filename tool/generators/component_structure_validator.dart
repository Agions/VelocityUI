import 'dart:io';
import 'package:path/path.dart' as path;

/// 组件结构验证结果
class ValidationResult {
  const ValidationResult({
    required this.isValid,
    required this.missingFiles,
    required this.extraFiles,
    required this.namingIssues,
    required this.componentPath,
    required this.componentName,
  });

  /// 是否有效
  final bool isValid;

  /// 缺失的文件列表
  final List<String> missingFiles;

  /// 多余的文件列表
  final List<String> extraFiles;

  /// 命名问题列表
  final List<String> namingIssues;

  /// 组件路径
  final String componentPath;

  /// 组件名称
  final String componentName;

  @override
  String toString() {
    if (isValid) {
      return 'ValidationResult: $componentName is valid';
    }
    final issues = <String>[];
    if (missingFiles.isNotEmpty) {
      issues.add('Missing files: ${missingFiles.join(", ")}');
    }
    if (extraFiles.isNotEmpty) {
      issues.add('Extra files: ${extraFiles.join(", ")}');
    }
    if (namingIssues.isNotEmpty) {
      issues.add('Naming issues: ${namingIssues.join(", ")}');
    }
    return 'ValidationResult: $componentName has issues:\n  ${issues.join("\n  ")}';
  }
}

/// 组件问题
class ComponentIssue {
  const ComponentIssue({
    required this.componentName,
    required this.componentPath,
    required this.issueType,
    required this.description,
    this.suggestedFix,
  });

  /// 组件名称
  final String componentName;

  /// 组件路径
  final String componentPath;

  /// 问题类型
  final IssueType issueType;

  /// 问题描述
  final String description;

  /// 建议的修复方案
  final String? suggestedFix;

  @override
  String toString() {
    return 'ComponentIssue: [$issueType] $componentName - $description';
  }
}

/// 问题类型
enum IssueType {
  missingImplementation,
  missingStyle,
  missingIndex,
  namingConvention,
  extraFile,
}

/// 迁移报告
class MigrationReport {
  const MigrationReport({
    required this.totalComponents,
    required this.validComponents,
    required this.invalidComponents,
    required this.issues,
    required this.validationResults,
    required this.generatedAt,
  });

  /// 扫描的组件总数
  final int totalComponents;

  /// 符合标准的组件数
  final int validComponents;

  /// 不符合标准的组件数
  final int invalidComponents;

  /// 所有问题列表
  final List<ComponentIssue> issues;

  /// 验证结果列表
  final List<ValidationResult> validationResults;

  /// 生成时间
  final DateTime generatedAt;

  /// 生成 Markdown 格式的报告
  String toMarkdown() {
    final buffer = StringBuffer();
    buffer.writeln('# Component Structure Migration Report');
    buffer.writeln();
    buffer.writeln('Generated at: ${generatedAt.toIso8601String()}');
    buffer.writeln();
    buffer.writeln('## Summary');
    buffer.writeln();
    buffer.writeln('| Metric | Count |');
    buffer.writeln('|--------|-------|');
    buffer.writeln('| Total Components | $totalComponents |');
    buffer.writeln('| Valid Components | $validComponents |');
    buffer.writeln('| Invalid Components | $invalidComponents |');
    buffer.writeln(
      '| Compliance Rate | ${(validComponents / totalComponents * 100).toStringAsFixed(1)}% |',
    );
    buffer.writeln();

    if (issues.isEmpty) {
      buffer.writeln('## Status');
      buffer.writeln();
      buffer.writeln('✅ All components conform to the standard structure!');
    } else {
      buffer.writeln('## Issues by Type');
      buffer.writeln();

      final issuesByType = <IssueType, List<ComponentIssue>>{};
      for (final issue in issues) {
        issuesByType.putIfAbsent(issue.issueType, () => []).add(issue);
      }

      for (final entry in issuesByType.entries) {
        buffer.writeln('### ${_issueTypeToString(entry.key)}');
        buffer.writeln();
        for (final issue in entry.value) {
          buffer.writeln('- **${issue.componentName}**: ${issue.description}');
          if (issue.suggestedFix != null) {
            buffer.writeln('  - Fix: ${issue.suggestedFix}');
          }
        }
        buffer.writeln();
      }

      buffer.writeln('## Detailed Results');
      buffer.writeln();

      for (final result in validationResults.where((r) => !r.isValid)) {
        buffer.writeln('### ${result.componentName}');
        buffer.writeln();
        buffer.writeln('Path: `${result.componentPath}`');
        buffer.writeln();
        if (result.missingFiles.isNotEmpty) {
          buffer.writeln('**Missing Files:**');
          for (final file in result.missingFiles) {
            buffer.writeln('- `$file`');
          }
          buffer.writeln();
        }
        if (result.extraFiles.isNotEmpty) {
          buffer.writeln('**Extra Files:**');
          for (final file in result.extraFiles) {
            buffer.writeln('- `$file`');
          }
          buffer.writeln();
        }
        if (result.namingIssues.isNotEmpty) {
          buffer.writeln('**Naming Issues:**');
          for (final issue in result.namingIssues) {
            buffer.writeln('- $issue');
          }
          buffer.writeln();
        }
      }
    }

    return buffer.toString();
  }

  String _issueTypeToString(IssueType type) {
    switch (type) {
      case IssueType.missingImplementation:
        return 'Missing Implementation Files';
      case IssueType.missingStyle:
        return 'Missing Style Files';
      case IssueType.missingIndex:
        return 'Missing Index Files';
      case IssueType.namingConvention:
        return 'Naming Convention Issues';
      case IssueType.extraFile:
        return 'Extra Files';
    }
  }

  @override
  String toString() {
    return 'MigrationReport: $validComponents/$totalComponents components valid';
  }
}

/// 组件结构验证器
///
/// 用于验证组件目录是否符合标准结构：
/// - component_name.dart (实现文件)
/// - component_name_style.dart (样式文件)
/// - index.dart (导出文件)
class ComponentStructureValidator {
  ComponentStructureValidator({required this.componentsRoot});

  /// 组件根目录
  final String componentsRoot;

  /// 组件类别列表
  static const List<String> componentCategories = [
    'basic',
    'display',
    'feedback',
    'form',
    'layout',
    'navigation',
  ];

  /// 验证单个组件目录结构
  ///
  /// [componentPath] 组件目录的完整路径
  /// 返回验证结果，包含缺失文件列表、多余文件列表和命名问题
  ValidationResult validate(String componentPath) {
    final dir = Directory(componentPath);
    if (!dir.existsSync()) {
      return ValidationResult(
        isValid: false,
        missingFiles: ['Directory does not exist'],
        extraFiles: [],
        namingIssues: [],
        componentPath: componentPath,
        componentName: path.basename(componentPath),
      );
    }

    final componentName = path.basename(componentPath);
    final files = dir
        .listSync()
        .whereType<File>()
        .map((f) => path.basename(f.path))
        .toList();

    // 期望的文件
    final expectedFiles = [
      '$componentName.dart',
      '${componentName}_style.dart',
      'index.dart',
    ];

    // 检查缺失的文件
    final missingFiles = <String>[];
    for (final expected in expectedFiles) {
      if (!files.contains(expected)) {
        missingFiles.add(expected);
      }
    }

    // 检查多余的文件（非 .dart 文件或不符合命名规范的文件）
    final extraFiles = <String>[];
    for (final file in files) {
      if (!file.endsWith('.dart')) {
        extraFiles.add(file);
      } else if (!expectedFiles.contains(file)) {
        // 允许额外的 dart 文件，但标记为额外文件
        extraFiles.add(file);
      }
    }

    // 检查命名问题
    final namingIssues = <String>[];
    if (!_isSnakeCase(componentName)) {
      namingIssues.add(
        'Component directory name "$componentName" is not in snake_case',
      );
    }

    for (final file in files) {
      if (file.endsWith('.dart') && file != 'index.dart') {
        final fileName = file.replaceAll('.dart', '');
        if (!_isSnakeCase(fileName)) {
          namingIssues.add('File name "$file" is not in snake_case');
        }
      }
    }

    final isValid = missingFiles.isEmpty && namingIssues.isEmpty;

    return ValidationResult(
      isValid: isValid,
      missingFiles: missingFiles,
      extraFiles: extraFiles,
      namingIssues: namingIssues,
      componentPath: componentPath,
      componentName: componentName,
    );
  }

  /// 扫描所有组件目录
  ///
  /// 返回不符合标准的组件问题列表
  List<ComponentIssue> scanAllComponents() {
    final issues = <ComponentIssue>[];

    for (final category in componentCategories) {
      final categoryPath = path.join(componentsRoot, category);
      final categoryDir = Directory(categoryPath);

      if (!categoryDir.existsSync()) {
        continue;
      }

      // 获取该类别下的所有组件目录
      final componentDirs =
          categoryDir.listSync().whereType<Directory>().toList();

      for (final componentDir in componentDirs) {
        final result = validate(componentDir.path);

        if (!result.isValid) {
          // 转换验证结果为问题列表
          for (final missingFile in result.missingFiles) {
            final issueType = _getIssueTypeForMissingFile(missingFile);
            issues.add(
              ComponentIssue(
                componentName: result.componentName,
                componentPath: result.componentPath,
                issueType: issueType,
                description: 'Missing file: $missingFile',
                suggestedFix: _getSuggestedFix(issueType, result.componentName),
              ),
            );
          }

          for (final namingIssue in result.namingIssues) {
            issues.add(
              ComponentIssue(
                componentName: result.componentName,
                componentPath: result.componentPath,
                issueType: IssueType.namingConvention,
                description: namingIssue,
                suggestedFix: 'Rename to follow snake_case convention',
              ),
            );
          }
        }
      }
    }

    return issues;
  }

  /// 生成迁移报告
  ///
  /// 返回包含所有组件验证结果的迁移报告
  MigrationReport generateMigrationReport() {
    final validationResults = <ValidationResult>[];
    var validCount = 0;
    var totalCount = 0;

    for (final category in componentCategories) {
      final categoryPath = path.join(componentsRoot, category);
      final categoryDir = Directory(categoryPath);

      if (!categoryDir.existsSync()) {
        continue;
      }

      final componentDirs =
          categoryDir.listSync().whereType<Directory>().toList();

      for (final componentDir in componentDirs) {
        totalCount++;
        final result = validate(componentDir.path);
        validationResults.add(result);

        if (result.isValid) {
          validCount++;
        }
      }
    }

    final issues = scanAllComponents();

    return MigrationReport(
      totalComponents: totalCount,
      validComponents: validCount,
      invalidComponents: totalCount - validCount,
      issues: issues,
      validationResults: validationResults,
      generatedAt: DateTime.now(),
    );
  }

  /// 检查字符串是否为 snake_case
  bool _isSnakeCase(String str) {
    // snake_case: 小写字母、数字和下划线，不能以数字或下划线开头
    final snakeCaseRegex = RegExp(r'^[a-z][a-z0-9]*(_[a-z0-9]+)*$');
    return snakeCaseRegex.hasMatch(str);
  }

  /// 根据缺失文件获取问题类型
  IssueType _getIssueTypeForMissingFile(String fileName) {
    if (fileName == 'index.dart') {
      return IssueType.missingIndex;
    } else if (fileName.endsWith('_style.dart')) {
      return IssueType.missingStyle;
    } else {
      return IssueType.missingImplementation;
    }
  }

  /// 获取建议的修复方案
  String _getSuggestedFix(IssueType issueType, String componentName) {
    switch (issueType) {
      case IssueType.missingImplementation:
        return 'Create $componentName.dart with component implementation';
      case IssueType.missingStyle:
        return 'Create ${componentName}_style.dart with style definitions';
      case IssueType.missingIndex:
        return 'Create index.dart to export public APIs';
      case IssueType.namingConvention:
        return 'Rename to follow snake_case convention';
      case IssueType.extraFile:
        return 'Consider removing or consolidating extra files';
    }
  }
}

/// 运行验证器的命令行入口
Future<void> main(List<String> args) async {
  final componentsRoot = args.isNotEmpty ? args[0] : 'lib/src/components';

  print('Scanning components in: $componentsRoot');
  print('');

  final validator = ComponentStructureValidator(componentsRoot: componentsRoot);
  final report = validator.generateMigrationReport();

  print(report.toMarkdown());

  // 保存报告到文件
  final reportFile = File('component_migration_report.md');
  await reportFile.writeAsString(report.toMarkdown());
  print('Report saved to: ${reportFile.path}');
}
