# Radio 单选框

单选框组件用于在多个选项中进行单选。

## 基础用法

```dart
String? selectedValue;

Column(
  children: [
    VelocityRadio<String>(
      value: 'option1',
      groupValue: selectedValue,
      label: '选项 1',
      onChanged: (value) {
        setState(() {
          selectedValue = value;
        });
      },
    ),
    VelocityRadio<String>(
      value: 'option2',
      groupValue: selectedValue,
      label: '选项 2',
      onChanged: (value) {
        setState(() {
          selectedValue = value;
        });
      },
    ),
  ],
)
```

## 禁用状态

```dart
VelocityRadio<String>(
  value: 'disabled',
  groupValue: selectedValue,
  label: '已禁用',
  enabled: false,
  onChanged: null,
)
```

## 单选框组

```dart
VelocityRadioGroup<String>(
  value: selectedValue,
  options: [
    RadioOption(value: 'small', label: '小'),
    RadioOption(value: 'medium', label: '中'),
    RadioOption(value: 'large', label: '大'),
  ],
  onChanged: (value) {
    setState(() {
      selectedValue = value;
    });
  },
)
```

## 水平布局

```dart
VelocityRadioGroup<String>(
  value: selectedValue,
  direction: Axis.horizontal,
  options: [
    RadioOption(value: 'male', label: '男'),
    RadioOption(value: 'female', label: '女'),
  ],
  onChanged: (value) {},
)
```

## 带描述

```dart
VelocityRadio<String>(
  value: 'premium',
  groupValue: selectedValue,
  label: '高级会员',
  description: '享受所有高级功能',
  onChanged: (value) {},
)
```

## 自定义样式

```dart
VelocityRadio<String>(
  value: 'custom',
  groupValue: selectedValue,
  label: '自定义样式',
  style: VelocityRadioStyle(
    activeColor: Colors.purple,
    borderRadius: 12,
  ),
  onChanged: (value) {},
)
```

## API

### VelocityRadio 属性

| 属性          | 类型                  | 默认值 | 说明           |
| ------------- | --------------------- | ------ | -------------- |
| `value`       | `T`                   | -      | 单选框的值     |
| `groupValue`  | `T?`                  | -      | 当前选中的值   |
| `label`       | `String?`             | -      | 标签文本       |
| `description` | `String?`             | -      | 描述文本       |
| `enabled`     | `bool`                | `true` | 是否启用       |
| `style`       | `VelocityRadioStyle?` | -      | 自定义样式     |
| `onChanged`   | `ValueChanged<T?>?`   | -      | 值改变时的回调 |

### VelocityRadioGroup 属性

| 属性        | 类型                   | 默认值          | 说明         |
| ----------- | ---------------------- | --------------- | ------------ |
| `value`     | `T?`                   | -               | 当前选中的值 |
| `options`   | `List<RadioOption<T>>` | -               | 选项列表     |
| `direction` | `Axis`                 | `Axis.vertical` | 布局方向     |
| `spacing`   | `double`               | `8.0`           | 选项间距     |
| `onChanged` | `ValueChanged<T?>?`    | -               | 值改变回调   |
