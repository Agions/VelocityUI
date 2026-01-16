/// VelocityUI 宽高比样式
library velocity_aspect_ratio_style;

/// VelocityAspectRatio 样式配置
///
/// 用于配置宽高比组件的样式属性
class VelocityAspectRatioStyle {
  const VelocityAspectRatioStyle({
    this.aspectRatio,
  });

  /// 创建默认样式 (16:9)
  factory VelocityAspectRatioStyle.defaults() {
    return const VelocityAspectRatioStyle(
      aspectRatio: 16 / 9,
    );
  }

  /// 预设宽高比 - 16:9 视频
  static const video = VelocityAspectRatioStyle(aspectRatio: 16 / 9);

  /// 预设宽高比 - 4:3 照片
  static const photo = VelocityAspectRatioStyle(aspectRatio: 4 / 3);

  /// 预设宽高比 - 1:1 正方形
  static const square = VelocityAspectRatioStyle(aspectRatio: 1);

  /// 预设宽高比 - 3:4 竖版
  static const portrait = VelocityAspectRatioStyle(aspectRatio: 3 / 4);

  /// 预设宽高比 - 21:9 超宽
  static const ultrawide = VelocityAspectRatioStyle(aspectRatio: 21 / 9);

  /// 宽高比
  final double? aspectRatio;

  /// 复制并修改样式
  VelocityAspectRatioStyle copyWith({
    double? aspectRatio,
  }) {
    return VelocityAspectRatioStyle(
      aspectRatio: aspectRatio ?? this.aspectRatio,
    );
  }
}
