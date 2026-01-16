/// VelocityUI 按钮样式
///
/// 定义按钮的视觉样式，支持样式合并和继承。
library velocity_button_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

/// 按钮样式配置
///
/// 支持 const 构造函数，可用于编译时常量。
/// 提供高效的样式合并方法，支持样式继承和组合。
class VelocityButtonStyle {
  /// 创建按钮样式
  const VelocityButtonStyle({
    this.backgroundColor,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.splashColor,
    this.highlightColor,
    this.borderRadius,
    this.border,
    this.boxShadow,
    this.padding,
    this.textStyle,
    this.iconSize,
    this.iconSpacing,
  });

  /// 创建默认样式
  factory VelocityButtonStyle.defaults() {
    return const VelocityButtonStyle(
      backgroundColor: VelocityColors.primary,
      foregroundColor: VelocityColors.white,
      disabledBackgroundColor: VelocityColors.gray300,
      disabledForegroundColor: VelocityColors.gray500,
      borderRadius: BorderRadius.all(Radius.circular(8)),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      iconSize: 18,
      iconSpacing: 8,
    );
  }

  /// 背景颜色
  final Color? backgroundColor;

  /// 前景颜色（文字、图标）
  final Color? foregroundColor;

  /// 禁用状态背景颜色
  final Color? disabledBackgroundColor;

  /// 禁用状态前景颜色
  final Color? disabledForegroundColor;

  /// 水波纹颜色
  final Color? splashColor;

  /// 高亮颜色
  final Color? highlightColor;

  /// 圆角
  final BorderRadius? borderRadius;

  /// 边框
  final Border? border;

  /// 阴影
  final List<BoxShadow>? boxShadow;

  /// 内边距
  final EdgeInsets? padding;

  /// 文字样式
  final TextStyle? textStyle;

  /// 图标尺寸
  final double? iconSize;

  /// 图标与文字间距
  final double? iconSpacing;

  /// 合并样式
  ///
  /// 将 [other] 样式合并到当前样式中。
  /// [other] 中的非空属性会覆盖当前样式的对应属性。
  /// 如果 [other] 为 null，则返回当前样式。
  ///
  /// 示例:
  /// ```dart
  /// final baseStyle = VelocityButtonStyle.defaults();
  /// final customStyle = VelocityButtonStyle(backgroundColor: Colors.red);
  /// final merged = baseStyle.merge(customStyle);
  /// // merged.backgroundColor == Colors.red
  /// // merged.foregroundColor == baseStyle.foregroundColor
  /// ```
  VelocityButtonStyle merge(VelocityButtonStyle? other) {
    if (other == null) return this;
    return VelocityButtonStyle(
      backgroundColor: other.backgroundColor ?? backgroundColor,
      foregroundColor: other.foregroundColor ?? foregroundColor,
      disabledBackgroundColor:
          other.disabledBackgroundColor ?? disabledBackgroundColor,
      disabledForegroundColor:
          other.disabledForegroundColor ?? disabledForegroundColor,
      splashColor: other.splashColor ?? splashColor,
      highlightColor: other.highlightColor ?? highlightColor,
      borderRadius: other.borderRadius ?? borderRadius,
      border: other.border ?? border,
      boxShadow: other.boxShadow ?? boxShadow,
      padding: other.padding ?? padding,
      textStyle: other.textStyle ?? textStyle,
      iconSize: other.iconSize ?? iconSize,
      iconSpacing: other.iconSpacing ?? iconSpacing,
    );
  }

  /// 根据类型和尺寸解析样式
  ///
  /// 合并基础类型样式、尺寸样式和自定义样式。
  /// 优先级: customStyle > sizeStyle > typeStyle
  static VelocityButtonStyle resolve({
    required dynamic type,
    required dynamic size,
    VelocityButtonStyle? customStyle,
  }) {
    final typeStyle = _getStyleForType(type);
    final sizeStyle = _getStyleForSize(size);

    // Merge in order: type -> size -> custom
    return typeStyle.merge(sizeStyle).merge(customStyle);
  }

