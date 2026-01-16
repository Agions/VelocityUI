/// VelocityUI 样式缓存系统
///
/// 提供高效的样式解析缓存，避免重复计算样式。
/// 支持按钮、输入框、卡片等组件的样式缓存。
library style_cache;

import 'package:flutter/material.dart';
import 'velocity_theme_data.dart';

/// 按钮类型枚举
enum VelocityButtonType {
  /// 主要按钮
  primary,

  /// 次要按钮
  secondary,

  /// 文本按钮
  text,

  /// 轮廓按钮
  outline,

  /// 危险按钮
  danger,

  /// 成功按钮
  success,

  /// 警告按钮
  warning,
}

/// 按钮尺寸枚举
enum VelocityButtonSize {
  /// 小尺寸
  small,

  /// 中等尺寸
  medium,

  /// 大尺寸
  large,
}

/// 输入框尺寸枚举
enum VelocityInputSize {
  /// 小尺寸
  small,

  /// 中等尺寸
  medium,

  /// 大尺寸
  large,
}

/// 卡片尺寸枚举
enum VelocityCardSize {
  /// 小尺寸
  small,

  /// 中等尺寸
  medium,

  /// 大尺寸
  large,
}

/// 样式缓存键
class _StyleCacheKey {
  const _StyleCacheKey({
    required this.themeHashCode,
    required this.type,
    required this.size,
    this.customStyleHashCode,
  });

  final int themeHashCode;
  final dynamic type;
  final dynamic size;
  final int? customStyleHashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _StyleCacheKey &&
        other.themeHashCode == themeHashCode &&
        other.type == type &&
        other.size == size &&
        other.customStyleHashCode == customStyleHashCode;
  }

  @override
  int get hashCode =>
      Object.hash(themeHashCode, type, size, customStyleHashCode);
}

/// 解析后的按钮样式
class ResolvedButtonStyle {
  const ResolvedButtonStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.disabledBackgroundColor,
    required this.disabledForegroundColor,
    required this.borderRadius,
    required this.padding,
    required this.elevation,
    this.borderColor,
    this.textStyle,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final Color disabledBackgroundColor;
  final Color disabledForegroundColor;
  final BorderRadius borderRadius;
  final EdgeInsets padding;
  final double elevation;
  final Color? borderColor;
  final TextStyle? textStyle;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ResolvedButtonStyle &&
        other.backgroundColor == backgroundColor &&
        other.foregroundColor == foregroundColor &&
        other.disabledBackgroundColor == disabledBackgroundColor &&
        other.disabledForegroundColor == disabledForegroundColor &&
        other.borderRadius == borderRadius &&
        other.padding == padding &&
        other.elevation == elevation &&
        other.borderColor == borderColor &&
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
        borderColor,
        textStyle,
      );
}

/// 解析后的输入框样式
class ResolvedInputStyle {
  const ResolvedInputStyle({
    required this.fillColor,
    required this.borderColor,
    required this.focusedBorderColor,
    required this.errorBorderColor,
    required this.textColor,
    required this.hintColor,
    required this.borderRadius,
    required this.padding,
  });

  final Color fillColor;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;
  final Color textColor;
  final Color hintColor;
  final BorderRadius borderRadius;
  final EdgeInsets padding;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ResolvedInputStyle &&
        other.fillColor == fillColor &&
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

/// 解析后的卡片样式
class ResolvedCardStyle {
  const ResolvedCardStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.shadowColor,
    required this.borderRadius,
    required this.padding,
    required this.elevation,
  });

  final Color backgroundColor;
  final Color borderColor;
  final Color shadowColor;
  final BorderRadius borderRadius;
  final EdgeInsets padding;
  final double elevation;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ResolvedCardStyle &&
        other.backgroundColor == backgroundColor &&
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

/// 样式解析缓存
///
/// 提供高效的样式缓存机制，避免重复计算样式。
/// 缓存按主题哈希码、类型、尺寸和自定义样式哈希码进行索引。
class StyleCache {
  StyleCache._();

  static final StyleCache _instance = StyleCache._();

  /// 获取单例实例
  static StyleCache get instance => _instance;

  /// 按钮样式缓存
  final Map<_StyleCacheKey, ResolvedButtonStyle> _buttonStyleCache = {};

  /// 输入框样式缓存
  final Map<_StyleCacheKey, ResolvedInputStyle> _inputStyleCache = {};

  /// 卡片样式缓存
  final Map<_StyleCacheKey, ResolvedCardStyle> _cardStyleCache = {};

