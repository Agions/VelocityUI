/// Navigation Components Examples Page
///
/// 展示所有导航组件的使用示例。
library;

import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 导航组件示例页面
class NavigationExamplesPage extends StatefulWidget {
  const NavigationExamplesPage({super.key});

  @override
  State<NavigationExamplesPage> createState() => _NavigationExamplesPageState();
}

class _NavigationExamplesPageState extends State<NavigationExamplesPage> {
  int _currentPage = 1;
  int _selectedSegment = 0;
  int _currentStep = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Components'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Tabs 示例
          _buildSection(
            title: 'Tabs',
            description: '标签页组件，用于内容切换',
            child: SizedBox(
              height: 200,
              child: VelocityTabs(
                tabs: const ['Tab 1', 'Tab 2', 'Tab 3'],
                children: const [
                  Center(child: Text('Content 1')),
                  Center(child: Text('Content 2')),
                  Center(child: Text('Content 3')),
                ],
                onChanged: (index) {
                  debugPrint('Tab changed to: $index');
                },
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Breadcrumb 示例
          _buildSection(
            title: 'Breadcrumb',
            description: '面包屑组件，用于展示页面路径',
            child: VelocityBreadcrumb(
              items: const [
                VelocityBreadcrumbItem(label: 'Home', icon: Icons.home),
                VelocityBreadcrumbItem(label: 'Products'),
                VelocityBreadcrumbItem(label: 'Electronics'),
                VelocityBreadcrumbItem(label: 'Phones'),
              ],
              onItemTap: (index) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Tapped item $index')),
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          // Pagination 示例
          _buildSection(
            title: 'Pagination',
            description: '分页组件，用于数据分页',
            child: Column(
              children: [
                VelocityPagination(
                  current: _currentPage,
                  total: 100,
                  pageSize: 10,
                  onPageChanged: (page) {
                    setState(() => _currentPage = page);
                  },
                ),
                const SizedBox(height: 16),
                Text('Current page: $_currentPage'),
                const SizedBox(height: 16),
                // 简单分页
                const Text('Simple Pagination:'),
                const SizedBox(height: 8),
                VelocityPagination(
                  current: _currentPage,
                  total: 100,
                  pageSize: 10,
                  simple: true,
                  onPageChanged: (page) {
                    setState(() => _currentPage = page);
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Segmented 示例
          _buildSection(
            title: 'Segmented Control',
            description: '分段控制器组件',
            child: Column(
              children: [
                VelocitySegmented<int>(
                  segments: const [
                    VelocitySegment(value: 0, label: 'Day'),
                    VelocitySegment(value: 1, label: 'Week'),
                    VelocitySegment(value: 2, label: 'Month'),
                  ],
                  value: _selectedSegment,
                  onChanged: (value) {
                    setState(() => _selectedSegment = value);
                  },
                ),
                const SizedBox(height: 12),
                Text('Selected: ${['Day', 'Week', 'Month'][_selectedSegment]}'),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Stepper 示例
          _buildSection(
            title: 'Stepper',
            description: '步骤条组件，用于展示流程进度',
            child: Column(
              children: [
                VelocityStepper(
                  currentStep: _currentStep,
                  steps: const [
                    VelocityStep(title: 'Step 1', subtitle: 'Description'),
                    VelocityStep(title: 'Step 2', subtitle: 'Description'),
                    VelocityStep(title: 'Step 3', subtitle: 'Description'),
                  ],
                  onStepTap: (index) {
                    setState(() => _currentStep = index);
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    VelocityButton.text(
                      text: 'Previous',
                      type: VelocityButtonType.outline,
                      disabled: _currentStep == 0,
                      onPressed: () {
                        if (_currentStep > 0) {
                          setState(() => _currentStep--);
                        }
                      },
                    ),
                    const SizedBox(width: 16),
                    VelocityButton.text(
                      text: 'Next',
                      disabled: _currentStep == 2,
                      onPressed: () {
                        if (_currentStep < 2) {
                          setState(() => _currentStep++);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Menu 示例
          _buildSection(
            title: 'Menu',
            description: '菜单组件，用于导航和操作',
            child: VelocityMenu(
              items: [
                const VelocityMenuItem(
                  icon: Icons.home,
                  label: 'Home',
                  value: 'home',
                ),
                const VelocityMenuItem(
                  icon: Icons.settings,
                  label: 'Settings',
                  value: 'settings',
                ),
                const VelocityMenuItem(
                  icon: Icons.person,
                  label: 'Profile',
                  value: 'profile',
                ),
                const VelocityMenuItem.divider(),
                const VelocityMenuItem(
                  icon: Icons.logout,
                  label: 'Logout',
                  value: 'logout',
                ),
              ],
              onSelected: (value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Selected: $value')),
                );
              },
              child: VelocityButton.text(
                text: 'Open Menu',
                onPressed: () {},
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Bottom Sheet 示例
          _buildSection(
            title: 'Bottom Sheet',
            description: '底部弹出组件',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                VelocityButton.text(
                  text: 'Show Bottom Sheet',
                  onPressed: () {
                    VelocityBottomSheet.show(
                      context: context,
                      title: 'Bottom Sheet',
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('This is a bottom sheet content.'),
                          const SizedBox(height: 24),
                          VelocityButton.text(
                            text: 'Close',
                            fullWidth: true,
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                VelocityButton.text(
                  text: 'Show Actions',
                  type: VelocityButtonType.outline,
                  onPressed: () {
                    VelocityBottomSheet.showActions(
                      context: context,
                      title: 'Choose an action',
                      cancelText: 'Cancel',
                      actions: [
                        const VelocityBottomSheetAction(
                          label: 'Share',
                          icon: Icons.share,
                          value: 'share',
                        ),
                        const VelocityBottomSheetAction(
                          label: 'Copy Link',
                          icon: Icons.link,
                          value: 'copy',
                        ),
                        const VelocityBottomSheetAction(
                          label: 'Delete',
                          icon: Icons.delete,
                          value: 'delete',
                          isDestructive: true,
                        ),
                      ],
                    ).then((value) {
                      if (value != null && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Selected: $value')),
                        );
                      }
                    });
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Drawer 示例
          _buildSection(
            title: 'Drawer',
            description: '抽屉组件，用于侧边导航',
            child: VelocityButton.text(
              text: 'Open Drawer',
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ],
      ),
      drawer: VelocityDrawer(
        header: Container(
          padding: const EdgeInsets.all(16),
          color: Colors.blue,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                child: Icon(Icons.person, size: 30),
              ),
              SizedBox(height: 12),
              Text(
                'VelocityUI',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Flutter UI Library',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        items: [
          VelocityDrawerItem(
            icon: Icons.home,
            label: 'Home',
            onTap: () => Navigator.pop(context),
          ),
          VelocityDrawerItem(
            icon: Icons.settings,
            label: 'Settings',
            onTap: () => Navigator.pop(context),
          ),
          const VelocityDrawerItem.divider(),
          VelocityDrawerItem(
            icon: Icons.help,
            label: 'Help',
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String description,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 16),
        child,
      ],
    );
  }
}
