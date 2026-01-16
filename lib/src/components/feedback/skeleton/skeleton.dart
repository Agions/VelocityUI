/// VelocityUI 骨架屏组件
library velocity_skeleton;

import 'package:flutter/material.dart';
import '../../../core/utils/velocity_repaint_boundary.dart';
import 'skeleton_style.dart';

export 'skeleton_style.dart';

/// VelocityUI 骨架屏
///
/// 支持动画加载效果的骨架屏组件。
/// 默认使用 RepaintBoundary 包装以优化渲染性能。
class VelocitySkeleton extends StatefulWidget {
  const VelocitySkeleton({
    super.key,
    this.width,
    this.height = 16,
    this.borderRadius,
    this.circle = false,
    this.style,
    this.useRepaintBoundary = true,
  });

  final double? width;
  final double height;
  final BorderRadius? borderRadius;
  final bool circle;
  final VelocitySkeletonStyle? style;

  /// 是否使用 RepaintBoundary 包装
  ///
  /// 默认为 true，用于隔离动画重绘区域，提升渲染性能。
  /// 设置为 false 可禁用 RepaintBoundary。
  final bool useRepaintBoundary;

  @override
  State<VelocitySkeleton> createState() => _VelocitySkeletonState();
}

class _VelocitySkeletonState extends State<VelocitySkeleton>
    with
        SingleTickerProviderStateMixin,
        VelocityAnimatedMixin<VelocitySkeleton> {
  @override
  bool get useRepaintBoundary => widget.useRepaintBoundary;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this)
      ..repeat();
    _animation = Tween<double>(begin: -2, end: 2)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = widget.style ?? const VelocitySkeletonStyle();
    final size = widget.circle ? widget.height : null;

    final content = AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.circle ? size : widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.circle
                ? null
                : (widget.borderRadius ?? effectiveStyle.borderRadius),
            shape: widget.circle ? BoxShape.circle : BoxShape.rectangle,
            gradient: LinearGradient(
              begin: Alignment(_animation.value, 0),
              end: Alignment(_animation.value + 1, 0),
              colors: [
                effectiveStyle.baseColor,
                effectiveStyle.highlightColor,
                effectiveStyle.baseColor
              ],
            ),
          ),
        );
      },
    );

    return wrapWithRepaintBoundary(content);
  }
}

/// VelocityUI 骨架屏容器
class VelocitySkeletonContainer extends StatelessWidget {
  const VelocitySkeletonContainer({
    required this.loading,
    required this.skeleton,
    required this.child,
    super.key,
  });

  final bool loading;
  final Widget skeleton;
  final Widget child;

  @override
  Widget build(BuildContext context) => loading ? skeleton : child;
}

/// VelocityUI 列表骨架屏
class VelocityListSkeleton extends StatelessWidget {
  const VelocityListSkeleton({super.key, this.itemCount = 5, this.style});
  final int itemCount;
  final VelocitySkeletonStyle? style;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          itemCount,
          (i) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    VelocitySkeleton(height: 48, circle: true, style: style),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          VelocitySkeleton(
                              width: 120, height: 16, style: style),
                          const SizedBox(height: 8),
                          VelocitySkeleton(height: 14, style: style),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
    );
  }
}

/// VelocityUI 卡片骨架屏
class VelocityCardSkeleton extends StatelessWidget {
  const VelocityCardSkeleton({super.key, this.style});
  final VelocitySkeletonStyle? style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VelocitySkeleton(
              height: 180,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              style: style),
          const SizedBox(height: 16),
          VelocitySkeleton(width: 200, height: 20, style: style),
          const SizedBox(height: 8),
          VelocitySkeleton(height: 14, style: style),
          const SizedBox(height: 4),
          VelocitySkeleton(width: 150, height: 14, style: style),
        ],
      ),
    );
  }
}
