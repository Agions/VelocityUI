/// VelocityUI 虚拟化列表组件
///
/// 提供针对超大数据集优化的虚拟化列表实现，支持：
/// - 高效的内存使用
/// - 固定项高度优化
/// - 大数据集流畅滚动
library velocity_virtualized_list;

import 'package:flutter/material.dart';

/// 虚拟化列表组件
///
/// 专为超大数据集设计的高性能列表组件。
/// 使用固定项高度和优化的缓存策略，确保即使在数万条数据时也能流畅滚动。
///
/// 与 [VelocityList] 的区别：
/// - 必须指定 [itemExtent]（固定项高度）
/// - 针对超大数据集优化内存使用
/// - 不支持分隔符（为了性能）
/// - 提供更精细的缓存控制
///
/// 示例:
/// ```dart
/// VelocityVirtualizedList<String>(
///   itemCount: 100000,
///   itemBuilder: (context, index) => ListTile(
///     title: Text('Item $index'),
///   ),
///   itemExtent: 56.0,
/// )
/// ```
class VelocityVirtualizedList<T> extends StatefulWidget {
  /// 创建虚拟化列表
  ///
  /// [itemCount] 列表项总数
  /// [itemBuilder] 列表项构建器
  /// [itemExtent] 固定项高度（必需）
  /// [cacheExtent] 缓存区域大小，默认为 itemExtent * 5
  /// [physics] 滚动物理效果
  /// [padding] 内边距
  /// [scrollController] 滚动控制器
  /// [addAutomaticKeepAlives] 是否自动保持存活
  /// [addRepaintBoundaries] 是否添加重绘边界
  /// [addSemanticIndexes] 是否添加语义索引
  /// [semanticLabel] 无障碍语义标签
  const VelocityVirtualizedList({
    required this.itemCount,
    required this.itemBuilder,
    required this.itemExtent,
    super.key,
    this.cacheExtent,
    this.physics,
    this.padding,
    this.scrollController,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.semanticLabel,
    this.onScrollStart,
    this.onScrollEnd,
    this.onScrollUpdate,
    this.style,
  });

  /// 列表项总数
  final int itemCount;

  /// 列表项构建器
  ///
  /// 接收 context 和 index，返回对应的 Widget
  final Widget Function(BuildContext context, int index) itemBuilder;

  /// 固定项高度
  ///
  /// 必须指定，用于优化滚动性能和内存使用
  final double itemExtent;

  /// 缓存区域大小
  ///
  /// 默认为 itemExtent * 5，增大此值可减少滚动时的重建
  final double? cacheExtent;

  /// 滚动物理效果
  final ScrollPhysics? physics;

  /// 内边距
  final EdgeInsets? padding;

  /// 滚动控制器
  final ScrollController? scrollController;

  /// 是否自动保持存活
  ///
  /// 设置为 false 可减少内存使用，但可能导致滚动时重建
  final bool addAutomaticKeepAlives;

  /// 是否添加重绘边界
  ///
  /// 设置为 true 可隔离每个列表项的重绘
  final bool addRepaintBoundaries;

  /// 是否添加语义索引
  final bool addSemanticIndexes;

  /// 无障碍语义标签
  final String? semanticLabel;

  /// 滚动开始回调
  final VoidCallback? onScrollStart;

  /// 滚动结束回调
  final VoidCallback? onScrollEnd;

  /// 滚动更新回调
  final void Function(ScrollUpdateNotification notification)? onScrollUpdate;

  /// 列表样式
  final VelocityVirtualizedListStyle? style;

  @override
  State<VelocityVirtualizedList<T>> createState() =>
      _VelocityVirtualizedListState<T>();
}

