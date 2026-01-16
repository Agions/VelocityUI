# 主题系统

VelocityUI 提供了完整的主题定制系统，支持颜色、排版、间距、圆角等配置。

## VelocityTheme

### 预设主题

```dart
// 亮色主题
VelocityApp(
  theme: VelocityTheme.light(),
  home: MyApp(),
)

// 暗色主题
VelocityApp(
  theme: VelocityTheme.dark(),
  home: MyApp(),
)

// 跟随系统
VelocityApp(
  theme: VelocityTheme.light(),
  darkTheme: VelocityTheme.dark(),
  themeMode: ThemeMode.system,
  home: MyApp(),
)
```

### 自定义主题

```dart
final customTheme = VelocityTheme.fromData(
  VelocityThemeData(
    primaryColor: Color(0xFF6366F1),
    secondaryColor: Color(0xFF8B5CF6),
    successColor: Color(0xFF22C55E),
    warningColor: Color(0xFFF59E0B),
    errorColor: Color(0xFFEF4444),
    backgroundColor: Color(0xFFF8FAFC),
    surfaceColor: Colors.white,
    textColor: Color(0xFF1E293B),
    borderRadius: 8.0,
    spacing: 16.0,
  ),
);
```

## VelocityColors

颜色系统提供语义化的颜色访问。

### 获取颜色

```dart
final colors = VelocityColors.of(context);

Container(
  color: colors.primary,
  child: Text(
    '文本',
    style: TextStyle(color: colors.onPrimary),
  ),
)
```

### 颜色属性

| 属性            | 说明               |
| --------------- | ------------------ |
| `primary`       | 主色               |
| `primaryLight`  | 主色浅色变体       |
| `primaryDark`   | 主色深色变体       |
| `primarySoft`   | 主色柔和变体       |
| `onPrimary`     | 主色上的文字颜色   |
| `secondary`     | 次要色             |
| `onSecondary`   | 次要色上的文字颜色 |
| `success`       | 成功色             |
| `onSuccess`     | 成功色上的文字颜色 |
| `warning`       | 警告色             |
| `onWarning`     | 警告色上的文字颜色 |
| `error`         | 错误色             |
| `onError`       | 错误色上的文字颜色 |
| `background`    | 背景色             |
| `onBackground`  | 背景色上的文字颜色 |
| `surface`       | 表面色             |
| `onSurface`     | 表面色上的文字颜色 |
| `border`        | 边框色             |
| `divider`       | 分割线色           |
| `disabled`      | 禁用色             |
| `text`          | 文字色             |
| `textSecondary` | 次要文字色         |
| `textHint`      | 提示文字色         |

## VelocityTypography

排版系统提供统一的文字样式。

### 获取排版

```dart
final typography = VelocityTypography.of(context);

Text('标题', style: typography.h1)
Text('正文', style: typography.body1)
```

### 排版属性

| 属性       | 说明       | 默认大小 |
| ---------- | ---------- | -------- |
| `h1`       | 一级标题   | 32px     |
| `h2`       | 二级标题   | 28px     |
| `h3`       | 三级标题   | 24px     |
| `h4`       | 四级标题   | 20px     |
| `h5`       | 五级标题   | 18px     |
| `h6`       | 六级标题   | 16px     |
| `body1`    | 正文       | 16px     |
| `body2`    | 正文小字   | 14px     |
| `caption`  | 说明文字   | 12px     |
| `overline` | 上划线文字 | 10px     |
| `button`   | 按钮文字   | 14px     |

### 自定义排版

```dart
final customTypography = VelocityTypographyData(
  fontFamily: 'PingFang SC',
  h1: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.2,
  ),
  body1: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
  ),
  // ...
);
```

## VelocitySpacing

间距系统提供统一的间距值。

### 获取间距

```dart
final spacing = VelocitySpacing.of(context);

Padding(
  padding: EdgeInsets.all(spacing.md),
  child: Column(
    children: [
      Widget1(),
      SizedBox(height: spacing.sm),
      Widget2(),
    ],
  ),
)
```

### 间距属性

