/// VelocityUI 加载动画组件
library velocity_spinner;

import 'package:flutter/material.dart';
import '../../../core/utils/velocity_repaint_boundary.dart';
import 'spinner_style.dart';

export 'spinner_style.dart';

/// 加载动画类型
enum VelocitySpinnerType { circular, dots, wave, pulse, ring }

/// VelocityUI 加载动画
///
/// 支持多种动画类型，包括圆形、点状、波浪、脉冲和环形动画。
/// 默认使用 RepaintBoundary 包装以优化渲染性能。
class VelocitySpinner extends StatefulWidget {
  const VelocitySpinner({
    super.key,
    this.type = VelocitySpinnerType.circular,
    this.size = 32,
    this.color,
    this.style,
    this.useRepaintBoundary = true,
  });

  /// 动画类型
  final VelocitySpinnerType type;

  /// 动画尺寸
  final double size;

  /// 动画颜色
  final Color? color;

  /// 动画样式
  final VelocitySpinnerStyle? style;

  /// 是否使用 RepaintBoundary 包装
  ///
  /// 默认为 true，用于隔离动画重绘区域，提升渲染性能。
  /// 设置为 false 可禁用 RepaintBoundary。
  final bool useRepaintBoundary;

  @override
  State<VelocitySpinner> createState() => _VelocitySpinnerState();
}

class _VelocitySpinnerState extends State<VelocitySpinner>
    with TickerProviderStateMixin, VelocityAnimatedMixin<VelocitySpinner> {
  @override
  bool get useRepaintBoundary => widget.useRepaintBoundary;
  late AnimationController _controller;

  Color _applyOpacity(Color color, double opacity) {
    return Color.fromARGB(
      (opacity * 255).round(),
      (color.r * 255).round(),
      (color.g * 255).round(),
      (color.b * 255).round(),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1200), vsync: this)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = widget.style ?? const VelocitySpinnerStyle();
    final color = widget.color ?? effectiveStyle.color;

    Widget content;
    switch (widget.type) {
      case VelocitySpinnerType.dots:
        content = _buildDots(color);
        break;
      case VelocitySpinnerType.wave:
        content = _buildWave(color);
        break;
      case VelocitySpinnerType.pulse:
        content = _buildPulse(color);
        break;
      case VelocitySpinnerType.ring:
        content = _buildRing(color);
        break;
      default:
        content = SizedBox(
          width: widget.size,
          height: widget.size,
          child: CircularProgressIndicator(
              strokeWidth: effectiveStyle.strokeWidth,
              valueColor: AlwaysStoppedAnimation(color)),
        );
    }

    return wrapWithRepaintBoundary(content);
  }

  Widget _buildDots(Color color) {
    return SizedBox(
      width: widget.size,
      height: widget.size / 3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
            3,
            (i) => AnimatedBuilder(
                  animation: _controller,
                  builder: (_, __) {
                    final value =
                        ((_controller.value * 3 - i) % 3).clamp(0.0, 1.0);
                    return Container(
                      width: widget.size / 5,
                      height: widget.size / 5,
                      decoration: BoxDecoration(
                          color: _applyOpacity(color, 0.3 + value * 0.7),
                          shape: BoxShape.circle),
                    );
                  },
                )),
      ),
    );
  }

  Widget _buildWave(Color color) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
            4,
            (i) => AnimatedBuilder(
                  animation: _controller,
                  builder: (_, __) {
                    final value =
                        (((_controller.value + i * 0.15) % 1.0) * 2 - 1).abs();
                    return Container(
                      width: widget.size / 8,
                      height: widget.size * (0.3 + value * 0.7),
                      decoration: BoxDecoration(
                          color: color,
                          borderRadius:
                              BorderRadius.circular(widget.size / 16)),
                    );
                  },
                )),
      ),
    );
  }

  Widget _buildPulse(Color color) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: _applyOpacity(color, 1 - _controller.value),
            shape: BoxShape.circle,
          ),
          child: Transform.scale(
            scale: 0.5 + _controller.value * 0.5,
            child: Container(
                decoration: BoxDecoration(
                    color: _applyOpacity(color, 0.3), shape: BoxShape.circle)),
          ),
        );
      },
    );
  }

  Widget _buildRing(Color color) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => Transform.rotate(
        angle: _controller.value * 6.28,
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: _applyOpacity(color, 0.2), width: 3),
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
          ),
        ),
      ),
    );
  }
}
