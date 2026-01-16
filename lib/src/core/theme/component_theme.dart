/// VelocityUI 组件级主题覆盖
///
/// 提供组件级别的主题覆盖功能，允许在局部范围内覆盖主题
/// 而不影响全局主题或兄弟/祖先组件。
library component_theme;

import 'package:flutter/material.dart';
import 'velocity_theme_data.dart';
import 'velocity_theme.dart';

/// 按钮主题覆盖
///
/// 在子树中覆盖按钮主题，不影响全局主题。
///
/// 示例:
/// ```dart
/// VelocityButtonTheme(
///   data: VelocityButtonThemeData(
///     backgroundColor: Colors.red,
///   ),
///   child: VelocityButton.text(
///     text: 'Red Button',
///     onPressed: () {},
///   ),
/// )
/// ```
class VelocityButtonTheme extends StatelessWidget {
  const VelocityButtonTheme({
    required this.data,
    required this.child,
    super.key,
  });

  /// 按钮主题数据
  final VelocityButtonThemeData data;

  /// 子组件
  final Widget child;

  /// 从上下文获取按钮主题数据
  ///
  /// 优先返回最近的 [VelocityButtonTheme] 中的数据，
  /// 如果没有找到，则返回全局主题中的按钮主题。
  static VelocityButtonThemeData of(BuildContext context) {
    final inheritedTheme = context
        .dependOnInheritedWidgetOfExactType<_InheritedVelocityButtonTheme>();
    if (inheritedTheme != null) {
      return inheritedTheme.data;
    }
    // 回退到全局主题
    final globalTheme = VelocityTheme.maybeOf(context);
    return globalTheme?.buttonTheme ?? VelocityButtonThemeData.light();
  }

  /// 尝试从上下文获取按钮主题数据
  ///
  /// 仅返回最近的 [VelocityButtonTheme] 中的数据，
  /// 如果没有找到则返回 null。
  static VelocityButtonThemeData? maybeOf(BuildContext context) {
    final inheritedTheme = context
        .dependOnInheritedWidgetOfExactType<_InheritedVelocityButtonTheme>();
    return inheritedTheme?.data;
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedVelocityButtonTheme(
      data: data,
      child: child,
    );
  }
}

class _InheritedVelocityButtonTheme extends InheritedWidget {
  const _InheritedVelocityButtonTheme({
    required this.data,
    required super.child,
  });

  final VelocityButtonThemeData data;

  @override
  bool updateShouldNotify(_InheritedVelocityButtonTheme oldWidget) {
    return data != oldWidget.data;
  }
}

/// 输入框主题覆盖
///
/// 在子树中覆盖输入框主题，不影响全局主题。
///
/// 示例:
/// ```dart
/// VelocityInputTheme(
///   data: VelocityInputThemeData(
///     borderColor: Colors.blue,
///   ),
///   child: VelocityInput(
///     placeholder: 'Blue border input',
///   ),
/// )
/// ```
class VelocityInputTheme extends StatelessWidget {
  const VelocityInputTheme({
    required this.data,
    required this.child,
    super.key,
  });

  /// 输入框主题数据
  final VelocityInputThemeData data;

  /// 子组件
  final Widget child;

  /// 从上下文获取输入框主题数据
  static VelocityInputThemeData of(BuildContext context) {
    final inheritedTheme = context
        .dependOnInheritedWidgetOfExactType<_InheritedVelocityInputTheme>();
    if (inheritedTheme != null) {
      return inheritedTheme.data;
    }
    final globalTheme = VelocityTheme.maybeOf(context);
    return globalTheme?.inputTheme ?? VelocityInputThemeData.light();
  }

  /// 尝试从上下文获取输入框主题数据
  static VelocityInputThemeData? maybeOf(BuildContext context) {
    final inheritedTheme = context
        .dependOnInheritedWidgetOfExactType<_InheritedVelocityInputTheme>();
    return inheritedTheme?.data;
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedVelocityInputTheme(
      data: data,
      child: child,
    );
  }
}

class _InheritedVelocityInputTheme extends InheritedWidget {
  const _InheritedVelocityInputTheme({
    required this.data,
    required super.child,
  });

  final VelocityInputThemeData data;

  @override
  bool updateShouldNotify(_InheritedVelocityInputTheme oldWidget) {
    return data != oldWidget.data;
  }
}

/// 卡片主题覆盖
///
/// 在子树中覆盖卡片主题，不影响全局主题。
class VelocityCardTheme extends StatelessWidget {
  const VelocityCardTheme({
    required this.data,
    required this.child,
    super.key,
  });

  /// 卡片主题数据
  final VelocityCardThemeData data;

  /// 子组件
  final Widget child;

  /// 从上下文获取卡片主题数据
  static VelocityCardThemeData of(BuildContext context) {
    final inheritedTheme = context
        .dependOnInheritedWidgetOfExactType<_InheritedVelocityCardTheme>();
    if (inheritedTheme != null) {
      return inheritedTheme.data;
    }
    final globalTheme = VelocityTheme.maybeOf(context);
    return globalTheme?.cardTheme ?? VelocityCardThemeData.light();
  }

  /// 尝试从上下文获取卡片主题数据
  static VelocityCardThemeData? maybeOf(BuildContext context) {
    final inheritedTheme = context
        .dependOnInheritedWidgetOfExactType<_InheritedVelocityCardTheme>();
    return inheritedTheme?.data;
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedVelocityCardTheme(
      data: data,
      child: child,
    );
  }
}

class _InheritedVelocityCardTheme extends InheritedWidget {
  const _InheritedVelocityCardTheme({
    required this.data,
    required super.child,
  });

  final VelocityCardThemeData data;

  @override
  bool updateShouldNotify(_InheritedVelocityCardTheme oldWidget) {
    return data != oldWidget.data;
  }
}

/// 对话框主题覆盖
///
/// 在子树中覆盖对话框主题，不影响全局主题。
class VelocityDialogTheme extends StatelessWidget {
  const VelocityDialogTheme({
    required this.data,
    required this.child,
    super.key,
  });

  /// 对话框主题数据
  final VelocityDialogThemeData data;

  /// 子组件
  final Widget child;

  /// 从上下文获取对话框主题数据
  static VelocityDialogThemeData of(BuildContext context) {
    final inheritedTheme = context
        .dependOnInheritedWidgetOfExactType<_InheritedVelocityDialogTheme>();
    if (inheritedTheme != null) {
      return inheritedTheme.data;
    }
    final globalTheme = VelocityTheme.maybeOf(context);
    return globalTheme?.dialogTheme ?? VelocityDialogThemeData.light();
  }

  /// 尝试从上下文获取对话框主题数据
  static VelocityDialogThemeData? maybeOf(BuildContext context) {
    final inheritedTheme = context
        .dependOnInheritedWidgetOfExactType<_InheritedVelocityDialogTheme>();
    return inheritedTheme?.data;
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedVelocityDialogTheme(
      data: data,
      child: child,
    );
  }
}

class _InheritedVelocityDialogTheme extends InheritedWidget {
  const _InheritedVelocityDialogTheme({
    required this.data,
    required super.child,
  });

  final VelocityDialogThemeData data;

  @override
  bool updateShouldNotify(_InheritedVelocityDialogTheme oldWidget) {
    return data != oldWidget.data;
  }
}
