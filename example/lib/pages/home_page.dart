/// VelocityUI Example Home Page
///
/// 主页面，展示所有组件分类和导航。
library;

import 'package:flutter/material.dart';

import 'basic/basic_examples_page.dart';
import 'display/display_examples_page.dart';
import 'feedback/feedback_examples_page.dart';
import 'form/form_examples_page.dart';
import 'layout/layout_examples_page.dart';
import 'navigation/navigation_examples_page.dart';
import 'interactive_preview_demo.dart';

/// 组件分类
class ComponentCategory {
  const ComponentCategory({
    required this.title,
    required this.description,
    required this.icon,
    required this.page,
  });

  final String title;
  final String description;
  final IconData icon;
  final Widget page;
}

/// 主页面
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const List<ComponentCategory> categories = [
    ComponentCategory(
      title: 'Interactive Preview',
      description: '交互式组件预览：实时修改属性，查看组件变化',
      icon: Icons.preview_outlined,
      page: InteractivePreviewDemoPage(),
    ),
    ComponentCategory(
      title: 'Basic',
      description: '基础组件：Button, Text, Icon, Image, Link, Chip, Spinner',
      icon: Icons.widgets_outlined,
      page: BasicExamplesPage(),
    ),
    ComponentCategory(
      title: 'Form',
      description: '表单组件：Input, Select, Checkbox, Radio, Switch, Slider',
      icon: Icons.edit_note_outlined,
      page: FormExamplesPage(),
    ),
    ComponentCategory(
      title: 'Display',
      description: '展示组件：Card, Avatar, Badge, Tag, Tooltip, Table',
      icon: Icons.view_agenda_outlined,
      page: DisplayExamplesPage(),
    ),
    ComponentCategory(
      title: 'Feedback',
      description: '反馈组件：Dialog, Toast, Loading, Progress, Skeleton',
      icon: Icons.feedback_outlined,
      page: FeedbackExamplesPage(),
    ),
    ComponentCategory(
      title: 'Navigation',
      description: '导航组件：Navbar, Tabs, Menu, Breadcrumb, Pagination',
      icon: Icons.navigation_outlined,
      page: NavigationExamplesPage(),
    ),
    ComponentCategory(
      title: 'Layout',
      description: '布局组件：Container, Grid, Space, Divider, Stack',
      icon: Icons.dashboard_outlined,
      page: LayoutExamplesPage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VelocityUI Examples'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Icon(category.icon, size: 32, color: Colors.blue),
              title: Text(
                category.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                category.description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => category.page),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
