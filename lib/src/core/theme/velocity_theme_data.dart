/// VelocityUI 主题数据
///
/// 包含完整的主题配置，支持亮色和暗色主题。
library velocity_theme_data;

import 'package:flutter/material.dart';
import 'velocity_colors.dart';
import 'velocity_typography.dart';

/// VelocityUI 主题数据
class VelocityThemeData {
  const VelocityThemeData({
    required this.colorScheme,
    required this.textTheme,
    this.brightness = Brightness.light,
    this.primaryColor,
    this.scaffoldBackgroundColor,
    this.cardColor,
    this.dividerColor,
    this.shadowColor,
    this.splashColor,
    this.highlightColor,
    this.hoverColor,
    this.focusColor,
    this.disabledColor,
    this.buttonTheme,
    this.inputTheme,
    this.cardTheme,
    this.dialogTheme,
    this.borderRadius,
    this.spacing,
    this.elevation,
  });

  /// 创建亮色主题
  factory VelocityThemeData.light({
    Color? primaryColor,
    Color? secondaryColor,
    String? fontFamily,
  }) {
    const colorScheme = VelocityColorScheme.light;
    final textTheme = VelocityTextTheme.light(fontFamily: fontFamily);

    return VelocityThemeData(
      colorScheme: colorScheme,
      textTheme: textTheme,
      brightness: Brightness.light,
      primaryColor: primaryColor ?? colorScheme.primary,
      scaffoldBackgroundColor: colorScheme.background,
      cardColor: VelocityColors.cardLight,
      dividerColor: colorScheme.outline,
      shadowColor: VelocityColors.withOpacity(VelocityColors.black, 0.1),
      splashColor: VelocityColors.withOpacity(colorScheme.primary, 0.12),
      highlightColor: VelocityColors.withOpacity(colorScheme.primary, 0.08),
      hoverColor: VelocityColors.withOpacity(colorScheme.primary, 0.04),
      focusColor: VelocityColors.withOpacity(colorScheme.primary, 0.12),
      disabledColor: VelocityColors.gray400,
      buttonTheme: VelocityButtonThemeData.light(),
      inputTheme: VelocityInputThemeData.light(),
      cardTheme: VelocityCardThemeData.light(),
      dialogTheme: VelocityDialogThemeData.light(),
      borderRadius: const VelocityBorderRadiusData(),
      spacing: const VelocitySpacingData(),
      elevation: const VelocityElevationData(),
    );
  }

  /// 创建暗色主题
  factory VelocityThemeData.dark({
    Color? primaryColor,
    Color? secondaryColor,
    String? fontFamily,
  }) {
    const colorScheme = VelocityColorScheme.dark;
    final textTheme = VelocityTextTheme.dark(fontFamily: fontFamily);

    return VelocityThemeData(
      colorScheme: colorScheme,
      textTheme: textTheme,
      brightness: Brightness.dark,
      primaryColor: primaryColor ?? colorScheme.primary,
      scaffoldBackgroundColor: colorScheme.background,
      cardColor: VelocityColors.cardDark,
      dividerColor: colorScheme.outline,
      shadowColor: VelocityColors.withOpacity(VelocityColors.black, 0.3),
      splashColor: VelocityColors.withOpacity(colorScheme.primary, 0.24),
      highlightColor: VelocityColors.withOpacity(colorScheme.primary, 0.16),
      hoverColor: VelocityColors.withOpacity(colorScheme.primary, 0.08),
      focusColor: VelocityColors.withOpacity(colorScheme.primary, 0.24),
      disabledColor: VelocityColors.gray600,
      buttonTheme: VelocityButtonThemeData.dark(),
      inputTheme: VelocityInputThemeData.dark(),
      cardTheme: VelocityCardThemeData.dark(),
      dialogTheme: VelocityDialogThemeData.dark(),
      borderRadius: const VelocityBorderRadiusData(),
      spacing: const VelocitySpacingData(),
      elevation: const VelocityElevationData(),
    );
  }

