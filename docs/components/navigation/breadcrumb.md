# Breadcrumb 面包屑

面包屑组件用于显示当前页面路径。

## 基础用法

```dart
VelocityBreadcrumb(
  items: [
    BreadcrumbItem(text: '首页', onTap: () {}),
    BreadcrumbItem(text: '列表', onTap: () {}),
    BreadcrumbItem(text: '详情'),
  ],
)
```

## API

### 属性

| 属性      | 类型                    | 默认值 | 说明           |
| --------- | ----------------------- | ------ | -------------- |
| `items`   | `List<BreadcrumbItem>` | -      | 面包屑项列表   |
| `separator` | `String`                | `'/'`  | 分隔符         |
