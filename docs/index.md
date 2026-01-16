---
layout: home

hero:
  name: VelocityUI
  text: 企业级 Flutter UI 组件库
  tagline: 专为高性能应用打造 · 60+ 组件 · 完整设计系统 · 生产就绪
  image:
    src: /logo.png
    alt: VelocityUI
  actions:
    - theme: brand
      text: 快速开始 →
      link: /getting-started/
    - theme: alt
      text: 组件文档
      link: /components/
    - theme: alt
      text: API 参考
      link: /api/

features:
  - icon: ⚡
    title: 极致性能
    details: 基于 Flutter 3.x 构建，采用智能渲染优化、懒加载策略和高效内存管理，确保 60fps 流畅体验。
  - icon: 🎨
    title: 设计系统
    details: 遵循 Material Design 3 规范，提供完整的设计令牌、主题定制和暗色模式支持。
  - icon: 📱
    title: 全平台适配
    details: 一套代码，完美运行于 iOS、Android、Web、macOS、Windows 和 Linux。
  - icon: 🧩
    title: 丰富组件
    details: 60+ 生产级组件，涵盖表单、导航、数据展示、反馈等企业应用全场景。
  - icon: 🔒
    title: 类型安全
    details: 100% Dart 类型覆盖，完善的空安全支持，编译时错误检测。
  - icon: 📖
    title: 完整文档
    details: 详尽的 API 文档、使用示例和最佳实践指南，降低学习成本。
---

<div class="vp-doc">

## 快速开始

### 安装

```bash
flutter pub add velocity_ui
```

### 基础使用

```dart
import 'package:velocity_ui/velocity_ui.dart';

void main() {
  runApp(
    VelocityApp(
      theme: VelocityTheme.light(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: VelocityButton.primary(
          text: '开始使用',
          onPressed: () {},
        ),
      ),
    );
  }
}
```

## 核心特性

### 🎯 生产就绪

VelocityUI 已在多个企业级项目中验证，支持高并发、大数据量场景，提供稳定可靠的组件实现。

### 🔧 高度可定制

通过主题系统和组件属性，轻松实现品牌定制。支持设计令牌、CSS 变量式的主题配置。

```dart
VelocityApp(
  theme: VelocityTheme(
    primaryColor: const Color(0xFF6366F1),
    borderRadius: BorderRadius.circular(12),
    fontFamily: 'Inter',
  ),
  child: const MyApp(),
)
```

### 📦 按需引入

支持 Tree Shaking，只打包使用到的组件，最小化应用体积。

## 组件一览

| 分类         | 组件                                                                         | 数量 |
| ------------ | ---------------------------------------------------------------------------- | ---- |
| **基础组件** | Button, Text, Icon, Image, Chip, Link, Spinner                               | 7    |
| **表单组件** | Input, Select, Checkbox, Radio, Switch, Slider, DatePicker, Rate, Upload     | 9    |
| **展示组件** | Avatar, Badge, Card, Carousel, Collapse, Table, Tag, Timeline, Tooltip, Tree | 10   |
| **反馈组件** | Dialog, Toast, Notification, Progress, Skeleton, Loading                     | 6    |
| **导航组件** | Tabs, Menu, Breadcrumb, Pagination, Stepper, Drawer                          | 6    |

[查看全部组件 →](/components/)

## 版本信息

| 版本  | Flutter | Dart   | 状态   |
| ----- | ------- | ------ | ------ |
| 1.0.0 | ≥3.10.0 | ≥3.0.0 | 稳定版 |

## 社区

- [GitHub](https://github.com/Agions/velocity-ui) - 源码仓库
- [Issues](https://github.com/Agions/velocity-ui/issues) - 问题反馈
- [Discussions](https://github.com/Agions/velocity-ui/discussions) - 社区讨论

</div>
