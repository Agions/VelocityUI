# Timeline 时间线

时间线组件用于展示时间流信息。

## 基础用法

```dart
VelocityTimeline(
  items: [
    TimelineItem(
      title: '创建订单',
      time: '2024-01-15 10:00',
    ),
    TimelineItem(
      title: '支付完成',
      time: '2024-01-15 10:05',
    ),
    TimelineItem(
      title: '发货',
      time: '2024-01-15 14:00',
    ),
  ],
)
```

## 自定义图标

```dart
VelocityTimeline(
  items: [
    TimelineItem(
      title: '完成',
      icon: Icons.check_circle,
      iconColor: Colors.green,
    ),
  ],
)
```

## API

### 属性

| 属性    | 类型                  | 默认值 | 说明         |
| ------- | --------------------- | ------ | ------------ |
| `items` | `List<TimelineItem>` | -      | 时间线项列表 |
