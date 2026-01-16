import 'package:flutter/widgets.dart';

/// 间距设计令牌
///
/// 提供标准化的间距值，用于组件内部和组件之间的间距。
/// 基于 4px 基础单位的倍数系统。
///
/// 使用示例:
/// ```dart
/// Padding(
///   padding: VelocitySpacing.insetsMd,
///   child: Text('Hello'),
/// )
/// ```
class VelocitySpacing {
  const VelocitySpacing._();

  // ============================================
  // 基础间距值
  // ============================================

  /// 无间距 (0px)
  static const double none = 0;

  /// 超小间距 (4px)
  static const double xs = 4;

  /// 小间距 (8px)
  static const double sm = 8;

  /// 中等间距 (16px)
  static const double md = 16;

  /// 大间距 (24px)
  static const double lg = 24;

  /// 超大间距 (32px)
  static const double xl = 32;

  /// 特大间距 (48px)
  static const double xxl = 48;

  /// 巨大间距 (64px)
  static const double xxxl = 64;

  // ============================================
  // EdgeInsets 便捷常量 - 全方向
  // ============================================

  /// 无内边距
  static const EdgeInsets insetsNone = EdgeInsets.zero;

  /// 超小内边距 (4px all)
  static const EdgeInsets insetsXs = EdgeInsets.all(xs);

  /// 小内边距 (8px all)
  static const EdgeInsets insetsSm = EdgeInsets.all(sm);

  /// 中等内边距 (16px all)
  static const EdgeInsets insetsMd = EdgeInsets.all(md);

  /// 大内边距 (24px all)
  static const EdgeInsets insetsLg = EdgeInsets.all(lg);

  /// 超大内边距 (32px all)
  static const EdgeInsets insetsXl = EdgeInsets.all(xl);

  /// 特大内边距 (48px all)
  static const EdgeInsets insetsXxl = EdgeInsets.all(xxl);

  // ============================================
  // EdgeInsets 便捷常量 - 水平方向
  // ============================================

  /// 超小水平内边距 (4px horizontal)
  static const EdgeInsets insetsHorizontalXs =
      EdgeInsets.symmetric(horizontal: xs);

  /// 小水平内边距 (8px horizontal)
  static const EdgeInsets insetsHorizontalSm =
      EdgeInsets.symmetric(horizontal: sm);

  /// 中等水平内边距 (16px horizontal)
  static const EdgeInsets insetsHorizontalMd =
      EdgeInsets.symmetric(horizontal: md);

  /// 大水平内边距 (24px horizontal)
  static const EdgeInsets insetsHorizontalLg =
      EdgeInsets.symmetric(horizontal: lg);

  /// 超大水平内边距 (32px horizontal)
  static const EdgeInsets insetsHorizontalXl =
      EdgeInsets.symmetric(horizontal: xl);

  // ============================================
  // EdgeInsets 便捷常量 - 垂直方向
  // ============================================

  /// 超小垂直内边距 (4px vertical)
  static const EdgeInsets insetsVerticalXs = EdgeInsets.symmetric(vertical: xs);

  /// 小垂直内边距 (8px vertical)
  static const EdgeInsets insetsVerticalSm = EdgeInsets.symmetric(vertical: sm);

  /// 中等垂直内边距 (16px vertical)
  static const EdgeInsets insetsVerticalMd = EdgeInsets.symmetric(vertical: md);

  /// 大垂直内边距 (24px vertical)
  static const EdgeInsets insetsVerticalLg = EdgeInsets.symmetric(vertical: lg);

  /// 超大垂直内边距 (32px vertical)
  static const EdgeInsets insetsVerticalXl = EdgeInsets.symmetric(vertical: xl);

  // ============================================
  // SizedBox 便捷常量 - 水平间隔
  // ============================================

  /// 超小水平间隔 (4px)
  static const SizedBox horizontalXs = SizedBox(width: xs);

  /// 小水平间隔 (8px)
  static const SizedBox horizontalSm = SizedBox(width: sm);

  /// 中等水平间隔 (16px)
  static const SizedBox horizontalMd = SizedBox(width: md);

  /// 大水平间隔 (24px)
  static const SizedBox horizontalLg = SizedBox(width: lg);

  /// 超大水平间隔 (32px)
  static const SizedBox horizontalXl = SizedBox(width: xl);

  // ============================================
  // SizedBox 便捷常量 - 垂直间隔
  // ============================================

  /// 超小垂直间隔 (4px)
  static const SizedBox verticalXs = SizedBox(height: xs);

  /// 小垂直间隔 (8px)
  static const SizedBox verticalSm = SizedBox(height: sm);

  /// 中等垂直间隔 (16px)
  static const SizedBox verticalMd = SizedBox(height: md);

  /// 大垂直间隔 (24px)
  static const SizedBox verticalLg = SizedBox(height: lg);

  /// 超大垂直间隔 (32px)
  static const SizedBox verticalXl = SizedBox(height: xl);
}
