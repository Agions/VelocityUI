# Badge 徽章

徽章组件用于展示数字或状态标记。

## 基础用法

```dart
VelocityBadge(
  count: 5,
  child: Icon(Icons.notifications),
)
```

## 最大值

```dart
VelocityBadge(
  count: 99,
  maxCount: 99,
  child: Icon(Icons.mail),
)
```

## 小红点

```dart
VelocityBadge(
  dot: true,
  child: Icon(Icons.message),
)
```

## 独立使用

```dart
VelocityBadge(
  count: 10,
)
```

## 自定义内容

```dart
VelocityBadge(
  text: 'NEW',
  child: Text('新功能'),
)
```

## 不同颜色

```dart
VelocityBadge(
  count: 5,
  color: Colors.red,
  child: Icon(Icons.shopping_cart),
)
```

## 不同位置

```dart
VelocityBadge(
  count: 3,
  position: VelocityBadgePosition.topRight,
  child: Icon(Icons.notifications),
)
```

## API

### 属性

| 属性        | 类型                    | 默认值                           | 说明       |
| ----------- | ----------------------- | -------------------------------- | ---------- |
| `count`     | `int?`                  | -                                | 数字       |
| `text`      | `String?`               | -                                | 文本       |
| `maxCount`  | `int`                   | `99`                             | 最大显示数 |
| `dot`       | `bool`                  | `false`                          | 小红点模式 |
| `showZero`  | `bool`                  | `false`                          | 显示 0     |
| `color`     | `Color`                 | `Colors.red`                     | 背景颜色   |
| `textColor` | `Color`                 | `Colors.white`                   | 文字颜色   |
| `position`  | `VelocityBadgePosition` | `VelocityBadgePosition.topRight` | 位置       |
| `child`     | `Widget?`               | -                                | 子组件     |
