/// VelocityUI 图标组件
library velocity_icon;

import 'package:flutter/material.dart';
import '../../../core/types/component_size.dart';
import 'icon_style.dart';

export 'icon_style.dart';

/// 图标尺寸（已弃用，请使用 VelocitySize 或 VelocityExtendedSize）
@Deprecated('Use VelocitySize or VelocityExtendedSize instead')
enum VelocityIconSize { xs, sm, md, lg, xl }

/// VelocityUI 图标组件
class VelocityIcon extends StatelessWidget {
  /// 创建图标组件
  ///
  /// 使用统一的 [VelocitySize] 尺寸枚举。
  const VelocityIcon(
    this.icon, {
    super.key,
    this.size = VelocitySize.medium,
    this.customSize,
    this.color,
    this.style,
    this.semanticLabel,
  }) : _legacySize = null;

  /// 创建图标组件（使用扩展尺寸）
  ///
  /// 使用 [VelocityExtendedSize] 提供更细粒度的尺寸控制。
  const VelocityIcon.extended(
    this.icon, {
    super.key,
    VelocityExtendedSize extendedSize = VelocityExtendedSize.medium,
    this.customSize,
    this.color,
    this.style,
    this.semanticLabel,
  })  : size = VelocitySize.medium,
        _legacySize = extendedSize;

  /// 图标数据
  final IconData icon;

  /// 尺寸（使用统一的 VelocitySize）
  final VelocitySize size;

  /// 扩展尺寸（内部使用）
  final VelocityExtendedSize? _legacySize;

  /// 自定义尺寸
  final double? customSize;

  /// 颜色
  final Color? color;

  /// 自定义样式
  final VelocityIconStyle? style;

  /// 语义标签
  final String? semanticLabel;

  double get _size {
    if (customSize != null) return customSize!;

    // 如果使用扩展尺寸
    final legacySize = _legacySize;
    if (legacySize != null) {
      switch (legacySize) {
        case VelocityExtendedSize.xs:
          return 14;
        case VelocityExtendedSize.small:
          return 18;
        case VelocityExtendedSize.medium:
          return 24;
        case VelocityExtendedSize.large:
          return 32;
        case VelocityExtendedSize.xl:
          return 48;
      }
    }

    // 使用统一尺寸
    switch (size) {
      case VelocitySize.small:
        return 18;
      case VelocitySize.medium:
        return 24;
      case VelocitySize.large:
        return 32;
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? VelocityIconStyle.defaults();

    return Icon(
      icon,
      size: _size,
      color: color ?? effectiveStyle.color,
      semanticLabel: semanticLabel,
    );
  }
}
