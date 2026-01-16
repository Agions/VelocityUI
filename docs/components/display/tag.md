# Tag 标签

标签组件用于标记和分类。

## 基础用法

```dart
VelocityTag(
  text: '标签',
)
```

## 不同类型

```dart
VelocityTag(text: '默认', type: VelocityTagType.default_),
VelocityTag(text: '主要', type: VelocityTagType.primary),
VelocityTag(text: '成功', type: VelocityTagType.success),
VelocityTag(text: '警告', type: VelocityTagType.warning),
VelocityTag(text: '危险', type: VelocityTagType.danger),
```

## 可关闭

```dart
VelocityTag(
  text: '可关闭',
  closable: true,
  onClose: () {
    print('标签被关闭');
  },
)
```

## API

### 属性

| 属性       | 类型                | 默认值                    | 说明     |
| ---------- | ------------------- | ------------------------- | -------- |
| `text`     | `String`            | -                         | 文本     |
| `type`     | `VelocityTagType`   | `VelocityTagType.default_` | 类型     |
| `closable` | `bool`              | `false`                   | 可关闭   |
| `onClose`  | `VoidCallback?`     | -                         | 关闭回调 |
