# Icon 图标

图标组件用于显示图标，支持 Material Icons 和自定义图标。

<InteractivePreview
  component="VelocityIcon"
  description="支持多种尺寸、颜色和徽章的图标组件"
  preview-path="Basic Examples > Icon"
  :variants="[
    {
      name: 'Basic',
      code: `VelocityIcon(Icons.home)`
    },
    {
      name: 'Sizes',
      code: `Row(
  children: [
    VelocityIcon(Icons.home, size: VelocitySize.small),
    VelocityIcon(Icons.home, size: VelocitySize.medium),
    VelocityIcon(Icons.home, size: VelocitySize.large),
  ],
)`
    },
    {
      name: 'Colors',
      code: `VelocityIcon(
  Icons.home,
  color: VelocityIconColor.primary,
)`
    },
    {
      name: 'With Badge',
      code: `VelocityIcon(
  Icons.notifications,
  badge: 5,
)`
    },
    {
      name: 'Icon Button',
      code: `VelocityIconButton(
  icon: Icons.favorite,
  onPressed: () {},
)`
    }
  ]"
/>

## 基础用法

```dart
VelocityIcon(Icons.home)
```

## 图标尺寸

```dart
// 小尺寸
VelocityIcon(
  Icons.home,
  size: VelocitySize.small,
)

// 中等尺寸
VelocityIcon(
  Icons.home,
  size: VelocitySize.medium,
)

// 大尺寸
VelocityIcon(
  Icons.home,
  size: VelocitySize.large,
)

// 自定义尺寸
VelocityIcon(
  Icons.home,
  customSize: 48,
)
```

## 图标颜色

```dart
// 主色
VelocityIcon(
  Icons.home,
  color: VelocityIconColor.primary,
)

// 次要色
VelocityIcon(
  Icons.home,
  color: VelocityIconColor.secondary,
)

// 自定义颜色
VelocityIcon(
  Icons.home,
  customColor: Colors.purple,
)
```

## 图标按钮

```dart
VelocityIconButton(
  icon: Icons.favorite,
  onPressed: () {
    print('图标按钮被点击');
  },
)

// 带背景的图标按钮
VelocityIconButton(
  icon: Icons.add,
  backgroundColor: Colors.blue,
  iconColor: Colors.white,
  onPressed: () {},
)
```

## 徽章图标

```dart
VelocityIcon(
  Icons.notifications,
  badge: 5,  // 显示数字徽章
)

VelocityIcon(
  Icons.mail,
  badge: true,  // 显示红点
)
```

## 自定义图标

```dart
// 使用自定义图标字体
VelocityIcon(
  VelocityIcons.custom_icon,
)

// 使用 SVG 图标
VelocityIcon.svg(
  'assets/icons/custom.svg',
  size: 24,
)
```

## API

### 属性

| 属性          | 类型                 | 默认值   | 说明               |
| ------------- | -------------------- | -------- | ------------------ |
| `icon`        | `IconData`           | -        | 图标数据           |
| `size`        | `VelocitySize`       | `medium` | 图标尺寸           |
| `customSize`  | `double?`            | -        | 自定义尺寸         |
| `color`       | `VelocityIconColor?` | -        | 图标颜色           |
| `customColor` | `Color?`             | -        | 自定义颜色         |
| `badge`       | `dynamic`            | -        | 徽章（数字或布尔） |

### VelocityIconColor

| 值          | 说明   |
| ----------- | ------ |
| `primary`   | 主色   |
| `secondary` | 次要色 |
| `success`   | 成功色 |
| `warning`   | 警告色 |
| `error`     | 错误色 |
| `disabled`  | 禁用色 |

- 装饰性图标可以不设置标签
- 图标按钮自动获得焦点样式
