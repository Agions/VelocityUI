/// VelocityUI 加载组件
library velocity_loading;

import 'package:flutter/material.dart';
import '../../../core/utils/velocity_repaint_boundary.dart';
import 'loading_style.dart';

export 'loading_style.dart';

/// 加载类型
enum VelocityLoadingType { circular, linear }

/// VelocityUI 加载组件
///
/// 支持圆形和线性两种加载指示器类型。
/// 默认使用 RepaintBoundary 包装以优化渲染性能。
class VelocityLoading extends StatelessWidget {
  const VelocityLoading({
    super.key,
    this.type = VelocityLoadingType.circular,
    this.size = 24,
    this.strokeWidth = 2,
    this.value,
    this.style,
    this.useRepaintBoundary = true,
  });

  /// 加载类型
  final VelocityLoadingType type;

  /// 圆形加载指示器的尺寸
  final double size;

  /// 圆形加载指示器的线条宽度
  final double strokeWidth;

  /// 进度值，范围 0.0 到 1.0，为 null 时显示不确定进度
  final double? value;

  /// 加载样式
  final VelocityLoadingStyle? style;

  /// 是否使用 RepaintBoundary 包装
  ///
  /// 默认为 true，用于隔离动画重绘区域，提升渲染性能。
  /// 设置为 false 可禁用 RepaintBoundary。
  final bool useRepaintBoundary;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? const VelocityLoadingStyle();

    Widget content;
    if (type == VelocityLoadingType.linear) {
      content = SizedBox(
        width: effectiveStyle.linearWidth,
        child: LinearProgressIndicator(
          value: value,
          backgroundColor: effectiveStyle.backgroundColor,
          valueColor: AlwaysStoppedAnimation<Color>(effectiveStyle.color),
          minHeight: effectiveStyle.linearHeight,
        ),
      );
    } else {
      content = SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          value: value,
          strokeWidth: strokeWidth,
          backgroundColor: effectiveStyle.backgroundColor,
          valueColor: AlwaysStoppedAnimation<Color>(effectiveStyle.color),
        ),
      );
    }

    return VelocityRepaintBoundary(
      enabled: useRepaintBoundary,
      child: content,
    );
  }
}

/// VelocityUI 加载覆盖层
class VelocityLoadingOverlay extends StatelessWidget {
  const VelocityLoadingOverlay({
    required this.child,
    required this.loading,
    super.key,
    this.message,
    this.style,
  });

  final Widget child;
  final bool loading;
  final String? message;
  final VelocityLoadingOverlayStyle? style;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? const VelocityLoadingOverlayStyle();

    return Stack(
      children: [
        child,
        if (loading)
          Positioned.fill(
            child: Container(
              color: effectiveStyle.effectiveOverlayColor,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    VelocityLoading(style: effectiveStyle.loadingStyle),
                    if (message != null) ...[
                      SizedBox(height: effectiveStyle.messageSpacing),
                      Text(message!, style: effectiveStyle.messageStyle),
                    ],
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
