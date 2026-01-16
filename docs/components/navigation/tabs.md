# Tabs 标签页

标签页组件用于内容分类展示。

## 基础用法

```dart
VelocityTabs(
  tabs: [
    Tab(text: '标签1'),
    Tab(text: '标签2'),
    Tab(text: '标签3'),
  ],
  children: [
    Center(child: Text('内容1')),
    Center(child: Text('内容2')),
    Center(child: Text('内容3')),
  ],
)
```

## API

### 属性

| 属性       | 类型           | 默认值 | 说明       |
| ---------- | -------------- | ------ | ---------- |
| `tabs`     | `List<Tab>`    | -      | 标签列表   |
| `children` | `List<Widget>` | -      | 内容列表   |
| `onChanged` | `ValueChanged<int>?` | -      | 切换回调   |
