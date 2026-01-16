/// Slider Component Examples
///
/// 展示 VelocitySlider 组件的所有主要用例和配置。
library;

import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 滑块组件示例
class SliderExample extends StatefulWidget {
  const SliderExample({super.key});

  @override
  State<SliderExample> createState() => _SliderExampleState();
}

class _SliderExampleState extends State<SliderExample> {
  double _value1 = 50;
  double _value2 = 30;
  RangeValues _rangeValues = const RangeValues(20, 80);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 基础滑块
        _buildSubsection(
          title: '基础滑块 (Basic Slider)',
          child: Column(
            children: [
              VelocitySlider(
                value: _value1,
                onChanged: (value) {
                  setState(() => _value1 = value);
                },
              ),
              Text('Value: ${_value1.toStringAsFixed(0)}'),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 带标签的滑块
        _buildSubsection(
          title: '带标签滑块 (Slider with Label)',
          child: VelocitySlider(
            value: _value2,
            min: 0,
            max: 100,
            showLabel: true,
            onChanged: (value) {
              setState(() => _value2 = value);
            },
          ),
        ),

        const SizedBox(height: 16),

        // 带刻度的滑块
        _buildSubsection(
          title: '带刻度滑块 (Slider with Divisions)',
          child: VelocitySlider(
            value: _value1,
            min: 0,
            max: 100,
            divisions: 10,
            showLabel: true,
            onChanged: (value) {
              setState(() => _value1 = value);
            },
          ),
        ),

        const SizedBox(height: 16),

        // 范围滑块
        _buildSubsection(
          title: '范围滑块 (Range Slider)',
          child: Column(
            children: [
              VelocityRangeSlider(
                values: _rangeValues,
                min: 0,
                max: 100,
                showLabels: true,
                onChanged: (values) {
                  setState(() => _rangeValues = values);
                },
              ),
              Text(
                'Range: ${_rangeValues.start.toStringAsFixed(0)} - ${_rangeValues.end.toStringAsFixed(0)}',
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 禁用状态
        _buildSubsection(
          title: '禁用状态 (Disabled State)',
          child: const VelocitySlider(
            value: 50,
            disabled: true,
            onChanged: null,
          ),
        ),

        const SizedBox(height: 16),

        // 自定义样式
        _buildSubsection(
          title: '自定义样式 (Custom Style)',
          child: Column(
            children: [
              VelocitySlider(
                value: _value1,
                style: const VelocitySliderStyle(
                  activeColor: Colors.green,
                  thumbColor: Colors.green,
                ),
                onChanged: (value) {
                  setState(() => _value1 = value);
                },
              ),
              const SizedBox(height: 8),
              VelocitySlider(
                value: _value2,
                style: const VelocitySliderStyle(
                  activeColor: Colors.orange,
                  thumbColor: Colors.orange,
                ),
                onChanged: (value) {
                  setState(() => _value2 = value);
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
