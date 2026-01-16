#!/usr/bin/env dart

import 'dart:io';

void main() {
  final docsDir = Directory('docs');

  if (!docsDir.existsSync()) {
    print('❌ docs 目录不存在');
    exit(1);
  }

  int processedFiles = 0;
  int modifiedFiles = 0;

  // 递归查找所有 .md 文件
  final mdFiles = docsDir
      .listSync(recursive: true)
      .where((entity) => entity is File && entity.path.endsWith('.md'))
      .cast<File>()
      .where((file) => !file.path.contains('node_modules'))
      .toList();

  print('📝 找到 ${mdFiles.length} 个 Markdown 文件\n');

  for (final file in mdFiles) {
    processedFiles++;
    final content = file.readAsStringSync();

    // 移除无障碍部分
    final modifiedContent = removeAccessibilitySection(content);

    if (modifiedContent != content) {
      file.writeAsStringSync(modifiedContent);
      modifiedFiles++;
      print('✅ 已修改: ${file.path}');
    }
  }

  print('\n📊 处理完成:');
  print('   - 处理文件数: $processedFiles');
  print('   - 修改文件数: $modifiedFiles');
  print('   - 未修改文件数: ${processedFiles - modifiedFiles}');
}

String removeAccessibilitySection(String content) {
  String result = content;

  // 方法1: 匹配 ## 无障碍 标题及其后续内容
  result = result.replaceAll(
    RegExp(r'\n## 无障碍\n[\s\S]*?(?=\n## |\n# |$)', multiLine: true),
    '',
  );

  // 方法2: 匹配 ### 无障碍 标题
  result = result.replaceAll(
    RegExp(r'\n### 无障碍\n[\s\S]*?(?=\n### |\n## |\n# |$)', multiLine: true),
    '',
  );

  // 方法3: 移除包含无障碍相关内容的列表项和段落
  final accessibilityPatterns = [
    // 匹配包含关键词的列表项
    r'^- .*无障碍.*$',
    r'^- .*屏幕阅读器.*$',
    r'^- .*键盘操作.*$',
    r'^- .*焦点管理.*$',
    r'^- .*支持键盘.*$',
    r'^- .*语义标签.*$',
    r'^- .*可访问性.*$',
    r'^- .*ARIA.*$',
    r'^- .*辅助功能.*$',
    r'^- .*被屏幕阅读器.*$',
    r'^- .*会被屏幕阅读器.*$',
    r'^- .*支持焦点.*$',
    r'^- .*禁用状态会被.*$',
    r'^- .*开关状态会被.*$',
    r'^- .*标签会被.*$',
    r'^- .*当前.*会被屏幕阅读器.*$',
    r'^- .*图片会有.*语义.*$',
    r'^- .*可点击.*支持焦点.*$',
    r'^- .*文字.*会被屏幕阅读器.*$',
    r'^- .*日期会被屏幕阅读器.*$',
    r'^- .*当前评分会被屏幕阅读器.*$',
    r'^- .*只读状态会被.*$',
    r'^- .*文件名会被屏幕阅读器.*$',
    r'^- .*上传状态会被.*$',
  ];

  for (final pattern in accessibilityPatterns) {
    result = result.replaceAll(
      RegExp(pattern + r'\n?', multiLine: true),
      '',
    );
  }

  // 清理多余的空行（超过2个连续空行）
  result = result.replaceAll(RegExp(r'\n{3,}'), '\n\n');

  // 清理文件末尾的多余空行
  result = result.trimRight() + '\n';

  return result;
}
