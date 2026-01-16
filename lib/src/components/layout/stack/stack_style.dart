/// VelocityUI 层叠布局样式
library velocity_stack_style;

import 'package:flutter/material.dart';

/// VelocityStack 样式配置
///
/// 用于配置层叠布局组件的样式属性
class VelocityStackStyle {
  const VelocityStackStyle({
    this.alignment,
    this.fit,
    this.clipBehavior,
  });

  /// 创建默认样式
  factory VelocityStackStyle.defaults() {
    return const VelocityStackStyle(
      alignment: AlignmentDirectional.topStart,
      fit: StackFit.loose,
      clipBehavior: Clip.hardEdge,
    );
  }

  /// 对齐方式
  final AlignmentGeometry? alignment;

  /// 子组件适应方式
  final StackFit? fit;

  /// 裁剪行为
  final Clip? clipBehavior;

  /// 复制并修改样式
  VelocityStackStyle copyWith({
    AlignmentGeometry? alignment,
    StackFit? fit,
    Clip? clipBehavior,
  }) {
    return VelocityStackStyle(
      alignment: alignment ?? this.alignment,
      fit: fit ?? this.fit,
      clipBehavior: clipBehavior ?? this.clipBehavior,
    );
  }

  /// 合并样式
  VelocityStackStyle merge(VelocityStackStyle? other) {
    if (other == null) return this;
    return copyWith(
      alignment: other.alignment,
      fit: other.fit,
      clipBehavior: other.clipBehavior,
    );
  }
}

/// VelocityPositioned 样式配置
///
/// 用于配置定位组件的样式属性
class VelocityPositionedStyle {
  const VelocityPositionedStyle({
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.width,
    this.height,
  });

  /// 创建填充样式
  factory VelocityPositionedStyle.fill() {
    return const VelocityPositionedStyle(
      left: 0,
      top: 0,
      right: 0,
      bottom: 0,
    );
  }

  /// 左边距
  final double? left;

  /// 上边距
  final double? top;

  /// 右边距
  final double? right;

  /// 下边距
  final double? bottom;

  /// 宽度
  final double? width;

  /// 高度
  final double? height;

  /// 复制并修改样式
  VelocityPositionedStyle copyWith({
    double? left,
    double? top,
    double? right,
    double? bottom,
    double? width,
    double? height,
  }) {
    return VelocityPositionedStyle(
      left: left ?? this.left,
      top: top ?? this.top,
      right: right ?? this.right,
      bottom: bottom ?? this.bottom,
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }
}
