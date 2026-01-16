/// Layout Components Examples Page
///
/// 展示所有布局组件的使用示例。
library;

import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 布局组件示例页面
class LayoutExamplesPage extends StatelessWidget {
  const LayoutExamplesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Layout Components'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Container 示例
          _buildSection(
            title: 'Container',
            description: '容器组件，用于包裹和布局内容',
            child: VelocityContainer(
              style: VelocityContainerStyle(
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('This is a VelocityContainer'),
            ),
          ),

          const SizedBox(height: 24),

          // Space 示例
          _buildSection(
            title: 'Space',
            description: '间距组件，用于添加元素间距',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Horizontal Space:'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildBox('A'),
                    const VelocitySpace.horizontal(16),
                    _buildBox('B'),
                    const VelocitySpace.horizontal(16),
                    _buildBox('C'),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('Vertical Space:'),
                const SizedBox(height: 8),
                Column(
                  children: [
                    _buildBox('1'),
                    const VelocitySpace.vertical(8),
                    _buildBox('2'),
                    const VelocitySpace.vertical(8),
                    _buildBox('3'),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('Preset Sizes:'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildBox('xs'),
                    VelocitySpace.xs,
                    _buildBox('sm'),
                    VelocitySpace.sm,
                    _buildBox('md'),
                    VelocitySpace.md,
                    _buildBox('lg'),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // VelocityRow 和 VelocityColumn 示例
          _buildSection(
            title: 'Row & Column',
            description: '带间距的行列组件',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('VelocityRow with spacing:'),
                const SizedBox(height: 8),
                VelocityRow(
                  spacing: 12,
                  children: [
                    _buildBox('A'),
                    _buildBox('B'),
                    _buildBox('C'),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('VelocityColumn with spacing:'),
                const SizedBox(height: 8),
                VelocityColumn(
                  spacing: 8,
                  children: [
                    _buildBox('1'),
                    _buildBox('2'),
                    _buildBox('3'),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Divider 示例
          _buildSection(
            title: 'Divider',
            description: '分割线组件，用于分隔内容',
            child: Column(
              children: [
                const Text('Content above'),
                const VelocityDivider(),
                const Text('Content below'),
                const SizedBox(height: 16),
                const Text('Vertical Divider:'),
                const SizedBox(height: 8),
                SizedBox(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Left'),
                      const SizedBox(width: 16),
                      const VelocityDivider(vertical: true),
                      const SizedBox(width: 16),
                      const Text('Right'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Grid 示例
          _buildSection(
            title: 'Grid',
            description: '网格组件，用于网格布局',
            child: VelocityGrid(
              columns: 3,
              children: List.generate(
                6,
                (index) => Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(child: Text('${index + 1}')),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Stack 示例
          _buildSection(
            title: 'Stack',
            description: '堆叠组件，用于层叠布局',
            child: SizedBox(
              height: 150,
              child: VelocityStack(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.green.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 40,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.orange.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // AspectRatio 示例
          _buildSection(
            title: 'Aspect Ratio',
            description: '宽高比组件，用于保持固定比例',
            child: Row(
              children: [
                Expanded(
                  child: VelocityAspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.purple.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(child: Text('1:1')),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: VelocityAspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.teal.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(child: Text('16:9')),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // SafeArea 示例
          _buildSection(
            title: 'Safe Area',
            description: '安全区域组件，避免系统UI遮挡',
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const VelocitySafeArea(
                child: Center(
                  child: Text('Content in safe area'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBox(String text) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(child: Text(text)),
    );
  }

  Widget _buildSection({
    required String title,
    required String description,
    required Widget child,
  }) {
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
