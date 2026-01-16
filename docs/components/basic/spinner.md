# Spinner 加载指示器

加载指示器组件用于显示加载状态。

<InteractivePreview
  component="VelocitySpinner"
  description="支持多种尺寸和颜色的加载指示器组件"
  preview-path="Basic Examples > Spinner"
  :variants="[
    {
      name: 'Basic',
      code: `VelocitySpinner()`
    },
    {
      name: 'Small',
      code: `VelocitySpinner(size: VelocitySize.small)`
    },
    {
      name: 'Large',
      code: `VelocitySpinner(size: VelocitySize.large)`
    },
    {
      name: 'Colored',
      code: `VelocitySpinner(color: Colors.blue)`
    },
    {
      name: 'With Label',
      code: `VelocitySpinner(
  label: '加载中...',
)`
    }
  ]"
/>

## 基础用法

```dart
VelocitySpinner()
```

## 尺寸

```dart
VelocitySpinner(size: VelocitySize.small)
VelocitySpinner(size: VelocitySize.medium)
VelocitySpinner(size: VelocitySize.large)
```

## 颜色

```dart
VelocitySpinner(color: Colors.blue)
```

## 带文字

```dart
VelocitySpinner(
  label: '加载中...',
)
```

## API

| 属性          | 类型           | 默认值   | 说明     |
| ------------- | -------------- | -------- | -------- |
| `size`        | `VelocitySize` | `medium` | 尺寸     |
| `color`       | `Color?`       | -        | 颜色     |
| `label`       | `String?`      | -        | 文字标签 |
| `strokeWidth` | `double`       | `2.0`    | 线条宽度 |