  static VelocityButtonStyle _getStyleForType(dynamic type) {
    final typeName = type.toString().split('.').last;

    switch (typeName) {
      case 'primary':
        return VelocityButtonStyle(
          backgroundColor: VelocityColors.primary,
          foregroundColor: VelocityColors.white,
          disabledBackgroundColor: VelocityColors.gray300,
          disabledForegroundColor: VelocityColors.gray500,
          splashColor: VelocityColors.withOpacity(VelocityColors.white, 0.2),
          highlightColor: VelocityColors.withOpacity(VelocityColors.white, 0.1),
        );
      case 'secondary':
        return VelocityButtonStyle(
          backgroundColor: VelocityColors.secondary,
          foregroundColor: VelocityColors.white,
          disabledBackgroundColor: VelocityColors.gray300,
          disabledForegroundColor: VelocityColors.gray500,
          splashColor: VelocityColors.withOpacity(VelocityColors.white, 0.2),
          highlightColor: VelocityColors.withOpacity(VelocityColors.white, 0.1),
        );
      case 'outline':
        return VelocityButtonStyle(
          backgroundColor: VelocityColors.transparent,
          foregroundColor: VelocityColors.primary,
          disabledBackgroundColor: VelocityColors.transparent,
          disabledForegroundColor: VelocityColors.gray400,
          splashColor: VelocityColors.withOpacity(VelocityColors.primary, 0.1),
          highlightColor:
              VelocityColors.withOpacity(VelocityColors.primary, 0.05),
          border: Border.all(color: VelocityColors.primary, width: 1),
        );
      case 'text':
        return VelocityButtonStyle(
          backgroundColor: VelocityColors.transparent,
          foregroundColor: VelocityColors.primary,
          disabledBackgroundColor: VelocityColors.transparent,
          disabledForegroundColor: VelocityColors.gray400,
          splashColor: VelocityColors.withOpacity(VelocityColors.primary, 0.1),
          highlightColor:
              VelocityColors.withOpacity(VelocityColors.primary, 0.05),
        );
      case 'danger':
        return VelocityButtonStyle(
          backgroundColor: VelocityColors.error,
          foregroundColor: VelocityColors.white,
          disabledBackgroundColor: VelocityColors.gray300,
          disabledForegroundColor: VelocityColors.gray500,
          splashColor: VelocityColors.withOpacity(VelocityColors.white, 0.2),
          highlightColor: VelocityColors.withOpacity(VelocityColors.white, 0.1),
        );
      case 'success':
        return VelocityButtonStyle(
          backgroundColor: VelocityColors.success,
          foregroundColor: VelocityColors.white,
          disabledBackgroundColor: VelocityColors.gray300,
          disabledForegroundColor: VelocityColors.gray500,
          splashColor: VelocityColors.withOpacity(VelocityColors.white, 0.2),
          highlightColor: VelocityColors.withOpacity(VelocityColors.white, 0.1),
        );
      case 'warning':
        return VelocityButtonStyle(
          backgroundColor: VelocityColors.warning,
          foregroundColor: VelocityColors.white,
          disabledBackgroundColor: VelocityColors.gray300,
          disabledForegroundColor: VelocityColors.gray500,
          splashColor: VelocityColors.withOpacity(VelocityColors.white, 0.2),
          highlightColor: VelocityColors.withOpacity(VelocityColors.white, 0.1),
        );
      default:
        return VelocityButtonStyle(
          backgroundColor: VelocityColors.primary,
          foregroundColor: VelocityColors.white,
          disabledBackgroundColor: VelocityColors.gray300,
          disabledForegroundColor: VelocityColors.gray500,
          splashColor: VelocityColors.withOpacity(VelocityColors.white, 0.2),
          highlightColor: VelocityColors.withOpacity(VelocityColors.white, 0.1),
        );
    }
  }

  static VelocityButtonStyle _getStyleForSize(dynamic size) {
    final sizeName = size.toString().split('.').last;

    switch (sizeName) {
      case 'small':
        return const VelocityButtonStyle(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          borderRadius: BorderRadius.all(Radius.circular(6)),
          textStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          iconSize: 16,
          iconSpacing: 6,
        );
      case 'medium':
        return const VelocityButtonStyle(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          borderRadius: BorderRadius.all(Radius.circular(8)),
          textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          iconSize: 18,
          iconSpacing: 8,
        );
      case 'large':
        return const VelocityButtonStyle(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          iconSize: 20,
          iconSpacing: 10,
        );
      default:
        return const VelocityButtonStyle(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          borderRadius: BorderRadius.all(Radius.circular(8)),
          textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          iconSize: 18,
          iconSpacing: 8,
        );
    }
  }