  /// 解析按钮样式
  ///
  /// 如果缓存中存在相同参数的样式，则返回缓存的实例。
  /// 否则，计算新样式并缓存。
  ResolvedButtonStyle resolveButtonStyle({
    required VelocityThemeData theme,
    required VelocityButtonType type,
    required VelocityButtonSize size,
    VelocityButtonThemeData? customStyle,
  }) {
    final key = _StyleCacheKey(
      themeHashCode: theme.hashCode,
      type: type,
      size: size,
      customStyleHashCode: customStyle?.hashCode,
    );

    return _buttonStyleCache.putIfAbsent(key, () {
      return _computeButtonStyle(
        theme: theme,
        type: type,
        size: size,
        customStyle: customStyle,
      );
    });
  }

  /// 解析输入框样式
  ///
  /// 如果缓存中存在相同参数的样式，则返回缓存的实例。
  /// 否则，计算新样式并缓存。
  ResolvedInputStyle resolveInputStyle({
    required VelocityThemeData theme,
    required VelocityInputSize size,
    VelocityInputThemeData? customStyle,
  }) {
    final key = _StyleCacheKey(
      themeHashCode: theme.hashCode,
      type: 'input',
      size: size,
      customStyleHashCode: customStyle?.hashCode,
    );

    return _inputStyleCache.putIfAbsent(key, () {
      return _computeInputStyle(
        theme: theme,
        size: size,
        customStyle: customStyle,
      );
    });
  }

  /// 解析卡片样式
  ///
  /// 如果缓存中存在相同参数的样式，则返回缓存的实例。
  /// 否则，计算新样式并缓存。
  ResolvedCardStyle resolveCardStyle({
    required VelocityThemeData theme,
    required VelocityCardSize size,
    VelocityCardThemeData? customStyle,
  }) {
    final key = _StyleCacheKey(
      themeHashCode: theme.hashCode,
      type: 'card',
      size: size,
      customStyleHashCode: customStyle?.hashCode,
    );

    return _cardStyleCache.putIfAbsent(key, () {
      return _computeCardStyle(
        theme: theme,
        size: size,
        customStyle: customStyle,
      );
    });
  }

  /// 清除所有缓存
  void clearCache() {
    _buttonStyleCache.clear();
    _inputStyleCache.clear();
    _cardStyleCache.clear();
  }

  /// 清除按钮样式缓存
  void clearButtonCache() {
    _buttonStyleCache.clear();
  }

  /// 清除输入框样式缓存
  void clearInputCache() {
    _inputStyleCache.clear();
  }

  /// 清除卡片样式缓存
  void clearCardCache() {
    _cardStyleCache.clear();
  }

  /// 获取按钮缓存大小
  int get buttonCacheSize => _buttonStyleCache.length;

  /// 获取输入框缓存大小
  int get inputCacheSize => _inputStyleCache.length;

  /// 获取卡片缓存大小
  int get cardCacheSize => _cardStyleCache.length;

  /// 计算按钮样式
  ResolvedButtonStyle _computeButtonStyle({
    required VelocityThemeData theme,
    required VelocityButtonType type,
    required VelocityButtonSize size,
    VelocityButtonThemeData? customStyle,
  }) {
    final buttonTheme = theme.buttonTheme ?? VelocityButtonThemeData.light();
    final colorScheme = theme.colorScheme;

    // 根据类型获取基础颜色
    Color backgroundColor;
    Color foregroundColor;
    Color? borderColor;

    switch (type) {
      case VelocityButtonType.primary:
        backgroundColor = customStyle?.backgroundColor ?? colorScheme.primary;
        foregroundColor = customStyle?.foregroundColor ?? colorScheme.onPrimary;
        break;
      case VelocityButtonType.secondary:
        backgroundColor = customStyle?.backgroundColor ?? colorScheme.secondary;
        foregroundColor =
            customStyle?.foregroundColor ?? colorScheme.onSecondary;
        break;
      case VelocityButtonType.text:
        backgroundColor = customStyle?.backgroundColor ?? Colors.transparent;
        foregroundColor = customStyle?.foregroundColor ?? colorScheme.primary;
        break;
      case VelocityButtonType.outline:
        backgroundColor = customStyle?.backgroundColor ?? Colors.transparent;
        foregroundColor = customStyle?.foregroundColor ?? colorScheme.primary;
        borderColor = colorScheme.primary;
        break;
      case VelocityButtonType.danger:
        backgroundColor = customStyle?.backgroundColor ?? colorScheme.error;
        foregroundColor = customStyle?.foregroundColor ?? colorScheme.onError;
        break;
      case VelocityButtonType.success:
        backgroundColor =
            customStyle?.backgroundColor ?? const Color(0xFF22C55E);
        foregroundColor = customStyle?.foregroundColor ?? Colors.white;
        break;
      case VelocityButtonType.warning:
        backgroundColor =
            customStyle?.backgroundColor ?? const Color(0xFFF59E0B);
        foregroundColor = customStyle?.foregroundColor ?? Colors.white;
        break;
    }

    // 根据尺寸获取 padding
    EdgeInsets padding;
    switch (size) {
      case VelocityButtonSize.small:
        padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
        break;
      case VelocityButtonSize.medium:
        padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
        break;
      case VelocityButtonSize.large:
        padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 16);
        break;
    }

