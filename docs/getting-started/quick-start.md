# 快速开始

本指南帮助你在 5 分钟内创建第一个 VelocityUI 应用。

## 创建项目

```bash
flutter create my_velocity_app
cd my_velocity_app
flutter pub add velocity_ui
```

## 基础配置

替换 `lib/main.dart` 内容：

```dart
import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return VelocityApp(
      title: 'My Velocity App',
      theme: VelocityTheme.light(),
      darkTheme: VelocityTheme.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VelocityUI Demo'),
      ),
      body: const Center(
        child: Text('Hello VelocityUI!'),
      ),
    );
  }
}
```

## 添加组件

### 按钮组件

```dart
VelocityButton.primary(
  text: '主要按钮',
  onPressed: () {
    print('Button clicked');
  },
)

VelocityButton.secondary(
  text: '次要按钮',
  onPressed: () {},
)

VelocityButton.outline(
  text: '边框按钮',
  icon: Icons.add,
  onPressed: () {},
)
```

### 输入框组件

```dart
VelocityInput(
  label: '用户名',
  placeholder: '请输入用户名',
  onChanged: (value) {
    print('Input: $value');
  },
)

VelocityInput.password(
  label: '密码',
  placeholder: '请输入密码',
)
```

### 卡片组件

```dart
VelocityCard(
  child: Column(
    children: [
      const Text('卡片标题'),
      const SizedBox(height: 8),
      const Text('卡片内容描述'),
      const SizedBox(height: 16),
      VelocityButton.primary(
        text: '操作',
        onPressed: () {},
      ),
    ],
  ),
)
```

## 完整示例

```dart
import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return VelocityApp(
      title: 'VelocityUI Demo',
      theme: VelocityTheme.light(),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _handleLogin() {
    setState(() => _isLoading = true);

    // 模拟登录请求
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isLoading = false);
      VelocityToast.success(context, message: '登录成功');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                '欢迎回来',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                '请登录您的账户',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              VelocityInput(
                controller: _usernameController,
                label: '用户名',
                placeholder: '请输入用户名',
                prefixIcon: Icons.person_outline,
              ),
              const SizedBox(height: 16),
              VelocityInput.password(
                controller: _passwordController,
                label: '密码',
                placeholder: '请输入密码',
              ),
              const SizedBox(height: 24),
              VelocityButton.primary(
                text: '登录',
                loading: _isLoading,
                fullWidth: true,
                onPressed: _handleLogin,
              ),
              const SizedBox(height: 16),
              VelocityButton.text(
                text: '忘记密码？',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
```

## 运行应用

```bash
flutter run
```

## 下一步

- [主题配置](/getting-started/configuration) - 自定义应用主题
- [组件文档](/components/) - 探索所有组件
- [API 参考](/api/) - 查看完整 API
