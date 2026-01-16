# Slider 滑块

滑块组件用于在一个范围内选择数值。

## 基础用法

```dart
double value = 50;

VelocitySlider(
  value: value,
  min: 0,
  max: 100,
  onChanged: (newValue) {
    setState(() {
      value = newValue;
    });
  },
)
```

## 带标签

```dart
VelocitySlider(
  value: value,
  min: 0,
  max: 100,
  label: '音量',
  showValue: true,
  onChanged: (newValue) {},
)
```

## 步进值

```dart
VelocitySlider(
  value: value,
  min: 0,
  max: 100,
  divisions: 10,  // 分成10段
  onChanged: (newValue) {},
)
```

## 范围滑块

```dart
RangeValues rangeValues = RangeValues(20, 80);

VelocityRangeSlider(
  values: rangeValues,
  min: 0,
  max: 100,
  onChanged: (newValues) {
    setState(() {
      rangeValues = newValues;
    });
  },
)
```

## 禁用状态

```dart
VelocitySlider(
  value: 50,
  min: 0,
  max: 100,
  enabled: false,
  onChanged: null,
)
```

## 自定义颜色

```dart
VelocitySlider(
  value: value,
  min: 0,
  max: 100,
  activeColor: Colors.blue,
  inactiveColor: Colors.grey.shade300,
  thumbColor: Colors.blue.shade700,
  onChanged: (newValue) {},
)
```

## 带刻度标记

```dart
VelocitySlider(
  value: value,
  min: 0,
  max: 100,
  divisions: 5,
  showMarks: true,
  marks: {
    0: '0',
    25: '25',
    50: '50',
    75: '75',
    100: '100',
  },
  onChanged: (newValue) {},
)
```

## API

### VelocitySlider 属性

| 属性            | 类型                    | 默认值  | 说明           |
| --------------- | ----------------------- | ------- | -------------- |
| `value`         | `double`                | -       | 当前值         |
| `min`           | `double`                | `0.0`   | 最小值         |
| `max`           | `double`                | `100.0` | 最大值         |
| `divisions`     | `int?`                  | -       | 分段数         |
| `label`         | `String?`               | -       | 标签文本       |
| `showValue`     | `bool`                  | `false` | 显示当前值     |
| `showMarks`     | `bool`                  | `false` | 显示刻度标记   |
| `marks`         | `Map<double,String>?`   | -       | 刻度标记       |
| `enabled`       | `bool`                  | `true`  | 是否启用       |
| `activeColor`   | `Color?`                | -       | 激活部分颜色   |
| `inactiveColor` | `Color?`                | -       | 未激活部分颜色 |
| `thumbColor`    | `Color?`                | -       | 滑块颜色       |
| `onChanged`     | `ValueChanged<double>`  | -       | 值改变时的回调 |
| `onChangeStart` | `ValueChanged<double>?` | -       | 开始拖动回调   |
| `onChangeEnd`   | `ValueChanged<double>?` | -       | 结束拖动回调   |

### VelocityRangeSlider 属性

| 属性        | 类型                        | 默认值  | 说明           |
| ----------- | --------------------------- | ------- | -------------- |
| `values`    | `RangeValues`               | -       | 当前范围值     |
| `min`       | `double`                    | `0.0`   | 最小值         |
| `max`       | `double`                    | `100.0` | 最大值         |
| `divisions` | `int?`                      | -       | 分段数         |
| `onChanged` | `ValueChanged<RangeValues>` | -       | 值改变时的回调 |
