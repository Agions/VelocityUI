/// VelocityUI 排版系统
///
/// 提供一套完整的排版定义，遵循 Material Design 3 规范。
library velocity_typography;

import 'package:flutter/material.dart';

/// VelocityUI 排版定义
class VelocityTypography {
  VelocityTypography._();

  /// 默认字体族
  static const String fontFamily = 'Roboto';

  /// 字体大小
  static const double displayLarge = 57.0;
  static const double displayMedium = 45.0;
  static const double displaySmall = 36.0;
  static const double headlineLarge = 32.0;
  static const double headlineMedium = 28.0;
  static const double headlineSmall = 24.0;
  static const double titleLarge = 22.0;
  static const double titleMedium = 16.0;
  static const double titleSmall = 14.0;
  static const double bodyLarge = 16.0;
  static const double bodyMedium = 14.0;
  static const double bodySmall = 12.0;
  static const double labelLarge = 14.0;
  static const double labelMedium = 12.0;
  static const double labelSmall = 11.0;

  /// 字体粗细
  static const FontWeight weightLight = FontWeight.w300;
  static const FontWeight weightRegular = FontWeight.w400;
  static const FontWeight weightMedium = FontWeight.w500;
  static const FontWeight weightSemiBold = FontWeight.w600;
  static const FontWeight weightBold = FontWeight.w700;

  /// 行高
  static const double lineHeightTight = 1.25;
  static const double lineHeightNormal = 1.5;
  static const double lineHeightLoose = 1.75;

  /// 字间距
  static const double letterSpacingTight = -0.5;
  static const double letterSpacingNormal = 0.0;
  static const double letterSpacingWide = 0.5;
}

/// VelocityUI 文本主题
class VelocityTextTheme {
  const VelocityTextTheme({
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
  });

  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle displaySmall;
  final TextStyle headlineLarge;
  final TextStyle headlineMedium;
  final TextStyle headlineSmall;
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle labelLarge;
  final TextStyle labelMedium;
  final TextStyle labelSmall;

  /// 创建亮色文本主题
  static VelocityTextTheme light({String? fontFamily}) {
    const color = Color(0xFF111827);
    return _createTextTheme(color, fontFamily);
  }

  /// 创建暗色文本主题
  static VelocityTextTheme dark({String? fontFamily}) {
    const color = Color(0xFFF9FAFB);
    return _createTextTheme(color, fontFamily);
  }

  static VelocityTextTheme _createTextTheme(Color color, String? fontFamily) {
    final family = fontFamily ?? VelocityTypography.fontFamily;

    return VelocityTextTheme(
      displayLarge: TextStyle(
        fontFamily: family,
        fontSize: VelocityTypography.displayLarge,
        fontWeight: VelocityTypography.weightRegular,
        letterSpacing: -0.25,
        height: 1.12,
        color: color,
      ),
      displayMedium: TextStyle(
        fontFamily: family,
        fontSize: VelocityTypography.displayMedium,
        fontWeight: VelocityTypography.weightRegular,
        letterSpacing: 0,
        height: 1.16,
        color: color,
      ),
      displaySmall: TextStyle(
        fontFamily: family,
        fontSize: VelocityTypography.displaySmall,
        fontWeight: VelocityTypography.weightRegular,
        letterSpacing: 0,
        height: 1.22,
        color: color,
      ),
      headlineLarge: TextStyle(
        fontFamily: family,
        fontSize: VelocityTypography.headlineLarge,
        fontWeight: VelocityTypography.weightRegular,
        letterSpacing: 0,
        height: 1.25,
        color: color,
      ),
      headlineMedium: TextStyle(
        fontFamily: family,
        fontSize: VelocityTypography.headlineMedium,
        fontWeight: VelocityTypography.weightRegular,
        letterSpacing: 0,
        height: 1.29,
        color: color,
      ),
      headlineSmall: TextStyle(
        fontFamily: family,
        fontSize: VelocityTypography.headlineSmall,
        fontWeight: VelocityTypography.weightRegular,
        letterSpacing: 0,
        height: 1.33,
        color: color,
      ),
      titleLarge: TextStyle(
        fontFamily: family,
        fontSize: VelocityTypography.titleLarge,
        fontWeight: VelocityTypography.weightMedium,
        letterSpacing: 0,
        height: 1.27,
        color: color,
      ),
      titleMedium: TextStyle(
        fontFamily: family,
        fontSize: VelocityTypography.titleMedium,
        fontWeight: VelocityTypography.weightMedium,
        letterSpacing: 0.15,
        height: 1.5,
        color: color,
      ),
      titleSmall: TextStyle(
        fontFamily: family,
        fontSize: VelocityTypography.titleSmall,
        fontWeight: VelocityTypography.weightMedium,
        letterSpacing: 0.1,
        height: 1.43,
        color: color,
      ),
      bodyLarge: TextStyle(
        fontFamily: family,
        fontSize: VelocityTypography.bodyLarge,
        fontWeight: VelocityTypography.weightRegular,
        letterSpacing: 0.5,
        height: 1.5,
        color: color,
      ),
      bodyMedium: TextStyle(
        fontFamily: family,
        fontSize: VelocityTypography.bodyMedium,
        fontWeight: VelocityTypography.weightRegular,
        letterSpacing: 0.25,
        height: 1.43,
        color: color,
      ),
      bodySmall: TextStyle(
        fontFamily: family,
        fontSize: VelocityTypography.bodySmall,
        fontWeight: VelocityTypography.weightRegular,
        letterSpacing: 0.4,
        height: 1.33,
        color: color,
      ),
      labelLarge: TextStyle(
        fontFamily: family,
        fontSize: VelocityTypography.labelLarge,
        fontWeight: VelocityTypography.weightMedium,
        letterSpacing: 0.1,
        height: 1.43,
        color: color,
      ),
      labelMedium: TextStyle(
        fontFamily: family,
        fontSize: VelocityTypography.labelMedium,
        fontWeight: VelocityTypography.weightMedium,
        letterSpacing: 0.5,
        height: 1.33,
        color: color,
      ),
      labelSmall: TextStyle(
        fontFamily: family,
        fontSize: VelocityTypography.labelSmall,
        fontWeight: VelocityTypography.weightMedium,
        letterSpacing: 0.5,
        height: 1.45,
        color: color,
      ),
    );
  }

