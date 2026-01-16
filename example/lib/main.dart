/// VelocityUI Example Application
///
/// This application demonstrates all VelocityUI components with
/// interactive examples and code snippets.
library velocity_ui_example;

import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

import 'pages/home_page.dart';

void main() {
  runApp(const VelocityUIExampleApp());
}

/// VelocityUI 示例应用
///
/// 展示所有 VelocityUI 组件的使用方法和最佳实践。
class VelocityUIExampleApp extends StatelessWidget {
  const VelocityUIExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return VelocityTheme(
      data: VelocityThemeData.light(),
      child: MaterialApp(
        title: 'VelocityUI Examples',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
