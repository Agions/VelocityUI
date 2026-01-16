# DatePicker 日期选择器

日期选择器组件用于选择日期和时间。

## 基础用法

```dart
DateTime? selectedDate;

VelocityDatePicker(
  value: selectedDate,
  onChanged: (date) {
    setState(() {
      selectedDate = date;
    });
  },
)
```

## 日期范围选择

```dart
DateTimeRange? dateRange;

VelocityDateRangePicker(
  value: dateRange,
  onChanged: (range) {
    setState(() {
      dateRange = range;
    });
  },
)
```

## 时间选择

```dart
TimeOfDay? selectedTime;

VelocityTimePicker(
  value: selectedTime,
  onChanged: (time) {
    setState(() {
      selectedTime = time;
    });
  },
)
```

## 日期时间选择

```dart
DateTime? selectedDateTime;

VelocityDateTimePicker(
  value: selectedDateTime,
  onChanged: (dateTime) {
    setState(() {
      selectedDateTime = dateTime;
    });
  },
)
```

## 限制日期范围

```dart
VelocityDatePicker(
  value: selectedDate,
  minDate: DateTime(2020, 1, 1),
  maxDate: DateTime(2030, 12, 31),
  onChanged: (date) {},
)
```

## 禁用特定日期

```dart
VelocityDatePicker(
  value: selectedDate,
  disabledDates: [
    DateTime(2024, 1, 1),  // 禁用元旦
    DateTime(2024, 12, 25), // 禁用圣诞节
  ],
  onChanged: (date) {},
)
```

## 自定义格式

```dart
VelocityDatePicker(
  value: selectedDate,
  format: 'yyyy年MM月dd日',
  onChanged: (date) {},
)
```

## 内联显示

```dart
VelocityDatePicker(
  value: selectedDate,
  inline: true,
  onChanged: (date) {},
)
```

## API

### VelocityDatePicker 属性

| 属性            | 类型                      | 默认值         | 说明           |
| --------------- | ------------------------- | -------------- | -------------- |
| `value`         | `DateTime?`               | -              | 选中的日期     |
| `minDate`       | `DateTime?`               | -              | 最小日期       |
| `maxDate`       | `DateTime?`               | -              | 最大日期       |
| `disabledDates` | `List<DateTime>?`         | -              | 禁用的日期列表 |
| `format`        | `String`                  | `'yyyy-MM-dd'` | 日期格式       |
| `inline`        | `bool`                    | `false`        | 内联显示       |
| `placeholder`   | `String?`                 | -              | 占位符文本     |
| `onChanged`     | `ValueChanged<DateTime?>` | -              | 日期改变回调   |

### VelocityDateRangePicker 属性

| 属性        | 类型                           | 默认值 | 说明           |
| ----------- | ------------------------------ | ------ | -------------- |
| `value`     | `DateTimeRange?`               | -      | 选中的日期范围 |
| `minDate`   | `DateTime?`                    | -      | 最小日期       |
| `maxDate`   | `DateTime?`                    | -      | 最大日期       |
| `onChanged` | `ValueChanged<DateTimeRange?>` | -      | 范围改变回调   |

### VelocityTimePicker 属性

| 属性        | 类型                       | 默认值 | 说明           |
| ----------- | -------------------------- | ------ | -------------- |
| `value`     | `TimeOfDay?`               | -      | 选中的时间     |
| `use24Hour` | `bool`                     | `true` | 使用 24 小时制 |
| `onChanged` | `ValueChanged<TimeOfDay?>` | -      | 时间改变回调   |
