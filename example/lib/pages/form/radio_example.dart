/// Radio Component Examples
///
/// 展示 VelocityRadio 组件的所有主要用例和配置。
library;

import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 单选框组件示例
class RadioExample extends StatefulWidget {
  const RadioExample({super.key});

  @override
  State<RadioExample> createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  String? _selectedOption = 'option1';
  String? _selectedSize = 'medium';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 基础单选框组
        _buildSubsection(
          title: '基础单选框组 (Basic Radio Group)',
          child: Column(
            children: [
              VelocityRadio<String>(
                value: 'option1',
                groupValue: _selectedOption,
                label: 'Option 1',
                onChanged: (value) {
                  setState(() => _selectedOption = value);
                },
              ),
              VelocityRadio<String>(
                value: 'option2',
                groupValue: _selectedOption,
                label: 'Option 2',
                onChanged: (value) {
                  setState(() => _selectedOption = value);
                },
              ),
              VelocityRadio<String>(
                value: 'option3',
                groupValue: _selectedOption,
                label: 'Option 3',
                onChanged: (value) {
                  setState(() => _selectedOption = value);
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 水平布局
        _buildSubsection(
          title: '水平布局 (Horizontal Layout)',
          child: Row(
            children: [
              VelocityRadio<String>(
                value: 'small',
                groupValue: _selectedSize,
                label: 'Small',
                onChanged: (value) {
                  setState(() => _selectedSize = value);
                },
              ),
              const SizedBox(width: 16),
              VelocityRadio<String>(
                value: 'medium',
                groupValue: _selectedSize,
                label: 'Medium',
                onChanged: (value) {
                  setState(() => _selectedSize = value);
                },
              ),
              const SizedBox(width: 16),
              VelocityRadio<String>(
                value: 'large',
                groupValue: _selectedSize,
                label: 'Large',
                onChanged: (value) {
                  setState(() => _selectedSize = value);
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 禁用状态
        _buildSubsection(
          title: '禁用状态 (Disabled State)',
          child: Column(
            children: [
              VelocityRadio<String>(
                value: 'a',
                groupValue: 'a',
                label: 'Selected (disabled)',
                disabled: true,
                onChanged: (_) {},
              ),
              VelocityRadio<String>(
                value: 'b',
                groupValue: 'a',
                label: 'Unselected (disabled)',
                disabled: true,
                onChanged: (_) {},
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 无标签单选框
        _buildSubsection(
          title: '无标签单选框 (Radio without Label)',
          child: Row(
            children: [
              VelocityRadio<String>(
                value: 'option1',
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() => _selectedOption = value);
                },
              ),
              const SizedBox(width: 8),
              VelocityRadio<String>(
                value: 'option2',
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() => _selectedOption = value);
                },
              ),
              const SizedBox(width: 8),
              VelocityRadio<String>(
                value: 'option3',
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() => _selectedOption = value);
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 自定义样式
        _buildSubsection(
          title: '自定义样式 (Custom Style)',
          child: Column(
            children: [
              VelocityRadio<String>(
                value: 'option1',
                groupValue: _selectedOption,
                label: 'Custom active color',
                style: const VelocityRadioStyle(
                  activeColor: Colors.green,
                ),
                onChanged: (value) {
                  setState(() => _selectedOption = value);
                },
              ),
              VelocityRadio<String>(
                value: 'option2',
                groupValue: _selectedOption,
                label: 'Custom orange color',
                style: const VelocityRadioStyle(
                  activeColor: Colors.orange,
                ),
                onChanged: (value) {
                  setState(() => _selectedOption = value);
                },
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