  /// 颜色方案
  final VelocityColorScheme colorScheme;

  /// 文本主题
  final VelocityTextTheme textTheme;

  /// 亮度模式
  final Brightness brightness;

  /// 主色
  final Color? primaryColor;

  /// 脚手架背景色
  final Color? scaffoldBackgroundColor;

  /// 卡片颜色
  final Color? cardColor;

  /// 分隔线颜色
  final Color? dividerColor;

  /// 阴影颜色
  final Color? shadowColor;

  /// 水波纹颜色
  final Color? splashColor;

  /// 高亮颜色
  final Color? highlightColor;

  /// 悬停颜色
  final Color? hoverColor;

  /// 焦点颜色
  final Color? focusColor;

  /// 禁用颜色
  final Color? disabledColor;

  /// 按钮主题
  final VelocityButtonThemeData? buttonTheme;

  /// 输入框主题
  final VelocityInputThemeData? inputTheme;

  /// 卡片主题
  final VelocityCardThemeData? cardTheme;

  /// 对话框主题
  final VelocityDialogThemeData? dialogTheme;

  /// 圆角配置
  final VelocityBorderRadiusData? borderRadius;

  /// 间距配置
  final VelocitySpacingData? spacing;

  /// 阴影配置
  final VelocityElevationData? elevation;

  /// 转换为 Material ThemeData
  ThemeData toThemeData() {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme.toColorScheme(),
      textTheme: textTheme.toTextTheme(),
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      cardColor: cardColor,
      dividerColor: dividerColor,
      shadowColor: shadowColor,
      splashColor: splashColor,
      highlightColor: highlightColor,
      hoverColor: hoverColor,
      focusColor: focusColor,
      disabledColor: disabledColor,
    );
  }

  /// 高效的相等性比较
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VelocityThemeData) return false;
    return other.colorScheme == colorScheme &&
        other.textTheme == textTheme &&
        other.brightness == brightness &&
        other.primaryColor == primaryColor &&
        other.scaffoldBackgroundColor == scaffoldBackgroundColor &&
        other.cardColor == cardColor &&
        other.dividerColor == dividerColor &&
        other.shadowColor == shadowColor &&
        other.splashColor == splashColor &&
        other.highlightColor == highlightColor &&
        other.hoverColor == hoverColor &&
        other.focusColor == focusColor &&
        other.disabledColor == disabledColor &&
        other.buttonTheme == buttonTheme &&
        other.inputTheme == inputTheme &&
        other.cardTheme == cardTheme &&
        other.dialogTheme == dialogTheme &&
        other.borderRadius == borderRadius &&
        other.spacing == spacing &&
        other.elevation == elevation;
  }

  @override
  int get hashCode => Object.hash(
        colorScheme,
        textTheme,
        brightness,
        primaryColor,
        scaffoldBackgroundColor,
        cardColor,
        dividerColor,
        shadowColor,
        splashColor,
        highlightColor,
        hoverColor,
        focusColor,
        disabledColor,
        buttonTheme,
        inputTheme,
        cardTheme,
        dialogTheme,
        borderRadius,
        spacing,
        elevation,
      );

  /// 复制并修改
  VelocityThemeData copyWith({
    VelocityColorScheme? colorScheme,
    VelocityTextTheme? textTheme,
    Brightness? brightness,
    Color? primaryColor,
    Color? scaffoldBackgroundColor,
    Color? cardColor,
    Color? dividerColor,
    Color? shadowColor,
    Color? splashColor,
    Color? highlightColor,
    Color? hoverColor,
    Color? focusColor,
    Color? disabledColor,
    VelocityButtonThemeData? buttonTheme,
    VelocityInputThemeData? inputTheme,
    VelocityCardThemeData? cardTheme,
    VelocityDialogThemeData? dialogTheme,
    VelocityBorderRadiusData? borderRadius,
    VelocitySpacingData? spacing,
    VelocityElevationData? elevation,
  }) {
    return VelocityThemeData(
      colorScheme: colorScheme ?? this.colorScheme,
      textTheme: textTheme ?? this.textTheme,
      brightness: brightness ?? this.brightness,
      primaryColor: primaryColor ?? this.primaryColor,
      scaffoldBackgroundColor:
          scaffoldBackgroundColor ?? this.scaffoldBackgroundColor,
      cardColor: cardColor ?? this.cardColor,
      dividerColor: dividerColor ?? this.dividerColor,
      shadowColor: shadowColor ?? this.shadowColor,
      splashColor: splashColor ?? this.splashColor,
      highlightColor: highlightColor ?? this.highlightColor,
      hoverColor: hoverColor ?? this.hoverColor,
      focusColor: focusColor ?? this.focusColor,
      disabledColor: disabledColor ?? this.disabledColor,
      buttonTheme: buttonTheme ?? this.buttonTheme,
      inputTheme: inputTheme ?? this.inputTheme,
      cardTheme: cardTheme ?? this.cardTheme,
      dialogTheme: dialogTheme ?? this.dialogTheme,
      borderRadius: borderRadius ?? this.borderRadius,
      spacing: spacing ?? this.spacing,
      elevation: elevation ?? this.elevation,
    );
  }
}

