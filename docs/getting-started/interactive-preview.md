# 交互式组件预览

VelocityUI 提供了交互式组件预览功能，让您可以实时修改组件属性并查看效果变化。

## 文档中的交互式预览

每个组件文档页面都包含一个交互式预览区域，展示组件的多种变体和使用方式：

- **变体切换**：通过标签页切换不同的组件变体
- **代码展示**：查看每个变体对应的 Dart 代码
- **一键复制**：快速复制代码到剪贴板
- **运行指引**：了解如何在本地运行完整的交互式预览

## 运行示例项目

要体验完整的交互式预览功能（包括实时属性修改），请运行示例项目：

```bash
# 进入示例项目目录
cd example

# 运行示例应用
flutter run
```

## 功能特性

### 实时属性修改

在交互式预览页面，您可以：

- **修改文本属性**：直接输入文本内容
- **切换布尔属性**：使用开关控制 disabled、loading 等状态
- **选择枚举属性**：通过选项卡选择不同的类型、尺寸
- **调整数值属性**：使用滑块调整数值
- **选择颜色属性**：从预设颜色中选择

### 代码预览

每个组件预览都包含：

- **实时渲染**：组件在预览区域实时渲染
- **源代码显示**：点击代码图标查看对应的 Dart 代码
- **一键复制**：快速复制代码到剪贴板

### 多变体展示

支持同一组件的多种变体展示：

- 通过标签页切换不同变体
- 每个变体有独立的源代码
- 方便对比不同配置的效果

## 使用 ComponentPreview 组件

您可以在自己的项目中使用 `ComponentPreview` 组件：

```dart
import 'package:velocity_ui_example/widgets/component_preview.dart';

ComponentPreview(
  config: ComponentPreviewConfig(
    title: 'VelocityButton',
    description: '按钮组件示例',
    sourceCode: '''
VelocityButton.text(
  text: 'Click Me',
  onPressed: () {},
)''',
  ),
  properties: [
    StringPropertyController(
      name: 'Text',
      initialValue: 'Click Me',
    ),
    BoolPropertyController(
      name: 'Disabled',
      initialValue: false,
    ),
  ],
  builder: (context, properties) {
    final textController = properties[0] as StringPropertyController;
    final disabledController = properties[1] as BoolPropertyController;

    return VelocityButton.text(
      text: textController.value,
      disabled: disabledController.value,
      onPressed: disabledController.value ? null : () {},
    );
  },
)
```

## 属性控制器类型

| 控制器类型                  | 用途   | 示例              |
| --------------------------- | ------ | ----------------- |
| `BoolPropertyController`    | 布尔值 | disabled, loading |
| `StringPropertyController`  | 字符串 | text, label       |
| `NumberPropertyController`  | 数值   | size, opacity     |
| `EnumPropertyController<T>` | 枚举   | type, size        |
| `ColorPropertyController`   | 颜色   | backgroundColor   |

## 组件变体

使用变体展示同一组件的不同配置：

```dart
ComponentPreview(
  config: ComponentPreviewConfig(
    title: 'VelocityTag',
    description: '标签组件',
    variants: [
      ComponentVariant(
        name: 'Default',
        builder: (context) => VelocityTag(text: 'Default'),
        sourceCode: "VelocityTag(text: 'Default')",
      ),
      ComponentVariant(
        name: 'Primary',
        builder: (context) => VelocityTag(
          text: 'Primary',
          type: VelocityTagType.primary,
        ),
        sourceCode: '''
VelocityTag(
  text: 'Primary',
  type: VelocityTagType.primary,
)''',
      ),
    ],
  ),
)
```

## 最佳实践

::: tip 推荐

- 为每个属性提供清晰的名称和描述
- 使用合理的初始值展示组件默认状态
- 提供多个变体展示组件的主要用例
- 确保源代码与实际渲染一致
  :::
