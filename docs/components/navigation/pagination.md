# Pagination 分页

分页组件用于数据分页展示。

## 基础用法

```dart
VelocityPagination(
  total: 100,
  pageSize: 10,
  currentPage: 1,
  onPageChanged: (page) {
    print('切换到第$page页');
  },
)
```

## API

### 属性

| 属性            | 类型                   | 默认值 | 说明         |
| --------------- | ---------------------- | ------ | ------------ |
| `total`         | `int`                  | -      | 总条数       |
| `pageSize`      | `int`                  | `10`   | 每页条数     |
| `currentPage`   | `int`                  | `1`    | 当前页       |
| `onPageChanged` | `ValueChanged<int>?`   | -      | 页码变化回调 |
