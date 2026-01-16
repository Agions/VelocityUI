/// VelocityUI 输入框样式
///
/// 定义输入框的视觉样式，支持样式合并和继承。
library velocity_input_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

/// 输入框尺寸枚举
enum VelocityInputSize {
  /// 小尺寸
  small,

  /// 中等尺寸
  medium,

  /// 大尺寸
  large,
}

/// 输入框样式配置
///
/// 支持 const 构造函数，可用于编译时常量。
/// 提供高效的样式合并方法，支持样式继承和组合。
class VelocityInputStyle {
  /// 创建输入框样式
  const VelocityInputStyle({
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
    this.helperStyle,
    this.errorStyle,
    this.fillColor,
    this.disabledFillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.disabledBorderColor,
    this.borderRadius,
    this.contentPadding,
    this.iconSize,
    this.iconColor,
    this.labelSpacing,
    this.helperSpacing,
    this.filled,
  });

  /// 创建默认样式
  factory VelocityInputStyle.defaults() {
    return const VelocityInputStyle(
      textStyle:
          TextStyle(fontSize: 14, color: VelocityColors.textPrimaryLight),
      hintStyle: TextStyle(fontSize: 14, color: VelocityColors.gray400),
      labelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: VelocityColors.gray700),
      helperStyle: TextStyle(fontSize: 12, color: VelocityColors.gray500),
      errorStyle: TextStyle(fontSize: 12, color: VelocityColors.error),
      fillColor: VelocityColors.white,
      disabledFillColor: VelocityColors.gray100,
      borderColor: VelocityColors.gray300,
      focusedBorderColor: VelocityColors.primary,
      errorBorderColor: VelocityColors.error,
      disabledBorderColor: VelocityColors.gray200,
      borderRadius: BorderRadius.all(Radius.circular(8)),
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      iconSize: 20,
      iconColor: VelocityColors.gray500,
      labelSpacing: 6,
      helperSpacing: 4,
      filled: true,
    );
  }

  /// 文字样式
  final TextStyle? textStyle;

  /// 提示文字样式
  final TextStyle? hintStyle;

  /// 标签样式
  final TextStyle? labelStyle;

  /// 帮助文字样式
  final TextStyle? helperStyle;

  /// 错误文字样式
  final TextStyle? errorStyle;

  /// 填充颜色
  final Color? fillColor;

  /// 禁用状态填充颜色
  final Color? disabledFillColor;

  /// 边框颜色
  final Color? borderColor;

  /// 聚焦边框颜色
  final Color? focusedBorderColor;

  /// 错误边框颜色
  final Color? errorBorderColor;

  /// 禁用边框颜色
  final Color? disabledBorderColor;

  /// 圆角
  final BorderRadius? borderRadius;

  /// 内容内边距
  final EdgeInsets? contentPadding;

  /// 图标尺寸
  final double? iconSize;

  /// 图标颜色
  final Color? iconColor;

  /// 标签与输入框间距
  final double? labelSpacing;

  /// 帮助文字与输入框间距
  final double? helperSpacing;

  /// 是否填充背景
  final bool? filled;

  /// 合并样式
  ///
  /// 将 [other] 样式合并到当前样式中。
  /// [other] 中的非空属性会覆盖当前样式的对应属性。
  /// 如果 [other] 为 null，则返回当前样式。
  VelocityInputStyle merge(VelocityInputStyle? other) {
    if (other == null) return this;
    return VelocityInputStyle(
      textStyle: other.textStyle ?? textStyle,
      hintStyle: other.hintStyle ?? hintStyle,
      labelStyle: other.labelStyle ?? labelStyle,
      helperStyle: other.helperStyle ?? helperStyle,
      errorStyle: other.errorStyle ?? errorStyle,
      fillColor: other.fillColor ?? fillColor,
      disabledFillColor: other.disabledFillColor ?? disabledFillColor,
      borderColor: other.borderColor ?? borderColor,
      focusedBorderColor: other.focusedBorderColor ?? focusedBorderColor,
      errorBorderColor: other.errorBorderColor ?? errorBorderColor,
      disabledBorderColor: other.disabledBorderColor ?? disabledBorderColor,
      borderRadius: other.borderRadius ?? borderRadius,
      contentPadding: other.contentPadding ?? contentPadding,
      iconSize: other.iconSize ?? iconSize,
      iconColor: other.iconColor ?? iconColor,
      labelSpacing: other.labelSpacing ?? labelSpacing,
      helperSpacing: other.helperSpacing ?? helperSpacing,
      filled: other.filled ?? filled,
    );
  }

  /// 根据尺寸解析样式
  ///
  /// 合并基础样式、尺寸样式和自定义样式。
  /// 优先级: customStyle > sizeStyle > defaultStyle
  static VelocityInputStyle resolve({
    required VelocityInputSize size,
    VelocityInputStyle? customStyle,
  }) {
    final defaultStyle = VelocityInputStyle.defaults();
    final sizeStyle = _getStyleForSize(size);

    return defaultStyle.merge(sizeStyle).merge(customStyle);
  }

  static VelocityInputStyle _getStyleForSize(VelocityInputSize size) {
    switch (size) {
      case VelocityInputSize.small:
        return const VelocityInputStyle(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          textStyle: TextStyle(fontSize: 13),
          hintStyle: TextStyle(fontSize: 13),
          labelStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          iconSize: 18,
          borderRadius: BorderRadius.all(Radius.circular(6)),
        );
      case VelocityInputSize.medium:
        return const VelocityInputStyle(
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          textStyle: TextStyle(fontSize: 14),
          hintStyle: TextStyle(fontSize: 14),
          labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          iconSize: 20,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        );
      case VelocityInputSize.large:
        return const VelocityInputStyle(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          textStyle: TextStyle(fontSize: 16),
          hintStyle: TextStyle(fontSize: 16),
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          iconSize: 24,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        );
    }
  }

  /// 复制并修改
  VelocityInputStyle copyWith({
    TextStyle? textStyle,
    TextStyle? hintStyle,
    TextStyle? labelStyle,
    TextStyle? helperStyle,
    TextStyle? errorStyle,
    Color? fillColor,
    Color? disabledFillColor,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    Color? disabledBorderColor,
    BorderRadius? borderRadius,
    EdgeInsets? contentPadding,
    double? iconSize,
    Color? iconColor,
    double? labelSpacing,
    double? helperSpacing,
    bool? filled,
  }) {
    return VelocityInputStyle(
      textStyle: textStyle ?? this.textStyle,
      hintStyle: hintStyle ?? this.hintStyle,
      labelStyle: labelStyle ?? this.labelStyle,
      helperStyle: helperStyle ?? this.helperStyle,
      errorStyle: errorStyle ?? this.errorStyle,
      fillColor: fillColor ?? this.fillColor,
      disabledFillColor: disabledFillColor ?? this.disabledFillColor,
      borderColor: borderColor ?? this.borderColor,
      focusedBorderColor: focusedBorderColor ?? this.focusedBorderColor,
      errorBorderColor: errorBorderColor ?? this.errorBorderColor,
      disabledBorderColor: disabledBorderColor ?? this.disabledBorderColor,
      borderRadius: borderRadius ?? this.borderRadius,
      contentPadding: contentPadding ?? this.contentPadding,
      iconSize: iconSize ?? this.iconSize,
      iconColor: iconColor ?? this.iconColor,
      labelSpacing: labelSpacing ?? this.labelSpacing,
      helperSpacing: helperSpacing ?? this.helperSpacing,
      filled: filled ?? this.filled,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VelocityInputStyle) return false;
    return other.textStyle == textStyle &&
        other.hintStyle == hintStyle &&
        other.labelStyle == labelStyle &&
        other.helperStyle == helperStyle &&
        other.errorStyle == errorStyle &&
        other.fillColor == fillColor &&
        other.disabledFillColor == disabledFillColor &&
        other.borderColor == borderColor &&
        other.focusedBorderColor == focusedBorderColor &&
        other.errorBorderColor == errorBorderColor &&
        other.disabledBorderColor == disabledBorderColor &&
        other.borderRadius == borderRadius &&
        other.contentPadding == contentPadding &&
        other.iconSize == iconSize &&
        other.iconColor == iconColor &&
        other.labelSpacing == labelSpacing &&
        other.helperSpacing == helperSpacing &&
        other.filled == filled;
  }

  @override
  int get hashCode => Object.hash(
        textStyle,
        hintStyle,
        labelStyle,
        helperStyle,
        errorStyle,
        fillColor,
        disabledFillColor,
        borderColor,
        focusedBorderColor,
        errorBorderColor,
        disabledBorderColor,
        borderRadius,
        contentPadding,
        iconSize,
        iconColor,
        labelSpacing,
        helperSpacing,
        // Note: filled is not included due to hash limit of 20 parameters
      );
}
