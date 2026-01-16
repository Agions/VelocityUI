# Button 按钮

按钮用于触发操作或事件，如提交表单、打开对话框等。

<InteractivePreview
  component="VelocityButton"
  description="支持多种类型、尺寸和状态的按钮组件"
  preview-path="Basic Examples > Button"
  :variants="[
    {
      name: 'Primary',
      code: `VelocityButton.text(
  text: '主要按钮',
  type: VelocityButtonType.primary,
  onPressed: () {},
)`
    },
    {
      name: 'Secondary',
      code: `VelocityButton.text(
  text: '次要按钮',
  type: VelocityButtonType.secondary,
  onPressed: () {},
)`
    },
    {
      name: 'Outline',
      code: `VelocityButton.text(
  text: '边框按钮',
  type: VelocityButtonType.outline,
  onPressed: () {},
)`
    },
    {
      name: 'Danger',
      code: `VelocityButton.text(
  text: '危险按钮',
  type: VelocityButtonType.danger,
  onPressed: () {},
)`
    },
    {
      name: 'With Icon',
      code: `VelocityButton.text(
  text: '搜索',
  icon: Icons.search,
  onPressed: () {},
)`
    },
    {
      name: 'Loading',
      code: `VelocityButton.text(
  text: '提交中',
  loading: true,
  onPressed: () {},
)`
    }
  ]"
/>

## 基础用法

最简单的按钮用法：

```dart
VelocityButton.text(
  text: '按钮',
  onPressed: () {
    print('按钮被点击');
  },
)
```

## 按钮类型

VelocityUI 提供多种按钮类型，适用于不同场景：

### 主要按钮 (Primary)

用于主要操作，一个区域内建议只使用一个主要按钮。

```dart
VelocityButton.text(
  text: '主要按钮',
  type: VelocityButtonType.primary,
  onPressed: () {},
)
```

### 次要按钮 (Secondary)

用于次要操作，与主要按钮配合使用。

```dart
VelocityButton.text(
  text: '次要按钮',
  type: VelocityButtonType.secondary,
  onPressed: () {},
)
```

### 边框按钮 (Outline)

用于一般操作，视觉上较轻量。

```dart
VelocityButton.text(
  text: '边框按钮',
  type: VelocityButtonType.outline,
  onPressed: () {},
)
```

### 文字按钮 (Text)

用于辅助操作，最轻量的按钮样式。

```dart
VelocityButton.text(
  text: '文字按钮',
  type: VelocityButtonType.text,
  onPressed: () {},
)
```

### 危险按钮 (Danger)

用于危险或不可逆操作，如删除。

```dart
VelocityButton.text(
  text: '危险按钮',
  type: VelocityButtonType.danger,
  onPressed: () {},
)
```

### 成功按钮 (Success)

用于成功或确认操作。

```dart
VelocityButton.text(
  text: '成功按钮',
  type: VelocityButtonType.success,
  onPressed: () {},
)
```

### 警告按钮 (Warning)

用于需要注意的操作。

```dart
VelocityButton.text(
  text: '警告按钮',
  type: VelocityButtonType.warning,
  onPressed: () {},
)
```

## 按钮尺寸

三种预设尺寸适应不同场景：

```dart
// 小尺寸 - 适用于紧凑布局
VelocityButton.text(
  text: '小按钮',
  size: VelocityButtonSize.small,
  onPressed: () {},
)

// 中等尺寸（默认）- 适用于大多数场景
VelocityButton.text(
  text: '中按钮',
  size: VelocityButtonSize.medium,
  onPressed: () {},
)

// 大尺寸 - 适用于突出显示
VelocityButton.text(
  text: '大按钮',
  size: VelocityButtonSize.large,
  onPressed: () {},
)
```

## 图标按钮

### 带前置图标

```dart
VelocityButton.text(
  text: '搜索',
  icon: Icons.search,
  onPressed: () {},
)
```

### 带后置图标

```dart
VelocityButton.text(
  text: '下一步',
  suffixIcon: Icons.arrow_forward,
  onPressed: () {},
)
```

### 仅图标按钮

