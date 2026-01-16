/// VelocityUI 输入框组件
///
/// 提供多种样式的输入框组件，支持主题定制、无障碍访问和 const 构造函数。
library velocity_input;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'input_style.dart';

export 'input_style.dart';

/// VelocityUI 输入框组件
///
/// 支持 const 构造函数，可用于优化 Widget 重建。
/// 提供完整的无障碍支持，包括语义标签和焦点指示器。
///
/// 示例:
/// ```dart
/// const VelocityInput(
///   label: 'Email',
///   hint: 'Enter your email',
///   semanticLabel: 'Email input field',
/// )
/// ```
class VelocityInput extends StatefulWidget {
  /// 创建输入框组件
  ///
  /// [controller] 文本控制器
  /// [focusNode] 焦点节点
  /// [label] 标签文本
  /// [hint] 提示文本
  /// [helper] 帮助文本
  /// [error] 错误文本
  /// [prefixIcon] 前缀图标
  /// [suffixIcon] 后缀图标
  /// [prefix] 前缀组件
  /// [suffix] 后缀组件
  /// [obscureText] 是否隐藏文本
  /// [enabled] 是否启用
  /// [readOnly] 是否只读
  /// [autofocus] 是否自动获取焦点
  /// [maxLines] 最大行数
  /// [minLines] 最小行数
  /// [maxLength] 最大长度
  /// [keyboardType] 键盘类型
  /// [textInputAction] 输入动作
  /// [inputFormatters] 输入格式化器
  /// [onChanged] 文本变化回调
  /// [onSubmitted] 提交回调
  /// [onTap] 点击回调
  /// [validator] 验证器
  /// [autovalidateMode] 自动验证模式
  /// [size] 输入框尺寸
  /// [style] 自定义样式
  /// [semanticLabel] 无障碍语义标签
  const VelocityInput({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.helper,
    this.error,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.validator,
    this.autovalidateMode,
    this.size = VelocityInputSize.medium,
    this.style,
    this.semanticLabel,
  });

  /// 文本控制器
  final TextEditingController? controller;

  /// 焦点节点
  final FocusNode? focusNode;

  /// 标签文本
  final String? label;

  /// 提示文本
  final String? hint;

  /// 帮助文本
  final String? helper;

  /// 错误文本
  final String? error;

  /// 前缀图标
  final IconData? prefixIcon;

  /// 后缀图标
  final IconData? suffixIcon;

  /// 前缀组件
  final Widget? prefix;

  /// 后缀组件
  final Widget? suffix;

  /// 是否隐藏文本（密码输入）
  final bool obscureText;

  /// 是否启用
  final bool enabled;

  /// 是否只读
  final bool readOnly;

  /// 是否自动获取焦点
  final bool autofocus;

  /// 最大行数
  final int maxLines;

  /// 最小行数
  final int? minLines;

  /// 最大长度
  final int? maxLength;

  /// 键盘类型
  final TextInputType? keyboardType;

  /// 输入动作
  final TextInputAction? textInputAction;

  /// 输入格式化器
  final List<TextInputFormatter>? inputFormatters;

  /// 文本变化回调
  final ValueChanged<String>? onChanged;

  /// 提交回调
  final ValueChanged<String>? onSubmitted;

  /// 点击回调
  final VoidCallback? onTap;

  /// 验证器
  final String? Function(String?)? validator;

  /// 自动验证模式
  final AutovalidateMode? autovalidateMode;

  /// 输入框尺寸
  final VelocityInputSize size;

  /// 自定义样式
  final VelocityInputStyle? style;

  /// 无障碍语义标签
  ///
  /// 用于屏幕阅读器读取输入框的描述。
  /// 如果未提供，将使用标签文本或提示文本作为语义标签。
  final String? semanticLabel;

  @override
  State<VelocityInput> createState() => _VelocityInputState();
}

