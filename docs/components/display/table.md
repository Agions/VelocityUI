# Table 表格

表格组件用于展示结构化数据。

## 基础用法

```dart
VelocityTable(
  columns: [
    TableColumn(title: '姓名', dataIndex: 'name'),
    TableColumn(title: '年龄', dataIndex: 'age'),
    TableColumn(title: '地址', dataIndex: 'address'),
  ],
  dataSource: [
    {'name': '张三', 'age': 28, 'address': '北京'},
    {'name': '李四', 'age': 32, 'address': '上海'},
  ],
)
```

## 可排序

```dart
VelocityTable(
  columns: [
    TableColumn(
      title: '年龄',
      dataIndex: 'age',
      sortable: true,
    ),
  ],
  dataSource: data,
)
```

## 可选择

```dart
VelocityTable(
  columns: columns,
  dataSource: data,
  selectable: true,
  onSelectionChanged: (selectedRows) {
    print('选中: $selectedRows');
  },
)
```

## API

### 属性

| 属性                 | 类型                              | 默认值  | 说明         |
| -------------------- | --------------------------------- | ------- | ------------ |
| `columns`            | `List<TableColumn>`               | -       | 列配置       |
| `dataSource`         | `List<Map<String, dynamic>>`      | -       | 数据源       |
| `selectable`         | `bool`                            | `false` | 可选择       |
| `loading`            | `bool`                            | `false` | 加载状态     |
| `onSelectionChanged` | `ValueChanged<List<int>>?`        | -       | 选择变化回调 |