/// 按钮主题数据
class VelocityButtonThemeData {
  const VelocityButtonThemeData({
    this.backgroundColor,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.borderRadius,
    this.padding,
    this.elevation,
    this.textStyle,
  });

  factory VelocityButtonThemeData.light() {
    return const VelocityButtonThemeData(
      backgroundColor: VelocityColors.primary,
      foregroundColor: VelocityColors.white,
      disabledBackgroundColor: VelocityColors.gray300,
      disabledForegroundColor: VelocityColors.gray500,
      borderRadius: BorderRadius.all(Radius.circular(8)),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      elevation: 0,
    );
  }

  factory VelocityButtonThemeData.dark() {
    return const VelocityButtonThemeData(
      backgroundColor: VelocityColors.primaryLight,
      foregroundColor: VelocityColors.white,
      disabledBackgroundColor: VelocityColors.gray700,
      disabledForegroundColor: VelocityColors.gray500,
      borderRadius: BorderRadius.all(Radius.circular(8)),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      elevation: 0,
    );
  }

  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final double? elevation;
  final TextStyle? textStyle;

  /// 合并样式 - 支持 null 安全合并
  VelocityButtonThemeData merge(VelocityButtonThemeData? other) {
    if (other == null) return this;
    return VelocityButtonThemeData(
      backgroundColor: other.backgroundColor ?? backgroundColor,
      foregroundColor: other.foregroundColor ?? foregroundColor,
      disabledBackgroundColor:
          other.disabledBackgroundColor ?? disabledBackgroundColor,
      disabledForegroundColor:
          other.disabledForegroundColor ?? disabledForegroundColor,
      borderRadius: other.borderRadius ?? borderRadius,
      padding: other.padding ?? padding,
      elevation: other.elevation ?? elevation,
      textStyle: other.textStyle ?? textStyle,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VelocityButtonThemeData) return false;
    return other.backgroundColor == backgroundColor &&
        other.foregroundColor == foregroundColor &&
        other.disabledBackgroundColor == disabledBackgroundColor &&
        other.disabledForegroundColor == disabledForegroundColor &&
        other.borderRadius == borderRadius &&
        other.padding == padding &&
        other.elevation == elevation &&
        other.textStyle == textStyle;
  }

  @override
  int get hashCode => Object.hash(
        backgroundColor,
        foregroundColor,
        disabledBackgroundColor,
        disabledForegroundColor,
        borderRadius,
        padding,
        elevation,
        textStyle,
      );
}

/// 输入框主题数据
class VelocityInputThemeData {
  const VelocityInputThemeData({
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.textColor,
    this.hintColor,
    this.borderRadius,
    this.padding,
  });

