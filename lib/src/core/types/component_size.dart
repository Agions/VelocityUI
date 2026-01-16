/// VelocityUI 统一组件尺寸枚举
///
/// 提供一致的尺寸枚举，确保所有组件使用相同的尺寸命名约定。
/// 根据 Requirements 5.3，所有组件应使用 small, medium, large 尺寸值。
library component_size;

/// 统一的组件尺寸枚举
///
/// 所有 VelocityUI 组件应使用此枚举来定义尺寸。
/// 尺寸顺序为: small < medium < large
///
/// 示例:
/// ```dart
/// VelocityButton(
///   size: VelocitySize.medium,
///   child: Text('Click me'),
/// )
/// ```
enum VelocitySize {
  /// 小尺寸
  ///
  /// 适用于紧凑的 UI 布局或次要操作。
  small,

  /// 中等尺寸（默认）
  ///
  /// 适用于大多数标准 UI 场景。
  medium,

  /// 大尺寸
  ///
  /// 适用于需要强调的主要操作或大屏幕布局。
  large,
}

/// 扩展尺寸枚举（包含额外的 xs 和 xl）
///
/// 用于需要更细粒度尺寸控制的组件，如图标和头像。
/// 尺寸顺序为: xs < small < medium < large < xl
enum VelocityExtendedSize {
  /// 超小尺寸
  xs,

  /// 小尺寸
  small,

  /// 中等尺寸（默认）
  medium,

  /// 大尺寸
  large,

  /// 超大尺寸
  xl,
}

/// 尺寸工具类
///
/// 提供尺寸相关的工具方法。
class VelocitySizeUtils {
  VelocitySizeUtils._();

  /// 将扩展尺寸转换为基础尺寸
  ///
  /// xs 和 small 映射到 small
  /// medium 映射到 medium
  /// large 和 xl 映射到 large
  static VelocitySize toBaseSize(VelocityExtendedSize extendedSize) {
    switch (extendedSize) {
      case VelocityExtendedSize.xs:
      case VelocityExtendedSize.small:
        return VelocitySize.small;
      case VelocityExtendedSize.medium:
        return VelocitySize.medium;
      case VelocityExtendedSize.large:
      case VelocityExtendedSize.xl:
        return VelocitySize.large;
    }
  }

  /// 将基础尺寸转换为扩展尺寸
  ///
  /// small 映射到 small
  /// medium 映射到 medium
  /// large 映射到 large
  static VelocityExtendedSize toExtendedSize(VelocitySize baseSize) {
    switch (baseSize) {
      case VelocitySize.small:
        return VelocityExtendedSize.small;
      case VelocitySize.medium:
        return VelocityExtendedSize.medium;
      case VelocitySize.large:
        return VelocityExtendedSize.large;
    }
  }

  /// 比较两个尺寸的大小
  ///
  /// 返回值:
  /// - 负数: size1 < size2
  /// - 0: size1 == size2
  /// - 正数: size1 > size2
  static int compare(VelocitySize size1, VelocitySize size2) {
    return size1.index - size2.index;
  }

  /// 比较两个扩展尺寸的大小
  ///
  /// 返回值:
  /// - 负数: size1 < size2
  /// - 0: size1 == size2
  /// - 正数: size1 > size2
  static int compareExtended(
      VelocityExtendedSize size1, VelocityExtendedSize size2) {
    return size1.index - size2.index;
  }

  /// 检查尺寸是否小于另一个尺寸
  static bool isSmaller(VelocitySize size1, VelocitySize size2) {
    return compare(size1, size2) < 0;
  }

  /// 检查尺寸是否大于另一个尺寸
  static bool isLarger(VelocitySize size1, VelocitySize size2) {
    return compare(size1, size2) > 0;
  }
}
