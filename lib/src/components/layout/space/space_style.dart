/// VelocityUI 间距样式
library velocity_space_style;

import 'package:flutter/material.dart';

/// VelocitySpace 样式配置
///
/// 用于配置间距组件的样式属性
class VelocitySpaceStyle {
  const VelocitySpaceStyle({
    this.width,
    this.height,
  });

  /// 创建默认样式
  factory VelocitySpaceStyle.defaults() {
    return const VelocitySpaceStyle(
      width: 0,
      height: 0,
    );
  }

  /// 预设尺寸 - 超小
  static const xs = VelocitySpaceStyle(width: 4, height: 4);

  /// 预设尺寸 - 小
  static const sm = VelocitySpaceStyle(width: 8, height: 8);

  /// 预设尺寸 - 中
  static const md = VelocitySpaceStyle(width: 16, height: 16);

  /// 预设尺寸 - 大
  static const lg = VelocitySpaceStyle(width: 24, height: 24);

  /// 预设尺寸 - 超大
  static const xl = VelocitySpaceStyle(width: 32, height: 32);

  /// 宽度
  final double? width;

  /// 高度
  final double? height;

  /// 复制并修改样式
  VelocitySpaceStyle copyWith({
    double? width,
    double? height,
  }) {
    return VelocitySpaceStyle(
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }
}

/// VelocityRow 样式配置
///
/// 用于配置行布局组件的样式属性
class VelocityRowStyle {
  const VelocityRowStyle({
    this.spacing,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.mainAxisSize,
  });

  /// 创建默认样式
  factory VelocityRowStyle.defaults() {
    return const VelocityRowStyle(
      spacing: 0,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
    );
  }

  /// 子组件间距
  final double? spacing;

  /// 主轴对齐方式
  final MainAxisAlignment? mainAxisAlignment;

  /// 交叉轴对齐方式
  final CrossAxisAlignment? crossAxisAlignment;

  /// 主轴尺寸
  final MainAxisSize? mainAxisSize;

  /// 复制并修改样式
  VelocityRowStyle copyWith({
    double? spacing,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    MainAxisSize? mainAxisSize,
  }) {
    return VelocityRowStyle(
      spacing: spacing ?? this.spacing,
      mainAxisAlignment: mainAxisAlignment ?? this.mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
      mainAxisSize: mainAxisSize ?? this.mainAxisSize,
    );
  }
}

/// VelocityColumn 样式配置
///
/// 用于配置列布局组件的样式属性
class VelocityColumnStyle {
  const VelocityColumnStyle({
    this.spacing,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.mainAxisSize,
  });

  /// 创建默认样式
  factory VelocityColumnStyle.defaults() {
    return const VelocityColumnStyle(
      spacing: 0,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
    );
  }

  /// 子组件间距
  final double? spacing;

  /// 主轴对齐方式
  final MainAxisAlignment? mainAxisAlignment;

  /// 交叉轴对齐方式
  final CrossAxisAlignment? crossAxisAlignment;

  /// 主轴尺寸
  final MainAxisSize? mainAxisSize;

  /// 复制并修改样式
  VelocityColumnStyle copyWith({
    double? spacing,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    MainAxisSize? mainAxisSize,
  }) {
    return VelocityColumnStyle(
      spacing: spacing ?? this.spacing,
      mainAxisAlignment: mainAxisAlignment ?? this.mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
      mainAxisSize: mainAxisSize ?? this.mainAxisSize,
    );
  }
}
