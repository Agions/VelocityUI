# Select 选择器

选择器组件用于从预设选项中选择一个或多个值。

<InteractivePreview
  component="VelocitySelect"
  description="支持单选、多选、搜索和远程加载的选择器组件"
  preview-path="Form Examples > Select"
  :variants="[
    {
      name: 'Basic',
      code: `VelocitySelect(
  label: '城市',
  options: ['北京', '上海', '广州', '深圳'],
  onChanged: (value) {
    print('选择了: \$value');
  },
)`
    },
    {
      name: 'Multiple',
      code: `VelocitySelect.multiple(
  label: '兴趣爱好',
  options: ['阅读', '运动', '音乐', '旅行'],
  value: ['阅读', '音乐'],
  onChanged: (values) {},
)`
    },
    {
      name: 'Searchable',
      code: `VelocitySelect(
  label: '城市',
  options: allCities,
  searchable: true,
  searchPlaceholder: '搜索城市...',
  onChanged: (value) {},
)`
    },
    {
      name: 'Grouped',
      code: `VelocitySelect(
  label: '城市',
  groups: [
    SelectGroup(label: '华北', options: ['北京', '天津']),
    SelectGroup(label: '华东', options: ['上海', '杭州']),
  ],
  onChanged: (value) {},
)`
    },
    {
      name: 'Clearable',
      code: `VelocitySelect(
  label: '城市',
  options: ['北京', '上海', '广州'],
  clearable: true,
  onChanged: (value) {},
)`
    }
  ]"
/>

## 基础用法

```dart
VelocitySelect(
  label: '城市',
  options: ['北京', '上海', '广州', '深圳'],
  onChanged: (value) {
    print('选择了: $value');
  },
)
```

## 带对象选项

```dart
VelocitySelect<City>(
  label: '城市',
  options: cities,
  labelBuilder: (city) => city.name,
  valueBuilder: (city) => city.id,
  onChanged: (city) {
    print('选择了: ${city?.name}');
  },
)
```

## 多选模式

```dart
VelocitySelect.multiple(
  label: '兴趣爱好',
  options: ['阅读', '运动', '音乐', '旅行', '美食'],
  value: ['阅读', '音乐'],
  onChanged: (values) {
    print('选择了: $values');
  },
)
```

## 可搜索

```dart
VelocitySelect(
  label: '城市',
  options: allCities,
  searchable: true,
  searchPlaceholder: '搜索城市...',
  onChanged: (value) {},
)
```

## 分组选项

```dart
VelocitySelect(
  label: '城市',
  groups: [
    SelectGroup(
      label: '华北',
      options: ['北京', '天津', '石家庄'],
    ),
    SelectGroup(
      label: '华东',
      options: ['上海', '杭州', '南京'],
    ),
    SelectGroup(
      label: '华南',
      options: ['广州', '深圳', '珠海'],
    ),
  ],
  onChanged: (value) {},
)
```

## 远程搜索

```dart
VelocitySelect(
  label: '用户',
  remote: true,
  onSearch: (keyword) async {
    final users = await api.searchUsers(keyword);
    return users.map((u) => SelectOption(
      label: u.name,
      value: u.id,
    )).toList();
  },
  onChanged: (value) {},
)
```

## 状态

```dart
// 禁用状态
VelocitySelect(
  label: '城市',
  options: ['北京', '上海'],
  disabled: true,
)

// 加载状态
VelocitySelect(
  label: '城市',
  options: [],
  loading: true,
)

// 错误状态
VelocitySelect(
  label: '城市',
  options: ['北京', '上海'],
  error: '请选择城市',
)
```

## 清除按钮

```dart
VelocitySelect(
  label: '城市',
  options: ['北京', '上海', '广州'],
  clearable: true,
  onChanged: (value) {},
)
```

## 自定义渲染

```dart
VelocitySelect<User>(
  label: '用户',
  options: users,
  optionBuilder: (user, isSelected) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.avatar),
      ),
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: isSelected ? Icon(Icons.check) : null,
    );
  },
  selectedBuilder: (user) {
    return Row(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundImage: NetworkImage(user.avatar),
        ),
        SizedBox(width: 8),
        Text(user.name),
      ],
    );
  },
  onChanged: (user) {},
)
```

## API

### 属性

| 属性                | 类型                                           | 默认值   | 说明         |
| ------------------- | ---------------------------------------------- | -------- | ------------ |
| `label`             | `String?`                                      | -        | 标签文本     |
| `placeholder`       | `String?`                                      | -        | 占位文本     |
| `options`           | `List<T>`                                      | `[]`     | 选项列表     |
| `groups`            | `List<SelectGroup<T>>?`                        | -        | 分组选项     |
| `value`             | `T?`                                           | -        | 当前值       |
| `labelBuilder`      | `String Function(T)?`                          | -        | 标签构建器   |
| `valueBuilder`      | `dynamic Function(T)?`                         | -        | 值构建器     |
| `optionBuilder`     | `Widget Function(T, bool)?`                    | -        | 选项渲染器   |
| `selectedBuilder`   | `Widget Function(T)?`                          | -        | 已选渲染器   |
| `searchable`        | `bool`                                         | `false`  | 是否可搜索   |
| `searchPlaceholder` | `String?`                                      | -        | 搜索占位符   |
| `remote`            | `bool`                                         | `false`  | 是否远程搜索 |
| `onSearch`          | `Future<List<SelectOption>> Function(String)?` | -        | 搜索回调     |
| `clearable`         | `bool`                                         | `false`  | 是否可清除   |
| `disabled`          | `bool`                                         | `false`  | 禁用状态     |
| `loading`           | `bool`                                         | `false`  | 加载状态     |
| `error`             | `String?`                                      | -        | 错误信息     |
| `size`              | `VelocitySize`                                 | `medium` | 尺寸         |
| `onChanged`         | `ValueChanged<T?>?`                            | -        | 值变化回调   |

### SelectGroup

| 属性      | 类型      | 说明     |
| --------- | --------- | -------- |
| `label`   | `String`  | 分组标签 |
| `options` | `List<T>` | 分组选项 |

- 支持 `aria-expanded` 和 `aria-selected` 属性
