/// Interactive Preview Demo Page
///
/// 演示交互式组件预览功能的示例页面。
library;

import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';
import '../widgets/component_preview.dart';

/// 交互式预览演示页面
class InteractivePreviewDemoPage extends StatefulWidget {
  const InteractivePreviewDemoPage({super.key});

  @override
  State<InteractivePreviewDemoPage> createState() =>
      _InteractivePreviewDemoPageState();
}

class _InteractivePreviewDemoPageState
    extends State<InteractivePreviewDemoPage> {
  // Button properties
  late final StringPropertyController _buttonTextController;
  late final BoolPropertyController _buttonDisabledController;
  late final EnumPropertyController<VelocityButtonType> _buttonTypeController;
  late final EnumPropertyController<VelocityButtonSize> _buttonSizeController;

  @override
  void initState() {
    super.initState();
    _buttonTextController = StringPropertyController(
      name: 'Text',
      initialValue: 'Click Me',
      description: 'Button label text',
    );
    _buttonDisabledController = BoolPropertyController(
      name: 'Disabled',
      initialValue: false,
      description: 'Whether the button is disabled',
    );
    _buttonTypeController = EnumPropertyController<VelocityButtonType>(
      name: 'Type',
      initialValue: VelocityButtonType.primary,
      options: VelocityButtonType.values,
      description: 'Button style type',
    );
    _buttonSizeController = EnumPropertyController<VelocityButtonSize>(
      name: 'Size',
      initialValue: VelocityButtonSize.medium,
      options: VelocityButtonSize.values,
      description: 'Button size',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interactive Preview Demo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildButtonPreview(),
          const SizedBox(height: 24),
          _buildTagPreview(),
          const SizedBox(height: 24),
          _buildAvatarPreview(),
        ],
      ),
    );
  }

  /// Button 组件交互式预览
  Widget _buildButtonPreview() {
    return ComponentPreview(
      config: const ComponentPreviewConfig(
        title: 'VelocityButton',
        description: '按钮组件，支持多种类型、尺寸和状态',
        sourceCode: '''
VelocityButton.text(
  text: 'Click Me',
  type: VelocityButtonType.primary,
  size: VelocitySize.medium,
  disabled: false,
  onPressed: () {},
)''',
      ),
      properties: [
        _buttonTextController,
        _buttonTypeController,
        _buttonSizeController,
        _buttonDisabledController,
      ],
      builder: (context, properties) {
        return VelocityButton.text(
          text: _buttonTextController.value,
          type: _buttonTypeController.value,
          size: _buttonSizeController.value,
          disabled: _buttonDisabledController.value,
          onPressed: _buttonDisabledController.value ? null : () {},
        );
      },
    );
  }

  /// Tag 组件交互式预览（使用变体）
  Widget _buildTagPreview() {
    return ComponentPreview(
      config: ComponentPreviewConfig(
        title: 'VelocityTag',
        description: '标签组件，用于分类和标记',
        variants: [
          ComponentVariant(
            name: 'Default',
            builder: (context) => const VelocityTag(text: 'Default'),
            sourceCode: "VelocityTag(text: 'Default')",
          ),
          ComponentVariant(
            name: 'Primary',
            builder: (context) => const VelocityTag(
              text: 'Primary',
              type: VelocityTagType.primary,
            ),
            sourceCode: '''
VelocityTag(
  text: 'Primary',
  type: VelocityTagType.primary,
)''',
          ),
          ComponentVariant(
            name: 'Success',
            builder: (context) => const VelocityTag(
              text: 'Success',
              type: VelocityTagType.success,
            ),
            sourceCode: '''
VelocityTag(
  text: 'Success',
  type: VelocityTagType.success,
)''',
          ),
          ComponentVariant(
            name: 'Warning',
            builder: (context) => const VelocityTag(
              text: 'Warning',
              type: VelocityTagType.warning,
            ),
            sourceCode: '''
VelocityTag(
  text: 'Warning',
  type: VelocityTagType.warning,
)''',
          ),
          ComponentVariant(
            name: 'Error',
            builder: (context) => const VelocityTag(
              text: 'Error',
              type: VelocityTagType.error,
            ),
            sourceCode: '''
VelocityTag(
  text: 'Error',
  type: VelocityTagType.error,
)''',
          ),
          ComponentVariant(
            name: 'With Icon',
            builder: (context) => const VelocityTag(
              text: 'With Icon',
              icon: Icons.star,
              type: VelocityTagType.primary,
            ),
            sourceCode: '''
VelocityTag(
  text: 'With Icon',
  icon: Icons.star,
  type: VelocityTagType.primary,
)''',
          ),
          ComponentVariant(
            name: 'Outlined',
            builder: (context) => const VelocityTag(
              text: 'Outlined',
              type: VelocityTagType.primary,
              outlined: true,
            ),
            sourceCode: '''
VelocityTag(
  text: 'Outlined',
  type: VelocityTagType.primary,
  outlined: true,
)''',
          ),
        ],
      ),
    );
  }

  /// Avatar 组件交互式预览（使用变体）
  Widget _buildAvatarPreview() {
    return ComponentPreview(
      config: ComponentPreviewConfig(
        title: 'VelocityAvatar',
        description: '头像组件，支持不同尺寸、文字和图标',
        variants: [
          ComponentVariant(
            name: 'Small',
            builder: (context) => const VelocityAvatar(
              size: VelocitySize.small,
              name: 'S',
            ),
            sourceCode: '''
VelocityAvatar(
  size: VelocitySize.small,
  name: 'S',
)''',
          ),
          ComponentVariant(
            name: 'Medium',
            builder: (context) => const VelocityAvatar(
              size: VelocitySize.medium,
              name: 'M',
            ),
            sourceCode: '''
VelocityAvatar(
  size: VelocitySize.medium,
  name: 'M',
)''',
          ),
          ComponentVariant(
            name: 'Large',
            builder: (context) => const VelocityAvatar(
              size: VelocitySize.large,
              name: 'L',
            ),
            sourceCode: '''
VelocityAvatar(
  size: VelocitySize.large,
  name: 'L',
)''',
          ),
          ComponentVariant(
            name: 'With Icon',
            builder: (context) => const VelocityAvatar(
              size: VelocitySize.medium,
              icon: Icons.person,
            ),
            sourceCode: '''
VelocityAvatar(
  size: VelocitySize.medium,
  icon: Icons.person,
)''',
          ),
        ],
      ),
    );
  }
}