  factory VelocityInputThemeData.light() {
    return const VelocityInputThemeData(
      fillColor: VelocityColors.white,
      borderColor: VelocityColors.gray300,
      focusedBorderColor: VelocityColors.primary,
      errorBorderColor: VelocityColors.error,
      textColor: VelocityColors.textPrimaryLight,
      hintColor: VelocityColors.gray400,
      borderRadius: BorderRadius.all(Radius.circular(8)),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    );
  }

  factory VelocityInputThemeData.dark() {
    return const VelocityInputThemeData(
      fillColor: VelocityColors.gray800,
      borderColor: VelocityColors.gray600,
      focusedBorderColor: VelocityColors.primaryLight,
      errorBorderColor: VelocityColors.errorLight,
      textColor: VelocityColors.textPrimaryDark,
      hintColor: VelocityColors.gray500,
      borderRadius: BorderRadius.all(Radius.circular(8)),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    );
  }

  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? textColor;
  final Color? hintColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;

  /// 合并样式 - 支持 null 安全合并
  VelocityInputThemeData merge(VelocityInputThemeData? other) {
    if (other == null) return this;
    return VelocityInputThemeData(
      fillColor: other.fillColor ?? fillColor,
      borderColor: other.borderColor ?? borderColor,
      focusedBorderColor: other.focusedBorderColor ?? focusedBorderColor,
      errorBorderColor: other.errorBorderColor ?? errorBorderColor,
      textColor: other.textColor ?? textColor,
      hintColor: other.hintColor ?? hintColor,
      borderRadius: other.borderRadius ?? borderRadius,
      padding: other.padding ?? padding,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VelocityInputThemeData) return false;
    return other.fillColor == fillColor &&
        other.borderColor == borderColor &&
        other.focusedBorderColor == focusedBorderColor &&
        other.errorBorderColor == errorBorderColor &&
        other.textColor == textColor &&
        other.hintColor == hintColor &&
        other.borderRadius == borderRadius &&
        other.padding == padding;
  }

  @override
  int get hashCode => Object.hash(
        fillColor,
        borderColor,
        focusedBorderColor,
        errorBorderColor,
        textColor,
        hintColor,
        borderRadius,
        padding,
      );
}

/// 卡片主题数据
class VelocityCardThemeData {
  const VelocityCardThemeData({
    this.backgroundColor,
    this.borderColor,
    this.shadowColor,
    this.borderRadius,
    this.padding,
    this.elevation,
  });

  factory VelocityCardThemeData.light() {
    return VelocityCardThemeData(
      backgroundColor: VelocityColors.white,
      borderColor: VelocityColors.gray200,
      shadowColor: VelocityColors.withOpacity(VelocityColors.black, 0.08),
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      padding: const EdgeInsets.all(16),
      elevation: 1,
    );
  }

  factory VelocityCardThemeData.dark() {
    return VelocityCardThemeData(
      backgroundColor: VelocityColors.gray800,
      borderColor: VelocityColors.gray700,
      shadowColor: VelocityColors.withOpacity(VelocityColors.black, 0.3),
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      padding: const EdgeInsets.all(16),
      elevation: 1,
    );
  }

  final Color? backgroundColor;
  final Color? borderColor;
  final Color? shadowColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final double? elevation;

  /// 合并样式 - 支持 null 安全合并
  VelocityCardThemeData merge(VelocityCardThemeData? other) {
    if (other == null) return this;
    return VelocityCardThemeData(
      backgroundColor: other.backgroundColor ?? backgroundColor,
      borderColor: other.borderColor ?? borderColor,
      shadowColor: other.shadowColor ?? shadowColor,
      borderRadius: other.borderRadius ?? borderRadius,
      padding: other.padding ?? padding,
      elevation: other.elevation ?? elevation,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VelocityCardThemeData) return false;
    return other.backgroundColor == backgroundColor &&
        other.borderColor == borderColor &&
        other.shadowColor == shadowColor &&
        other.borderRadius == borderRadius &&
        other.padding == padding &&
        other.elevation == elevation;
  }

  @override
  int get hashCode => Object.hash(
        backgroundColor,
        borderColor,
        shadowColor,
        borderRadius,
        padding,
        elevation,
      );
}

