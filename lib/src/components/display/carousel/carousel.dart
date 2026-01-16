/// VelocityUI 轮播图组件
library velocity_carousel;

import 'package:flutter/material.dart';
import '../../../core/utils/velocity_repaint_boundary.dart';
import 'carousel_style.dart';

export 'carousel_style.dart';

/// VelocityUI 轮播图
///
/// 支持自动播放、指示器显示等功能。
/// 默认使用 RepaintBoundary 包装以优化渲染性能。
class VelocityCarousel extends StatefulWidget {
  const VelocityCarousel({
    required this.items,
    super.key,
    this.height = 200,
    this.autoPlay = true,
    this.autoPlayInterval = const Duration(seconds: 3),
    this.showIndicator = true,
    this.onPageChanged,
    this.style,
    this.useRepaintBoundary = true,
  });

  /// 轮播项列表
  final List<Widget> items;

  /// 轮播图高度
  final double height;

  /// 是否自动播放
  final bool autoPlay;

  /// 自动播放间隔
  final Duration autoPlayInterval;

  /// 是否显示指示器
  final bool showIndicator;

  /// 页面切换回调
  final ValueChanged<int>? onPageChanged;

  /// 轮播图样式
  final VelocityCarouselStyle? style;

  /// 是否使用 RepaintBoundary 包装
  ///
  /// 默认为 true，用于隔离动画重绘区域，提升渲染性能。
  /// 设置为 false 可禁用 RepaintBoundary。
  final bool useRepaintBoundary;

  @override
  State<VelocityCarousel> createState() => _VelocityCarouselState();
}

class _VelocityCarouselState extends State<VelocityCarousel>
    with VelocityAnimatedMixin<VelocityCarousel> {
  @override
  bool get useRepaintBoundary => widget.useRepaintBoundary;
  late PageController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    if (widget.autoPlay && widget.items.length > 1) _startAutoPlay();
  }

  void _startAutoPlay() {
    Future.delayed(widget.autoPlayInterval, () {
      if (mounted && widget.autoPlay) {
        final nextPage = (_currentPage + 1) % widget.items.length;
        _controller.animateToPage(nextPage,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
        _startAutoPlay();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = widget.style ?? const VelocityCarouselStyle();

    final content = SizedBox(
      height: widget.height,
      child: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.items.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
              widget.onPageChanged?.call(index);
            },
            itemBuilder: (context, index) => Padding(
              padding: effectiveStyle.itemPadding,
              child: ClipRRect(
                borderRadius: effectiveStyle.borderRadius,
                child: widget.items[index],
              ),
            ),
          ),
          if (widget.showIndicator && widget.items.length > 1)
            Positioned(
              left: 0,
              right: 0,
              bottom: effectiveStyle.indicatorBottom,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    widget.items.length,
                    (index) => Container(
                          width: _currentPage == index
                              ? effectiveStyle.activeIndicatorWidth
                              : effectiveStyle.indicatorSize,
                          height: effectiveStyle.indicatorSize,
                          margin: EdgeInsets.symmetric(
                              horizontal: effectiveStyle.indicatorSpacing / 2),
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? effectiveStyle.activeIndicatorColor
                                : effectiveStyle.indicatorColor,
                            borderRadius: BorderRadius.circular(
                                effectiveStyle.indicatorSize / 2),
                          ),
                        )),
              ),
            ),
        ],
      ),
    );

    return wrapWithRepaintBoundary(content);
  }
}
