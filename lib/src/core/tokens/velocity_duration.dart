/// 动画时长设计令牌
///
/// 提供标准化的动画时长值，用于组件的过渡和动画效果。
/// 基于用户体验研究的最佳实践时长。
///
/// 使用示例:
/// ```dart
/// AnimatedContainer(
///   duration: VelocityDuration.normal,
///   curve: VelocityCurve.easeOut,
///   child: Text('Hello'),
/// )
/// ```
class VelocityDuration {
  const VelocityDuration._();

  // ============================================
  // 基础时长值
  // ============================================

  /// 即时 (0ms) - 无动画
  static const Duration instant = Duration.zero;

  /// 超快 (50ms) - 用于微交互反馈
  static const Duration fastest = Duration(milliseconds: 50);

  /// 快速 (100ms) - 用于简单状态变化
  static const Duration faster = Duration(milliseconds: 100);

  /// 较快 (150ms) - 用于按钮点击反馈
  static const Duration fast = Duration(milliseconds: 150);

  /// 正常 (250ms) - 用于大多数过渡动画
  static const Duration normal = Duration(milliseconds: 250);

  /// 较慢 (350ms) - 用于复杂过渡
  static const Duration slow = Duration(milliseconds: 350);

  /// 慢速 (500ms) - 用于强调动画
  static const Duration slower = Duration(milliseconds: 500);

  /// 最慢 (700ms) - 用于页面过渡
  static const Duration slowest = Duration(milliseconds: 700);

  // ============================================
  // 语义化时长
  // ============================================

  /// 微交互时长 - 用于按钮点击、开关切换等
  static const Duration micro = fast;

  /// 小型动画时长 - 用于工具提示、下拉菜单等
  static const Duration small = normal;

  /// 中型动画时长 - 用于模态框、抽屉等
  static const Duration medium = slow;

  /// 大型动画时长 - 用于页面过渡、复杂动画等
  static const Duration large = slower;

  // ============================================
  // 特定场景时长
  // ============================================

  /// 按钮按下反馈时长
  static const Duration buttonPress = fast;

  /// 悬停状态变化时长
  static const Duration hover = faster;

  /// 焦点状态变化时长
  static const Duration focus = fast;

  /// 展开/折叠动画时长
  static const Duration expand = normal;

  /// 淡入淡出时长
  static const Duration fade = normal;

  /// 滑动动画时长
  static const Duration slide = slow;

  /// 缩放动画时长
  static const Duration scale = normal;

  /// 旋转动画时长
  static const Duration rotate = slow;

  /// 模态框进入时长
  static const Duration modalEnter = slow;

  /// 模态框退出时长
  static const Duration modalExit = normal;

  /// 页面过渡时长
  static const Duration pageTransition = slower;

  /// 加载动画循环时长
  static const Duration loadingLoop = Duration(milliseconds: 1000);

  /// 脉冲动画时长
  static const Duration pulse = Duration(milliseconds: 1500);

  // ============================================
  // 延迟时长
  // ============================================

  /// 短延迟 - 用于连续动画之间
  static const Duration delayShort = Duration(milliseconds: 100);

  /// 中等延迟 - 用于交错动画
  static const Duration delayMedium = Duration(milliseconds: 200);

  /// 长延迟 - 用于强调效果
  static const Duration delayLong = Duration(milliseconds: 400);

  /// 工具提示显示延迟
  static const Duration tooltipDelay = Duration(milliseconds: 500);

  /// 长按识别延迟
  static const Duration longPressDelay = Duration(milliseconds: 500);
}
