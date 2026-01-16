/// Feedback Components Examples Page
///
/// 展示所有反馈组件的使用示例，包括：
/// - Dialog: 对话框组件
/// - Toast: 轻提示组件
/// - Loading: 加载组件
/// - Progress: 进度条组件
/// - Skeleton: 骨架屏组件
/// - Result: 结果组件
/// - Popconfirm: 气泡确认框组件
/// - ActionSheet: 动作面板组件
/// - Notification: 通知组件
/// - Popover: 气泡卡片组件
library;

import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 反馈组件示例页面
class FeedbackExamplesPage extends StatelessWidget {
  const FeedbackExamplesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback Components'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Dialog 示例
          _buildDialogSection(context),
          const SizedBox(height: 24),

          // Toast 示例
          _buildToastSection(context),
          const SizedBox(height: 24),

          // Loading 示例
          _buildLoadingSection(),
          const SizedBox(height: 24),

          // Progress 示例
          _buildProgressSection(),
          const SizedBox(height: 24),

          // Skeleton 示例
          _buildSkeletonSection(),
          const SizedBox(height: 24),

          // Result 示例
          _buildResultSection(),
          const SizedBox(height: 24),

          // Popconfirm 示例
          _buildPopconfirmSection(context),
          const SizedBox(height: 24),

          // ActionSheet 示例
          _buildActionSheetSection(context),
          const SizedBox(height: 24),

          // Notification 示例
          _buildNotificationSection(context),
          const SizedBox(height: 24),

