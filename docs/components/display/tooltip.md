# Tooltip 提示

提示组件用于显示简短的提示信息。

## 基础用法

```dart
VelocityTooltip(
  message: '这是提示信息',
  child: Icon(Icons.help),
)
```

## 不同位置

```dart
VelocityTooltip(
  message: '顶部提示',
  position: VelocityTooltipPosition.top,
  child: Text('悬停查看'),
)
```

## API

### 属性

| 属性       | 类型                      | 默认值                      | 说明     |
| ---------- | ------------------------- | --------------------------- | -------- |
| `message`  | `String`                  | -                           | 提示文本 |
| `position` | `VelocityTooltipPosition` | `VelocityTooltipPosition.top` | 位置     |
| `child`    | `Widget`                  | -                           | 子组件   |
