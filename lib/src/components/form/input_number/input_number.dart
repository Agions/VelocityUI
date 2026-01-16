/// VelocityUI 数字输入框组件
library velocity_input_number;

import 'package:flutter/material.dart';
import 'input_number_style.dart';
import '../../../core/theme/velocity_colors.dart';

export 'input_number_style.dart';

/// 数字输入框组件
class VelocityInputNumber extends StatefulWidget {
  /// 创建数字输入框组件
  const VelocityInputNumber({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.helper,
    this.error,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.readOnly = false,
    this.value,
    this.min,
    this.max,
    this.step = 1,
    this.decimals = 0,
    this.showButtons = true,
    this.buttonPlacement = VelocityInputNumberButtonPlacement.vertical,
    this.onChanged,
    this.onSubmitted,
    this.onIncrement,
    this.onDecrement,
    this.style,
  });

  /// 控制器
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

  /// 是否启用
  final bool enabled;

  /// 是否只读
  final bool readOnly;

  /// 当前值
  final num? value;

  /// 最小值
  final num? min;

  /// 最大值
  final num? max;

  /// 步长
  final num step;

  /// 小数位数
  final int decimals;

  /// 是否显示按钮
  final bool showButtons;

  /// 按钮位置
  final VelocityInputNumberButtonPlacement buttonPlacement;

  /// 值改变回调
  final ValueChanged<num>? onChanged;

  /// 提交回调
  final ValueChanged<num>? onSubmitted;

  /// 增加回调
  final VoidCallback? onIncrement;

  /// 减少回调
  final VoidCallback? onDecrement;

  /// 样式
  final VelocityInputNumberStyle? style;

  @override
  State<VelocityInputNumber> createState() => _VelocityInputNumberState();
}

/// 数字输入框按钮位置
enum VelocityInputNumberButtonPlacement {
  /// 垂直排列
  vertical,

  /// 水平排列
  horizontal,

  /// 内外排列
  inside,
}

