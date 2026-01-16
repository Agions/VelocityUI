# Text 文本

文本组件用于显示文字内容，支持多种样式和格式。

<InteractivePreview
  component="VelocityText"
  description="支持多种变体、颜色和样式的文本组件"
  preview-path="Basic Examples > Text"
  :variants="[
    {
      name: 'Basic',
      code: `VelocityText('这是一段文本')`
    },
    {
      name: 'Heading',
      code: `VelocityText(
  '标题文本',
  variant: VelocityTextVariant.h1,
)`
    },
    {
      name: 'Colored',
      code: `VelocityText(
  '主色文本',
  color: VelocityTextColor.primary,
)`
    },
    {
      name: 'Ellipsis',
      code: `VelocityText(
  '这是一段很长的文本，超出部分会显示省略号...',
  overflow: TextOverflow.ellipsis,
  maxLines: 1,
)`
    },
    {
      name: 'Selectable',
      code: `VelocityText(
  '这段文本可以被选择复制',
  selectable: true,
)`
    }
  ]"
/>

## 基础用法

```dart
VelocityText('这是一段文本')
```

## 文本样式

```dart
// 标题
VelocityText(
  '标题文本',
  variant: VelocityTextVariant.h1,
)

// 副标题
VelocityText(
  '副标题文本',
  variant: VelocityTextVariant.h2,
)

// 正文
VelocityText(
  '正文文本',
  variant: VelocityTextVariant.body1,
)

// 小字
VelocityText(
  '小字文本',
  variant: VelocityTextVariant.caption,
)
```

## 文本颜色

```dart
// 主色
VelocityText(
  '主色文本',
  color: VelocityTextColor.primary,
)

// 次要色
VelocityText(
  '次要色文本',
  color: VelocityTextColor.secondary,
)

// 成功色
VelocityText(
  '成功文本',
  color: VelocityTextColor.success,
)

// 警告色
VelocityText(
  '警告文本',
  color: VelocityTextColor.warning,
)

// 错误色
VelocityText(
  '错误文本',
  color: VelocityTextColor.error,
)
```

## 文本对齐

```dart
VelocityText(
  '居中文本',
  textAlign: TextAlign.center,
)

VelocityText(
  '右对齐文本',
  textAlign: TextAlign.right,
)
```

## 文本溢出

```dart
// 省略号
VelocityText(
  '这是一段很长的文本，超出部分会显示省略号...',
  overflow: TextOverflow.ellipsis,
  maxLines: 1,
)

// 多行省略
VelocityText(
  '这是一段很长的文本，可以显示多行，超出部分会显示省略号...',
  overflow: TextOverflow.ellipsis,
  maxLines: 2,
)
```

## 可选择文本

```dart
VelocityText(
  '这段文本可以被选择复制',
  selectable: true,
)
```

## 富文本

```dart
VelocityText.rich(
  children: [
    TextSpan(text: '普通文本'),
    TextSpan(
      text: '加粗文本',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    TextSpan(
      text: '彩色文本',
      style: TextStyle(color: Colors.blue),
    ),
  ],
)
```

## 自定义样式

```dart
VelocityText(
  '自定义样式文本',
  style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
    height: 1.5,
  ),
)
```

## API

### 属性

| 属性         | 类型                  | 默认值  | 说明       |
| ------------ | --------------------- | ------- | ---------- |
| `data`       | `String`              | -       | 文本内容   |
| `variant`    | `VelocityTextVariant` | `body1` | 文本变体   |
| `color`      | `VelocityTextColor?`  | -       | 文本颜色   |
| `style`      | `TextStyle?`          | -       | 自定义样式 |
| `textAlign`  | `TextAlign?`          | -       | 文本对齐   |
| `overflow`   | `TextOverflow?`       | -       | 溢出处理   |
| `maxLines`   | `int?`                | -       | 最大行数   |
| `selectable` | `bool`                | `false` | 是否可选择 |

### VelocityTextVariant

| 值         | 说明         |
| ---------- | ------------ |
| `h1`       | 一级标题     |
| `h2`       | 二级标题     |
| `h3`       | 三级标题     |
| `h4`       | 四级标题     |
| `h5`       | 五级标题     |
| `h6`       | 六级标题     |
| `body1`    | 正文（默认） |
| `body2`    | 正文小字     |
| `caption`  | 说明文字     |
| `overline` | 上划线文字   |

### VelocityTextColor

| 值          | 说明   |
| ----------- | ------ |
| `primary`   | 主色   |
| `secondary` | 次要色 |
| `success`   | 成功色 |
| `warning`   | 警告色 |
| `error`     | 错误色 |
| `disabled`  | 禁用色 |

- 文本组件自动设置语义化标签
- 支持高对比度模式