          // Popover 示例
          _buildPopoverSection(),
        ],
      ),
    );
  }

  /// Dialog 对话框组件示例
  Widget _buildDialogSection(BuildContext context) {
    return _buildSection(
      title: 'Dialog',
      description: '对话框组件，用于重要信息确认',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          // Alert 对话框
          VelocityButton.text(
            text: 'Alert Dialog',
            onPressed: () {
              VelocityDialog.alert(
                context,
                title: 'Alert',
                content: 'This is an alert dialog.',
              );
            },
          ),
          // Confirm 对话框
          VelocityButton.text(
            text: 'Confirm Dialog',
            type: VelocityButtonType.outline,
            onPressed: () async {
              final result = await VelocityDialog.confirm(
                context,
                title: 'Confirm',
                content: 'Are you sure you want to proceed?',
              );
              if (context.mounted && (result ?? false)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Confirmed!')),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  /// Toast 轻提示组件示例
  Widget _buildToastSection(BuildContext context) {
    return _buildSection(
      title: 'Toast',
      description: '轻提示组件，用于操作反馈，支持多种类型',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          // Success Toast
          VelocityButton.text(
            text: 'Success Toast',
            type: VelocityButtonType.success,
            onPressed: () {
              VelocityToast.show(
                context,
                message: 'Operation successful!',
                type: VelocityToastType.success,
              );
            },
          ),
          // Error Toast
          VelocityButton.text(
            text: 'Error Toast',
            type: VelocityButtonType.danger,
            onPressed: () {
              VelocityToast.show(
                context,
                message: 'Something went wrong!',
                type: VelocityToastType.error,
              );
            },
          ),
          // Warning Toast
          VelocityButton.text(
            text: 'Warning Toast',
            type: VelocityButtonType.warning,
            onPressed: () {
              VelocityToast.show(
                context,
                message: 'Please check your input.',
                type: VelocityToastType.warning,
              );
            },
          ),
          // Info Toast
          VelocityButton.text(
            text: 'Info Toast',
            type: VelocityButtonType.outline,
            onPressed: () {
              VelocityToast.show(
                context,
                message: 'Here is some information.',
                type: VelocityToastType.info,
              );
            },
          ),
        ],
      ),
    );
  }

  /// Loading 加载组件示例
  Widget _buildLoadingSection() {
    return _buildSection(
      title: 'Loading',
      description: '加载组件，用于异步操作等待，支持圆形和线性样式',
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 内联加载指示器 - 不同尺寸
          Text('Inline Loading Indicators:',
              style: TextStyle(fontWeight: FontWeight.w500)),
          SizedBox(height: 12),
          Row(
            children: [
              VelocityLoading(size: 24),
              SizedBox(width: 16),
              VelocityLoading(size: 32),
              SizedBox(width: 16),
              VelocityLoading(size: 48),
            ],
          ),
          SizedBox(height: 16),
          // 线性加载指示器
          Text('Linear Loading:',
              style: TextStyle(fontWeight: FontWeight.w500)),
          SizedBox(height: 8),
          VelocityLoading(
            type: VelocityLoadingType.linear,
          ),
          SizedBox(height: 16),
          // 带进度的加载
          Text('With Progress (60%):',
              style: TextStyle(fontWeight: FontWeight.w500)),
          SizedBox(height: 8),
          VelocityLoading(
            type: VelocityLoadingType.linear,
            value: 0.6,
          ),
        ],
      ),
    );
  }

  /// Progress 进度条组件示例
  Widget _buildProgressSection() {
    return _buildSection(
      title: 'Progress',
      description: '进度条组件，支持线性和圆形样式',
      child: const Column(
        children: [
          // 线性进度条 - 不同进度
          VelocityProgress(
            value: 0.3,
            showLabel: true,
            label: 'Downloading',
          ),
          SizedBox(height: 12),
          VelocityProgress(
            value: 0.6,
            showLabel: true,
          ),
          SizedBox(height: 12),
          VelocityProgress(
            value: 0.9,
            showLabel: true,
          ),
          SizedBox(height: 16),
          // 圆形进度条
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              VelocityProgress(
                value: 0.25,
                type: VelocityProgressType.circular,
                showLabel: true,
              ),
              VelocityProgress(
                value: 0.5,
                type: VelocityProgressType.circular,
                showLabel: true,
              ),
              VelocityProgress(
                value: 0.75,
                type: VelocityProgressType.circular,
                showLabel: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Skeleton 骨架屏组件示例
  Widget _buildSkeletonSection() {
    return _buildSection(
      title: 'Skeleton',
      description: '骨架屏组件，用于加载占位',
      child: const Column(
        children: [
          // 基础骨架屏 - 模拟用户卡片
          Row(
            children: [
              VelocitySkeleton(height: 48, width: 48, circle: true),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VelocitySkeleton(width: 120, height: 16),
                    SizedBox(height: 8),
                    VelocitySkeleton(width: 200, height: 12),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          // 内容骨架屏
          VelocitySkeleton(height: 100),
          SizedBox(height: 16),
          // 列表骨架屏
          Text('List Skeleton:', style: TextStyle(fontWeight: FontWeight.w500)),
          SizedBox(height: 8),
          VelocityListSkeleton(itemCount: 2),
        ],
      ),
    );
  }

  /// Result 结果组件示例
  Widget _buildResultSection() {
    return _buildSection(
      title: 'Result',
      description: '结果组件，用于展示操作结果，支持多种状态',
      child: const Column(
        children: [
          VelocityResult(
            type: VelocityResultType.success,
            title: 'Success',
            subtitle: 'Your operation has been completed successfully.',
          ),
          SizedBox(height: 24),
          VelocityResult(
            type: VelocityResultType.error,
            title: 'Error',
            subtitle: 'Something went wrong. Please try again.',
          ),
          SizedBox(height: 24),
          VelocityResult(
            type: VelocityResultType.warning,
            title: 'Warning',
            subtitle: 'Please review your input before proceeding.',
          ),
          SizedBox(height: 24),
          VelocityResult(
            type: VelocityResultType.info,
            title: 'Info',
            subtitle: 'Here is some important information.',
          ),
        ],
      ),
    );
  }

  /// Popconfirm 气泡确认框组件示例
  Widget _buildPopconfirmSection(BuildContext context) {
    return _buildSection(
      title: 'Popconfirm',
      description: '气泡确认框组件，用于二次确认操作',
      child: VelocityPopconfirm(
        title: 'Are you sure?',
        content: 'This action cannot be undone.',
        onConfirm: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Confirmed!')),
          );
        },
        child: VelocityButton.text(
          text: 'Delete',
          type: VelocityButtonType.danger,
          onPressed: () {},
        ),
      ),
    );
  }

  /// ActionSheet 动作面板组件示例
  Widget _buildActionSheetSection(BuildContext context) {
    return _buildSection(
      title: 'ActionSheet',
      description: '动作面板组件，从底部弹出的操作菜单',
      child: VelocityButton.text(
        text: 'Show ActionSheet',
        onPressed: () async {
          final result = await VelocityActionSheet.show<String>(
            context: context,
            title: 'Select an action',
            message: 'Choose one of the following options',
            actions: [
              const VelocityActionSheetItem(
                label: 'Share',
                value: 'share',
              ),
              const VelocityActionSheetItem(
                label: 'Copy Link',
                value: 'copy',
              ),
              const VelocityActionSheetItem(
                label: 'Delete',
                value: 'delete',
                isDestructive: true, // 危险操作样式
              ),
            ],
            cancelAction: const VelocityActionSheetItem(
              label: 'Cancel',
              value: 'cancel',
            ),
          );
          if (context.mounted && result != null && result != 'cancel') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Selected: $result')),
            );
          }
        },
      ),
    );
  }

  /// Notification 通知组件示例
  Widget _buildNotificationSection(BuildContext context) {
    return _buildSection(
      title: 'Notification',
      description: '通知组件，用于展示系统通知，支持多种类型和位置',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          // Info 通知
          VelocityButton.text(
            text: 'Info',
            type: VelocityButtonType.outline,
            onPressed: () {
              VelocityNotification.show(
                context: context,
                title: 'Information',
                message: 'This is an informational notification.',
                type: VelocityNotificationType.info,
              );
            },
          ),
          // Success 通知
          VelocityButton.text(
            text: 'Success',
            type: VelocityButtonType.success,
            onPressed: () {
              VelocityNotification.show(
                context: context,
                title: 'Success',
                message: 'Your operation was successful!',
                type: VelocityNotificationType.success,
              );
            },
          ),
          // Warning 通知
          VelocityButton.text(
            text: 'Warning',
            type: VelocityButtonType.warning,
            onPressed: () {
              VelocityNotification.show(
                context: context,
                title: 'Warning',
                message: 'Please check your input.',
                type: VelocityNotificationType.warning,
              );
            },
          ),
          // Error 通知
          VelocityButton.text(
            text: 'Error',
            type: VelocityButtonType.danger,
            onPressed: () {
              VelocityNotification.show(
                context: context,
                title: 'Error',
                message: 'Something went wrong!',
                type: VelocityNotificationType.error,
              );
            },
          ),
          // 底部通知
          VelocityButton.text(
            text: 'Bottom Position',
            onPressed: () {
              VelocityNotification.show(
                context: context,
                title: 'Bottom Notification',
                message: 'This notification appears at the bottom.',
                type: VelocityNotificationType.info,
                position: VelocityNotificationPosition.bottom,
              );
            },
          ),
        ],
      ),
    );
  }

  /// Popover 气泡卡片组件示例
  Widget _buildPopoverSection() {
    return _buildSection(
      title: 'Popover',
      description: '气泡卡片组件，用于展示更多内容，支持点击和悬停触发',
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          // 点击触发
          VelocityPopOver(
            trigger: VelocityPopOverTrigger.click,
            position: VelocityPopOverPosition.bottom,
            content: const Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Popover Title',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('This is the popover content.'),
                ],
              ),
            ),
            child: VelocityButton.text(
              text: 'Click me',
              onPressed: () {},
            ),
          ),
          // 悬停触发
          VelocityPopOver(
            trigger: VelocityPopOverTrigger.hover,
            position: VelocityPopOverPosition.top,
            content: const Padding(
              padding: EdgeInsets.all(8),
              child: Text('Hover content'),
            ),
            child: const Chip(label: Text('Hover me')),
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