class _VelocityInputNumberState extends State<VelocityInputNumber> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  late num _currentValue;

  // Default values for nullable style properties
  static const Color _defaultBorderColor = VelocityColors.gray300;
  static const Color _defaultFocusedBorderColor = VelocityColors.primary;
  static const Color _defaultErrorBorderColor = VelocityColors.error;
  static const Color _defaultDisabledBorderColor = VelocityColors.gray200;
  static const BorderRadius _defaultBorderRadius =
      BorderRadius.all(Radius.circular(8));

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _currentValue = widget.value ?? 0;
    _controller.text = _currentValue.toStringAsFixed(widget.decimals);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _increment() {
    if (!widget.enabled || widget.readOnly) return;

    var newValue = _currentValue + widget.step;
    if (widget.max != null && newValue > widget.max!) {
      newValue = widget.max!;
    }
    _updateValue(newValue);
    widget.onIncrement?.call();
  }

  void _decrement() {
    if (!widget.enabled || widget.readOnly) return;

    var newValue = _currentValue - widget.step;
    if (widget.min != null && newValue < widget.min!) {
      newValue = widget.min!;
    }
    _updateValue(newValue);
    widget.onDecrement?.call();
  }

  void _updateValue(num value) {
    setState(() {
      _currentValue = value;
      _controller.text = _currentValue.toStringAsFixed(widget.decimals);
      widget.onChanged?.call(_currentValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = widget.style ?? VelocityInputNumberStyle.defaults();
    final hasError = widget.error != null && widget.error!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!, style: effectiveStyle.labelStyle),
          SizedBox(height: effectiveStyle.labelSpacing ?? 6),
        ],
        widget.showButtons
            ? _buildWithButtons(effectiveStyle, hasError)
            : _buildWithoutButtons(effectiveStyle, hasError),
        if (widget.error != null && widget.error!.isNotEmpty) ...[
          SizedBox(height: effectiveStyle.helperSpacing ?? 4),
          Text(widget.error!, style: effectiveStyle.errorStyle),
        ] else if (widget.helper != null && widget.helper!.isNotEmpty) ...[
          SizedBox(height: effectiveStyle.helperSpacing ?? 4),
          Text(widget.helper!, style: effectiveStyle.helperStyle),
        ],
      ],
    );
  }

  Widget _buildWithButtons(
      VelocityInputNumberStyle effectiveStyle, bool hasError) {
    final borderColor = effectiveStyle.borderColor ?? _defaultBorderColor;
    final focusedBorderColor =
        effectiveStyle.focusedBorderColor ?? _defaultFocusedBorderColor;
    final errorBorderColor =
        effectiveStyle.errorBorderColor ?? _defaultErrorBorderColor;
    final borderRadius = effectiveStyle.borderRadius ?? _defaultBorderRadius;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: hasError
              ? errorBorderColor
              : _focusNode.hasFocus
                  ? focusedBorderColor
                  : borderColor,
          width: _focusNode.hasFocus ? 2 : 1,
        ),
        borderRadius: borderRadius,
      ),
      child:
          widget.buttonPlacement == VelocityInputNumberButtonPlacement.vertical
              ? _buildVerticalButtons(effectiveStyle)
              : widget.buttonPlacement ==
                      VelocityInputNumberButtonPlacement.horizontal
                  ? _buildHorizontalButtons(effectiveStyle)
                  : _buildInsideButtons(effectiveStyle),
    );
  }

  Widget _buildVerticalButtons(VelocityInputNumberStyle effectiveStyle) {
    final borderColor = effectiveStyle.borderColor ?? _defaultBorderColor;

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            enabled: widget.enabled,
            readOnly: widget.readOnly,
            keyboardType: TextInputType.numberWithOptions(
              decimal: widget.decimals > 0,
            ),
            textAlign: TextAlign.center,
            style: effectiveStyle.textStyle,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: effectiveStyle.hintStyle,
              border: InputBorder.none,
              contentPadding: effectiveStyle.contentPadding,
            ),
            onChanged: (value) {
              final parsedValue = num.tryParse(value);
              if (parsedValue != null) {
                setState(() {
                  _currentValue = parsedValue;
                  widget.onChanged?.call(parsedValue);
                });
              }
            },
            onSubmitted: (value) {
              final parsedValue = num.tryParse(value);
              if (parsedValue != null) {
                widget.onSubmitted?.call(parsedValue);
              }
            },
          ),
        ),
        Container(
          width: 40,
          decoration: BoxDecoration(
            border: Border(left: BorderSide(color: borderColor)),
          ),
          child: Column(
            children: [
              Expanded(
                child: InkWell(
                  onTap: _increment,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: borderColor)),
                    ),
                    child: const Icon(
                      Icons.keyboard_arrow_up,
                      size: 16,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: _decrement,
                  child: Container(
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHorizontalButtons(VelocityInputNumberStyle effectiveStyle) {
    final borderColor = effectiveStyle.borderColor ?? _defaultBorderColor;

    return Row(
      children: [
        InkWell(
          onTap: _decrement,
          child: Container(
            width: 40,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(right: BorderSide(color: borderColor)),
            ),
            child: const Icon(
              Icons.remove,
              size: 16,
            ),
          ),
        ),
        Expanded(
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            enabled: widget.enabled,
            readOnly: widget.readOnly,
            keyboardType: TextInputType.numberWithOptions(
              decimal: widget.decimals > 0,
            ),
            textAlign: TextAlign.center,
            style: effectiveStyle.textStyle,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: effectiveStyle.hintStyle,
              border: InputBorder.none,
              contentPadding: effectiveStyle.contentPadding,
            ),
            onChanged: (value) {
              final parsedValue = num.tryParse(value);
              if (parsedValue != null) {
                setState(() {
                  _currentValue = parsedValue;
                  widget.onChanged?.call(parsedValue);
                });
              }
            },
            onSubmitted: (value) {
              final parsedValue = num.tryParse(value);
              if (parsedValue != null) {
                widget.onSubmitted?.call(parsedValue);
              }
            },
          ),
        ),
        InkWell(
          onTap: _increment,
          child: Container(
            width: 40,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(left: BorderSide(color: borderColor)),
            ),
            child: const Icon(
              Icons.add,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInsideButtons(VelocityInputNumberStyle effectiveStyle) {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      keyboardType: TextInputType.numberWithOptions(
        decimal: widget.decimals > 0,
      ),
      style: effectiveStyle.textStyle,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: effectiveStyle.hintStyle,
        border: InputBorder.none,
        contentPadding: effectiveStyle.contentPadding,
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: _decrement,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.remove,
                  size: 16,
                ),
              ),
            ),
            InkWell(
              onTap: _increment,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.add,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
      ),
      onChanged: (value) {
        final parsedValue = num.tryParse(value);
        if (parsedValue != null) {
          setState(() {
            _currentValue = parsedValue;
            widget.onChanged?.call(parsedValue);
          });
        }
      },
      onSubmitted: (value) {
        final parsedValue = num.tryParse(value);
        if (parsedValue != null) {
          widget.onSubmitted?.call(parsedValue);
        }
      },
    );
  }

  Widget _buildWithoutButtons(
      VelocityInputNumberStyle effectiveStyle, bool hasError) {
    final borderColor = effectiveStyle.borderColor ?? _defaultBorderColor;
    final focusedBorderColor =
        effectiveStyle.focusedBorderColor ?? _defaultFocusedBorderColor;
    final errorBorderColor =
        effectiveStyle.errorBorderColor ?? _defaultErrorBorderColor;
    final disabledBorderColor =
        effectiveStyle.disabledBorderColor ?? _defaultDisabledBorderColor;
    final borderRadius = effectiveStyle.borderRadius ?? _defaultBorderRadius;

    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      keyboardType: TextInputType.numberWithOptions(
        decimal: widget.decimals > 0,
      ),
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
            ? Icon(widget.prefixIcon, size: effectiveStyle.iconSize)
            : null,
        suffixIcon: widget.suffixIcon != null
            ? Icon(widget.suffixIcon, size: effectiveStyle.iconSize)
            : null,
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: hasError ? errorBorderColor : borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: hasError ? errorBorderColor : focusedBorderColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: errorBorderColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: errorBorderColor,
            width: 2,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: disabledBorderColor),
        ),
      ),
      onChanged: (value) {
        final parsedValue = num.tryParse(value);
        if (parsedValue != null) {
          setState(() {
            _currentValue = parsedValue;
            widget.onChanged?.call(parsedValue);
          });
        }
      },
      onSubmitted: (value) {
        final parsedValue = num.tryParse(value);
        if (parsedValue != null) {
          widget.onSubmitted?.call(parsedValue);
        }
      },
    );
  }
}