```dart
VelocityButton.icon(
  icon: Icons.add,
  onPressed: () {},
)
```

## 按钮状态

### 加载状态

显示加载指示器，自动禁用点击：

```dart
VelocityButton.text(
  text: '提交中',
  loading: true,
  onPressed: () {},
)
```

### 禁用状态

```dart
VelocityButton.text(
  text: '禁用按钮',
  disabled: true,
  onPressed: () {},
)
```

## 全宽按钮

占满父容器宽度：

```dart
VelocityButton.text(
  text: '全宽按钮',
  fullWidth: true,
  onPressed: () {},
)
```

## 自定义样式

通过 `VelocityButtonStyle` 自定义按钮外观：

```dart
VelocityButton.text(
  text: '自定义按钮',
  style: VelocityButtonStyle(
    backgroundColor: Colors.purple,
    foregroundColor: Colors.white,
    borderRadius: BorderRadius.circular(20),
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  ),
  onPressed: () {},
)
```

## API 参考

### VelocityButton.text

| 属性         | 类型                   | 默认值                       | 说明       |
| ------------ | ---------------------- | ---------------------------- | ---------- |
| `text`       | `String`               | 必填                         | 按钮文本   |
| `onPressed`  | `VoidCallback?`        | -                            | 点击回调   |
| `type`       | `VelocityButtonType`   | `VelocityButtonType.primary` | 按钮类型   |
| `size`       | `VelocityButtonSize`   | `VelocityButtonSize.medium`  | 按钮尺寸   |
| `icon`       | `IconData?`            | -                            | 前置图标   |
| `suffixIcon` | `IconData?`            | -                            | 后置图标   |
| `loading`    | `bool`                 | `false`                      | 加载状态   |
| `disabled`   | `bool`                 | `false`                      | 禁用状态   |
| `fullWidth`  | `bool`                 | `false`                      | 全宽按钮   |
| `style`      | `VelocityButtonStyle?` | -                            | 自定义样式 |

### VelocityButton.icon

| 属性        | 类型                   | 默认值                       | 说明       |
| ----------- | ---------------------- | ---------------------------- | ---------- |
| `icon`      | `IconData`             | 必填                         | 图标       |
| `onPressed` | `VoidCallback?`        | -                            | 点击回调   |
| `type`      | `VelocityButtonType`   | `VelocityButtonType.primary` | 按钮类型   |
| `size`      | `VelocityButtonSize`   | `VelocityButtonSize.medium`  | 按钮尺寸   |
| `loading`   | `bool`                 | `false`                      | 加载状态   |
| `disabled`  | `bool`                 | `false`                      | 禁用状态   |
| `style`     | `VelocityButtonStyle?` | -                            | 自定义样式 |

### VelocityButtonType

| 值          | 说明                   |
| ----------- | ---------------------- |
| `primary`   | 主要按钮，用于主要操作 |
| `secondary` | 次要按钮，用于次要操作 |
| `outline`   | 边框按钮，用于一般操作 |
| `text`      | 文字按钮，用于辅助操作 |
| `danger`    | 危险按钮，用于危险操作 |
| `success`   | 成功按钮，用于确认操作 |
| `warning`   | 警告按钮，用于警示操作 |

### VelocityButtonSize

| 值       | 说明     |
| -------- | -------- |
| `small`  | 小尺寸   |
| `medium` | 中等尺寸 |
| `large`  | 大尺寸   |

## 最佳实践

::: tip 推荐

- 主要按钮在同一区域内建议只使用一个
- 危险操作使用 `danger` 类型并配合确认对话框
  :::

::: warning 注意

- `onPressed` 为 `null` 时按钮会自动禁用
- 加载状态时按钮会自动禁用点击
- 全宽按钮会忽略 `size` 属性的宽度设置
  :::

## 示例代码

完整示例请参考：

- [example/lib/pages/basic/button_example.dart](https://github.com/your-repo/velocity_ui/blob/main/example/lib/pages/basic/button_example.dart)
- [example/lib/pages/interactive_preview_demo.dart](https://github.com/your-repo/velocity_ui/blob/main/example/lib/pages/interactive_preview_demo.dart)
