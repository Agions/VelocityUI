import 'package:flutter/widgets.dart';

/// 动画曲线设计令牌
///
/// 提供标准化的动画曲线，用于组件的过渡和动画效果。
/// 基于 Material Design 和用户体验研究的最佳实践。
///
/// 使用示例:
/// ```dart
/// AnimatedContainer(
///   duration: VelocityDuration.normal,
///   curve: VelocityCurve.easeOut,
///   child: Text('Hello'),
/// )
/// ```
class VelocityCurve {
  const VelocityCurve._();

  // ============================================
  // 基础曲线
  // ============================================

  /// 线性曲线 - 匀速运动
  static const Curve linear = Curves.linear;

  /// 缓入曲线 - 开始慢，结束快
  static const Curve easeIn = Curves.easeIn;

  /// 缓出曲线 - 开始快，结束慢（推荐用于大多数动画）
  static const Curve easeOut = Curves.easeOut;

  /// 缓入缓出曲线 - 开始和结束都慢
  static const Curve easeInOut = Curves.easeInOut;

  // ============================================
  // 强调曲线
  // ============================================

  /// 快速缓出 - 用于进入动画
  static const Curve fastOutSlowIn = Curves.fastOutSlowIn;

  /// 慢速缓入 - 用于退出动画
  static const Curve slowMiddle = Curves.slowMiddle;

  /// 减速曲线 - 用于自然减速效果
  static const Curve decelerate = Curves.decelerate;

  /// 加速曲线 - 用于自然加速效果
  static const Curve accelerate = Curves.easeIn;

  // ============================================
  // 弹性曲线
  // ============================================

  /// 弹跳曲线 - 用于有趣的弹跳效果
  static const Curve bounce = Curves.bounceOut;

  /// 弹跳进入曲线
  static const Curve bounceIn = Curves.bounceIn;

  /// 弹跳退出曲线
  static const Curve bounceOut = Curves.bounceOut;

  /// 弹跳进出曲线
  static const Curve bounceInOut = Curves.bounceInOut;

  /// 弹性曲线 - 用于弹簧效果
  static const Curve elastic = Curves.elasticOut;

  /// 弹性进入曲线
  static const Curve elasticIn = Curves.elasticIn;

  /// 弹性退出曲线
  static const Curve elasticOut = Curves.elasticOut;

  /// 弹性进出曲线
  static const Curve elasticInOut = Curves.elasticInOut;

  // ============================================
  // 语义化曲线
  // ============================================

  /// 默认曲线 - 用于大多数动画
  static const Curve standard = easeOut;

  /// 进入曲线 - 用于元素进入视图
  static const Curve enter = fastOutSlowIn;

  /// 退出曲线 - 用于元素离开视图
  static const Curve exit = easeIn;

  /// 强调曲线 - 用于吸引注意力的动画
  static const Curve emphasis = Curves.easeOutBack;

  /// 平滑曲线 - 用于平滑过渡
  static const Curve smooth = easeInOut;

  // ============================================
  // 特定场景曲线
  // ============================================

  /// 按钮按下曲线
  static const Curve buttonPress = easeOut;

  /// 悬停状态曲线
  static const Curve hover = easeOut;

  /// 展开动画曲线
  static const Curve expand = fastOutSlowIn;

  /// 折叠动画曲线
  static const Curve collapse = easeIn;

  /// 淡入曲线
  static const Curve fadeIn = easeOut;

  /// 淡出曲线
  static const Curve fadeOut = easeIn;

  /// 滑入曲线
  static const Curve slideIn = fastOutSlowIn;

  /// 滑出曲线
  static const Curve slideOut = easeIn;

  /// 缩放进入曲线
  static const Curve scaleIn = fastOutSlowIn;

  /// 缩放退出曲线
  static const Curve scaleOut = easeIn;

  /// 模态框进入曲线
  static const Curve modalEnter = Curves.easeOutCubic;

  /// 模态框退出曲线
  static const Curve modalExit = Curves.easeInCubic;

  /// 页面过渡曲线
  static const Curve pageTransition = fastOutSlowIn;

  /// 列表项交错动画曲线
  static const Curve stagger = fastOutSlowIn;

  // ============================================
  // 三次贝塞尔曲线 (自定义)
  // ============================================

  /// Material Design 标准曲线
  static const Curve materialStandard = Cubic(0.2, 0.0, 0, 1.0);

  /// Material Design 加速曲线
  static const Curve materialAccelerate = Cubic(0.3, 0.0, 1.0, 1.0);

  /// Material Design 减速曲线
  static const Curve materialDecelerate = Cubic(0.0, 0.0, 0.2, 1.0);

  /// iOS 风格曲线
  static const Curve ios = Cubic(0.25, 0.1, 0.25, 1.0);

  /// 平滑弹性曲线
  static const Curve smoothElastic = Cubic(0.68, -0.55, 0.265, 1.55);
}