class _VelocityInputState extends State<VelocityInput> {
  late bool _obscureText;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(VelocityInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode.removeListener(_handleFocusChange);
      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode.addListener(_handleFocusChange);
    }
    if (widget.obscureText != oldWidget.obscureText) {
      _obscureText = widget.obscureText;
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
    final effectiveStyle = VelocityInputStyle.resolve(
      size: widget.size,
      customStyle: widget.style,
    );
    final hasError = widget.error != null && widget.error!.isNotEmpty;

    // Build the effective semantic label
    final effectiveSemanticLabel = widget.semanticLabel ??
        widget.label ??
        widget.hint ??
        'Text input field';

    // Build focus indicator decoration
    BoxDecoration? focusDecoration;
    if (_isFocused && widget.enabled && !widget.readOnly) {
      focusDecoration = BoxDecoration(
        borderRadius: effectiveStyle.borderRadius,
        boxShadow: [
          BoxShadow(
            color: (effectiveStyle.focusedBorderColor ?? Colors.blue)
                .withValues(alpha: 0.3),
            blurRadius: 0,
            spreadRadius: 2,
          ),
        ],
      );
    }

    Widget inputField = Container(
      decoration: focusDecoration,
      child: TextFormField(
        controller: widget.controller,
        focusNode: _focusNode,
        obscureText: _obscureText,
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        autofocus: widget.autofocus,
        maxLines: widget.obscureText ? 1 : widget.maxLines,
        minLines: widget.minLines,
        maxLength: widget.maxLength,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        inputFormatters: widget.inputFormatters,
        onChanged: widget.enabled ? widget.onChanged : null,
        onFieldSubmitted: widget.enabled ? widget.onSubmitted : null,
        onTap: widget.enabled ? widget.onTap : null,
        validator: widget.validator,
        autovalidateMode: widget.autovalidateMode,
        style: effectiveStyle.textStyle,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: effectiveStyle.hintStyle,
          filled: effectiveStyle.filled,
          fillColor: widget.enabled
              ? effectiveStyle.fillColor
              : effectiveStyle.disabledFillColor,
          contentPadding: effectiveStyle.contentPadding,
          prefixIcon: widget.prefixIcon != null
              ? Icon(widget.prefixIcon,
                  size: effectiveStyle.iconSize,
                  color: effectiveStyle.iconColor)
              : widget.prefix,
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      size: effectiveStyle.iconSize,
                      color: effectiveStyle.iconColor),
                  onPressed: widget.enabled
                      ? () => setState(() => _obscureText = !_obscureText)
                      : null,
                )
              : widget.suffixIcon != null
                  ? Icon(widget.suffixIcon,
                      size: effectiveStyle.iconSize,
                      color: effectiveStyle.iconColor)
                  : widget.suffix,
          border: OutlineInputBorder(
              borderRadius:
                  effectiveStyle.borderRadius ?? BorderRadius.circular(8),
              borderSide:
                  BorderSide(color: effectiveStyle.borderColor ?? Colors.grey)),
          enabledBorder: OutlineInputBorder(
              borderRadius:
                  effectiveStyle.borderRadius ?? BorderRadius.circular(8),
              borderSide: BorderSide(
                  color: hasError
                      ? (effectiveStyle.errorBorderColor ?? Colors.red)
                      : (effectiveStyle.borderColor ?? Colors.grey))),
          focusedBorder: OutlineInputBorder(
              borderRadius:
                  effectiveStyle.borderRadius ?? BorderRadius.circular(8),
              borderSide: BorderSide(
                  color: hasError
                      ? (effectiveStyle.errorBorderColor ?? Colors.red)
                      : (effectiveStyle.focusedBorderColor ?? Colors.blue),
                  width: 2)),
          errorBorder: OutlineInputBorder(
              borderRadius:
                  effectiveStyle.borderRadius ?? BorderRadius.circular(8),
              borderSide: BorderSide(
                  color: effectiveStyle.errorBorderColor ?? Colors.red)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius:
                  effectiveStyle.borderRadius ?? BorderRadius.circular(8),
              borderSide: BorderSide(
                  color: effectiveStyle.errorBorderColor ?? Colors.red,
                  width: 2)),
          disabledBorder: OutlineInputBorder(
              borderRadius:
                  effectiveStyle.borderRadius ?? BorderRadius.circular(8),
              borderSide: BorderSide(
                  color: effectiveStyle.disabledBorderColor ?? Colors.grey)),
          counterText: '',
        ),
      ),
    );

    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!, style: effectiveStyle.labelStyle),
          SizedBox(height: effectiveStyle.labelSpacing ?? 6),
        ],
        inputField,
        if (widget.error != null && widget.error!.isNotEmpty) ...[
          SizedBox(height: effectiveStyle.helperSpacing ?? 4),
          Text(widget.error!, style: effectiveStyle.errorStyle),
        ] else if (widget.helper != null && widget.helper!.isNotEmpty) ...[
          SizedBox(height: effectiveStyle.helperSpacing ?? 4),
          Text(widget.helper!, style: effectiveStyle.helperStyle),
        ],
      ],
    );

    // Wrap with Semantics for accessibility
    return Semantics(
      textField: true,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      label: effectiveSemanticLabel,
      hint: widget.hint,
      value: widget.controller?.text,
      child: content,
    );
  }
}

/// VelocityUI 文本区域
///
/// 支持 const 构造函数和无障碍访问。
class VelocityTextArea extends StatelessWidget {
  /// 创建文本区域组件
  ///
  /// [controller] 文本控制器
  /// [focusNode] 焦点节点
  /// [label] 标签文本
  /// [hint] 提示文本
  /// [helper] 帮助文本
  /// [error] 错误文本
  /// [enabled] 是否启用
  /// [readOnly] 是否只读
  /// [autofocus] 是否自动获取焦点
  /// [maxLines] 最大行数
  /// [minLines] 最小行数
  /// [maxLength] 最大长度
  /// [onChanged] 文本变化回调
  /// [onSubmitted] 提交回调
  /// [size] 输入框尺寸
  /// [style] 自定义样式
  /// [semanticLabel] 无障碍语义标签
  const VelocityTextArea({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.helper,
    this.error,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 5,
    this.minLines = 3,
    this.maxLength,
    this.onChanged,
    this.onSubmitted,
    this.size = VelocityInputSize.medium,
    this.style,
    this.semanticLabel,
  });

  /// 文本控制器
  final TextEditingController? controller;

  /// 焦点节点
  final FocusNode? focusNode;

  /// 标签文本
  final String? label;

  /// 提示文本
  final String? hint;

  /// 帮助文本
  final String? helper;

  /// 错误文本
  final String? error;

  /// 是否启用
  final bool enabled;

  /// 是否只读
  final bool readOnly;

  /// 是否自动获取焦点
  final bool autofocus;

  /// 最大行数
  final int maxLines;

  /// 最小行数
  final int minLines;

  /// 最大长度
  final int? maxLength;

  /// 文本变化回调
  final ValueChanged<String>? onChanged;

  /// 提交回调
  final ValueChanged<String>? onSubmitted;

  /// 输入框尺寸
  final VelocityInputSize size;

  /// 自定义样式
  final VelocityInputStyle? style;

  /// 无障碍语义标签
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return VelocityInput(
      controller: controller,
      focusNode: focusNode,
      label: label,
      hint: hint,
      helper: helper,
      error: error,
      enabled: enabled,
      readOnly: readOnly,
      autofocus: autofocus,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      size: size,
      style: style,
      semanticLabel: semanticLabel ?? label ?? hint ?? 'Text area',
    );
  }
}
