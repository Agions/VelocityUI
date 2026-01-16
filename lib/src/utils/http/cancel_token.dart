/// VelocityUI HTTP 请求取消令牌
/// 提供请求取消功能
library velocity_cancel_token;

import 'dart:async';

import 'package:flutter/foundation.dart';

/// 请求取消令牌
/// 用于取消正在进行的 HTTP 请求
class CancelToken {
  /// 创建取消令牌
  CancelToken();

  bool _isCancelled = false;
  String? _reason;
  final List<VoidCallback> _listeners = [];
  Completer<void>? _completer;

  /// 是否已取消
  bool get isCancelled => _isCancelled;

  /// 取消原因
  String? get reason => _reason;

  /// 获取取消 Future
  /// 当令牌被取消时，此 Future 会完成
  Future<void> get whenCancel {
    _completer ??= Completer<void>();
    return _completer!.future;
  }

  /// 取消请求
  /// [reason] 可选的取消原因
  void cancel([String? reason]) {
    if (_isCancelled) return;

    _isCancelled = true;
    _reason = reason ?? '请求已取消';

    // 完成 completer
    if (_completer != null && !_completer!.isCompleted) {
      _completer!.complete();
    }

    // 通知所有监听器
    for (final listener in _listeners) {
      try {
        listener();
      } catch (e) {
        // 忽略监听器中的错误
        debugPrint('CancelToken listener error: $e');
      }
    }
  }

  /// 添加取消监听器
  /// 当令牌被取消时，监听器会被调用
  void addListener(VoidCallback listener) {
    if (_isCancelled) {
      // 如果已经取消，立即调用监听器
      listener();
      return;
    }
    _listeners.add(listener);
  }

  /// 移除取消监听器
  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  /// 清除所有监听器
  void clearListeners() {
    _listeners.clear();
  }

  /// 检查是否已取消，如果已取消则抛出异常
  void throwIfCancelled() {
    if (_isCancelled) {
      throw CancelledException(_reason ?? '请求已取消');
    }
  }

  /// 重置令牌状态
  /// 允许令牌被重新使用
  void reset() {
    _isCancelled = false;
    _reason = null;
    _completer = null;
    _listeners.clear();
  }

  @override
  String toString() =>
      'CancelToken(isCancelled: $_isCancelled, reason: $_reason)';
}

/// 请求已取消异常
class CancelledException implements Exception {
  /// 创建取消异常
  const CancelledException([this.message = '请求已取消']);

  /// 取消消息
  final String message;

  @override
  String toString() => 'CancelledException: $message';
}

/// 可取消的操作扩展
extension CancellableOperation<T> on Future<T> {
  /// 使 Future 可被取消
  /// 当 [token] 被取消时，返回的 Future 会以 [CancelledException] 完成
  Future<T> withCancelToken(CancelToken token) {
    if (token.isCancelled) {
      return Future.error(CancelledException(token.reason ?? '请求已取消'));
    }

    final completer = Completer<T>();

    // 监听取消
    void onCancel() {
      if (!completer.isCompleted) {
        completer.completeError(
          CancelledException(token.reason ?? '请求已取消'),
        );
      }
    }

    token.addListener(onCancel);

    // 监听原始 Future
    then((value) {
      token.removeListener(onCancel);
      if (!completer.isCompleted) {
        completer.complete(value);
      }
    }).catchError((Object error, StackTrace stackTrace) {
      token.removeListener(onCancel);
      if (!completer.isCompleted) {
        completer.completeError(error, stackTrace);
      }
    });

    return completer.future;
  }
}
