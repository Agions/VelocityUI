# Rate 评分

评分组件用于对事物进行评级操作。

## 基础用法

```dart
double rating = 0;

VelocityRate(
  value: rating,
  onChanged: (value) {
    setState(() {
      rating = value;
    });
  },
)
```

## 只读模式

```dart
VelocityRate(
  value: 4.5,
  readOnly: true,
)
```

## 自定义数量

```dart
VelocityRate(
  value: rating,
  count: 10,  // 10颗星
  onChanged: (value) {},
)
```

## 允许半星

```dart
VelocityRate(
  value: rating,
  allowHalf: true,
  onChanged: (value) {},
)
```

## 自定义图标

```dart
VelocityRate(
  value: rating,
  icon: Icons.favorite,
  onChanged: (value) {},
)
```

## 自定义颜色

```dart
VelocityRate(
  value: rating,
  activeColor: Colors.red,
  inactiveColor: Colors.grey.shade300,
  onChanged: (value) {},
)
```

## 带文字描述

```dart
VelocityRate(
  value: rating,
  showText: true,
  texts: ['很差', '较差', '一般', '满意', '非常满意'],
  onChanged: (value) {},
)
```

## 不同尺寸

```dart
// 小尺寸
VelocityRate(
  value: rating,
  size: 16,
  onChanged: (value) {},
)

// 大尺寸
VelocityRate(
  value: rating,
  size: 32,
  onChanged: (value) {},
)
```

## API

### 属性

| 属性            | 类型                    | 默认值         | 说明           |
| --------------- | ----------------------- | -------------- | -------------- |
| `value`         | `double`                | `0`            | 当前评分       |
| `count`         | `int`                   | `5`            | 星星总数       |
| `allowHalf`     | `bool`                  | `false`        | 是否允许半星   |
| `readOnly`      | `bool`                  | `false`        | 是否只读       |
| `size`          | `double`                | `24`           | 图标大小       |
| `icon`          | `IconData`              | `Icons.star`   | 图标           |
| `activeColor`   | `Color`                 | `Colors.amber` | 激活状态颜色   |
| `inactiveColor` | `Color`                 | `Colors.grey`  | 未激活状态颜色 |
| `showText`      | `bool`                  | `false`        | 显示文字描述   |
| `texts`         | `List<String>?`         | -              | 文字描述列表   |
| `spacing`       | `double`                | `4`            | 星星间距       |
| `onChanged`     | `ValueChanged<double>?` | -              | 评分改变回调   |
