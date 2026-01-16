/// VelocityUI 头像组件
library velocity_avatar;

import 'package:flutter/material.dart';
import '../../../core/types/component_size.dart';
import 'avatar_style.dart';

export 'avatar_style.dart';

/// 头像尺寸（已弃用，请使用 VelocitySize 或 VelocityExtendedSize）
@Deprecated('Use VelocitySize or VelocityExtendedSize instead')
enum VelocityAvatarSize { xs, sm, md, lg, xl }

/// 头像形状
enum VelocityAvatarShape { circle, square, rounded }

/// VelocityUI 头像组件
class VelocityAvatar extends StatelessWidget {
  /// 创建头像组件
  ///
  /// 使用统一的 [VelocitySize] 尺寸枚举。
  const VelocityAvatar({
    super.key,
    this.imageUrl,
    this.name,
    this.icon,
    this.size = VelocitySize.medium,
    this.shape = VelocityAvatarShape.circle,
    this.customSize,
    this.style,
    this.onTap,
  }) : _legacySize = null;

  /// 创建头像组件（使用扩展尺寸）
  ///
  /// 使用 [VelocityExtendedSize] 提供更细粒度的尺寸控制。
  const VelocityAvatar.extended({
    super.key,
    this.imageUrl,
    this.name,
    this.icon,
    VelocityExtendedSize extendedSize = VelocityExtendedSize.medium,
    this.shape = VelocityAvatarShape.circle,
    this.customSize,
    this.style,
    this.onTap,
  })  : size = VelocitySize.medium,
        _legacySize = extendedSize;

  /// 图片地址
  final String? imageUrl;

  /// 名称（生成首字母）
  final String? name;

  /// 自定义图标
  final IconData? icon;

  /// 尺寸（使用统一的 VelocitySize）
  final VelocitySize size;

  /// 扩展尺寸（内部使用）
  final VelocityExtendedSize? _legacySize;

  /// 形状
  final VelocityAvatarShape shape;

  /// 自定义尺寸
  final double? customSize;

  /// 自定义样式
  final VelocityAvatarStyle? style;

  /// 点击回调
  final VoidCallback? onTap;

  double get _size {
    if (customSize != null) return customSize!;

    // 如果使用扩展尺寸
    final legacySize = _legacySize;
    if (legacySize != null) {
      switch (legacySize) {
        case VelocityExtendedSize.xs:
          return 24;
        case VelocityExtendedSize.small:
          return 32;
        case VelocityExtendedSize.medium:
          return 40;
        case VelocityExtendedSize.large:
          return 48;
        case VelocityExtendedSize.xl:
          return 64;
      }
    }

    // 使用统一尺寸
    switch (size) {
      case VelocitySize.small:
        return 32;
      case VelocitySize.medium:
        return 40;
      case VelocitySize.large:
        return 48;
    }
  }

  double get _fontSize {
    final legacySize = _legacySize;
    if (legacySize != null) {
      switch (legacySize) {
        case VelocityExtendedSize.xs:
          return 10;
        case VelocityExtendedSize.small:
          return 12;
        case VelocityExtendedSize.medium:
          return 14;
        case VelocityExtendedSize.large:
          return 18;
        case VelocityExtendedSize.xl:
          return 24;
      }
    }

    switch (size) {
      case VelocitySize.small:
        return 12;
      case VelocitySize.medium:
        return 14;
      case VelocitySize.large:
        return 18;
    }
  }

  double get _iconSize {
    final legacySize = _legacySize;
    if (legacySize != null) {
      switch (legacySize) {
        case VelocityExtendedSize.xs:
          return 14;
        case VelocityExtendedSize.small:
          return 16;
        case VelocityExtendedSize.medium:
          return 20;
        case VelocityExtendedSize.large:
          return 24;
        case VelocityExtendedSize.xl:
          return 32;
      }
    }

    switch (size) {
      case VelocitySize.small:
        return 16;
      case VelocitySize.medium:
        return 20;
      case VelocitySize.large:
        return 24;
    }
  }

  BorderRadius get _borderRadius {
    switch (shape) {
      case VelocityAvatarShape.circle:
        return BorderRadius.circular(_size / 2);
      case VelocityAvatarShape.square:
        return BorderRadius.zero;
      case VelocityAvatarShape.rounded:
        return const BorderRadius.all(Radius.circular(8));
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? VelocityAvatarStyle.defaults();

    Widget content;
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      content = ClipRRect(
        borderRadius: _borderRadius,
        child: Image.network(
          imageUrl!,
          width: _size,
          height: _size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              _buildFallback(effectiveStyle),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return _buildFallback(effectiveStyle);
          },
        ),
      );
    } else {
      content = _buildFallback(effectiveStyle);
    }

    Widget avatar = Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        borderRadius: _borderRadius,
        border: effectiveStyle.border,
      ),
      clipBehavior: Clip.antiAlias,
      child: content,
    );

    if (onTap != null) {
      avatar = GestureDetector(onTap: onTap, child: avatar);
    }

    return avatar;
  }

  Widget _buildFallback(VelocityAvatarStyle style) {
    return Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        color: style.backgroundColor,
        borderRadius: _borderRadius,
      ),
      child: Center(
        child: icon != null
            ? Icon(icon, size: _iconSize, color: style.foregroundColor)
            : name != null && name!.isNotEmpty
                ? Text(_getInitials(name!),
                    style: TextStyle(
                        color: style.foregroundColor,
                        fontSize: _fontSize,
                        fontWeight: FontWeight.w500))
                : Icon(Icons.person,
                    size: _iconSize, color: style.foregroundColor),
      ),
    );
  }

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return name.substring(0, name.length >= 2 ? 2 : 1).toUpperCase();
  }
}

/// VelocityUI 头像组
class VelocityAvatarGroup extends StatelessWidget {
  /// 创建头像组
  const VelocityAvatarGroup({
    required this.avatars,
    super.key,
    this.max = 5,
    this.size = VelocitySize.medium,
    this.overlap = 8,
    this.style,
  });

  /// 头像列表
  final List<VelocityAvatar> avatars;

  /// 最大显示数量
  final int max;

  /// 尺寸
  final VelocitySize size;

  /// 重叠距离
  final double overlap;

  /// 样式
  final VelocityAvatarGroupStyle? style;

  @override
  Widget build(BuildContext context) {
    final displayAvatars = avatars.take(max).toList();
    final remaining = avatars.length - max;
    final effectiveStyle = style ?? VelocityAvatarGroupStyle.defaults();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < displayAvatars.length; i++)
          Transform.translate(
            offset: Offset(-i * overlap, 0),
            child: VelocityAvatar(
              imageUrl: displayAvatars[i].imageUrl,
              name: displayAvatars[i].name,
              icon: displayAvatars[i].icon,
              size: size,
              style: VelocityAvatarStyle(
                backgroundColor: displayAvatars[i].style?.backgroundColor,
                foregroundColor: displayAvatars[i].style?.foregroundColor,
                border: Border.all(
                    color: effectiveStyle.borderColor,
                    width: effectiveStyle.borderWidth),
              ),
            ),
          ),
        if (remaining > 0)
          Transform.translate(
            offset: Offset(-displayAvatars.length * overlap, 0),
            child: VelocityAvatar(
              name: '+$remaining',
              size: size,
              style: VelocityAvatarStyle(
                backgroundColor: effectiveStyle.overflowBackgroundColor,
                foregroundColor: effectiveStyle.overflowForegroundColor,
                border: Border.all(
                    color: effectiveStyle.borderColor,
                    width: effectiveStyle.borderWidth),
              ),
            ),
          ),
      ],
    );
  }
}
