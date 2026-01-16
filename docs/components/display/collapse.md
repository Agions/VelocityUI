# Collapse 折叠面板

折叠面板组件用于折叠/展开内容区域。

## 基础用法

```dart
VelocityCollapse(
  items: [
    CollapseItem(
      title: '标题1',
      content: Text('内容1'),
    ),
    CollapseItem(
      title: '标题2',
      content: Text('内容2'),
    ),
  ],
)
```

## 手风琴模式

```dart
VelocityCollapse(
  accordion: true,
  items: items,
)
```

## 默认展开

```dart
VelocityCollapse(
  defaultActiveKeys: ['1', '2'],
  items: items,
)
```

## API

### 属性

| 属性                 | 类型                    | 默认值  | 说明           |
| -------------------- | ----------------------- | ------- | -------------- |
| `items`              | `List<CollapseItem>`    | -       | 折叠项列表     |
| `accordion`          | `bool`                  | `false` | 手风琴模式     |
| `defaultActiveKeys`  | `List<String>?`         | -       | 默认展开的面板 |
| `onChange`           | `ValueChanged<List<String>>?` | -       | 切换回调       |