class _VelocityVirtualizedListState<T>
    extends State<VelocityVirtualizedList<T>> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
  }

  @override
  void didUpdateWidget(VelocityVirtualizedList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.scrollController != oldWidget.scrollController) {
      if (oldWidget.scrollController == null) {
        _scrollController.dispose();
      }
      _scrollController = widget.scrollController ?? ScrollController();
    }
  }

  @override
  void dispose() {
    if (widget.scrollController == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = widget.style ?? const VelocityVirtualizedListStyle();
    final effectiveCacheExtent = widget.cacheExtent ??
        widget.itemExtent * effectiveStyle.cacheMultiplier;

    Widget list = ListView.builder(
      controller: _scrollController,
      itemCount: widget.itemCount,
      itemExtent: widget.itemExtent,
      cacheExtent: effectiveCacheExtent,
      physics: widget.physics,
      padding: widget.padding,
      addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
      addRepaintBoundaries: widget.addRepaintBoundaries,
      addSemanticIndexes: widget.addSemanticIndexes,
      itemBuilder: widget.itemBuilder,
    );

    // 添加滚动通知监听
    if (widget.onScrollStart != null ||
        widget.onScrollEnd != null ||
        widget.onScrollUpdate != null) {
      list = NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
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

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollStartNotification) {
      widget.onScrollStart?.call();
    } else if (notification is ScrollEndNotification) {
      widget.onScrollEnd?.call();
    } else if (notification is ScrollUpdateNotification) {
      widget.onScrollUpdate?.call(notification);
    }
    return false;
  }
}

/// 虚拟化列表样式
class VelocityVirtualizedListStyle {
  /// 创建虚拟化列表样式
  const VelocityVirtualizedListStyle({
    this.cacheMultiplier = 5,
  });

  /// 缓存倍数
  ///
  /// 缓存区域大小 = itemExtent * cacheMultiplier
  final int cacheMultiplier;

  /// 复制并修改样式
  VelocityVirtualizedListStyle copyWith({
    int? cacheMultiplier,
  }) {
    return VelocityVirtualizedListStyle(
      cacheMultiplier: cacheMultiplier ?? this.cacheMultiplier,
    );
  }
}

/// 虚拟化列表控制器
///
/// 提供对虚拟化列表的编程控制
class VelocityVirtualizedListController {
  VelocityVirtualizedListController({
    ScrollController? scrollController,
  }) : _scrollController = scrollController ?? ScrollController();

  final ScrollController _scrollController;

  /// 获取滚动控制器
  ScrollController get scrollController => _scrollController;

  /// 滚动到指定索引
  ///
  /// [index] 目标索引
  /// [itemExtent] 项高度
  /// [duration] 动画时长
  /// [curve] 动画曲线
  void scrollToIndex(
    int index, {
    required double itemExtent,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    final offset = index * itemExtent;
    _scrollController.animateTo(
      offset,
      duration: duration,
      curve: curve,
    );
  }

  /// 立即跳转到指定索引
  ///
  /// [index] 目标索引
  /// [itemExtent] 项高度
  void jumpToIndex(int index, {required double itemExtent}) {
    final offset = index * itemExtent;
    _scrollController.jumpTo(offset);
  }

  /// 滚动到顶部
  void scrollToTop({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    _scrollController.animateTo(
      0,
      duration: duration,
      curve: curve,
    );
  }

  /// 滚动到底部
  void scrollToBottom({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: duration,
      curve: curve,
    );
  }

  /// 获取当前可见的第一个索引
  int getFirstVisibleIndex({required double itemExtent}) {
    if (!_scrollController.hasClients) return 0;
    return (_scrollController.offset / itemExtent).floor();
  }

  /// 获取当前可见的最后一个索引
  int getLastVisibleIndex({
    required double itemExtent,
    required double viewportHeight,
  }) {
    if (!_scrollController.hasClients) return 0;
    final firstIndex = getFirstVisibleIndex(itemExtent: itemExtent);
    final visibleCount = (viewportHeight / itemExtent).ceil();
    return firstIndex + visibleCount;
  }

  /// 释放资源
  void dispose() {
    _scrollController.dispose();
  }
}
