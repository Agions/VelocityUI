/// VelocityUI 按钮组件
///
/// 提供多种样式的按钮组件，支持主题定制、无障碍访问和 const 构造函数。
library velocity_button;

import 'package:flutter/material.dart';
import 'button_style.dart';

export 'button_style.dart';

/// 按钮类型
enum VelocityButtonType {
  primary,
  secondary,
  outline,
  text,
  danger,
  success,
  warning
}

/// 按钮尺寸
enum VelocityButtonSize { small, medium, large }

/// 图标位置
enum VelocityIconPosition { left, right }

/// VelocityUI 按钮组件
///
/// 支持 const 构造函数，可用于优化 Widget 重建。
/// 提供完整的无障碍支持，包括语义标签和焦点指示器。
///
/// 示例:
/// ```dart
/// const VelocityButton.text(
///   text: 'Click me',
///   semanticLabel: 'Submit form button',
/// )
/// ```
class VelocityButton extends StatefulWidget {
  /// 创建一个按钮
  ///
  /// [child] 按钮内容
  /// [onPressed] 点击回调
  /// [onLongPress] 长按回调
  /// [type] 按钮类型
  /// [size] 按钮尺寸
  /// [loading] 是否显示加载状态
  /// [disabled] 是否禁用
  /// [fullWidth] 是否全宽
  /// [style] 自定义样式
  /// [semanticLabel] 无障碍语义标签
  /// [focusNode] 焦点节点
  /// [autofocus] 是否自动获取焦点
  const VelocityButton({
    required this.child,
    super.key,
    this.onPressed,
    this.onLongPress,
    this.type = VelocityButtonType.primary,
    this.size = VelocityButtonSize.medium,
    this.loading = false,
    this.disabled = false,
    this.fullWidth = false,
    this.style,
    this.semanticLabel,
    this.focusNode,
    this.autofocus = false,
  })  : _text = null,
        _icon = null,
        _iconPosition = VelocityIconPosition.left;

  /// 创建一个带文本的按钮
  ///
  /// [text] 按钮文本
  /// [onPressed] 点击回调
  /// [semanticLabel] 无障碍语义标签，如果未提供则使用 [text]
  const VelocityButton.text({
    required String text,
    super.key,
    this.onPressed,
    this.onLongPress,
    this.type = VelocityButtonType.primary,
    this.size = VelocityButtonSize.medium,
    this.loading = false,
    this.disabled = false,
    this.fullWidth = false,
    this.style,
    this.semanticLabel,
    this.focusNode,
    this.autofocus = false,
  })  : child = null,
        _text = text,
        _icon = null,
        _iconPosition = VelocityIconPosition.left;

  /// 创建一个带图标的按钮
  ///
  /// [text] 按钮文本
  /// [icon] 图标
  /// [iconPosition] 图标位置
  /// [semanticLabel] 无障碍语义标签，如果未提供则使用 [text]
  const VelocityButton.icon({
    required String text,
    required IconData icon,
    super.key,
    VelocityIconPosition iconPosition = VelocityIconPosition.left,
    this.onPressed,
    this.onLongPress,
    this.type = VelocityButtonType.primary,
    this.size = VelocityButtonSize.medium,
    this.loading = false,
    this.disabled = false,
    this.fullWidth = false,
    this.style,
    this.semanticLabel,
    this.focusNode,
    this.autofocus = false,
  })  : child = null,
        _text = text,
        _icon = icon,
        _iconPosition = iconPosition;

  /// 按钮内容
  final Widget? child;

  /// 点击回调
  final VoidCallback? onPressed;

  /// 长按回调
  final VoidCallback? onLongPress;

  /// 按钮类型
  final VelocityButtonType type;

  /// 按钮尺寸
  final VelocityButtonSize size;

  /// 是否显示加载状态
  final bool loading;

  /// 是否禁用
  final bool disabled;

  /// 是否全宽
  final bool fullWidth;

  /// 自定义样式
  final VelocityButtonStyle? style;

  /// 无障碍语义标签
  ///
  /// 用于屏幕阅读器读取按钮的描述。
  /// 如果未提供，将使用按钮文本作为语义标签。
  final String? semanticLabel;

  /// 焦点节点
  final FocusNode? focusNode;

  /// 是否自动获取焦点
  final bool autofocus;

