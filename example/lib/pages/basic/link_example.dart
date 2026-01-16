/// Link Component Examples
///
/// 展示 VelocityLink 组件的所有主要用例和配置。
library;

import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 链接组件示例
class LinkExample extends StatelessWidget {
  const LinkExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 基础链接
        _buildSubsection(
          title: '基础链接 (Basic Links)',
          child: Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              VelocityLink(
                text: 'Default Link',
                onTap: () => _showTap(context, 'Default Link'),
              ),
              VelocityLink(
                text: 'Underlined Link',
                underline: true,
                onTap: () => _showTap(context, 'Underlined Link'),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 带图标的链接
        _buildSubsection(
          title: '带图标链接 (Links with Icons)',
          child: Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              VelocityLink(
                text: 'External Link',
                icon: Icons.open_in_new,
                onTap: () => _showTap(context, 'External Link'),
              ),
              VelocityLink(
                text: 'Download',
                icon: Icons.download,
                onTap: () => _showTap(context, 'Download'),
              ),
              VelocityLink(
                text: 'Email Us',
                icon: Icons.email,
                onTap: () => _showTap(context, 'Email Us'),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 禁用状态
        _buildSubsection(
          title: '禁用状态 (Disabled State)',
          child: const Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              VelocityLink(
                text: 'Disabled Link',
                disabled: true,
              ),
              VelocityLink(
                text: 'Disabled with Icon',
                icon: Icons.link,
                disabled: true,
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 在文本中使用链接
        _buildSubsection(
          title: '内联链接 (Inline Links)',
          child: Wrap(
            children: [
              const Text('By continuing, you agree to our '),
              VelocityLink(
                text: 'Terms of Service',
                underline: true,
                onTap: () => _showTap(context, 'Terms of Service'),
              ),
              const Text(' and '),
              VelocityLink(
                text: 'Privacy Policy',
                underline: true,
                onTap: () => _showTap(context, 'Privacy Policy'),
              ),
              const Text('.'),
            ],
          ),
        ),
      ],
    );
  }

  void _showTap(BuildContext context, String linkName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tapped: $linkName'),
        duration: const Duration(seconds: 1),
      ),
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
