# Avatar 头像

头像组件用于展示用户或实体的图片。

## 基础用法

```dart
VelocityAvatar(
  image: NetworkImage('https://example.com/avatar.jpg'),
)
```

## 不同尺寸

```dart
// 小尺寸
VelocityAvatar(
  size: VelocityAvatarSize.small,
  image: NetworkImage('https://example.com/avatar.jpg'),
)

// 中等尺寸（默认）
VelocityAvatar(
  size: VelocityAvatarSize.medium,
  image: NetworkImage('https://example.com/avatar.jpg'),
)

// 大尺寸
VelocityAvatar(
  size: VelocityAvatarSize.large,
  image: NetworkImage('https://example.com/avatar.jpg'),
)

// 自定义尺寸
VelocityAvatar(
  radius: 50,
  image: NetworkImage('https://example.com/avatar.jpg'),
)
```

## 文字头像

```dart
VelocityAvatar(
  text: '张三',
)

VelocityAvatar(
  text: 'John Doe',
)
```

## 图标头像

```dart
VelocityAvatar(
  icon: Icons.person,
)
```

## 不同形状

```dart
// 圆形（默认）
VelocityAvatar(
  shape: VelocityAvatarShape.circle,
  image: NetworkImage('https://example.com/avatar.jpg'),
)

// 方形
VelocityAvatar(
  shape: VelocityAvatarShape.square,
  image: NetworkImage('https://example.com/avatar.jpg'),
)
```

## 带徽章

```dart
VelocityAvatar(
  image: NetworkImage('https://example.com/avatar.jpg'),
  badge: VelocityBadge(
    count: 5,
  ),
)
```

## 头像组

```dart
VelocityAvatarGroup(
  avatars: [
    VelocityAvatar(image: NetworkImage('https://example.com/avatar1.jpg')),
    VelocityAvatar(image: NetworkImage('https://example.com/avatar2.jpg')),
    VelocityAvatar(image: NetworkImage('https://example.com/avatar3.jpg')),
  ],
  maxCount: 3,
  moreText: '+2',
)
```

## 可点击头像

```dart
VelocityAvatar(
  image: NetworkImage('https://example.com/avatar.jpg'),
  onTap: () {
    print('头像被点击');
  },
)
```

## 自定义背景色

```dart
VelocityAvatar(
  text: 'AB',
  backgroundColor: Colors.blue,
  textColor: Colors.white,
)
```

## API

### 属性

| 属性              | 类型                  | 默认值                       | 说明       |
| ----------------- | --------------------- | ---------------------------- | ---------- |
| `image`           | `ImageProvider?`      | -                            | 头像图片   |
| `text`            | `String?`             | -                            | 文字头像   |
| `icon`            | `IconData?`           | -                            | 图标头像   |
| `size`            | `VelocityAvatarSize`  | `VelocityAvatarSize.medium`  | 预设尺寸   |
| `radius`          | `double?`             | -                            | 自定义半径 |
| `shape`           | `VelocityAvatarShape` | `VelocityAvatarShape.circle` | 形状       |
| `backgroundColor` | `Color?`              | -                            | 背景颜色   |
| `textColor`       | `Color?`              | -                            | 文字颜色   |
| `badge`           | `Widget?`             | -                            | 徽章       |
| `onTap`           | `VoidCallback?`       | -                            | 点击回调   |

### VelocityAvatarSize

| 值       | 半径 | 说明     |
| -------- | ---- | -------- |
| `small`  | 16   | 小尺寸   |
| `medium` | 24   | 中等尺寸 |
| `large`  | 32   | 大尺寸   |

### VelocityAvatarShape

| 值       | 说明 |
| -------- | ---- |
| `circle` | 圆形 |
| `square` | 方形 |
