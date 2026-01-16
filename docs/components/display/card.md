# Card 卡片

卡片组件用于展示信息的容器，支持标题、内容和操作按钮。

<InteractivePreview
  component="VelocityCard"
  description="支持多种变体和自定义内容的卡片容器组件"
  preview-path="Display Examples > Card"
  :variants="[
    {
      name: 'Basic',
      code: `VelocityCard(
  title: '卡片标题',
  content: Text('这是卡片内容'),
)`
    },
    {
      name: 'With Subtitle',
      code: `VelocityCard(
  title: '卡片标题',
  subtitle: '这是副标题',
  content: Text('这是卡片内容'),
)`
    },
    {
      name: 'With Actions',
      code: `VelocityCard(
  title: '卡片标题',
  content: Text('这是卡片内容'),
  actions: [
    VelocityButton(
      text: '取消',
      type: VelocityButtonType.text,
      onPressed: () {},
    ),
    VelocityButton(
      text: '确定',
      type: VelocityButtonType.primary,
      onPressed: () {},
    ),
  ],
)`
    },
    {
      name: 'Outlined',
      code: `VelocityCard(
  title: '边框卡片',
  variant: VelocityCardVariant.outlined,
)`
    },
    {
      name: 'Clickable',
      code: `VelocityCard(
  title: '可点击卡片',
  content: Text('点击查看详情'),
  onTap: () {
    print('卡片被点击');
  },
)`
    }
  ]"
/>

## 基础用法

```dart
VelocityCard(
  title: '卡片标题',
  content: Text('这是卡片内容'),
)
```

## 带副标题

```dart
VelocityCard(
  title: '卡片标题',
  subtitle: '这是副标题',
  content: Text('这是卡片内容'),
)
```

## 带操作按钮

```dart
VelocityCard(
  title: '卡片标题',
  content: Text('这是卡片内容'),
  actions: [
    VelocityButton(
      text: '取消',
      type: VelocityButtonType.text,
      onPressed: () {},
    ),
    VelocityButton(
      text: '确定',
      type: VelocityButtonType.primary,
      onPressed: () {},
    ),
  ],
)
```

## 带封面图

```dart
VelocityCard(
  cover: Image.network(
    'https://example.com/image.jpg',
    fit: BoxFit.cover,
  ),
  title: '卡片标题',
  content: Text('这是卡片内容'),
)
```

## 带头像

```dart
VelocityCard(
  avatar: VelocityAvatar(
    image: NetworkImage('https://example.com/avatar.jpg'),
  ),
  title: '用户名',
  subtitle: '2024-01-01',
  content: Text('这是用户发布的内容'),
)
```

## 可点击卡片

```dart
VelocityCard(
  title: '可点击卡片',
  content: Text('点击查看详情'),
  onTap: () {
    print('卡片被点击');
  },
)
```

## 卡片变体

```dart
// 默认卡片
VelocityCard(
  title: '默认卡片',
  variant: VelocityCardVariant.elevated,
)

// 边框卡片
VelocityCard(
  title: '边框卡片',
  variant: VelocityCardVariant.outlined,
)

// 填充卡片
VelocityCard(
  title: '填充卡片',
  variant: VelocityCardVariant.filled,
)
```

## 自定义样式

```dart
VelocityCard(
  title: '自定义卡片',
  content: Text('自定义样式'),
  style: VelocityCardStyle(
    backgroundColor: Colors.blue.shade50,
    borderRadius: 16,
    padding: EdgeInsets.all(24),
    elevation: 4,
  ),
)
```

## 加载状态

```dart
VelocityCard(
  title: '加载中',
  loading: true,
)
```

## API

### 属性

| 属性       | 类型                  | 默认值     | 说明       |
| ---------- | --------------------- | ---------- | ---------- |
| `title`    | `String?`             | -          | 标题       |
| `subtitle` | `String?`             | -          | 副标题     |
| `content`  | `Widget?`             | -          | 内容       |
| `cover`    | `Widget?`             | -          | 封面图     |
| `avatar`   | `Widget?`             | -          | 头像       |
| `actions`  | `List<Widget>?`       | -          | 操作按钮   |
| `variant`  | `VelocityCardVariant` | `elevated` | 卡片变体   |
| `style`    | `VelocityCardStyle?`  | -          | 自定义样式 |
| `loading`  | `bool`                | `false`    | 加载状态   |
| `onTap`    | `VoidCallback?`       | -          | 点击回调   |

### VelocityCardVariant

| 值         | 说明           |
| ---------- | -------------- |
| `elevated` | 带阴影的卡片   |
| `outlined` | 带边框的卡片   |
| `filled`   | 填充背景的卡片 |

- 可点击卡片会获得焦点样式
