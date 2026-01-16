import 'package:flutter/widgets.dart';

/// 圆角设计令牌
///
/// 提供标准化的圆角值，用于组件的边框圆角。
///
/// 使用示例:
/// ```dart
/// Container(
///   decoration: BoxDecoration(
///     borderRadius: VelocityRadius.borderMd,
///   ),
///   child: Text('Hello'),
/// )
/// ```
class VelocityRadius {
  const VelocityRadius._();

  // ============================================
  // 基础圆角值
  // ============================================

  /// 无圆角 (0px)
  static const double none = 0;

  /// 超小圆角 (2px)
  static const double xs = 2;

  /// 小圆角 (4px)
  static const double sm = 4;

  /// 中等圆角 (8px)
  static const double md = 8;

  /// 大圆角 (12px)
  static const double lg = 12;

  /// 超大圆角 (16px)
  static const double xl = 16;

  /// 特大圆角 (24px)
  static const double xxl = 24;

  /// 完全圆角 (9999px) - 用于胶囊形状
  static const double full = 9999;

  // ============================================
  // Radius 便捷常量
  // ============================================

  /// 无圆角 Radius
  static const Radius radiusNone = Radius.zero;

  /// 超小圆角 Radius (2px)
  static const Radius radiusXs = Radius.circular(xs);

  /// 小圆角 Radius (4px)
  static const Radius radiusSm = Radius.circular(sm);

  /// 中等圆角 Radius (8px)
  static const Radius radiusMd = Radius.circular(md);

  /// 大圆角 Radius (12px)
  static const Radius radiusLg = Radius.circular(lg);

  /// 超大圆角 Radius (16px)
  static const Radius radiusXl = Radius.circular(xl);

  /// 特大圆角 Radius (24px)
  static const Radius radiusXxl = Radius.circular(xxl);

  /// 完全圆角 Radius
  static const Radius radiusFull = Radius.circular(full);

  // ============================================
  // BorderRadius 便捷常量 - 全方向
  // ============================================

  /// 无圆角 BorderRadius
  static const BorderRadius borderNone = BorderRadius.zero;

  /// 超小圆角 BorderRadius (2px all)
  static const BorderRadius borderXs = BorderRadius.all(radiusXs);

  /// 小圆角 BorderRadius (4px all)
  static const BorderRadius borderSm = BorderRadius.all(radiusSm);

  /// 中等圆角 BorderRadius (8px all)
  static const BorderRadius borderMd = BorderRadius.all(radiusMd);

  /// 大圆角 BorderRadius (12px all)
  static const BorderRadius borderLg = BorderRadius.all(radiusLg);

  /// 超大圆角 BorderRadius (16px all)
  static const BorderRadius borderXl = BorderRadius.all(radiusXl);

  /// 特大圆角 BorderRadius (24px all)
  static const BorderRadius borderXxl = BorderRadius.all(radiusXxl);

  /// 完全圆角 BorderRadius - 胶囊形状
  static const BorderRadius borderFull = BorderRadius.all(radiusFull);

  // ============================================
  // BorderRadius 便捷常量 - 顶部
  // ============================================

  /// 小圆角 BorderRadius - 仅顶部 (4px top)
  static const BorderRadius borderTopSm = BorderRadius.only(
    topLeft: radiusSm,
    topRight: radiusSm,
  );

  /// 中等圆角 BorderRadius - 仅顶部 (8px top)
  static const BorderRadius borderTopMd = BorderRadius.only(
    topLeft: radiusMd,
    topRight: radiusMd,
  );

  /// 大圆角 BorderRadius - 仅顶部 (12px top)
  static const BorderRadius borderTopLg = BorderRadius.only(
    topLeft: radiusLg,
    topRight: radiusLg,
  );

  /// 超大圆角 BorderRadius - 仅顶部 (16px top)
  static const BorderRadius borderTopXl = BorderRadius.only(
    topLeft: radiusXl,
    topRight: radiusXl,
  );

  // ============================================
  // BorderRadius 便捷常量 - 底部
  // ============================================

  /// 小圆角 BorderRadius - 仅底部 (4px bottom)
  static const BorderRadius borderBottomSm = BorderRadius.only(
    bottomLeft: radiusSm,
    bottomRight: radiusSm,
  );

  /// 中等圆角 BorderRadius - 仅底部 (8px bottom)
  static const BorderRadius borderBottomMd = BorderRadius.only(
    bottomLeft: radiusMd,
    bottomRight: radiusMd,
  );

  /// 大圆角 BorderRadius - 仅底部 (12px bottom)
  static const BorderRadius borderBottomLg = BorderRadius.only(
    bottomLeft: radiusLg,
    bottomRight: radiusLg,
  );

  /// 超大圆角 BorderRadius - 仅底部 (16px bottom)
  static const BorderRadius borderBottomXl = BorderRadius.only(
    bottomLeft: radiusXl,
    bottomRight: radiusXl,
  );

  // ============================================
  // BorderRadius 便捷常量 - 左侧
  // ============================================

  /// 小圆角 BorderRadius - 仅左侧 (4px left)
  static const BorderRadius borderLeftSm = BorderRadius.only(
    topLeft: radiusSm,
    bottomLeft: radiusSm,
  );

  /// 中等圆角 BorderRadius - 仅左侧 (8px left)
  static const BorderRadius borderLeftMd = BorderRadius.only(
    topLeft: radiusMd,
    bottomLeft: radiusMd,
  );

  // ============================================
  // BorderRadius 便捷常量 - 右侧
  // ============================================

  /// 小圆角 BorderRadius - 仅右侧 (4px right)
  static const BorderRadius borderRightSm = BorderRadius.only(
    topRight: radiusSm,
    bottomRight: radiusSm,
  );

  /// 中等圆角 BorderRadius - 仅右侧 (8px right)
  static const BorderRadius borderRightMd = BorderRadius.only(
    topRight: radiusMd,
    bottomRight: radiusMd,
  );
}