  final String? _text;
  final IconData? _icon;
  final VelocityIconPosition _iconPosition;

  @override
  State<VelocityButton> createState() => _VelocityButtonState();
}

class _VelocityButtonState extends State<VelocityButton> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(VelocityButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode.removeListener(_handleFocusChange);
      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode.addListener(_handleFocusChange);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _handleFocusChange() {
    if (mounted) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = VelocityButtonStyle.resolve(
      type: widget.type,
      size: widget.size,
      customStyle: widget.style,
    );
    final effectiveDisabled = widget.disabled || widget.loading;

    final content = _buildContent(effectiveStyle);

    final bgColor = effectiveDisabled
        ? (effectiveStyle.disabledBackgroundColor ?? Colors.grey)
        : (effectiveStyle.backgroundColor ?? Colors.blue);

    // Build focus indicator decoration
    BoxDecoration decoration = BoxDecoration(
      color: bgColor,
      borderRadius: effectiveStyle.borderRadius,
      border: _buildBorder(effectiveStyle),
      boxShadow: effectiveStyle.boxShadow,
    );

    // Add focus ring when focused
    if (_isFocused && !effectiveDisabled) {
      decoration = decoration.copyWith(
        boxShadow: [
          ...?effectiveStyle.boxShadow,
          BoxShadow(
            color: (effectiveStyle.backgroundColor ?? Colors.blue)
                .withValues(alpha: 0.4),
            blurRadius: 0,
            spreadRadius: 2,
          ),
        ],
      );
    }

    Widget button = Focus(
      focusNode: _focusNode,
      autofocus: widget.autofocus,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: effectiveDisabled ? null : widget.onPressed,
          onLongPress: effectiveDisabled ? null : widget.onLongPress,
          borderRadius: effectiveStyle.borderRadius,
          splashColor: effectiveStyle.splashColor,
          highlightColor: effectiveStyle.highlightColor,
          canRequestFocus: false, // Focus is handled by parent Focus widget
          child: Container(
            padding: effectiveStyle.padding,
            decoration: decoration,
            child: content,
          ),
        ),
      ),
    );

    if (widget.fullWidth) {
      button = SizedBox(width: double.infinity, child: button);
    }

    // Wrap with Semantics for accessibility
    final effectiveSemanticLabel =
        widget.semanticLabel ?? widget._text ?? 'Button';

    return Semantics(
      button: true,
      enabled: !effectiveDisabled,
      label: effectiveSemanticLabel,
      child: button,
    );
  }

  Border? _buildBorder(VelocityButtonStyle effectiveStyle) {
    if (effectiveStyle.border != null) {
      return effectiveStyle.border;
    }
    return null;
  }

  Widget _buildContent(VelocityButtonStyle effectiveStyle) {
    final effectiveDisabled = widget.disabled || widget.loading;
    final foregroundColor = effectiveDisabled
        ? (effectiveStyle.disabledForegroundColor ?? Colors.grey)
        : (effectiveStyle.foregroundColor ?? Colors.white);

    if (widget.loading) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: effectiveStyle.iconSize ?? 18,
            height: effectiveStyle.iconSize ?? 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
            ),
          ),
          if (widget._text != null) ...[
            SizedBox(width: effectiveStyle.iconSpacing ?? 8),
            Text(widget._text!,
                style:
                    effectiveStyle.textStyle?.copyWith(color: foregroundColor)),
          ],
        ],
      );
    }

    if (widget.child != null) return widget.child!;

    if (widget._icon != null && widget._text != null) {
      final iconWidget = Icon(widget._icon,
          size: effectiveStyle.iconSize ?? 18, color: foregroundColor);
      final textWidget = Text(widget._text!,
          style: effectiveStyle.textStyle?.copyWith(color: foregroundColor));

      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget._iconPosition == VelocityIconPosition.left
            ? [
                iconWidget,
                SizedBox(width: effectiveStyle.iconSpacing ?? 8),
                textWidget
              ]
            : [
                textWidget,
                SizedBox(width: effectiveStyle.iconSpacing ?? 8),
                iconWidget
              ],
      );
    }

    if (widget._text != null) {
      return Text(widget._text!,
          style: effectiveStyle.textStyle?.copyWith(color: foregroundColor));
    }

    return const SizedBox.shrink();
  }
}