  /// 复制并修改
  VelocityButtonStyle copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    Color? disabledBackgroundColor,
    Color? disabledForegroundColor,
    Color? splashColor,
    Color? highlightColor,
    BorderRadius? borderRadius,
    Border? border,
    List<BoxShadow>? boxShadow,
    EdgeInsets? padding,
    TextStyle? textStyle,
    double? iconSize,
    double? iconSpacing,
  }) {
    return VelocityButtonStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      disabledBackgroundColor:
          disabledBackgroundColor ?? this.disabledBackgroundColor,
      disabledForegroundColor:
          disabledForegroundColor ?? this.disabledForegroundColor,
      splashColor: splashColor ?? this.splashColor,
      highlightColor: highlightColor ?? this.highlightColor,
      borderRadius: borderRadius ?? this.borderRadius,
      border: border ?? this.border,
      boxShadow: boxShadow ?? this.boxShadow,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
      iconSize: iconSize ?? this.iconSize,
      iconSpacing: iconSpacing ?? this.iconSpacing,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VelocityButtonStyle) return false;
    return other.backgroundColor == backgroundColor &&
        other.foregroundColor == foregroundColor &&
        other.disabledBackgroundColor == disabledBackgroundColor &&
        other.disabledForegroundColor == disabledForegroundColor &&
        other.splashColor == splashColor &&
        other.highlightColor == highlightColor &&
        other.borderRadius == borderRadius &&
        other.border == border &&
        _listEquals(other.boxShadow, boxShadow) &&
        other.padding == padding &&
        other.textStyle == textStyle &&
        other.iconSize == iconSize &&
        other.iconSpacing == iconSpacing;
  }

  @override
  int get hashCode => Object.hash(
        backgroundColor,
        foregroundColor,
        disabledBackgroundColor,
        disabledForegroundColor,
        splashColor,
        highlightColor,
        borderRadius,
        border,
        boxShadow != null ? Object.hashAll(boxShadow!) : null,
        padding,
        textStyle,
        iconSize,
        iconSpacing,
      );

  static bool _listEquals<T>(List<T>? a, List<T>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}

/// 图标按钮样式配置
///
/// 支持 const 构造函数。
class VelocityIconButtonStyle {
  /// 创建图标按钮样式
  const VelocityIconButtonStyle({
    this.backgroundColor,
    this.iconColor,
    this.disabledBackgroundColor,
    this.disabledIconColor,
    this.splashColor,
    this.highlightColor,
    this.borderRadius,
    this.border,
  });

  /// 默认样式
  factory VelocityIconButtonStyle.defaults() {
    return VelocityIconButtonStyle(
      backgroundColor: VelocityColors.transparent,
      iconColor: VelocityColors.gray700,
      disabledBackgroundColor: VelocityColors.gray200,
      disabledIconColor: VelocityColors.gray400,
      splashColor: VelocityColors.withOpacity(VelocityColors.gray700, 0.1),
      highlightColor: VelocityColors.withOpacity(VelocityColors.gray700, 0.05),
    );
  }

  /// 背景颜色
  final Color? backgroundColor;

  /// 图标颜色
  final Color? iconColor;

  /// 禁用状态背景颜色
  final Color? disabledBackgroundColor;

  /// 禁用状态图标颜色
  final Color? disabledIconColor;

  /// 水波纹颜色
  final Color? splashColor;

  /// 高亮颜色
  final Color? highlightColor;

  /// 圆角
  final BorderRadius? borderRadius;

  /// 边框
  final Border? border;

  /// 合并样式
  VelocityIconButtonStyle merge(VelocityIconButtonStyle? other) {
    if (other == null) return this;
    return VelocityIconButtonStyle(
      backgroundColor: other.backgroundColor ?? backgroundColor,
      iconColor: other.iconColor ?? iconColor,
      disabledBackgroundColor:
          other.disabledBackgroundColor ?? disabledBackgroundColor,
      disabledIconColor: other.disabledIconColor ?? disabledIconColor,
      splashColor: other.splashColor ?? splashColor,
      highlightColor: other.highlightColor ?? highlightColor,
      borderRadius: other.borderRadius ?? borderRadius,
      border: other.border ?? border,
    );
  }

  /// 复制并修改
  VelocityIconButtonStyle copyWith({
    Color? backgroundColor,
    Color? iconColor,
    Color? disabledBackgroundColor,
    Color? disabledIconColor,
    Color? splashColor,
    Color? highlightColor,
    BorderRadius? borderRadius,
    Border? border,
  }) {
    return VelocityIconButtonStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      iconColor: iconColor ?? this.iconColor,
      disabledBackgroundColor:
          disabledBackgroundColor ?? this.disabledBackgroundColor,
      disabledIconColor: disabledIconColor ?? this.disabledIconColor,
      splashColor: splashColor ?? this.splashColor,
      highlightColor: highlightColor ?? this.highlightColor,
      borderRadius: borderRadius ?? this.borderRadius,
      border: border ?? this.border,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VelocityIconButtonStyle) return false;
    return other.backgroundColor == backgroundColor &&
        other.iconColor == iconColor &&
        other.disabledBackgroundColor == disabledBackgroundColor &&
        other.disabledIconColor == disabledIconColor &&
        other.splashColor == splashColor &&
        other.highlightColor == highlightColor &&
        other.borderRadius == borderRadius &&
        other.border == border;
  }

  @override
  int get hashCode => Object.hash(
        backgroundColor,
        iconColor,
        disabledBackgroundColor,
        disabledIconColor,
        splashColor,
        highlightColor,
        borderRadius,
        border,
      );
}
