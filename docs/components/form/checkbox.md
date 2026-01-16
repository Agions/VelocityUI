# Checkbox 复选框

复选框组件用于在多个选项中进行多选。

## 基础用法

```dart
bool checked = false;

VelocityCheckbox(
  value: checked,
  onChanged: (value) {
    setState(() {
      checked = value ?? false;
    });
  },
)
```

## 带标签

```dart
VelocityCheckbox(
  value: checked,
  label: '同意用户协议',
  onChanged: (value) {
    setState(() {
      checked = value ?? false;
    });
  },
)
```

## 禁用状态

```dart
VelocityCheckbox(
  value: true,
  label: '已禁用',
  enabled: false,
  onChanged: null,
)
```

## 不确定状态

```dart
VelocityCheckbox(
  value: null,
  tristate: true,
  label: '全选',
  onChanged: (value) {
    // 处理三态切换
  },
)
```

## 复选框组

```dart
List<String> selectedItems = [];

Column(
  children: [
    VelocityCheckbox(
      value: selectedItems.contains('apple'),
      label: '苹果',
      onChanged: (value) {
        setState(() {
          if (value == true) {
            selectedItems.add('apple');
          } else {
            selectedItems.remove('apple');
          }
        });
      },
    ),
    VelocityCheckbox(
      value: selectedItems.contains('banana'),
      label: '香蕉',
      onChanged: (value) {
        setState(() {
          if (value == true) {
            selectedItems.add('banana');
          } else {
            selectedItems.remove('banana');
          }
        });
      },
    ),
  ],
)
```

## 自定义样式

```dart
VelocityCheckbox(
  value: checked,
  label: '自定义样式',
  style: VelocityCheckboxStyle(
    activeColor: Colors.green,
    checkColor: Colors.white,
    borderRadius: 4,
  ),
  onChanged: (value) {},
)
```

## API

### 属性

| 属性        | 类型                     | 默认值  | 说明           |
| ----------- | ------------------------ | ------- | -------------- |
| `value`     | `bool?`                  | -       | 选中状态       |
| `label`     | `String?`                | -       | 标签文本       |
| `tristate`  | `bool`                   | `false` | 是否支持三态   |
| `enabled`   | `bool`                   | `true`  | 是否启用       |
| `style`     | `VelocityCheckboxStyle?` | -       | 自定义样式     |
| `onChanged` | `ValueChanged<bool?>?`   | -       | 值改变时的回调 |
