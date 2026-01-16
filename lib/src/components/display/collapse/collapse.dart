/// VelocityUI 折叠面板组件
library velocity_collapse;

import 'package:flutter/material.dart';
import '../../../core/utils/velocity_repaint_boundary.dart';
import 'collapse_style.dart';

export 'collapse_style.dart';

/// VelocityUI 折叠面板
///
/// 支持展开/折叠动画的面板组件。
/// 默认使用 RepaintBoundary 包装以优化渲染性能。
class VelocityCollapse extends StatefulWidget {
  const VelocityCollapse({
    required this.title,
    required this.child,
    super.key,
    this.leading,
    this.initiallyExpanded = false,
    this.onChanged,
    this.style,
    this.useRepaintBoundary = true,
  });

  final Widget title;
  final Widget child;
  final Widget? leading;
  final bool initiallyExpanded;
  final ValueChanged<bool>? onChanged;
  final VelocityCollapseStyle? style;

  /// 是否使用 RepaintBoundary 包装
  ///
  /// 默认为 true，用于隔离动画重绘区域，提升渲染性能。
  /// 设置为 false 可禁用 RepaintBoundary。
  final bool useRepaintBoundary;

  @override
  State<VelocityCollapse> createState() => _VelocityCollapseState();
}

class _VelocityCollapseState extends State<VelocityCollapse>
    with
        SingleTickerProviderStateMixin,
        VelocityAnimatedMixin<VelocityCollapse> {
  @override
  bool get useRepaintBoundary => widget.useRepaintBoundary;

  late bool _isExpanded;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
    _controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
      _isExpanded ? _controller.forward() : _controller.reverse();
      widget.onChanged?.call(_isExpanded);
    });
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = widget.style ?? const VelocityCollapseStyle();

    final content = Container(
      decoration: BoxDecoration(
          color: effectiveStyle.backgroundColor,
          borderRadius: effectiveStyle.borderRadius,
          border: effectiveStyle.border),
      child: Column(
        children: [
          InkWell(
            onTap: _toggle,
            borderRadius: effectiveStyle.borderRadius,
            child: Padding(
              padding: effectiveStyle.headerPadding,
              child: Row(
                children: [
                  if (widget.leading != null) ...[
                    widget.leading!,
                    SizedBox(width: effectiveStyle.leadingSpacing)
                  ],
                  Expanded(
                      child: DefaultTextStyle(
                          style: effectiveStyle.titleStyle,
                          child: widget.title)),
                  RotationTransition(
                    turns: Tween(begin: 0.0, end: 0.5).animate(_animation),
                    child: Icon(Icons.expand_more,
                        color: effectiveStyle.iconColor,
                        size: effectiveStyle.iconSize),
                  ),
                ],
              ),
            ),
          ),
          SizeTransition(
              sizeFactor: _animation,
              child: Padding(
                  padding: effectiveStyle.contentPadding, child: widget.child)),
        ],
      ),
    );

    return wrapWithRepaintBoundary(content);
  }
}

/// VelocityUI 手风琴组件
class VelocityAccordion extends StatefulWidget {
  const VelocityAccordion({
    required this.items,
    super.key,
    this.allowMultiple = false,
    this.style,
  });

  final List<VelocityAccordionItem> items;
  final bool allowMultiple;
  final VelocityCollapseStyle? style;

  @override
  State<VelocityAccordion> createState() => _VelocityAccordionState();
}

class _VelocityAccordionState extends State<VelocityAccordion> {
  late Set<int> _expandedIndices;

  @override
  void initState() {
    super.initState();
    _expandedIndices = {};
    for (var i = 0; i < widget.items.length; i++) {
      if (widget.items[i].initiallyExpanded) _expandedIndices.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < widget.items.length; i++)
          Padding(
            padding: EdgeInsets.only(top: i > 0 ? 8 : 0),
            child: VelocityCollapse(
              title: widget.items[i].title,
              leading: widget.items[i].leading,
              initiallyExpanded: _expandedIndices.contains(i),
              onChanged: (expanded) {
                setState(() {
                  if (expanded) {
                    if (!widget.allowMultiple) _expandedIndices.clear();
                    _expandedIndices.add(i);
                  } else {
                    _expandedIndices.remove(i);
                  }
                });
              },
              style: widget.style,
              child: widget.items[i].child,
            ),
          ),
      ],
    );
  }
}

class VelocityAccordionItem {
  const VelocityAccordionItem(
      {required this.title,
      required this.child,
      this.leading,
      this.initiallyExpanded = false});
  final Widget title;
  final Widget child;
  final Widget? leading;
  final bool initiallyExpanded;
}
