# 常见问题

## 安装相关

### 如何安装 VelocityUI？

```bash
flutter pub add velocity_ui
```

或在 `pubspec.yaml` 中添加：

```yaml
dependencies:
  velocity_ui: ^1.0.0
```

### 支持哪些 Flutter 版本？

VelocityUI 需要 Flutter 3.10.0 或更高版本。推荐使用最新稳定版。

### 支持哪些平台？

支持所有 Flutter 平台：iOS、Android、Web、macOS、Windows、Linux。

## 使用相关

### 如何配置主题？

```dart
VelocityApp(
  theme: VelocityTheme(
    primaryColor: Colors.blue,
    // 其他配置...
  ),
  child: const MyApp(),
)
```

详见 [主题配置](/getting-started/configuration)。

### 如何使用暗色模式？

```dart
VelocityApp(
  theme: VelocityTheme.light(),
  darkTheme: VelocityTheme.dark(),
  themeMode: ThemeMode.system,  // 跟随系统
  child: const MyApp(),
)
```

### 组件如何按需引入？

VelocityUI 支持 Tree Shaking，未使用的组件不会打包。也可以单独导入：

```dart
import 'package:velocity_ui/components/button.dart';
```

### 如何自定义组件样式？

每个组件都支持 `style` 属性：

```dart
VelocityButton.primary(
  text: '按钮',
  style: VelocityButtonStyle(
    backgroundColor: Colors.purple,
    borderRadius: BorderRadius.circular(20),
  ),
  onPressed: () {},
)
```

## 性能相关

### VelocityUI 性能如何？

VelocityUI 针对性能进行了优化：

- 智能重建：只重建必要的组件
- 懒加载：列表和图片支持懒加载
- 内存管理：自动释放不需要的资源
- Tree Shaking：只打包使用的代码

### 如何优化长列表性能？

使用 `VelocityList` 组件，内置虚拟滚动：

```dart
VelocityList.builder(
  itemCount: 10000,
  itemBuilder: (context, index) => ListTile(
    title: Text('Item $index'),
  ),
)
```

## 问题排查

### 组件样式不生效？

确保使用了 `VelocityApp` 作为根组件：

```dart
VelocityApp(
  theme: VelocityTheme.light(),
  child: const MyApp(),  // 你的应用
)
```

### 构建失败？

1. 检查 Flutter 版本：`flutter --version`
2. 清理缓存：`flutter clean && flutter pub get`
3. 升级依赖：`flutter pub upgrade`

### 热重载不生效？

尝试热重启：按 `R`（大写）或运行 `flutter run --hot`。

## 其他问题

### 如何贡献代码？

查看 [贡献指南](https://github.com/Agions/velocity-ui/blob/main/CONTRIBUTING.md)。

### 如何报告 Bug？

在 [GitHub Issues](https://github.com/Agions/velocity-ui/issues) 提交，请包含：

- Flutter 版本
- VelocityUI 版本
- 复现步骤
- 错误日志

### 有商业支持吗？

请联系 support@velocityui.dev 了解企业支持方案。
