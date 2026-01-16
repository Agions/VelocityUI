/// Chip Component Examples
///
/// 展示 VelocityChip 组件的所有主要用例和配置。
library;

import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 标签组件示例
class ChipExample extends StatefulWidget {
  const ChipExample({super.key});

  @override
  State<ChipExample> createState() => _ChipExampleState();
}

class _ChipExampleState extends State<ChipExample> {
  final Set<String> _selectedTags = {'Flutter'};

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 基础标签
        _buildSubsection(
          title: '基础标签 (Basic Chips)',
          child: const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              VelocityChip(label: 'Default'),
              VelocityChip(label: 'Filled', type: VelocityChipType.filled),
              VelocityChip(label: 'Outlined', type: VelocityChipType.outlined),
              VelocityChip(label: 'Tonal', type: VelocityChipType.tonal),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 带图标的标签
        _buildSubsection(
          title: '带图标标签 (Chips with Icons)',
          child: const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              VelocityChip(
                label: 'Flutter',
                icon: Icons.flutter_dash,
              ),
              VelocityChip(
                label: 'Dart',
                icon: Icons.code,
              ),
              VelocityChip(
                label: 'Mobile',
                icon: Icons.phone_android,
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 可选择的标签
        _buildSubsection(
          title: '可选择标签 (Selectable Chips)',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final tag in ['Flutter', 'Dart', 'React', 'Vue'])
                VelocityChoiceChip(
                  label: tag,
                  selected: _selectedTags.contains(tag),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedTags.add(tag);
                      } else {
                        _selectedTags.remove(tag);
                      }
                    });
                  },
                ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 可删除的标签
        _buildSubsection(
          title: '可删除标签 (Deletable Chips)',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              VelocityChip(
                label: 'Tag 1',
                onDelete: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Tag 1 deleted')),
                  );
                },
              ),
              VelocityChip(
                label: 'Tag 2',
                onDelete: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Tag 2 deleted')),
                  );
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 禁用状态
        _buildSubsection(
          title: '禁用状态 (Disabled State)',
          child: const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              VelocityChip(label: 'Disabled', disabled: true),
              VelocityChip(
                label: 'Disabled with Icon',
                icon: Icons.star,
                disabled: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSubsection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}
