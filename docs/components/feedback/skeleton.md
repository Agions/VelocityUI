# Skeleton 骨架屏

骨架屏组件用于在内容加载前显示占位图。

## 基础用法

```dart
VelocitySkeleton(
  loading: true,
  child: YourContent(),
)
```

## 不同类型

```dart
VelocitySkeleton.text(lines: 3)
VelocitySkeleton.avatar()
VelocitySkeleton.card()
```

## API

### 属性

| 属性      | 类型     | 默认值 | 说明       |
| --------- | -------- | ------ | ---------- |
| `loading` | `bool`   | `true` | 加载状态   |
| `child`   | `Widget?` | -      | 实际内容   |
