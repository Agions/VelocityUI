/// VelocityUI RepaintBoundary 包装器
library velocity_repaint_boundary;

import 'package:flutter/material.dart';

/// VelocityUI RepaintBoundary 包装器
///
/// 提供可配置的 RepaintBoundary 支持，用于隔离重绘区域，
/// 限制重绘范围以提升渲染性能。
///
/// 示例:
/// ```dart
/// VelocityRepaintBoundary(
///   enabled: true,
///   child: ExpensiveWidget(),
/// )
/// ```
class VelocityRepaintBoundary extends StatelessWidget {
  /// 创建一个 VelocityRepaintBoundary 包装器
  ///
  /// [child] 要包装的子组件
  /// [enabled] 是否启用 RepaintBoundary，默认为 true
  const VelocityRepaintBoundary({
    super.key,
    required this.child,
    this.enabled = true,
  });

  /// 要包装的子组件
  final Widget child;

  /// 是否启用 RepaintBoundary
  ///
  /// 当设置为 true 时，子组件将被 RepaintBoundary 包装，
  /// 隔离其重绘区域。
  /// 当设置为 false 时，直接返回子组件，不添加 RepaintBoundary。
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    if (!enabled) return child;
    return RepaintBoundary(child: child);
  }
}

/// 带 RepaintBoundary 支持的动画组件 Mixin
///
/// 为 StatefulWidget 的 State 提供 RepaintBoundary 包装功能，
/// 适用于包含动画或频繁视觉更新的组件。
///
/// 示例:
/// ```dart
/// class _MyAnimatedWidgetState extends State<MyAnimatedWidget>
///     with VelocityAnimatedMixin<MyAnimatedWidget> {
///
///   @override
///   bool get useRepaintBoundary => true;
///
///   @override
///   Widget build(BuildContext context) {
///     return wrapWithRepaintBoundary(
///       AnimatedContainer(...),
///     );
///   }
/// }
/// ```
mixin VelocityAnimatedMixin<T extends StatefulWidget> on State<T> {
  /// 是否使用 RepaintBoundary 包装动画内容
  ///
  /// 子类可以覆盖此属性来控制是否启用 RepaintBoundary。
  /// 默认为 true，表示启用 RepaintBoundary 以优化渲染性能。
  bool get useRepaintBoundary => true;

  /// 使用 RepaintBoundary 包装子组件
  ///
  /// 根据 [useRepaintBoundary] 的值决定是否添加 RepaintBoundary。
  /// 当 [useRepaintBoundary] 为 true 时，返回被 RepaintBoundary 包装的子组件。
  /// 当 [useRepaintBoundary] 为 false 时，直接返回子组件。
  Widget wrapWithRepaintBoundary(Widget child) {
    if (!useRepaintBoundary) return child;
    return RepaintBoundary(child: child);
  }
}
