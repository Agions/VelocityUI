# Progress 进度条

进度条组件用于展示操作进度。

## 基础用法

```dart
VelocityProgress(
  value: 0.6,
)
```

## 环形进度条

```dart
VelocityProgress.circle(
  value: 0.75,
)
```

## 显示百分比

```dart
VelocityProgress(
  value: 0.6,
  showPercentage: true,
)
```

## API

### 属性

| 属性             | 类型     | 默认值  | 说明       |
| ---------------- | -------- | ------- | ---------- |
| `value`          | `double` | -       | 进度值0-1  |
| `showPercentage` | `bool`   | `false` | 显示百分比 |
| `color`          | `Color?` | -       | 进度条颜色 |
