/// VelocityUI 高性能列表组件
///
/// 提供基于 ListView.builder 的高性能列表实现，支持：
/// - itemExtent 和 cacheExtent 参数优化滚动性能
/// - 下拉刷新和加载更多功能
/// - 空状态、加载状态和错误状态处理
library velocity_list_optimized;

import 'package:flutter/material.dart';
import 'list_style.dart';

/// 列表加载状态
enum VelocityListLoadingState {
  /// 初始状态
  initial,

  /// 加载中
  loading,

  /// 加载更多中
  loadingMore,

  /// 加载完成
  loaded,

  /// 没有更多数据
  noMore,

  /// 加载错误
  error,
}

/// 高性能列表组件
///
/// 使用 ListView.builder 模式实现懒加载，支持大数据集高效渲染。
///
/// 示例:
/// ```dart
/// VelocityList<String>(
///   items: ['Item 1', 'Item 2', 'Item 3'],
///   itemBuilder: (context, item, index) => ListTile(title: Text(item)),
///   itemExtent: 56.0,
///   onRefresh: () async {
///     // 刷新数据
///   },
///   onLoadMore: () async {
///     // 加载更多
///   },
/// )
/// ```
class VelocityList<T> extends StatefulWidget {
  /// 创建高性能列表
  ///
  /// [items] 列表数据
  /// [itemBuilder] 列表项构建器
  /// [separatorBuilder] 分隔符构建器
  /// [itemExtent] 固定项高度，设置后可提升滚动性能
  /// [cacheExtent] 缓存区域大小
  /// [physics] 滚动物理效果
  /// [padding] 内边距
  /// [shrinkWrap] 是否收缩包裹
  /// [reverse] 是否反向
  /// [onRefresh] 下拉刷新回调
  /// [onLoadMore] 加载更多回调
  /// [emptyBuilder] 空状态构建器
  /// [loadingBuilder] 加载状态构建器
  /// [errorBuilder] 错误状态构建器
  /// [loadMoreBuilder] 加载更多指示器构建器
  /// [noMoreBuilder] 没有更多数据构建器
  /// [scrollController] 滚动控制器
  /// [loadMoreThreshold] 触发加载更多的阈值（距离底部的像素数）
  const VelocityList({
    required this.items,
    required this.itemBuilder,
    super.key,
    this.separatorBuilder,
    this.itemExtent,
    this.cacheExtent,
    this.physics,
    this.padding,
    this.shrinkWrap = false,
    this.reverse = false,
    this.onRefresh,
    this.onLoadMore,
    this.emptyBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.loadMoreBuilder,
    this.noMoreBuilder,
    this.scrollController,
    this.loadMoreThreshold = 200.0,
    this.loadingState = VelocityListLoadingState.loaded,
    this.error,
    this.style,
    this.semanticLabel,
  });

  /// 列表数据
  final List<T> items;

  /// 列表项构建器
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  /// 分隔符构建器
  final Widget Function(BuildContext context, int index)? separatorBuilder;

  /// 固定项高度
  ///
  /// 设置后可显著提升滚动性能，适用于所有项高度相同的列表
  final double? itemExtent;

  /// 缓存区域大小
  ///
  /// 默认为 250.0，增大此值可减少滚动时的重建，但会增加内存使用
  final double? cacheExtent;

  /// 滚动物理效果
  final ScrollPhysics? physics;

  /// 内边距
  final EdgeInsets? padding;

  /// 是否收缩包裹
  final bool shrinkWrap;

  /// 是否反向
  final bool reverse;

  /// 下拉刷新回调
  final Future<void> Function()? onRefresh;

  /// 加载更多回调
  final Future<void> Function()? onLoadMore;

  /// 空状态构建器
  final Widget Function(BuildContext context)? emptyBuilder;

  /// 加载状态构建器
  final Widget Function(BuildContext context)? loadingBuilder;

  /// 错误状态构建器
  final Widget Function(BuildContext context, Object error)? errorBuilder;

  /// 加载更多指示器构建器
  final Widget Function(BuildContext context)? loadMoreBuilder;

  /// 没有更多数据构建器
  final Widget Function(BuildContext context)? noMoreBuilder;

  /// 滚动控制器
  final ScrollController? scrollController;

  /// 触发加载更多的阈值
  final double loadMoreThreshold;

  /// 加载状态
  final VelocityListLoadingState loadingState;

  /// 错误对象
  final Object? error;

  /// 列表样式
  final VelocityListStyle? style;

  /// 无障碍语义标签
  final String? semanticLabel;

  @override
  State<VelocityList<T>> createState() => _VelocityListState<T>();
}

