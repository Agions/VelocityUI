import 'package:flutter/widgets.dart';

/// 阴影设计令牌
///
/// 提供标准化的阴影值，用于组件的投影效果。
/// 基于 Material Design 的阴影层级系统。
///
/// 使用示例:
/// ```dart
/// Container(
///   decoration: BoxDecoration(
///     boxShadow: VelocityShadow.md,
///   ),
///   child: Text('Hello'),
/// )
/// ```
class VelocityShadow {
  const VelocityShadow._();

  // ============================================
  // 阴影颜色
  // ============================================

  /// 默认阴影颜色 (黑色 5% 透明度)
  static const Color _shadowColor5 = Color(0x0D000000);

  /// 默认阴影颜色 (黑色 10% 透明度)
  static const Color _shadowColor10 = Color(0x1A000000);

  /// 默认阴影颜色 (黑色 15% 透明度)
  static const Color _shadowColor15 = Color(0x26000000);

  /// 默认阴影颜色 (黑色 20% 透明度)
  static const Color _shadowColor20 = Color(0x33000000);

  // ============================================
  // 标准阴影
  // ============================================

  /// 无阴影
  static const List<BoxShadow> none = [];

  /// 超小阴影 - 用于微妙的层次感
  static const List<BoxShadow> xs = [
    BoxShadow(
      color: _shadowColor5,
      blurRadius: 1,
      offset: Offset(0, 1),
    ),
  ];

  /// 小阴影 - 用于卡片悬停状态
  static const List<BoxShadow> sm = [
    BoxShadow(
      color: _shadowColor5,
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
    BoxShadow(
      color: _shadowColor5,
      blurRadius: 3,
      spreadRadius: -1,
      offset: Offset(0, 1),
    ),
  ];

  /// 中等阴影 - 用于卡片和弹出层
  static const List<BoxShadow> md = [
    BoxShadow(
      color: _shadowColor10,
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
    BoxShadow(
      color: _shadowColor5,
      blurRadius: 6,
      spreadRadius: -1,
      offset: Offset(0, 2),
    ),
  ];

  /// 大阴影 - 用于模态框和下拉菜单
  static const List<BoxShadow> lg = [
    BoxShadow(
      color: _shadowColor10,
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
    BoxShadow(
      color: _shadowColor5,
      blurRadius: 12,
      spreadRadius: -2,
      offset: Offset(0, 4),
    ),
  ];

  /// 超大阴影 - 用于对话框和浮动按钮
  static const List<BoxShadow> xl = [
    BoxShadow(
      color: _shadowColor15,
      blurRadius: 16,
      offset: Offset(0, 8),
    ),
    BoxShadow(
      color: _shadowColor10,
      blurRadius: 24,
      spreadRadius: -4,
      offset: Offset(0, 8),
    ),
  ];

  /// 特大阴影 - 用于全屏模态和重要弹出层
  static const List<BoxShadow> xxl = [
    BoxShadow(
      color: _shadowColor20,
      blurRadius: 24,
      offset: Offset(0, 12),
    ),
    BoxShadow(
      color: _shadowColor15,
      blurRadius: 48,
      spreadRadius: -8,
      offset: Offset(0, 12),
    ),
  ];

  // ============================================
  // 内阴影 (用于凹陷效果)
  // ============================================

  /// 小内阴影 - 用于输入框聚焦状态
  static const List<BoxShadow> innerSm = [
    BoxShadow(
      color: _shadowColor5,
      blurRadius: 2,
      spreadRadius: -1,
      offset: Offset(0, 1),
    ),
  ];

  /// 中等内阴影 - 用于按下状态
  static const List<BoxShadow> innerMd = [
    BoxShadow(
      color: _shadowColor10,
      blurRadius: 4,
      spreadRadius: -1,
      offset: Offset(0, 2),
    ),
  ];

  // ============================================
  // 彩色阴影 (用于强调效果)
  // ============================================

  /// 创建自定义颜色阴影
  ///
  /// [color] 阴影颜色
  /// [elevation] 阴影层级 (1-5)
  static List<BoxShadow> colored(Color color, {int elevation = 2}) {
    final opacity = (elevation * 0.05).clamp(0.05, 0.25);
    final blur = (elevation * 4.0).clamp(4.0, 24.0);
    final offset = (elevation * 2.0).clamp(2.0, 12.0);

    return [
      BoxShadow(
        color: color.withValues(alpha: opacity),
        blurRadius: blur,
        offset: Offset(0, offset),
      ),
    ];
  }

  /// 创建主色调阴影
  static List<BoxShadow> primary(Color primaryColor) {
    return colored(primaryColor, elevation: 3);
  }

  // ============================================
  // 焦点环阴影 (用于无障碍焦点指示)
  // ============================================

  /// 创建焦点环阴影
  ///
  /// [color] 焦点环颜色
  /// [width] 焦点环宽度
  static List<BoxShadow> focusRing(Color color, {double width = 2}) {
    return [
      BoxShadow(
        color: color.withValues(alpha: 0.5),
        blurRadius: 0,
        spreadRadius: width,
      ),
    ];
  }
}
