/// Image Component Examples
///
/// 展示 VelocityImage 组件的所有主要用例和配置。
library;

import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 图片组件示例
class ImageExample extends StatelessWidget {
  const ImageExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 基础图片
        _buildSubsection(
          title: '基础图片 (Basic Image)',
          child: const Row(
            children: [
              VelocityImage(
                src: 'assets/images/logo.png',
                width: 80,
                height: 80,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 16),
              Text('从 assets 加载图片'),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 图片形状（使用 style 的 borderRadius）
        _buildSubsection(
          title: '图片形状 (Image Shapes)',
          child: Row(
            children: [
              const Column(
                children: [
                  VelocityImage(
                    src: 'assets/images/logo.png',
                    width: 60,
                    height: 60,
                    style: VelocityImageStyle(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text('Square', style: TextStyle(fontSize: 12)),
                ],
              ),
              const SizedBox(width: 16),
              Column(
                children: [
                  VelocityImage(
                    src: 'assets/images/logo.png',
                    width: 60,
                    height: 60,
                    style: VelocityImageStyle(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text('Rounded', style: TextStyle(fontSize: 12)),
                ],
              ),
              const SizedBox(width: 16),
              Column(
                children: [
                  VelocityImage(
                    src: 'assets/images/logo.png',
                    width: 60,
                    height: 60,
                    style: VelocityImageStyle(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text('Circle', style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 图片适应方式
        _buildSubsection(
          title: '图片适应方式 (Box Fit)',
          child: const Row(
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 80,
                    height: 60,
                    child: VelocityImage(
                      src: 'assets/images/logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text('Contain', style: TextStyle(fontSize: 12)),
                ],
              ),
              SizedBox(width: 16),
              Column(
                children: [
                  SizedBox(
                    width: 80,
                    height: 60,
                    child: VelocityImage(
                      src: 'assets/images/logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text('Cover', style: TextStyle(fontSize: 12)),
                ],
              ),
              SizedBox(width: 16),
              Column(
                children: [
                  SizedBox(
                    width: 80,
                    height: 60,
                    child: VelocityImage(
                      src: 'assets/images/logo.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text('Fill', style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 加载占位符
        _buildSubsection(
          title: '加载占位符 (Placeholder)',
          child: const Row(
            children: [
              VelocityImage(
                src: 'assets/images/logo.png',
                width: 80,
                height: 80,
                placeholder: Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              SizedBox(width: 16),
              Text('图片加载时显示占位符'),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 错误占位符
        _buildSubsection(
          title: '错误占位符 (Error Placeholder)',
          child: const Row(
            children: [
              VelocityImage(
                src: 'invalid_path.png',
                width: 80,
                height: 80,
                errorWidget: Center(
                  child: Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
              SizedBox(width: 16),
              Text('图片加载失败时显示错误占位符'),
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
