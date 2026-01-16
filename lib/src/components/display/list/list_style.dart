library velocity_list_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

/// VelocityList 高性能列表样式
class VelocityListStyle {
  /// 创建列表样式
  const VelocityListStyle({
    this.defaultCacheExtent = 250.0,
    this.loadingIndicatorColor = VelocityColors.primary,
    this.refreshIndicatorColor = VelocityColors.primary,
    this.refreshIndicatorBackgroundColor = VelocityColors.white,
    this.emptyIconColor = VelocityColors.gray400,
    this.emptyTextStyle = const TextStyle(
      fontSize: 14,
      color: VelocityColors.gray500,
    ),
    this.emptyText = '暂无数据',
    this.errorIconColor = VelocityColors.error,
    this.errorTextStyle = const TextStyle(
      fontSize: 14,
      color: VelocityColors.gray500,
    ),
    this.errorText = '加载失败',
    this.retryText = '点击重试',
    this.footerPadding = const EdgeInsets.symmetric(vertical: 16),
    this.footerTextStyle = const TextStyle(
      fontSize: 14,
      color: VelocityColors.gray500,
    ),
    this.loadingMoreText = '加载中...',
    this.noMoreText = '没有更多了',
  });

  /// 默认缓存区域大小
  final double defaultCacheExtent;

  /// 加载指示器颜色
  final Color loadingIndicatorColor;

  /// 下拉刷新指示器颜色
  final Color refreshIndicatorColor;

  /// 下拉刷新指示器背景颜色
  final Color refreshIndicatorBackgroundColor;

  /// 空状态图标颜色
  final Color emptyIconColor;

  /// 空状态文本样式
  final TextStyle emptyTextStyle;

  /// 空状态文本
  final String emptyText;

  /// 错误状态图标颜色
  final Color errorIconColor;

  /// 错误状态文本样式
  final TextStyle errorTextStyle;

  /// 错误状态文本
  final String errorText;

  /// 重试按钮文本
  final String retryText;

  /// 底部加载区域内边距
  final EdgeInsets footerPadding;

  /// 底部文本样式
  final TextStyle footerTextStyle;

  /// 加载更多文本
  final String loadingMoreText;

  /// 没有更多数据文本
  final String noMoreText;

  /// 复制并修改样式
  VelocityListStyle copyWith({
    double? defaultCacheExtent,
    Color? loadingIndicatorColor,
    Color? refreshIndicatorColor,
    Color? refreshIndicatorBackgroundColor,
    Color? emptyIconColor,
    TextStyle? emptyTextStyle,
    String? emptyText,
    Color? errorIconColor,
    TextStyle? errorTextStyle,
    String? errorText,
    String? retryText,
    EdgeInsets? footerPadding,
    TextStyle? footerTextStyle,
    String? loadingMoreText,
    String? noMoreText,
  }) {
    return VelocityListStyle(
      defaultCacheExtent: defaultCacheExtent ?? this.defaultCacheExtent,
      loadingIndicatorColor:
          loadingIndicatorColor ?? this.loadingIndicatorColor,
      refreshIndicatorColor:
          refreshIndicatorColor ?? this.refreshIndicatorColor,
      refreshIndicatorBackgroundColor: refreshIndicatorBackgroundColor ??
          this.refreshIndicatorBackgroundColor,
      emptyIconColor: emptyIconColor ?? this.emptyIconColor,
      emptyTextStyle: emptyTextStyle ?? this.emptyTextStyle,
      emptyText: emptyText ?? this.emptyText,
      errorIconColor: errorIconColor ?? this.errorIconColor,
      errorTextStyle: errorTextStyle ?? this.errorTextStyle,
      errorText: errorText ?? this.errorText,
      retryText: retryText ?? this.retryText,
      footerPadding: footerPadding ?? this.footerPadding,
      footerTextStyle: footerTextStyle ?? this.footerTextStyle,
      loadingMoreText: loadingMoreText ?? this.loadingMoreText,
      noMoreText: noMoreText ?? this.noMoreText,
    );
  }
}

class VelocityListTileStyle {
  const VelocityListTileStyle({
    this.backgroundColor = VelocityColors.white,
    this.selectedColor = VelocityColors.primaryLight,
    this.splashColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.densePadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.titleStyle =
        const TextStyle(fontSize: 16, color: VelocityColors.gray900),
    this.subtitleStyle =
        const TextStyle(fontSize: 14, color: VelocityColors.gray500),
    this.leadingSpacing = 16,
    this.trailingSpacing = 16,
    this.subtitleSpacing = 4,
  });

  final Color backgroundColor;
  final Color selectedColor;
  final Color? splashColor;
  final EdgeInsets padding;
  final EdgeInsets densePadding;
  final TextStyle titleStyle;
  final TextStyle subtitleStyle;
  final double leadingSpacing;
  final double trailingSpacing;
  final double subtitleSpacing;
}

class VelocityListGroupStyle {
  const VelocityListGroupStyle({
    this.backgroundColor = VelocityColors.white,
    this.borderRadius,
    this.headerStyle = const TextStyle(
        fontSize: 13,
        color: VelocityColors.gray500,
        fontWeight: FontWeight.w500),
    this.headerPadding = const EdgeInsets.only(left: 16, bottom: 8, top: 16),
    this.dividerColor = VelocityColors.gray200,
    this.dividerIndent = 16,
  });

  final Color backgroundColor;
  final BorderRadius? borderRadius;
  final TextStyle headerStyle;
  final EdgeInsets headerPadding;
  final Color dividerColor;
  final double dividerIndent;
}
