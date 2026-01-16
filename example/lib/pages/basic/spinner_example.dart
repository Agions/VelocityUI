/// Spinner Component Examples
///
/// 展示 VelocitySpinner 组件的所有主要用例和配置。
library;

import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 加载指示器组件示例
class SpinnerExample extends StatelessWidget {
  const SpinnerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 基础加载指示器
        _buildSubsection(
          title: '基础加载指示器 (Basic Spinners)',
          child: const Row(
            children: [
              VelocitySpinner(),
              SizedBox(width: 24),
              VelocitySpinner(color: Colors.blue),
              SizedBox(width: 24),
              VelocitySpinner(color: Colors.green),
              SizedBox(width: 24),
              VelocitySpinner(color: Colors.orange),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 不同类型
        _buildSubsection(
          title: '加载指示器类型 (Spinner Types)',
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  VelocitySpinner(type: VelocitySpinnerType.circular),
                  SizedBox(height: 4),
                  Text('Circular', style: TextStyle(fontSize: 12)),
                ],
              ),
              SizedBox(width: 24),
              Column(
                children: [
                  VelocitySpinner(type: VelocitySpinnerType.dots),
                  SizedBox(height: 4),
                  Text('Dots', style: TextStyle(fontSize: 12)),
                ],
              ),
              SizedBox(width: 24),
              Column(
                children: [
                  VelocitySpinner(type: VelocitySpinnerType.wave),
                  SizedBox(height: 4),
                  Text('Wave', style: TextStyle(fontSize: 12)),
                ],
              ),
              SizedBox(width: 24),
              Column(
                children: [
                  VelocitySpinner(type: VelocitySpinnerType.pulse),
                  SizedBox(height: 4),
                  Text('Pulse', style: TextStyle(fontSize: 12)),
                ],
              ),
              SizedBox(width: 24),
              Column(
                children: [
                  VelocitySpinner(type: VelocitySpinnerType.ring),
                  SizedBox(height: 4),
                  Text('Ring', style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 带文本的加载指示器
        _buildSubsection(
          title: '带文本加载指示器 (Spinner with Text)',
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  VelocitySpinner(size: 20),
                  SizedBox(width: 8),
                  Text('Loading...'),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  VelocitySpinner(
                    size: 20,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 8),
                  Text('Fetching data...'),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 自定义尺寸
        _buildSubsection(
          title: '自定义尺寸 (Custom Size)',
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              VelocitySpinner(size: 16),
              SizedBox(width: 16),
              VelocitySpinner(size: 24),
              SizedBox(width: 16),
              VelocitySpinner(size: 32),
              SizedBox(width: 16),
              VelocitySpinner(size: 48),
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
