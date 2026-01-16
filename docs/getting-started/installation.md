# 安装

本指南介绍如何将 VelocityUI 添加到 Flutter 项目中。

## 使用 pub 安装

### 方式一：命令行安装（推荐）

```bash
flutter pub add velocity_ui
```

### 方式二：手动添加依赖

在 `pubspec.yaml` 中添加：

```yaml
dependencies:
  velocity_ui: ^1.0.0
```

然后运行：

```bash
flutter pub get
```

## 验证安装

创建一个简单的测试文件验证安装是否成功：

```dart
import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

void main() {
  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return VelocityApp(
      theme: VelocityTheme.light(),
      child: Scaffold(
        body: Center(
          child: VelocityButton.primary(
            text: 'VelocityUI 安装成功！',
            onPressed: () {
              print('Button pressed');
            },
          ),
        ),
      ),
    );
  }
}
```

运行应用：

```bash
flutter run
```

如果看到按钮正常显示，说明安装成功。

## 可选依赖

根据需要安装额外功能：

### 图标包

```yaml
dependencies:
  velocity_icons: ^1.0.0 # 扩展图标库
```

### 动画库

```yaml
dependencies:
  velocity_animations: ^1.0.0 # 高级动画效果
```

## IDE 配置

### VS Code

安装 Flutter 和 Dart 插件后，VelocityUI 的代码补全和文档提示会自动生效。

### Android Studio / IntelliJ

确保已安装 Flutter 和 Dart 插件，重启 IDE 后即可使用。

## 常见问题

### 依赖冲突

如果遇到依赖版本冲突，尝试：

```bash
flutter pub upgrade --major-versions
```

### 构建失败

确保 Flutter SDK 版本满足最低要求：

```bash
flutter --version
# 需要 Flutter 3.10.0 或更高版本
```

如需升级 Flutter：

```bash
flutter upgrade
```

## 下一步

- [快速开始](/getting-started/quick-start) - 创建第一个 VelocityUI 应用
- [主题配置](/getting-started/configuration) - 自定义主题样式
