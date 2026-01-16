/// Select Component Examples
///
/// 展示 VelocitySelect 组件的所有主要用例和配置。
library;

import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 下拉选择组件示例
class SelectExample extends StatefulWidget {
  const SelectExample({super.key});

  @override
  State<SelectExample> createState() => _SelectExampleState();
}

class _SelectExampleState extends State<SelectExample> {
  String? _selectedFruit;
  String? _selectedCountry;

  final List<VelocitySelectItem<String>> _fruitItems = const [
    VelocitySelectItem(value: 'apple', label: 'Apple'),
    VelocitySelectItem(value: 'banana', label: 'Banana'),
    VelocitySelectItem(value: 'orange', label: 'Orange'),
    VelocitySelectItem(value: 'grape', label: 'Grape'),
    VelocitySelectItem(value: 'mango', label: 'Mango'),
  ];

  final List<VelocitySelectItem<String>> _countryItems = const [
    VelocitySelectItem(value: 'cn', label: 'China', icon: Icons.flag),
    VelocitySelectItem(value: 'us', label: 'United States', icon: Icons.flag),
    VelocitySelectItem(value: 'jp', label: 'Japan', icon: Icons.flag),
    VelocitySelectItem(value: 'uk', label: 'United Kingdom', icon: Icons.flag),
    VelocitySelectItem(value: 'de', label: 'Germany', icon: Icons.flag),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 基础下拉选择
        _buildSubsection(
          title: '基础下拉选择 (Basic Select)',
          child: VelocitySelect<String>(
            label: 'Select a fruit',
            hint: 'Choose your favorite fruit',
            items: _fruitItems,
            value: _selectedFruit,
            onChanged: (value) {
              setState(() => _selectedFruit = value);
            },
          ),
        ),

        const SizedBox(height: 16),

        // 带图标的选项
        _buildSubsection(
          title: '带图标选项 (Options with Icons)',
          child: VelocitySelect<String>(
            label: 'Select a country',
            hint: 'Choose your country',
            items: _countryItems,
            value: _selectedCountry,
            onChanged: (value) {
              setState(() => _selectedCountry = value);
            },
          ),
        ),

        const SizedBox(height: 16),

        // 禁用状态
        _buildSubsection(
          title: '禁用状态 (Disabled State)',
          child: VelocitySelect<String>(
            label: 'Disabled select',
            hint: 'This select is disabled',
            items: _fruitItems,
            value: null,
            disabled: true,
            onChanged: (_) {},
          ),
        ),

        const SizedBox(height: 16),

        // 带禁用选项
        _buildSubsection(
          title: '禁用选项 (Disabled Options)',
          child: VelocitySelect<String>(
            label: 'Select with disabled options',
            hint: 'Some options are disabled',
            items: const [
              VelocitySelectItem(value: 'a', label: 'Option A'),
              VelocitySelectItem(
                  value: 'b', label: 'Option B (disabled)', disabled: true),
              VelocitySelectItem(value: 'c', label: 'Option C'),
              VelocitySelectItem(
                  value: 'd', label: 'Option D (disabled)', disabled: true),
            ],
            value: null,
            onChanged: (value) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Selected: $value')),
              );
            },
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