/// 对话框主题数据
class VelocityDialogThemeData {
  const VelocityDialogThemeData({
    this.backgroundColor,
    this.titleColor,
    this.contentColor,
    this.borderRadius,
    this.padding,
    this.elevation,
  });

  factory VelocityDialogThemeData.light() {
    return const VelocityDialogThemeData(
      backgroundColor: VelocityColors.white,
      titleColor: VelocityColors.textPrimaryLight,
      contentColor: VelocityColors.textSecondaryLight,
      borderRadius: BorderRadius.all(Radius.circular(16)),
      padding: EdgeInsets.all(24),
      elevation: 8,
    );
  }

  factory VelocityDialogThemeData.dark() {
    return const VelocityDialogThemeData(
      backgroundColor: VelocityColors.gray800,
      titleColor: VelocityColors.textPrimaryDark,
      contentColor: VelocityColors.textSecondaryDark,
      borderRadius: BorderRadius.all(Radius.circular(16)),
      padding: EdgeInsets.all(24),
      elevation: 8,
    );
  }

  final Color? backgroundColor;
  final Color? titleColor;
  final Color? contentColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final double? elevation;

  /// 合并样式 - 支持 null 安全合并
  VelocityDialogThemeData merge(VelocityDialogThemeData? other) {
    if (other == null) return this;
    return VelocityDialogThemeData(
      backgroundColor: other.backgroundColor ?? backgroundColor,
      titleColor: other.titleColor ?? titleColor,
      contentColor: other.contentColor ?? contentColor,
      borderRadius: other.borderRadius ?? borderRadius,
      padding: other.padding ?? padding,
      elevation: other.elevation ?? elevation,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VelocityDialogThemeData) return false;
    return other.backgroundColor == backgroundColor &&
        other.titleColor == titleColor &&
        other.contentColor == contentColor &&
        other.borderRadius == borderRadius &&
        other.padding == padding &&
        other.elevation == elevation;
  }

  @override
  int get hashCode => Object.hash(
        backgroundColor,
        titleColor,
        contentColor,
        borderRadius,
        padding,
        elevation,
      );
}

/// 圆角配置
class VelocityBorderRadiusData {
  const VelocityBorderRadiusData({
    this.none = 0,
    this.sm = 4,
    this.md = 8,
    this.lg = 12,
    this.xl = 16,
    this.xxl = 24,
    this.full = 9999,
  });

  final double none;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;
  final double full;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VelocityBorderRadiusData) return false;
    return other.none == none &&
        other.sm == sm &&
        other.md == md &&
        other.lg == lg &&
        other.xl == xl &&
        other.xxl == xxl &&
        other.full == full;
  }

  @override
  int get hashCode => Object.hash(none, sm, md, lg, xl, xxl, full);
}

/// 间距配置
class VelocitySpacingData {
  const VelocitySpacingData({
    this.none = 0,
    this.xs = 4,
    this.sm = 8,
    this.md = 16,
    this.lg = 24,
    this.xl = 32,
    this.xxl = 48,
  });

  final double none;
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VelocitySpacingData) return false;
    return other.none == none &&
        other.xs == xs &&
        other.sm == sm &&
        other.md == md &&
        other.lg == lg &&
        other.xl == xl &&
        other.xxl == xxl;
  }

  @override
  int get hashCode => Object.hash(none, xs, sm, md, lg, xl, xxl);
}

/// 阴影配置
class VelocityElevationData {
  const VelocityElevationData({
    this.none = 0,
    this.sm = 1,
    this.md = 2,
    this.lg = 4,
    this.xl = 8,
    this.xxl = 16,
  });

  final double none;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VelocityElevationData) return false;
    return other.none == none &&
        other.sm == sm &&
        other.md == md &&
        other.lg == lg &&
        other.xl == xl &&
        other.xxl == xxl;
  }

  @override
  int get hashCode => Object.hash(none, sm, md, lg, xl, xxl);
}
