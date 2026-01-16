# Drawer 抽屉

抽屉组件用于侧边栏展示。

## 基础用法

```dart
VelocityDrawer.show(
  context,
  child: YourDrawerContent(),
)
```

## 不同位置

```dart
VelocityDrawer.show(
  context,
  position: VelocityDrawerPosition.right,
  child: content,
)
```

## API

### 方法

| 方法   | 参数                                                | 说明       |
| ------ | --------------------------------------------------- | ---------- |
| `show` | `BuildContext context, {Widget child, VelocityDrawerPosition position}` | 显示抽屉   |
