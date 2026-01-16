# Menu 菜单

菜单组件用于导航。

## 基础用法

```dart
VelocityMenu(
  items: [
    MenuItem(title: '首页', icon: Icons.home),
    MenuItem(title: '设置', icon: Icons.settings),
  ],
  onSelect: (item) {
    print('选中: ${item.title}');
  },
)
```

## API

### 属性

| 属性       | 类型                      | 默认值 | 说明       |
| ---------- | ------------------------- | ------ | ---------- |
| `items`    | `List<MenuItem>`          | -      | 菜单项列表 |
| `onSelect` | `ValueChanged<MenuItem>?` | -      | 选择回调   |
