/// Button Component Examples
///
/// 展示 VelocityButton 组件的所有主要用例和配置。
library;

import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 按钮组件示例
///
/// 包含以下示例：
/// - 按钮类型（Primary, Secondary, Outline, Text, Danger, Success, Warning）
/// - 按钮尺寸（Small, Medium, Large）
/// - 带图标的按钮
/// - 加载状态
/// - 禁用状态
/// - 全宽按钮
class ButtonExample extends StatefulWidget {
  const ButtonExample({super.key});

  @override
  State<ButtonExample> createState() => _ButtonExampleState();
}

class _ButtonExampleState extends State<ButtonExample> {
  bool _isLoading = false;

  void _handlePress() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Button pressed!'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _simulateLoading() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 按钮类型示例
        _buildSubsection(
          title: '按钮类型 (Button Types)',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              // Primary 按钮 - 主要操作
              VelocityButton.text(
                text: 'Primary',
                type: VelocityButtonType.primary,
                onPressed: _handlePress,
                semanticLabel: 'Primary button example',
              ),
              // Secondary 按钮 - 次要操作
              VelocityButton.text(
                text: 'Secondary',
                type: VelocityButtonType.secondary,
                onPressed: _handlePress,
                semanticLabel: 'Secondary button example',
              ),
              // Outline 按钮 - 轮廓样式
              VelocityButton.text(
                text: 'Outline',
                type: VelocityButtonType.outline,
                onPressed: _handlePress,
                semanticLabel: 'Outline button example',
              ),
              // Text 按钮 - 文本样式
              VelocityButton.text(
                text: 'Text',
                type: VelocityButtonType.text,
                onPressed: _handlePress,
                semanticLabel: 'Text button example',
              ),
              // Danger 按钮 - 危险操作
              VelocityButton.text(
                text: 'Danger',
                type: VelocityButtonType.danger,
                onPressed: _handlePress,
                semanticLabel: 'Danger button example',
              ),
              // Success 按钮 - 成功状态
              VelocityButton.text(
                text: 'Success',
                type: VelocityButtonType.success,
                onPressed: _handlePress,
                semanticLabel: 'Success button example',
              ),
              // Warning 按钮 - 警告状态
              VelocityButton.text(
                text: 'Warning',
                type: VelocityButtonType.warning,
                onPressed: _handlePress,
                semanticLabel: 'Warning button example',
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // 按钮尺寸示例
        _buildSubsection(
          title: '按钮尺寸 (Button Sizes)',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              // Small 尺寸
              VelocityButton.text(
                text: 'Small',
                size: VelocityButtonSize.small,
                onPressed: _handlePress,
                semanticLabel: 'Small size button',
              ),
              // Medium 尺寸（默认）
              VelocityButton.text(
                text: 'Medium',
                size: VelocityButtonSize.medium,
                onPressed: _handlePress,
                semanticLabel: 'Medium size button',
              ),
              // Large 尺寸
              VelocityButton.text(
                text: 'Large',
                size: VelocityButtonSize.large,
                onPressed: _handlePress,
                semanticLabel: 'Large size button',
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // 带图标的按钮
        _buildSubsection(
          title: '带图标按钮 (Buttons with Icons)',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              // 左侧图标
              VelocityButton.icon(
                text: 'Add Item',
                icon: Icons.add,
                iconPosition: VelocityIconPosition.left,
                onPressed: _handlePress,
                semanticLabel: 'Add item button with left icon',
              ),
              // 右侧图标
              VelocityButton.icon(
                text: 'Next',
                icon: Icons.arrow_forward,
                iconPosition: VelocityIconPosition.right,
                onPressed: _handlePress,
                semanticLabel: 'Next button with right icon',
              ),
              // 下载按钮
              VelocityButton.icon(
                text: 'Download',
                icon: Icons.download,
                type: VelocityButtonType.outline,
                onPressed: _handlePress,
                semanticLabel: 'Download button',
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // 图标按钮
        _buildSubsection(
          title: '图标按钮 (Icon Buttons)',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              VelocityIconButton(
                icon: Icons.favorite,
                onPressed: _handlePress,
                tooltip: 'Like',
                semanticLabel: 'Like button',
              ),
              VelocityIconButton(
                icon: Icons.share,
                onPressed: _handlePress,
                tooltip: 'Share',
                semanticLabel: 'Share button',
              ),
              VelocityIconButton(
                icon: Icons.more_vert,
                onPressed: _handlePress,
                tooltip: 'More options',
                semanticLabel: 'More options button',
              ),
              VelocityIconButton(
                icon: Icons.delete,
                onPressed: _handlePress,
                tooltip: 'Delete',
                semanticLabel: 'Delete button',
                style: const VelocityIconButtonStyle(
                  iconColor: Colors.red,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // 加载状态
        _buildSubsection(
          title: '加载状态 (Loading State)',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              VelocityButton.text(
                text: 'Click to Load',
                loading: _isLoading,
                onPressed: _simulateLoading,
                semanticLabel: 'Button with loading state',
              ),
              VelocityButton.text(
                text: 'Loading...',
                loading: true,
                onPressed: () {},
                semanticLabel: 'Always loading button',
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // 禁用状态
        _buildSubsection(
          title: '禁用状态 (Disabled State)',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              VelocityButton.text(
                text: 'Disabled Primary',
                type: VelocityButtonType.primary,
                disabled: true,
                onPressed: _handlePress,
                semanticLabel: 'Disabled primary button',
              ),
              VelocityButton.text(
                text: 'Disabled Outline',
                type: VelocityButtonType.outline,
                disabled: true,
                onPressed: _handlePress,
                semanticLabel: 'Disabled outline button',
              ),
              VelocityIconButton(
                icon: Icons.edit,
                disabled: true,
                onPressed: _handlePress,
                tooltip: 'Edit (disabled)',
                semanticLabel: 'Disabled edit button',
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // 全宽按钮
        _buildSubsection(
          title: '全宽按钮 (Full Width Button)',
          child: Column(
            children: [
              VelocityButton.text(
                text: 'Full Width Primary',
                fullWidth: true,
                onPressed: _handlePress,
                semanticLabel: 'Full width primary button',
              ),
              const SizedBox(height: 8),
              VelocityButton.text(
                text: 'Full Width Outline',
                type: VelocityButtonType.outline,
                fullWidth: true,
                onPressed: _handlePress,
                semanticLabel: 'Full width outline button',
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