class _VelocityListState<T> extends State<VelocityList<T>> {
  late ScrollController _scrollController;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    if (widget.onLoadMore != null) {
      _scrollController.addListener(_onScroll);
    }
  }

  @override
  void didUpdateWidget(VelocityList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.scrollController != oldWidget.scrollController) {
      if (oldWidget.scrollController == null) {
        _scrollController.removeListener(_onScroll);
        _scrollController.dispose();
      }
      _scrollController = widget.scrollController ?? ScrollController();
      if (widget.onLoadMore != null) {
        _scrollController.addListener(_onScroll);
      }
    }
  }

  @override
  void dispose() {
    if (widget.scrollController == null) {
      _scrollController.removeListener(_onScroll);
      _scrollController.dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    if (_isLoadingMore) return;
    if (widget.loadingState == VelocityListLoadingState.noMore) return;
    if (widget.loadingState == VelocityListLoadingState.loadingMore) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll - currentScroll <= widget.loadMoreThreshold) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (widget.onLoadMore == null) return;
    if (_isLoadingMore) return;

    _isLoadingMore = true;
    try {
      await widget.onLoadMore!();
    } finally {
      _isLoadingMore = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = widget.style ?? const VelocityListStyle();

    // 处理加载状态
    if (widget.loadingState == VelocityListLoadingState.loading) {
      return _buildLoadingState(effectiveStyle);
    }

    // 处理错误状态
    if (widget.loadingState == VelocityListLoadingState.error &&
        widget.error != null) {
      return _buildErrorState(effectiveStyle);
    }

    // 处理空状态
    if (widget.items.isEmpty) {
      return _buildEmptyState(effectiveStyle);
    }

    // 构建列表
    var list = _buildList(effectiveStyle);

    // 添加下拉刷新支持
    if (widget.onRefresh != null) {
      list = RefreshIndicator(
        onRefresh: widget.onRefresh!,
        color: effectiveStyle.refreshIndicatorColor,
        backgroundColor: effectiveStyle.refreshIndicatorBackgroundColor,
        child: list,
      );
    }

    // 添加无障碍语义
    if (widget.semanticLabel != null) {
      list = Semantics(
        label: widget.semanticLabel,
        child: list,
      );
    }

    return list;
  }

  Widget _buildList(VelocityListStyle effectiveStyle) {
    final hasFooter = widget.onLoadMore != null;
    final itemCount = _calculateItemCount(hasFooter);

    if (widget.separatorBuilder != null) {
      return ListView.separated(
        controller: _scrollController,
        itemCount: hasFooter ? widget.items.length + 1 : widget.items.length,
        cacheExtent: widget.cacheExtent ?? effectiveStyle.defaultCacheExtent,
        physics: widget.physics,
        padding: widget.padding,
        shrinkWrap: widget.shrinkWrap,
        reverse: widget.reverse,
        itemBuilder: (context, index) {
          if (hasFooter && index == widget.items.length) {
            return _buildFooter(effectiveStyle);
          }
          return widget.itemBuilder(context, widget.items[index], index);
        },
        separatorBuilder: widget.separatorBuilder!,
      );
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: itemCount,
      itemExtent: widget.itemExtent,
      cacheExtent: widget.cacheExtent ?? effectiveStyle.defaultCacheExtent,
      physics: widget.physics,
      padding: widget.padding,
      shrinkWrap: widget.shrinkWrap,
      reverse: widget.reverse,
      itemBuilder: (context, index) {
        if (hasFooter && index == widget.items.length) {
          return _buildFooter(effectiveStyle);
        }
        return widget.itemBuilder(context, widget.items[index], index);
      },
    );
  }

  int _calculateItemCount(bool hasFooter) {
    return hasFooter ? widget.items.length + 1 : widget.items.length;
  }

  Widget _buildFooter(VelocityListStyle effectiveStyle) {
    if (widget.loadingState == VelocityListLoadingState.noMore) {
      if (widget.noMoreBuilder != null) {
        return widget.noMoreBuilder!(context);
      }
      return _buildDefaultNoMore(effectiveStyle);
    }

    if (widget.loadingState == VelocityListLoadingState.loadingMore ||
        _isLoadingMore) {
      if (widget.loadMoreBuilder != null) {
        return widget.loadMoreBuilder!(context);
      }
      return _buildDefaultLoadMore(effectiveStyle);
    }

    return const SizedBox.shrink();
  }

  Widget _buildDefaultLoadMore(VelocityListStyle effectiveStyle) {
    return Container(
      padding: effectiveStyle.footerPadding,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                effectiveStyle.loadingIndicatorColor,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            effectiveStyle.loadingMoreText,
            style: effectiveStyle.footerTextStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultNoMore(VelocityListStyle effectiveStyle) {
    return Container(
      padding: effectiveStyle.footerPadding,
      alignment: Alignment.center,
      child: Text(
        effectiveStyle.noMoreText,
        style: effectiveStyle.footerTextStyle,
      ),
    );
  }

  Widget _buildLoadingState(VelocityListStyle effectiveStyle) {
    if (widget.loadingBuilder != null) {
      return widget.loadingBuilder!(context);
    }
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          effectiveStyle.loadingIndicatorColor,
        ),
      ),
    );
  }

  Widget _buildEmptyState(VelocityListStyle effectiveStyle) {
    if (widget.emptyBuilder != null) {
      return widget.emptyBuilder!(context);
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 48,
            color: effectiveStyle.emptyIconColor,
          ),
          const SizedBox(height: 16),
          Text(
            effectiveStyle.emptyText,
            style: effectiveStyle.emptyTextStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(VelocityListStyle effectiveStyle) {
    if (widget.errorBuilder != null) {
      return widget.errorBuilder!(context, widget.error!);
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: effectiveStyle.errorIconColor,
          ),
          const SizedBox(height: 16),
          Text(
            effectiveStyle.errorText,
            style: effectiveStyle.errorTextStyle,
          ),
          if (widget.onRefresh != null) ...[
            const SizedBox(height: 16),
            TextButton(
              onPressed: widget.onRefresh,
              child: Text(effectiveStyle.retryText),
            ),
          ],
        ],
      ),
    );
  }
}
