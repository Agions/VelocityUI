/// Basic Components Examples Page
///
/// 展示所有基础组件的使用示例。
library;

import 'package:flutter/material.dart';

import 'button_example.dart';
import 'text_example.dart';
import 'icon_example.dart';
import 'chip_example.dart';
import 'spinner_example.dart';
import 'link_example.dart';
import 'image_example.dart';

/// 基础组件示例页面
class BasicExamplesPage extends StatelessWidget {
  const BasicExamplesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Components'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _ExampleSection(
            title: 'Button',
            description: '按钮组件，支持多种类型、尺寸和状态',
            child: ButtonExample(),
          ),
          SizedBox(height: 24),
          _ExampleSection(
            title: 'Text',
            description: '文本组件，支持多种排版变体',
            child: TextExample(),
          ),
          SizedBox(height: 24),
          _ExampleSection(
            title: 'Icon',
            description: '图标组件，支持多种尺寸和颜色',
            child: IconExample(),
          ),
          SizedBox(height: 24),
          _ExampleSection(
            title: 'Chip',
            description: '标签组件，用于展示标签和选择项',
            child: ChipExample(),
          ),
          SizedBox(height: 24),
          _ExampleSection(
            title: 'Spinner',
            description: '加载指示器组件',
            child: SpinnerExample(),
          ),
          SizedBox(height: 24),
          _ExampleSection(
            title: 'Link',
            description: '链接组件，用于导航和外部链接',
            child: LinkExample(),
          ),
          SizedBox(height: 24),
          _ExampleSection(
            title: 'Image',
            description: '图片组件，支持多种加载方式',
            child: ImageExample(),
          ),
        ],
      ),
    );
  }
}

/// 示例区块组件
class _ExampleSection extends StatelessWidget {
  const _ExampleSection({
    required this.title,
    required this.description,
    required this.child,
  });

  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 16),
        child,
      ],
    );
  }
}
