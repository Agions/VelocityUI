#!/usr/bin/env dart

import 'dart:io';

/// Documentation cleanup script
/// Removes redundant documentation files identified by the scanner
void main() {
  print('=== VelocityUI Documentation Cleanup ===\n');

  final cleaner = DocumentationCleaner();
  cleaner.cleanup();

  print('\n✅ Cleanup complete!');
}

class DocumentationCleaner {
  final List<String> deletedFiles = [];
  final List<String> movedFiles = [];

  void cleanup() {
    // Create reports directory if it doesn't exist
    _createReportsDirectory();

    // Move generated reports to reports/ directory
    _moveGeneratedReports();

    // Delete analysis.txt (it's outdated and contains errors)
    _deleteAnalysisFile();

    // Update README.md to be more concise
    _updateReadme();

    _printSummary();
  }

  void _createReportsDirectory() {
    print('📁 Creating reports directory...');
    final reportsDir = Directory('reports');
    if (!reportsDir.existsSync()) {
      reportsDir.createSync();
      print('  ✓ Created reports/ directory\n');
    } else {
      print('  ✓ reports/ directory already exists\n');
    }
  }

  void _moveGeneratedReports() {
    print('📦 Moving generated reports...');

    final reportsToMove = [
      'component_migration_report.md',
      'test_coverage_summary.md',
      'docs_redundancy_report.md',
    ];

    for (final filename in reportsToMove) {
      final sourceFile = File(filename);
      if (sourceFile.existsSync()) {
        final targetPath = 'reports/$filename';
        final targetFile = File(targetPath);

        // Copy content
        targetFile.writeAsStringSync(sourceFile.readAsStringSync());

        // Delete original
        sourceFile.deleteSync();

        movedFiles.add('$filename → $targetPath');
        print('  ✓ Moved $filename to reports/');
      }
    }
    print('');
  }

  void _deleteAnalysisFile() {
    print('🗑️  Deleting outdated analysis file...');

    final analysisFile = File('analysis.txt');
    if (analysisFile.existsSync()) {
      analysisFile.deleteSync();
      deletedFiles.add('analysis.txt');
      print('  ✓ Deleted analysis.txt\n');
    } else {
      print('  ℹ️  analysis.txt not found\n');
    }
  }

  void _updateReadme() {
    print('📝 Updating README.md to be more concise...');

    final readme = File('README.md');
    if (!readme.existsSync()) {
      print('  ℹ️  README.md not found\n');
      return;
    }

    final content = readme.readAsStringSync();

    // Create a more concise version
    final updatedContent = _createConciseReadme(content);

    // Backup original
    final backup = File('README.md.backup');
    backup.writeAsStringSync(content);

    // Write updated version
    readme.writeAsStringSync(updatedContent);

    print('  ✓ Updated README.md (backup saved as README.md.backup)\n');
  }

  String _createConciseReadme(String original) {
    // Keep the header and key sections, but make them more concise
    // Remove duplicate content that's in docs/

    return '''# VelocityUI

<div align="center">

![VelocityUI Logo](https://raw.githubusercontent.com/Agions/velocity-ui/main/assets/images/logo_python.svg)

**高性能企业级 Flutter UI 组件库**

![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-28A745?style=for-the-badge)
![Version](https://img.shields.io/badge/Version-1.0.3-FF6B6B?style=for-the-badge)

[![Stars](https://img.shields.io/github/stars/Agions/velocity-ui?style=for-the-badge&logo=github)](https://github.com/Agions/velocity-ui)
[![Issues](https://img.shields.io/github/issues/Agions/velocity-ui?style=for-the-badge&logo=github)](https://github.com/Agions/velocity-ui/issues)

**🚀 60+ 专业组件 • ⚡ 高性能 • 🎨 设计系统 • 📱 响应式 • ♿ 无障碍**

[📚 文档](https://agions.github.io/velocity-ui/) • [🚀 快速开始](#快速开始) • [💬 讨论](https://github.com/Agions/velocity-ui/discussions)

</div>

---

## ✨ 特性

- **60+ 专业组件** - 涵盖表单、导航、数据展示、反馈等全场景
- **设计系统** - 基于 Material Design 3，统一的设计语言
- **高性能** - 优化的渲染策略和内存管理
- **无障碍** - 符合 WCAG AA 标准
- **响应式** - 完美适配移动端、平板和桌面端
- **类型安全** - 完整的 Dart 类型支持

## 🚀 快速开始

### 安装

```yaml
dependencies:
  velocity_ui: ^1.0.3
```

### 使用

```dart
import 'package:velocity_ui/velocity_ui.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return VelocityApp(
      theme: VelocityTheme.light(),
      home: Scaffold(
        body: Center(
          child: VelocityButton(
            text: '开始使用',
            onPressed: () => print('Hello VelocityUI!'),
          ),
        ),
      ),
    );
  }
}
```

## 📚 文档

完整文档请访问：[https://agions.github.io/velocity-ui/](https://agions.github.io/velocity-ui/)

- [快速开始](https://agions.github.io/velocity-ui/getting-started/)
- [组件文档](https://agions.github.io/velocity-ui/components/)
- [API 参考](https://agions.github.io/velocity-ui/api/)
- [常见问题](https://agions.github.io/velocity-ui/faq)

## 🤝 贡献

欢迎贡献！请查看 [贡献指南](CONTRIBUTING.md) 了解详情。

## 📄 开源协议

本项目采用 [MIT 协议](LICENSE) 开源。

---

<div align="center">

**由 Agions 团队用 ❤️ 精心打造**

[![GitHub](https://img.shields.io/github/stars/Agions/velocity-ui?style=social)](https://github.com/Agions/velocity-ui)

</div>
''';
  }

  void _printSummary() {
    print('=== Cleanup Summary ===\n');

    if (deletedFiles.isNotEmpty) {
      print('Deleted files (${deletedFiles.length}):');
      for (final file in deletedFiles) {
        print('  - $file');
      }
      print('');
    }

    if (movedFiles.isNotEmpty) {
      print('Moved files (${movedFiles.length}):');
      for (final file in movedFiles) {
        print('  - $file');
      }
      print('');
    }

    print('Actions taken:');
    print('  ✓ Created reports/ directory');
    print('  ✓ Moved generated reports to reports/');
    print('  ✓ Deleted outdated analysis.txt');
    print('  ✓ Updated README.md to be more concise');
    print('  ✓ Created README.md.backup');
  }
}