| 属性  | 值   | 说明     |
| ----- | ---- | -------- |
| `xs`  | 4px  | 极小间距 |
| `sm`  | 8px  | 小间距   |
| `md`  | 16px | 中等间距 |
| `lg`  | 24px | 大间距   |
| `xl`  | 32px | 超大间距 |
| `xxl` | 48px | 极大间距 |

## VelocityRadius

圆角系统提供统一的圆角值。

### 获取圆角

```dart
final radius = VelocityRadius.of(context);

Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius.md),
  ),
)
```

### 圆角属性

| 属性   | 值     | 说明     |
| ------ | ------ | -------- |
| `none` | 0px    | 无圆角   |
| `sm`   | 4px    | 小圆角   |
| `md`   | 8px    | 中等圆角 |
| `lg`   | 12px   | 大圆角   |
| `xl`   | 16px   | 超大圆角 |
| `full` | 9999px | 完全圆角 |

## VelocityShadow

阴影系统提供统一的阴影效果。

### 获取阴影

```dart
final shadow = VelocityShadow.of(context);

Container(
  decoration: BoxDecoration(
    boxShadow: [shadow.md],
  ),
)
```

### 阴影属性

| 属性   | 说明     |
| ------ | -------- |
| `none` | 无阴影   |
| `sm`   | 小阴影   |
| `md`   | 中等阴影 |
| `lg`   | 大阴影   |
| `xl`   | 超大阴影 |

## VelocityDuration

动画时长系统。

### 获取时长

```dart
final duration = VelocityDuration.of(context);

AnimatedContainer(
  duration: duration.normal,
  // ...
)
```

### 时长属性

| 属性      | 值    | 说明 |
| --------- | ----- | ---- |
| `instant` | 0ms   | 即时 |
| `fast`    | 150ms | 快速 |
| `normal`  | 300ms | 正常 |
| `slow`    | 500ms | 慢速 |

## VelocityCurve

动画曲线系统。

### 获取曲线

```dart
final curve = VelocityCurve.of(context);

AnimatedContainer(
  curve: curve.easeInOut,
  // ...
)
```

### 曲线属性

| 属性        | 说明     |
| ----------- | -------- |
| `linear`    | 线性     |
| `easeIn`    | 缓入     |
| `easeOut`   | 缓出     |
| `easeInOut` | 缓入缓出 |
| `bounce`    | 弹跳     |

## 组件主题

### VelocityButtonTheme

```dart
VelocityButtonTheme(
  data: VelocityButtonThemeData(
    defaultSize: VelocitySize.medium,
    defaultType: VelocityButtonType.primary,
    borderRadius: 8.0,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  ),
  child: MyApp(),
)
```

### VelocityInputTheme

```dart
VelocityInputTheme(
  data: VelocityInputThemeData(
    borderRadius: 8.0,
    borderColor: Colors.grey.shade300,
    focusBorderColor: Colors.blue,
    errorBorderColor: Colors.red,
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  ),
  child: MyApp(),
)
```

### VelocityCardTheme

```dart
VelocityCardTheme(
  data: VelocityCardThemeData(
    borderRadius: 12.0,
    elevation: 2.0,
    padding: EdgeInsets.all(16),
  ),
  child: MyApp(),
)
```

## 完整示例

```dart
import 'package:velocity_ui/velocity_ui.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return VelocityApp(
      theme: VelocityTheme.fromData(
        VelocityThemeData(
          primaryColor: Color(0xFF6366F1),
          secondaryColor: Color(0xFF8B5CF6),
          borderRadius: 8.0,
        ),
      ),
      darkTheme: VelocityTheme.dark(),
      themeMode: ThemeMode.system,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = VelocityColors.of(context);
    final typography = VelocityTypography.of(context);
    final spacing = VelocitySpacing.of(context);
    final radius = VelocityRadius.of(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('标题', style: typography.h1),
            SizedBox(height: spacing.md),
            Container(
              padding: EdgeInsets.all(spacing.md),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(radius.md),
                border: Border.all(color: colors.border),
              ),
              child: Text('内容', style: typography.body1),
            ),
          ],
        ),
      ),
    );
  }
}
```
