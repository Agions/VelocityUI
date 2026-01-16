/// Checkbox Component Examples
///
/// 展示 VelocityCheckbox 组件的所有主要用例和配置。
library;

import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 复选框组件示例
class CheckboxExample extends StatefulWidget {
  const CheckboxExample({super.key});

  @override
  State<CheckboxExample> createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckboxExample> {
  bool _checked1 = false;
  bool _checked2 = true;
  bool _checked3 = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 基础复选框
        _buildSubsection(
          title: '基础复选框 (Basic Checkbox)',
          child: Column(
            children: [
              VelocityCheckbox(
                label: 'Option 1',
                value: _checked1,
                onChanged: (value) {
                  setState(() => _checked1 = value);
                },
              ),
              VelocityCheckbox(
                label: 'Option 2 (checked)',
                value: _checked2,
                onChanged: (value) {
                  setState(() => _checked2 = value);
                },
              ),
              VelocityCheckbox(
                label: 'Option 3',
                value: _checked3,
                onChanged: (value) {
                  setState(() => _checked3 = value);
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 禁用状态
        _buildSubsection(
          title: '禁用状态 (Disabled State)',
          child: const Column(
            children: [
              VelocityCheckbox(
                label: 'Disabled unchecked',
                value: false,
                disabled: true,
                onChanged: null,
              ),
              VelocityCheckbox(
                label: 'Disabled checked',
                value: true,
                disabled: true,
                onChanged: null,
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 无标签复选框
        _buildSubsection(
          title: '无标签复选框 (Checkbox without Label)',
          child: Row(
            children: [
              VelocityCheckbox(
                value: _checked1,
                onChanged: (value) {
                  setState(() => _checked1 = value);
                },
              ),
              const SizedBox(width: 8),
              VelocityCheckbox(
                value: _checked2,
                onChanged: (value) {
                  setState(() => _checked2 = value);
                },
              ),
              const SizedBox(width: 8),
              VelocityCheckbox(
                value: _checked3,
                onChanged: (value) {
                  setState(() => _checked3 = value);
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
              VelocityCheckbox(
                label: 'Custom active color',
                value: _checked1,
                style: const VelocityCheckboxStyle(
                  activeColor: Colors.green,
                ),
                onChanged: (value) {
                  setState(() => _checked1 = value);
                },
              ),
              VelocityCheckbox(
                label: 'Custom border color',
                value: _checked2,
                style: const VelocityCheckboxStyle(
                  activeColor: Colors.orange,
                  borderColor: Colors.orange,
                ),
                onChanged: (value) {
                  setState(() => _checked2 = value);
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
