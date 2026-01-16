/// VelocityUI 安全区域样式
library velocity_safe_area_style;

import 'package:flutter/material.dart';

/// VelocitySafeArea 样式配置
///
/// 用于配置安全区域组件的样式属性
class VelocitySafeAreaStyle {
  const VelocitySafeAreaStyle({
    this.backgroundColor,
    this.padding,
  });

  /// 创建默认样式
  factory VelocitySafeAreaStyle.defaults() {
    return const VelocitySafeAreaStyle(
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.zero,
    );
  }

  /// 背景颜色
  final Color? backgroundColor;

  /// 内边距
  final EdgeInsets? padding;

  /// 复制并修改样式
  VelocitySafeAreaStyle copyWith({
    Color? backgroundColor,
    EdgeInsets? padding,
  }) {
    return VelocitySafeAreaStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      padding: padding ?? this.padding,
    );
  }

  /// 合并样式
  VelocitySafeAreaStyle merge(VelocitySafeAreaStyle? other) {
    if (other == null) return this;
    return copyWith(
      backgroundColor: other.backgroundColor,
      padding: other.padding,
    );
  }
}
