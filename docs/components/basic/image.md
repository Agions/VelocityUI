# Image 图片

图片组件用于显示图片，支持懒加载、占位符和错误处理。

<InteractivePreview
  component="VelocityImage"
  description="支持懒加载、占位符和多种形状的图片组件"
  preview-path="Basic Examples > Image"
  :variants="[
    {
      name: 'Basic',
      code: `VelocityImage(
  src: 'https://example.com/image.jpg',
)`
    },
    {
      name: 'With Placeholder',
      code: `VelocityImage(
  src: 'https://example.com/image.jpg',
  placeholder: VelocitySkeleton.image(),
)`
    },
    {
      name: 'Rounded',
      code: `VelocityImage(
  src: 'https://example.com/image.jpg',
  borderRadius: 8,
)`
    },
    {
      name: 'Circle',
      code: `VelocityImage(
  src: 'https://example.com/image.jpg',
  shape: VelocityImageShape.circle,
)`
    }
  ]"
/>

## 基础用法

```dart
VelocityImage(
  src: 'https://example.com/image.jpg',
)
```

## 占位符

```dart
VelocityImage(
  src: 'https://example.com/image.jpg',
  placeholder: VelocitySkeleton.image(),
)
```

## 错误处理

```dart
VelocityImage(
  src: 'https://example.com/image.jpg',
  errorWidget: Icon(Icons.broken_image),
)
```

## 圆角图片

```dart
VelocityImage(
  src: 'https://example.com/image.jpg',
  borderRadius: 8,
)
```

## 圆形图片

```dart
VelocityImage(
  src: 'https://example.com/image.jpg',
  shape: VelocityImageShape.circle,
)
```

## API

| 属性           | 类型                 | 默认值      | 说明     |
| -------------- | -------------------- | ----------- | -------- |
| `src`          | `String`             | -           | 图片地址 |
| `width`        | `double?`            | -           | 宽度     |
| `height`       | `double?`            | -           | 高度     |
| `fit`          | `BoxFit`             | `cover`     | 填充模式 |
| `placeholder`  | `Widget?`            | -           | 占位符   |
| `errorWidget`  | `Widget?`            | -           | 错误组件 |
| `borderRadius` | `double?`            | -           | 圆角     |
| `shape`        | `VelocityImageShape` | `rectangle` | 形状     |