/// VelocityUI 图标按钮组件
///
/// 支持 const 构造函数和无障碍访问。
class VelocityIconButton extends StatefulWidget {
  /// 创建一个图标按钮
  ///
  /// [icon] 图标
  /// [onPressed] 点击回调
  /// [size] 按钮尺寸
  /// [iconSize] 图标尺寸
  /// [style] 自定义样式
  /// [disabled] 是否禁用
  /// [loading] 是否显示加载状态
  /// [tooltip] 提示文本
  /// [semanticLabel] 无障碍语义标签
  /// [focusNode] 焦点节点
  /// [autofocus] 是否自动获取焦点
  const VelocityIconButton({
    required this.icon,
    super.key,
    this.onPressed,
    this.size = 40,
    this.iconSize = 20,
    this.style,
    this.disabled = false,
    this.loading = false,
    this.tooltip,
    this.semanticLabel,
    this.focusNode,
    this.autofocus = false,
  });

  /// 图标
  final IconData icon;

  /// 点击回调
  final VoidCallback? onPressed;

  /// 按钮尺寸
  final double size;

  /// 图标尺寸
  final double iconSize;

  /// 自定义样式
  final VelocityIconButtonStyle? style;

  /// 是否禁用
  final bool disabled;

  /// 是否显示加载状态
  final bool loading;

  /// 提示文本
  final String? tooltip;

  /// 无障碍语义标签
  final String? semanticLabel;

  /// 焦点节点
  final FocusNode? focusNode;

  /// 是否自动获取焦点
  final bool autofocus;

  @override
  State<VelocityIconButton> createState() => _VelocityIconButtonState();
}

class _VelocityIconButtonState extends State<VelocityIconButton> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(VelocityIconButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode.removeListener(_handleFocusChange);
      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode.addListener(_handleFocusChange);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _handleFocusChange() {
    if (mounted) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = widget.style ?? VelocityIconButtonStyle.defaults();
    final effectiveDisabled = widget.disabled || widget.loading;

    final effectiveBackgroundColor = effectiveDisabled
        ? (effectiveStyle.disabledBackgroundColor ?? Colors.grey.shade200)
        : (effectiveStyle.backgroundColor ?? Colors.transparent);
    final effectiveIconColor = effectiveDisabled
        ? (effectiveStyle.disabledIconColor ?? Colors.grey)
        : (effectiveStyle.iconColor ?? Colors.grey.shade700);

    final borderRadius =
        effectiveStyle.borderRadius ?? BorderRadius.circular(widget.size / 2);

    // Build decoration with focus indicator
    BoxDecoration? decoration;
    if (effectiveStyle.border != null || _isFocused) {
      decoration = BoxDecoration(
        borderRadius: borderRadius,
        border: effectiveStyle.border,
      );

      if (_isFocused && !effectiveDisabled) {
        decoration = decoration.copyWith(
          boxShadow: [
            BoxShadow(
              color: (effectiveStyle.iconColor ?? Colors.grey.shade700)
                  .withValues(alpha: 0.4),
              blurRadius: 0,
              spreadRadius: 2,
            ),
          ],
        );
      }
    }

    Widget button = Focus(
      focusNode: _focusNode,
      autofocus: widget.autofocus,
      child: Material(
        color: effectiveBackgroundColor,
        borderRadius: borderRadius,
        child: InkWell(
          onTap: effectiveDisabled ? null : widget.onPressed,
          borderRadius: borderRadius,
          splashColor: effectiveStyle.splashColor,
          highlightColor: effectiveStyle.highlightColor,
          canRequestFocus: false,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: decoration,
            child: Center(
              child: widget.loading
                  ? SizedBox(
                      width: widget.iconSize,
                      height: widget.iconSize,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(effectiveIconColor),
                      ),
                    )
                  : Icon(widget.icon,
                      size: widget.iconSize, color: effectiveIconColor),
            ),
          ),
        ),
      ),
    );

    if (widget.tooltip != null) {
      button = Tooltip(message: widget.tooltip!, child: button);
    }

    // Wrap with Semantics for accessibility
    final effectiveSemanticLabel =
        widget.semanticLabel ?? widget.tooltip ?? 'Icon button';

    return Semantics(
      button: true,
      enabled: !effectiveDisabled,
      label: effectiveSemanticLabel,
      child: button,
    );
  }
}
