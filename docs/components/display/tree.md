# Tree 树形控件

树形控件用于展示层级结构数据。

## 基础用法

```dart
VelocityTree(
  nodes: [
    TreeNode(
      title: '父节点1',
      children: [
        TreeNode(title: '子节点1-1'),
        TreeNode(title: '子节点1-2'),
      ],
    ),
  ],
)
```

## 可选择

```dart
VelocityTree(
  nodes: nodes,
  selectable: true,
  onSelect: (node) {
    print('选中: ${node.title}');
  },
)
```

## API

### 属性

| 属性         | 类型                      | 默认值  | 说明         |
| ------------ | ------------------------- | ------- | ------------ |
| `nodes`      | `List<TreeNode>`          | -       | 树节点列表   |
| `selectable` | `bool`                    | `false` | 可选择       |
| `onSelect`   | `ValueChanged<TreeNode>?` | -       | 选择回调     |
