# Link 链接

链接组件用于页面跳转或外部链接。

<InteractivePreview
  component="VelocityLink"
  description="支持内部跳转和外部链接的链接组件"
  preview-path="Basic Examples > Link"
  :variants="[
    {
      name: 'Basic',
      code: `VelocityLink(
  text: '点击跳转',
  onTap: () {
    // 处理跳转
  },
)`
    },
    {
      name: 'External',
      code: `VelocityLink(
  text: '访问官网',
  href: 'https://example.com',
  external: true,
)`
    },
    {
      name: 'With Icon',
      code: `VelocityLink(
  text: '下载文件',
  icon: Icons.download,
  onTap: () {},
)`
    }
  ]"
/>

## 基础用法

```dart
VelocityLink(
  text: '点击跳转',
  onTap: () {
    // 处理跳转
  },
)
```

## 外部链接

```dart
VelocityLink(
  text: '访问官网',
  href: 'https://example.com',
  external: true,
)
```

## 带图标

```dart
VelocityLink(
  text: '下载文件',
  icon: Icons.download,
  onTap: () {},
)
```

## API

| 属性       | 类型            | 默认值  | 说明         |
| ---------- | --------------- | ------- | ------------ |
| `text`     | `String`        | -       | 链接文本     |
| `href`     | `String?`       | -       | 链接地址     |
| `external` | `bool`          | `false` | 是否外部链接 |
| `icon`     | `IconData?`     | -       | 图标         |
| `onTap`    | `VoidCallback?` | -       | 点击回调     |
| `disabled` | `bool`          | `false` | 是否禁用     |
