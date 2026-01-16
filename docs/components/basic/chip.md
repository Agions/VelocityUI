# Chip 标签

标签组件用于显示标签、选择项或过滤条件。

<InteractivePreview
  component="VelocityChip"
  description="支持选择、删除和自定义图标的标签组件"
  preview-path="Basic Examples > Chip"
  :variants="[
    {
      name: 'Default',
      code: `VelocityChip(
  label: '标签',
)`
    },
    {
      name: 'Selectable',
      code: `VelocityChip(
  label: '可选标签',
  selected: isSelected,
  onSelected: (selected) {
    setState(() => isSelected = selected);
  },
)`
    },
    {
      name: 'Deletable',
      code: `VelocityChip(
  label: '可删除标签',
  onDeleted: () {
    // 处理删除
  },
)`
    },
    {
      name: 'With Avatar',
      code: `VelocityChip(
  label: '带图标',
  avatar: Icon(Icons.star),
)`
    }
  ]"
/>

## 基础用法

```dart
VelocityChip(
  label: '标签',
)
```

## 可选择

```dart
VelocityChip(
  label: '可选标签',
  selected: isSelected,
  onSelected: (selected) {
    setState(() => isSelected = selected);
  },
)
```

## 可删除

```dart
VelocityChip(
  label: '可删除标签',
  onDeleted: () {
    // 处理删除
  },
)
```

## 带图标

```dart
VelocityChip(
  label: '带图标',
  avatar: Icon(Icons.star),
)
```

## 标签组

```dart
VelocityChipGroup(
  children: [
    VelocityChip(label: '标签1'),
    VelocityChip(label: '标签2'),
    VelocityChip(label: '标签3'),
  ],
)
```

## API

| 属性         | 类型                  | 默认值  | 说明      |
| ------------ | --------------------- | ------- | --------- |
| `label`      | `String`              | -       | 标签文本  |
| `avatar`     | `Widget?`             | -       | 头像/图标 |
| `selected`   | `bool`                | `false` | 是否选中  |
| `disabled`   | `bool`                | `false` | 是否禁用  |
| `onSelected` | `ValueChanged<bool>?` | -       | 选择回调  |
| `onDeleted`  | `VoidCallback?`       | -       | 删除回调  |
