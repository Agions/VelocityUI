/// VelocityUI 通知组件
library velocity_notification;

import 'package:flutter/material.dart';
import '../../../core/utils/velocity_repaint_boundary.dart';
import 'notification_style.dart';

export 'notification_style.dart';

/// 通知类型
enum VelocityNotificationType { info, success, warning, error }

/// 通知位置
enum VelocityNotificationPosition { top, bottom }

/// VelocityUI 通知
class VelocityNotification {
  static OverlayEntry? _currentEntry;

  static void show({
    required BuildContext context,
    required String title,
    String? message,
    VelocityNotificationType type = VelocityNotificationType.info,
    VelocityNotificationPosition position = VelocityNotificationPosition.top,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onTap,
    bool showClose = true,
    VelocityNotificationStyle? style,
    bool useRepaintBoundary = true,
  }) {
    dismiss();
    final effectiveStyle = style ?? const VelocityNotificationStyle();
    final overlay = Overlay.of(context);

    _currentEntry = OverlayEntry(
      builder: (context) => _VelocityNotificationWidget(
        title: title,
        message: message,
        type: type,
        position: position,
        duration: duration,
        onTap: onTap,
        showClose: showClose,
        style: effectiveStyle,
        onDismiss: dismiss,
        useRepaintBoundary: useRepaintBoundary,
      ),
    );

    overlay.insert(_currentEntry!);
  }

  static void dismiss() {
    _currentEntry?.remove();
    _currentEntry = null;
  }
}

class _VelocityNotificationWidget extends StatefulWidget {
  const _VelocityNotificationWidget({
    required this.title,
    required this.type,
    required this.position,
    required this.duration,
    required this.showClose,
    required this.style,
    required this.onDismiss,
    this.message,
    this.onTap,
    this.useRepaintBoundary = true,
  });

  final String title;
  final String? message;
  final VelocityNotificationType type;
  final VelocityNotificationPosition position;
  final Duration duration;
  final VoidCallback? onTap;
  final bool showClose;
  final VelocityNotificationStyle style;
  final VoidCallback onDismiss;

  /// 是否使用 RepaintBoundary 包装
  ///
  /// 默认为 true，用于隔离动画重绘区域，提升渲染性能。
  /// 设置为 false 可禁用 RepaintBoundary。
  final bool useRepaintBoundary;

  @override
  State<_VelocityNotificationWidget> createState() =>
      _VelocityNotificationWidgetState();
}

class _VelocityNotificationWidgetState
    extends State<_VelocityNotificationWidget>
    with
        SingleTickerProviderStateMixin,
        VelocityAnimatedMixin<_VelocityNotificationWidget> {
  @override
  bool get useRepaintBoundary => widget.useRepaintBoundary;

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _slideAnimation = Tween<Offset>(
      begin: Offset(
          0, widget.position == VelocityNotificationPosition.top ? -1 : 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
    Future.delayed(widget.duration, _dismiss);
  }

  void _dismiss() {
    if (!mounted) return;
    _controller.reverse().then((_) => widget.onDismiss());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color get _typeColor {
    switch (widget.type) {
      case VelocityNotificationType.success:
        return widget.style.successColor;
      case VelocityNotificationType.warning:
        return widget.style.warningColor;
      case VelocityNotificationType.error:
        return widget.style.errorColor;
      default:
        return widget.style.infoColor;
    }
  }

  IconData get _typeIcon {
    switch (widget.type) {
      case VelocityNotificationType.success:
        return Icons.check_circle;
      case VelocityNotificationType.warning:
        return Icons.warning;
      case VelocityNotificationType.error:
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = Positioned(
      top: widget.position == VelocityNotificationPosition.top
          ? MediaQuery.of(context).padding.top + 16
          : null,
      bottom: widget.position == VelocityNotificationPosition.bottom
          ? MediaQuery.of(context).padding.bottom + 16
          : null,
      left: 16,
      right: 16,
      child: SlideTransition(
        position: _slideAnimation,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: widget.style.padding,
              decoration: BoxDecoration(
                color: widget.style.backgroundColor,
                borderRadius: widget.style.borderRadius,
                boxShadow: widget.style.boxShadow,
                border: Border(left: BorderSide(color: _typeColor, width: 4)),
              ),
              child: Row(
                children: [
                  Icon(_typeIcon,
                      color: _typeColor, size: widget.style.iconSize),
                  SizedBox(width: widget.style.iconSpacing),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(widget.title, style: widget.style.titleStyle),
                        if (widget.message != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(widget.message!,
                                style: widget.style.messageStyle),
                          ),
                      ],
                    ),
                  ),
                  if (widget.showClose)
                    IconButton(
                      onPressed: _dismiss,
                      icon: Icon(Icons.close,
                          size: 18, color: widget.style.closeColor),
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    return wrapWithRepaintBoundary(content);
  }
}
