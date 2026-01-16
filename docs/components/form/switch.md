# Switch 开关

开关组件用于切换单个选项的开/关状态。

## 基础用法

```dart
bool enabled = false;

VelocitySwitch(
  value: enabled,
  onChanged: (value) {
    setState(() {
      enabled = value;
    });
  },
)
```

## 带标签

```dart
VelocitySwitch(
  value: enabled,
  label: '启用通知',
  onChanged: (value) {
    setState(() {
      enabled = value;
    });
  },
)
```

## 禁用状态

```dart
VelocitySwitch(
  value: true,
  label: '已禁用',
  enabled: false,
  onChanged: null,
)
```

## 带图标

```dart
VelocitySwitch(
  value: enabled,
  activeIcon: Icons.check,
  inactiveIcon: Icons.close,
  onChanged: (value) {},
)
```

## 加载状态

```dart
VelocitySwitch(
  value: enabled,
  loading: true,
  onChanged: (value) async {
    // 异步操作
    await Future.delayed(Duration(seconds: 2));
  },
)
```

## 不同尺寸

```dart
// 小尺寸
VelocitySwitch(
  value: enabled,
  size: VelocitySwitchSize.small,
  onChanged: (value) {},
)

// 中等尺寸（默认）
VelocitySwitch(
  value: enabled,
  size: VelocitySwitchSize.medium,
  onChanged: (value) {},
)

// 大尺寸
VelocitySwitch(
  value: enabled,
  size: VelocitySwitchSize.large,
  onChanged: (value) {},
)
```

## 自定义颜色

```dart
VelocitySwitch(
  value: enabled,
  activeColor: Colors.green,
  inactiveColor: Colors.grey,
  thumbColor: Colors.white,
  onChanged: (value) {},
)
```

## 带描述

```dart
VelocitySwitch(
  value: enabled,
  label: '自动保存',
  description: '编辑时自动保存草稿',
  onChanged: (value) {},
)
```

## API

### 属性

| 属性            | 类型                  | 默认值                      | 说明           |
| --------------- | --------------------- | --------------------------- | -------------- |
| `value`         | `bool`                | -                           | 开关状态       |
| `label`         | `String?`             | -                           | 标签文本       |
| `description`   | `String?`             | -                           | 描述文本       |
| `enabled`       | `bool`                | `true`                      | 是否启用       |
| `loading`       | `bool`                | `false`                     | 加载状态       |
| `size`          | `VelocitySwitchSize`  | `VelocitySwitchSize.medium` | 尺寸           |
| `activeColor`   | `Color?`              | -                           | 激活状态颜色   |
| `inactiveColor` | `Color?`              | -                           | 未激活状态颜色 |
| `thumbColor`    | `Color?`              | -                           | 滑块颜色       |
| `activeIcon`    | `IconData?`           | -                           | 激活状态图标   |
| `inactiveIcon`  | `IconData?`           | -                           | 未激活状态图标 |
| `onChanged`     | `ValueChanged<bool>?` | -                           | 值改变时的回调 |

### VelocitySwitchSize

| 值       | 说明     |
| -------- | -------- |
| `small`  | 小尺寸   |
| `medium` | 中等尺寸 |
| `large`  | 大尺寸   |
