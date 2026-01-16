# VelocityUI

<div align="center">

![VelocityUI Logo](https://raw.githubusercontent.com/Agions/velocity-ui/main/assets/images/logo_python.svg)

**高性能企业级 Flutter UI 组件库**

![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-28A745?style=for-the-badge)
![Version](https://img.shields.io/badge/Version-1.0.4-FF6B6B?style=for-the-badge)

[![Stars](https://img.shields.io/github/stars/Agions/velocity-ui?style=for-the-badge&logo=github)](https://github.com/Agions/velocity-ui)
[![Issues](https://img.shields.io/github/issues/Agions/velocity-ui?style=for-the-badge&logo=github)](https://github.com/Agions/velocity-ui/issues)

**🚀 60+ 专业组件 • ⚡ 高性能 • 🎨 设计系统 • 📱 响应式 • ♿ 无障碍**

[📚 文档](https://agions.github.io/velocity-ui/) • [🚀 快速开始](#快速开始) • [💬 讨论](https://github.com/Agions/velocity-ui/discussions)

</div>

---

## ✨ 特性

- **60+ 专业组件** - 涵盖表单、导航、数据展示、反馈等全场景
- **设计系统** - 基于 Material Design 3，统一的设计语言
- **高性能** - 优化的渲染策略和内存管理
- **无障碍** - 符合 WCAG AA 标准
- **响应式** - 完美适配移动端、平板和桌面端
- **类型安全** - 完整的 Dart 类型支持

## 🚀 快速开始

### 安装

```yaml
dependencies:
  velocity_ui: ^1.0.4
```

### 使用

```dart
import 'package:velocity_ui/velocity_ui.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return VelocityApp(
      theme: VelocityTheme.light(),
      home: Scaffold(
        body: Center(
          child: VelocityButton(
            text: '开始使用',
            onPressed: () => print('Hello VelocityUI!'),
          ),
        ),
      ),
    );
  }
}
```

## 📚 文档

完整文档请访问：[https://agions.github.io/velocity-ui/](https://agions.github.io/velocity-ui/)

- [快速开始](https://agions.github.io/velocity-ui/getting-started/)
- [组件文档](https://agions.github.io/velocity-ui/components/)
- [API 参考](https://agions.github.io/velocity-ui/api/)
- [常见问题](https://agions.github.io/velocity-ui/faq)

## 🤝 贡献

欢迎贡献！请查看 [贡献指南](CONTRIBUTING.md) 了解详情。

## 📄 开源协议

本项目采用 [MIT 协议](LICENSE) 开源。

---

<div align="center">

**由 Agions 团队用 ❤️ 精心打造**

[![GitHub](https://img.shields.io/github/stars/Agions/velocity-ui?style=social)](https://github.com/Agions/velocity-ui)

</div>
