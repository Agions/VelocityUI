# 主题配置

VelocityUI 提供灵活的主题系统，支持全局样式定制和暗色模式。

## 基础配置

### 使用预设主题

```dart
VelocityApp(
  theme: VelocityTheme.light(),      // 亮色主题
  darkTheme: VelocityTheme.dark(),   // 暗色主题
  child: const MyApp(),
)
```

### 自定义主题

```dart
VelocityApp(
  theme: VelocityTheme(
    // 主色调
    primaryColor: const Color(0xFF6366F1),

    // 语义色
    successColor: const Color(0xFF22C55E),
    warningColor: const Color(0xFFF59E0B),
    errorColor: const Color(0xFFEF4444),
    infoColor: const Color(0xFF3B82F6),

    // 背景色
    backgroundColor: Colors.white,
    surfaceColor: const Color(0xFFF8FAFC),

    // 文字色
    textPrimaryColor: const Color(0xFF1E293B),
    textSecondaryColor: const Color(0xFF64748B),

    // 边框
    borderColor: const Color(0xFFE2E8F0),
    borderRadius: BorderRadius.circular(8),

    // 字体
    fontFamily: 'Inter',
  ),
  child: const MyApp(),
)
```

## 主题属性

### 颜色系统

| 属性              | 类型    | 说明                         |
| ----------------- | ------- | ---------------------------- |
| `primaryColor`    | `Color` | 主色调，用于主要按钮、链接等 |
| `secondaryColor`  | `Color` | 次要色，用于次要操作         |
| `successColor`    | `Color` | 成功状态色                   |
| `warningColor`    | `Color` | 警告状态色                   |
| `errorColor`      | `Color` | 错误状态色                   |
| `infoColor`       | `Color` | 信息提示色                   |
| `backgroundColor` | `Color` | 页面背景色                   |
| `surfaceColor`    | `Color` | 卡片、面板背景色             |

### 文字样式

| 属性                 | 类型     | 说明         |
| -------------------- | -------- | ------------ |
| `fontFamily`         | `String` | 字体族       |
| `textPrimaryColor`   | `Color`  | 主要文字颜色 |
| `textSecondaryColor` | `Color`  | 次要文字颜色 |
| `textDisabledColor`  | `Color`  | 禁用文字颜色 |

### 间距与圆角

| 属性           | 类型              | 说明     |
| -------------- | ----------------- | -------- |
| `borderRadius` | `BorderRadius`    | 全局圆角 |
| `spacing`      | `VelocitySpacing` | 间距配置 |

## 暗色模式

### 自动切换

```dart
VelocityApp(
  theme: VelocityTheme.light(),
  darkTheme: VelocityTheme.dark(),
  themeMode: ThemeMode.system,  // 跟随系统
  child: const MyApp(),
)
```

### 手动切换

```dart
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return VelocityApp(
      theme: VelocityTheme.light(),
      darkTheme: VelocityTheme.dark(),
      themeMode: _themeMode,
      child: HomePage(onToggleTheme: _toggleTheme),
    );
  }
}
```

## 获取主题

在组件中获取当前主题：

```dart
@override
Widget build(BuildContext context) {
  final theme = VelocityTheme.of(context);

  return Container(
    color: theme.primaryColor,
    child: Text(
      'Hello',
      style: TextStyle(color: theme.textPrimaryColor),
    ),
  );
}
```

## 组件级样式

### 按钮样式

```dart
VelocityButton.primary(
  text: '自定义按钮',
  style: VelocityButtonStyle(
    backgroundColor: Colors.purple,
    foregroundColor: Colors.white,
    borderRadius: BorderRadius.circular(20),
    padding: const EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 12,
    ),
  ),
  onPressed: () {},
)
```

### 输入框样式

```dart
VelocityInput(
  label: '自定义输入框',
  style: VelocityInputStyle(
    borderColor: Colors.blue,
    focusBorderColor: Colors.blueAccent,
    borderRadius: BorderRadius.circular(12),
  ),
)
```

## 设计令牌

VelocityUI 使用设计令牌管理样式变量：

```dart
// 颜色令牌
VelocityColors.primary      // 主色
VelocityColors.gray50       // 灰色 50
VelocityColors.gray100      // 灰色 100
// ...

// 间距令牌
VelocitySpacing.xs          // 4px
VelocitySpacing.sm          // 8px
VelocitySpacing.md          // 16px
VelocitySpacing.lg          // 24px
VelocitySpacing.xl          // 32px

// 圆角令牌
VelocityRadius.sm           // 4px
VelocityRadius.md           // 8px
VelocityRadius.lg           // 12px
VelocityRadius.full         // 9999px
```

## 最佳实践

::: tip 推荐

- 在应用入口统一配置主题
- 使用设计令牌保持样式一致性
- 为暗色模式提供完整的颜色配置
  :::

::: warning 注意

- 避免在组件中硬编码颜色值
- 主题切换时确保所有组件正确响应
  :::

## 下一步

- [组件文档](/components/) - 查看组件样式定制
- [API 参考](/api/theme) - 完整主题 API
