# Notification 通知

通知组件用于显示全局通知消息。

## 基础用法

```dart
VelocityNotification.show(
  title: '通知标题',
  message: '这是通知内容',
);
```

## 不同类型

```dart
VelocityNotification.success(
  title: '成功',
  message: '操作成功完成',
);

VelocityNotification.error(
  title: '错误',
  message: '操作失败',
);
```

## 自定义位置

```dart
VelocityNotification.show(
  title: '通知',
  message: '内容',
  position: VelocityNotificationPosition.topRight,
);
```

## API

### 方法

| 方法      | 参数                                                      | 说明         |
| --------- | --------------------------------------------------------- | ------------ |
| `show`    | `{String title, String message, Duration? duration}`      | 显示通知     |
| `success` | `{String title, String message, Duration? duration}`      | 显示成功通知 |
| `error`   | `{String title, String message, Duration? duration}`      | 显示错误通知 |
| `warning` | `{String title, String message, Duration? duration}`      | 显示警告通知 |
