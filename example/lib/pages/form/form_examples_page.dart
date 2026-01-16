/// Form Components Examples Page
///
/// 展示所有表单组件的使用示例，包括：
/// - Input: 输入框组件
/// - Select: 下拉选择组件
/// - Checkbox: 复选框组件
/// - Radio: 单选框组件
/// - Switch: 开关组件
/// - Slider: 滑块组件
/// - Counter: 计数器组件
/// - Rate: 评分组件
/// - Search: 搜索框组件
/// - DatePicker: 日期选择器组件
library;

import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

import 'input_example.dart';
import 'select_example.dart';
import 'checkbox_example.dart';
import 'radio_example.dart';
import 'switch_example.dart';
import 'slider_example.dart';

/// 表单组件示例页面
class FormExamplesPage extends StatefulWidget {
  const FormExamplesPage({super.key});

  @override
  State<FormExamplesPage> createState() => _FormExamplesPageState();
}

class _FormExamplesPageState extends State<FormExamplesPage> {
  // Counter state
  int _counterValue = 5;

  // Rate state
  double _rateValue = 3.5;

  // Search state
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Components'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _ExampleSection(
            title: 'Input',
            description: '输入框组件，支持多种类型和验证',
            child: InputExample(),
          ),
          const SizedBox(height: 24),
          const _ExampleSection(
            title: 'Select',
            description: '下拉选择组件',
            child: SelectExample(),
          ),
          const SizedBox(height: 24),
          const _ExampleSection(
            title: 'Checkbox',
            description: '复选框组件',
            child: CheckboxExample(),
          ),
          const SizedBox(height: 24),
          const _ExampleSection(
            title: 'Radio',
            description: '单选框组件',
            child: RadioExample(),
          ),
          const SizedBox(height: 24),
          const _ExampleSection(
            title: 'Switch',
            description: '开关组件',
            child: SwitchExample(),
          ),
          const SizedBox(height: 24),
          const _ExampleSection(
            title: 'Slider',
            description: '滑块组件',
            child: SliderExample(),
          ),
          const SizedBox(height: 24),
          _ExampleSection(
            title: 'Counter',
            description: '计数器组件，用于数字增减输入',
            child: _buildCounterExample(),
          ),
          const SizedBox(height: 24),
          _ExampleSection(
            title: 'Rate',
            description: '评分组件，支持半星评分',
            child: _buildRateExample(),
          ),
          const SizedBox(height: 24),
          _ExampleSection(
            title: 'Search',
            description: '搜索框组件，支持清除和取消按钮',
            child: _buildSearchExample(),
          ),
          const SizedBox(height: 24),
          _ExampleSection(
            title: 'DatePicker',
            description: '日期选择器组件，支持日期、时间和日期时间选择',
            child: _buildDatePickerExample(),
          ),
        ],
      ),
    );
  }

  Widget _buildCounterExample() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Basic Counter: '),
            const SizedBox(width: 16),
            VelocityCounter(
              value: _counterValue,
              min: 0,
              max: 100,
              step: 1,
              onChanged: (value) {
                setState(() {
                  _counterValue = value;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Text('Step 5: '),
            const SizedBox(width: 16),
            VelocityCounter(
              value: 10,
              min: 0,
              max: 100,
              step: 5,
              onChanged: (value) {},
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Text('Disabled: '),
            const SizedBox(width: 16),
            VelocityCounter(
              value: 5,
              disabled: true,
              onChanged: (value) {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRateExample() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Basic: '),
            const SizedBox(width: 16),
            VelocityRate(
              value: _rateValue,
              onChanged: (value) {
                setState(() {
                  _rateValue = value;
                });
              },
            ),
            const SizedBox(width: 8),
            Text('($_rateValue)'),
          ],
        ),
        const SizedBox(height: 16),
        const Row(
          children: [
            Text('Half Star: '),
            SizedBox(width: 16),
            VelocityRate(
              value: 2.5,
              allowHalf: true,
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Row(
          children: [
            Text('10 Stars: '),
            SizedBox(width: 16),
            VelocityRate(
              value: 7,
              count: 10,
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Row(
          children: [
            Text('Disabled: '),
            SizedBox(width: 16),
            VelocityRate(
              value: 4,
              disabled: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchExample() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VelocitySearch(
          controller: _searchController,
          placeholder: 'Search...',
          onChanged: (value) {},
          onSubmitted: (value) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Searching: $value')),
            );
          },
          onClear: () {},
        ),
        const SizedBox(height: 16),
        VelocitySearch(
          placeholder: 'Search with cancel',
          showCancelButton: true,
          cancelText: 'Cancel',
          onCancel: () {},
        ),
      ],
    );
  }

  Widget _buildDatePickerExample() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VelocityDatePicker(
          label: 'Select Date',
          hint: 'YYYY-MM-DD',
          type: VelocityDatePickerType.date,
          onDateSelected: (date) {},
        ),
        const SizedBox(height: 16),
        const VelocityTimePicker(
          label: 'Select Time',
          hint: 'HH:MM',
        ),
        const SizedBox(height: 16),
        VelocityDatePicker(
          label: 'Select DateTime',
          hint: 'YYYY-MM-DD HH:MM',
          type: VelocityDatePickerType.datetime,
          onDateSelected: (date) {},
        ),
      ],
    );
  }
}

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
