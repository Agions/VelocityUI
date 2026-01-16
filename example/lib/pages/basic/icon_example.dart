/// Icon Component Examples
///
/// 展示 VelocityIcon 组件的所有主要用例和配置。
library;

import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 图标组件示例
///
/// 包含以下示例：
/// - 图标尺寸
/// - 图标颜色
/// - 常用图标展示
class IconExample extends StatelessWidget {
  const IconExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 图标尺寸
        _buildSubsection(
          title: '图标尺寸 (Icon Sizes)',
          child: const Row(
            children: [
              Column(
                children: [
                  VelocityIcon(Icons.home, size: VelocitySize.small),
                  SizedBox(height: 4),
                  Text('Small', style: TextStyle(fontSize: 12)),
                ],
              ),
              SizedBox(width: 24),
              Column(
                children: [
                  VelocityIcon(Icons.home, size: VelocitySize.medium),
                  SizedBox(height: 4),
                  Text('Medium', style: TextStyle(fontSize: 12)),
                ],
              ),
              SizedBox(width: 24),
              Column(
                children: [
                  VelocityIcon(Icons.home, size: VelocitySize.large),
                  SizedBox(height: 4),
                  Text('Large', style: TextStyle(fontSize: 12)),
                ],
              ),
              SizedBox(width: 24),
              Column(
                children: [
                  VelocityIcon(Icons.home, customSize: 48),
                  SizedBox(height: 4),
                  Text('Custom (48)', style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 图标颜色
        _buildSubsection(
          title: '图标颜色 (Icon Colors)',
          child: const Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              VelocityIcon(Icons.favorite, color: Colors.red),
              VelocityIcon(Icons.star, color: Colors.amber),
              VelocityIcon(Icons.check_circle, color: Colors.green),
              VelocityIcon(Icons.info, color: Colors.blue),
              VelocityIcon(Icons.warning, color: Colors.orange),
              VelocityIcon(Icons.error, color: Colors.red),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 常用图标
        _buildSubsection(
          title: '常用图标 (Common Icons)',
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildIconWithLabel(Icons.home, 'Home'),
              _buildIconWithLabel(Icons.search, 'Search'),
              _buildIconWithLabel(Icons.settings, 'Settings'),
              _buildIconWithLabel(Icons.person, 'Person'),
              _buildIconWithLabel(Icons.notifications, 'Notifications'),
              _buildIconWithLabel(Icons.email, 'Email'),
              _buildIconWithLabel(Icons.phone, 'Phone'),
              _buildIconWithLabel(Icons.camera_alt, 'Camera'),
              _buildIconWithLabel(Icons.location_on, 'Location'),
              _buildIconWithLabel(Icons.calendar_today, 'Calendar'),
              _buildIconWithLabel(Icons.shopping_cart, 'Cart'),
              _buildIconWithLabel(Icons.bookmark, 'Bookmark'),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 带语义标签的图标
        _buildSubsection(
          title: '无障碍支持 (Accessibility)',
          child: const Row(
            children: [
              VelocityIcon(
                Icons.accessibility,
                semanticLabel: 'Accessibility icon',
                color: Colors.blue,
              ),
              SizedBox(width: 8),
              Text('图标支持 semanticLabel 属性，用于屏幕阅读器'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIconWithLabel(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        VelocityIcon(icon, color: Colors.grey[700]),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.grey),
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