  /// 转换为 Material TextTheme
  TextTheme toTextTheme() {
    return TextTheme(
      displayLarge: displayLarge,
      displayMedium: displayMedium,
      displaySmall: displaySmall,
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: titleSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      labelLarge: labelLarge,
      labelMedium: labelMedium,
      labelSmall: labelSmall,
    );
  }

  /// 复制并修改
  VelocityTextTheme copyWith({
    TextStyle? displayLarge,
    TextStyle? displayMedium,
    TextStyle? displaySmall,
    TextStyle? headlineLarge,
    TextStyle? headlineMedium,
    TextStyle? headlineSmall,
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? titleSmall,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? labelLarge,
    TextStyle? labelMedium,
    TextStyle? labelSmall,
  }) {
    return VelocityTextTheme(
      displayLarge: displayLarge ?? this.displayLarge,
      displayMedium: displayMedium ?? this.displayMedium,
      displaySmall: displaySmall ?? this.displaySmall,
      headlineLarge: headlineLarge ?? this.headlineLarge,
      headlineMedium: headlineMedium ?? this.headlineMedium,
      headlineSmall: headlineSmall ?? this.headlineSmall,
      titleLarge: titleLarge ?? this.titleLarge,
      titleMedium: titleMedium ?? this.titleMedium,
      titleSmall: titleSmall ?? this.titleSmall,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
      labelLarge: labelLarge ?? this.labelLarge,
      labelMedium: labelMedium ?? this.labelMedium,
      labelSmall: labelSmall ?? this.labelSmall,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VelocityTextTheme) return false;
    return other.displayLarge == displayLarge &&
        other.displayMedium == displayMedium &&
        other.displaySmall == displaySmall &&
        other.headlineLarge == headlineLarge &&
        other.headlineMedium == headlineMedium &&
        other.headlineSmall == headlineSmall &&
        other.titleLarge == titleLarge &&
        other.titleMedium == titleMedium &&
        other.titleSmall == titleSmall &&
        other.bodyLarge == bodyLarge &&
        other.bodyMedium == bodyMedium &&
        other.bodySmall == bodySmall &&
        other.labelLarge == labelLarge &&
        other.labelMedium == labelMedium &&
        other.labelSmall == labelSmall;
  }

  @override
  int get hashCode => Object.hash(
        displayLarge,
        displayMedium,
        displaySmall,
        headlineLarge,
        headlineMedium,
        headlineSmall,
        titleLarge,
        titleMedium,
        titleSmall,
        bodyLarge,
        bodyMedium,
        bodySmall,
        labelLarge,
        labelMedium,
        labelSmall,
      );
}