    return ResolvedButtonStyle(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      disabledBackgroundColor: customStyle?.disabledBackgroundColor ??
          buttonTheme.disabledBackgroundColor ??
          Colors.grey.shade300,
      disabledForegroundColor: customStyle?.disabledForegroundColor ??
          buttonTheme.disabledForegroundColor ??
          Colors.grey.shade500,
      borderRadius: customStyle?.borderRadius ??
          buttonTheme.borderRadius ??
          const BorderRadius.all(Radius.circular(8)),
      padding: customStyle?.padding ?? padding,
      elevation: customStyle?.elevation ?? buttonTheme.elevation ?? 0,
      borderColor: borderColor,
      textStyle: customStyle?.textStyle ?? buttonTheme.textStyle,
    );
  }

  /// 计算输入框样式
  ResolvedInputStyle _computeInputStyle({
    required VelocityThemeData theme,
    required VelocityInputSize size,
    VelocityInputThemeData? customStyle,
  }) {
    final inputTheme = theme.inputTheme ?? VelocityInputThemeData.light();

    // 根据尺寸获取 padding
    EdgeInsets padding;
    switch (size) {
      case VelocityInputSize.small:
        padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 8);
        break;
      case VelocityInputSize.medium:
        padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 12);
        break;
      case VelocityInputSize.large:
        padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 16);
        break;
    }

    return ResolvedInputStyle(
      fillColor: customStyle?.fillColor ?? inputTheme.fillColor ?? Colors.white,
      borderColor: customStyle?.borderColor ??
          inputTheme.borderColor ??
          Colors.grey.shade300,
      focusedBorderColor: customStyle?.focusedBorderColor ??
          inputTheme.focusedBorderColor ??
          theme.colorScheme.primary,
      errorBorderColor: customStyle?.errorBorderColor ??
          inputTheme.errorBorderColor ??
          theme.colorScheme.error,
      textColor:
          customStyle?.textColor ?? inputTheme.textColor ?? Colors.black87,
      hintColor: customStyle?.hintColor ??
          inputTheme.hintColor ??
          Colors.grey.shade400,
      borderRadius: customStyle?.borderRadius ??
          inputTheme.borderRadius ??
          const BorderRadius.all(Radius.circular(8)),
      padding: customStyle?.padding ?? padding,
    );
  }

  /// 计算卡片样式
  ResolvedCardStyle _computeCardStyle({
    required VelocityThemeData theme,
    required VelocityCardSize size,
    VelocityCardThemeData? customStyle,
  }) {
    final cardTheme = theme.cardTheme ?? VelocityCardThemeData.light();

    // 根据尺寸获取 padding
    EdgeInsets padding;
    switch (size) {
      case VelocityCardSize.small:
        padding = const EdgeInsets.all(8);
        break;
      case VelocityCardSize.medium:
        padding = const EdgeInsets.all(16);
        break;
      case VelocityCardSize.large:
        padding = const EdgeInsets.all(24);
        break;
    }

    return ResolvedCardStyle(
      backgroundColor: customStyle?.backgroundColor ??
          cardTheme.backgroundColor ??
          Colors.white,
      borderColor: customStyle?.borderColor ??
          cardTheme.borderColor ??
          Colors.grey.shade200,
      shadowColor: customStyle?.shadowColor ??
          cardTheme.shadowColor ??
          Colors.black.withValues(alpha: 0.08),
      borderRadius: customStyle?.borderRadius ??
          cardTheme.borderRadius ??
          const BorderRadius.all(Radius.circular(12)),
      padding: customStyle?.padding ?? padding,
      elevation: customStyle?.elevation ?? cardTheme.elevation ?? 1,
    );
  }
}
