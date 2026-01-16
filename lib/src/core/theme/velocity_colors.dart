/// VelocityUI 颜色系统
///
/// 提供一套完整的颜色定义，支持亮色和暗色主题。
library velocity_colors;

import 'package:flutter/material.dart';

/// VelocityUI 颜色定义
class VelocityColors {
  VelocityColors._();

  // ============ 主色调 ============

  /// 主色 - 蓝色系
  static const Color primary = Color(0xFF2563EB);
  static const Color primaryLight = Color(0xFF3B82F6);
  static const Color primaryDark = Color(0xFF1D4ED8);

  /// 次要色 - 紫色系
  static const Color secondary = Color(0xFF7C3AED);
  static const Color secondaryLight = Color(0xFF8B5CF6);
  static const Color secondaryDark = Color(0xFF6D28D9);

  /// 强调色 - 青色系
  static const Color accent = Color(0xFF06B6D4);
  static const Color accentLight = Color(0xFF22D3EE);
  static const Color accentDark = Color(0xFF0891B2);

  // ============ 语义色 ============

  /// 成功色
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFF34D399);
  static const Color successDark = Color(0xFF059669);

  /// 警告色
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFBBF24);
  static const Color warningDark = Color(0xFFD97706);

  /// 错误色
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFF87171);
  static const Color errorDark = Color(0xFFDC2626);

  /// 信息色
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFF60A5FA);
  static const Color infoDark = Color(0xFF2563EB);

  // ============ 中性色 ============

  /// 灰色系
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray900 = Color(0xFF111827);

  // ============ 背景色 ============

  /// 亮色主题背景
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFF9FAFB);
  static const Color cardLight = Color(0xFFFFFFFF);

  /// 暗色主题背景
  static const Color backgroundDark = Color(0xFF111827);
  static const Color surfaceDark = Color(0xFF1F2937);
  static const Color cardDark = Color(0xFF374151);

  // ============ 文本色 ============

  /// 亮色主题文本
  static const Color textPrimaryLight = Color(0xFF111827);
  static const Color textSecondaryLight = Color(0xFF6B7280);
  static const Color textDisabledLight = Color(0xFF9CA3AF);

  /// 暗色主题文本
  static const Color textPrimaryDark = Color(0xFFF9FAFB);
  static const Color textSecondaryDark = Color(0xFF9CA3AF);
  static const Color textDisabledDark = Color(0xFF6B7280);

  // ============ 边框色 ============

  static const Color borderLight = Color(0xFFE5E7EB);
  static const Color borderDark = Color(0xFF374151);

  // ============ 透明色 ============

  static const Color transparent = Colors.transparent;
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  /// 获取带透明度的颜色
  static Color withOpacity(Color color, double opacity) {
    return color.withValues(alpha: opacity);
  }
}

/// VelocityUI 颜色方案
class VelocityColorScheme {
  const VelocityColorScheme({
    required this.primary,
    required this.primaryContainer,
    required this.secondary,
    required this.secondaryContainer,
    required this.surface,
    required this.background,
    required this.error,
    required this.onPrimary,
    required this.onSecondary,
    required this.onSurface,
    required this.onBackground,
    required this.onError,
    required this.outline,
    required this.shadow,
    required this.brightness,
  });

  final Color primary;
  final Color primaryContainer;
  final Color secondary;
  final Color secondaryContainer;
  final Color surface;
  final Color background;
  final Color error;
  final Color onPrimary;
  final Color onSecondary;
  final Color onSurface;
  final Color onBackground;
  final Color onError;
  final Color outline;
  final Color shadow;
  final Brightness brightness;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VelocityColorScheme) return false;
    return other.primary == primary &&
        other.primaryContainer == primaryContainer &&
        other.secondary == secondary &&
        other.secondaryContainer == secondaryContainer &&
        other.surface == surface &&
        other.background == background &&
        other.error == error &&
        other.onPrimary == onPrimary &&
        other.onSecondary == onSecondary &&
        other.onSurface == onSurface &&
        other.onBackground == onBackground &&
        other.onError == onError &&
        other.outline == outline &&
        other.shadow == shadow &&
        other.brightness == brightness;
  }

  @override
  int get hashCode => Object.hash(
        primary,
        primaryContainer,
        secondary,
        secondaryContainer,
        surface,
        background,
        error,
        onPrimary,
        onSecondary,
        onSurface,
        onBackground,
        onError,
        outline,
        shadow,
        brightness,
      );

  /// 亮色方案
  static const VelocityColorScheme light = VelocityColorScheme(
    primary: VelocityColors.primary,
    primaryContainer: VelocityColors.primaryLight,
    secondary: VelocityColors.secondary,
    secondaryContainer: VelocityColors.secondaryLight,
    surface: VelocityColors.surfaceLight,
    background: VelocityColors.backgroundLight,
    error: VelocityColors.error,
    onPrimary: VelocityColors.white,
    onSecondary: VelocityColors.white,
    onSurface: VelocityColors.textPrimaryLight,
    onBackground: VelocityColors.textPrimaryLight,
    onError: VelocityColors.white,
    outline: VelocityColors.borderLight,
    shadow: VelocityColors.black,
    brightness: Brightness.light,
  );

  /// 暗色方案
  static const VelocityColorScheme dark = VelocityColorScheme(
    primary: VelocityColors.primaryLight,
    primaryContainer: VelocityColors.primaryDark,
    secondary: VelocityColors.secondaryLight,
    secondaryContainer: VelocityColors.secondaryDark,
    surface: VelocityColors.surfaceDark,
    background: VelocityColors.backgroundDark,
    error: VelocityColors.errorLight,
    onPrimary: VelocityColors.white,
    onSecondary: VelocityColors.white,
    onSurface: VelocityColors.textPrimaryDark,
    onBackground: VelocityColors.textPrimaryDark,
    onError: VelocityColors.white,
    outline: VelocityColors.borderDark,
    shadow: VelocityColors.black,
    brightness: Brightness.dark,
  );

  /// 转换为 Material ColorScheme
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimary,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondary,
      error: error,
      onError: onError,
      surface: surface,
      onSurface: onSurface,
      outline: outline,
      shadow: shadow,
    );
  }
}
