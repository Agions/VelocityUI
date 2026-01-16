/// Text Component Examples
///
/// 展示 VelocityText 组件的所有主要用例和配置。
library;

import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 文本组件示例
///
/// 包含以下示例：
/// - 文本变体（Display, Headline, Title, Body, Label）
/// - 文本颜色
/// - 文本对齐
/// - 文本溢出处理
class TextExample extends StatelessWidget {
  const TextExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Display 变体
        _buildSubsection(
          title: 'Display 变体',
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VelocityText.displayLarge('Display Large'),
              SizedBox(height: 4),
              VelocityText.displayMedium('Display Medium'),
              SizedBox(height: 4),
              VelocityText.displaySmall('Display Small'),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Headline 变体
        _buildSubsection(
          title: 'Headline 变体',
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VelocityText.headlineLarge('Headline Large'),
              SizedBox(height: 4),
              VelocityText.headlineMedium('Headline Medium'),
              SizedBox(height: 4),
              VelocityText.headlineSmall('Headline Small'),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Title 变体
        _buildSubsection(
          title: 'Title 变体',
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VelocityText.titleLarge('Title Large'),
              SizedBox(height: 4),
              VelocityText.titleMedium('Title Medium'),
              SizedBox(height: 4),
              VelocityText.titleSmall('Title Small'),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Body 变体
        _buildSubsection(
          title: 'Body 变体',
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VelocityText.bodyLarge('Body Large - 用于主要正文内容'),
              SizedBox(height: 4),
              VelocityText.bodyMedium('Body Medium - 用于一般正文内容'),
              SizedBox(height: 4),
              VelocityText.bodySmall('Body Small - 用于辅助说明文字'),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Label 变体
        _buildSubsection(
          title: 'Label 变体',
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VelocityText.labelLarge('Label Large'),
              SizedBox(height: 4),
              VelocityText.labelMedium('Label Medium'),
              SizedBox(height: 4),
              VelocityText.labelSmall('Label Small'),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 文本颜色
        _buildSubsection(
          title: '文本颜色 (Text Colors)',
          child: const Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              VelocityText.bodyMedium('Default', color: Colors.black),
              VelocityText.bodyMedium('Primary', color: Colors.blue),
              VelocityText.bodyMedium('Success', color: Colors.green),
              VelocityText.bodyMedium('Warning', color: Colors.orange),
              VelocityText.bodyMedium('Danger', color: Colors.red),
              VelocityText.bodyMedium('Muted', color: Colors.grey),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 文本溢出
        _buildSubsection(
          title: '文本溢出处理 (Text Overflow)',
          child: const SizedBox(
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VelocityText.bodyMedium(
                  '这是一段很长的文本，用于演示文本溢出时的省略号效果',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                VelocityText.bodyMedium(
                  '这是一段很长的文本，用于演示多行文本溢出时的省略号效果，最多显示两行',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
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
