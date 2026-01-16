/// VelocityUI 统一禁用状态处理
///
/// 提供一致的禁用状态处理模式，确保所有组件的禁用行为一致。
/// 根据 Requirements 5.4，所有组件应使用一致的 disabled 参数和行为。
library disabled_state;

/// 禁用状态接口
///
/// 所有支持禁用状态的 VelocityUI 组件应实现此接口。
/// 这确保了禁用状态处理的一致性。
abstract class VelocityDisableable {
  /// 是否禁用
  ///
  /// 当设置为 true 时，组件应：
  /// 1. 不触发任何用户交互回调（onTap, onPressed, onChanged 等）
  /// 2. 显示禁用状态的视觉样式
  /// 3. 不响应键盘导航
  bool get disabled;
}

/// 禁用状态工具类
///
/// 提供禁用状态相关的工具方法。
class VelocityDisabledUtils {
  VelocityDisabledUtils._();

  /// 检查组件是否有效禁用
  ///
  /// 考虑 disabled 和 loading 状态。
  /// 当组件处于 loading 状态时，也应被视为禁用。
  static bool isEffectivelyDisabled({
    required bool disabled,
    bool loading = false,
  }) {
    return disabled || loading;
  }

  /// 获取有效的回调
  ///
  /// 如果组件被禁用，返回 null；否则返回原始回调。
  /// 这确保了禁用状态下不会触发任何回调。
  static T? getEffectiveCallback<T extends Function>({
    required T? callback,
    required bool disabled,
    bool loading = false,
  }) {
    if (isEffectivelyDisabled(disabled: disabled, loading: loading)) {
      return null;
    }
    return callback;
  }

  /// 获取有效的 VoidCallback
  ///
  /// 如果组件被禁用，返回 null；否则返回原始回调。
  static VoidCallback? getEffectiveVoidCallback({
    required VoidCallback? callback,
    required bool disabled,
    bool loading = false,
  }) {
    return getEffectiveCallback<VoidCallback>(
      callback: callback,
      disabled: disabled,
      loading: loading,
    );
  }

  /// 获取有效的 ValueChanged 回调
  ///
  /// 如果组件被禁用，返回 null；否则返回原始回调。
  static ValueChanged<T>? getEffectiveValueChanged<T>({
    required ValueChanged<T>? callback,
    required bool disabled,
    bool loading = false,
  }) {
    return getEffectiveCallback<ValueChanged<T>>(
      callback: callback,
      disabled: disabled,
      loading: loading,
    );
  }
}

/// VoidCallback 类型定义（用于避免导入 dart:ui）
typedef VoidCallback = void Function();

/// ValueChanged 类型定义
typedef ValueChanged<T> = void Function(T value);
