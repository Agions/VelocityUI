/// VelocityUI HTTP 全局加载状态管理
/// 提供请求加载状态的全局管理和回调支持
library velocity_http_loading_state;

import 'dart:async';

import 'package:flutter/foundation.dart';

/// 加载状态回调类型
/// [isLoading] 是否正在加载
/// [activeRequests] 当前活跃请求数
typedef LoadingStateCallback = void Function(
    bool isLoading, int activeRequests);

/// 请求开始回调类型
typedef RequestStartCallback = void Function(String requestId, String url);

/// 请求结束回调类型
typedef RequestEndCallback = void Function(
  String requestId,
  String url,
  Duration duration,
  bool success,
);

/// 加载状态变化事件
class LoadingStateEvent {
  /// 创建加载状态变化事件
  const LoadingStateEvent({
    required this.isLoading,
    required this.activeRequests,
    required this.timestamp,
    this.requestId,
    this.url,
  });

  /// 是否正在加载
  final bool isLoading;

  /// 当前活跃请求数
  final int activeRequests;

  /// 事件时间戳
  final DateTime timestamp;

  /// 触发事件的请求 ID
  final String? requestId;

  /// 触发事件的请求 URL
  final String? url;

  @override
  String toString() => 'LoadingStateEvent('
      'isLoading: $isLoading, '
      'activeRequests: $activeRequests, '
      'requestId: $requestId)';
}

/// 请求跟踪信息
class RequestTrackingInfo {
  /// 创建请求跟踪信息
  RequestTrackingInfo({
    required this.requestId,
    required this.url,
    required this.startTime,
    this.method,
  });

  /// 请求 ID
  final String requestId;

  /// 请求 URL
  final String url;

  /// 开始时间
  final DateTime startTime;

  /// 请求方法
  final String? method;

  /// 计算请求持续时间
  Duration get duration => DateTime.now().difference(startTime);

  @override
  String toString() => 'RequestTrackingInfo('
      'requestId: $requestId, '
      'url: $url, '
      'duration: $duration)';
}

/// 全局加载状态管理器
/// 跟踪所有 HTTP 请求的加载状态
class LoadingStateManager {
  /// 创建加载状态管理器
  LoadingStateManager({
    this.onLoadingStateChanged,
    this.onRequestStart,
    this.onRequestEnd,
    this.debounceDelay = const Duration(milliseconds: 100),
  });

  /// 加载状态变化回调
  final LoadingStateCallback? onLoadingStateChanged;

  /// 请求开始回调
  final RequestStartCallback? onRequestStart;

  /// 请求结束回调
  final RequestEndCallback? onRequestEnd;

  /// 防抖延迟（避免快速请求导致的闪烁）
  final Duration debounceDelay;

  /// 活跃请求映射
  final Map<String, RequestTrackingInfo> _activeRequests = {};

  /// 加载状态流控制器
  final StreamController<LoadingStateEvent> _stateController =
      StreamController<LoadingStateEvent>.broadcast();

  /// 防抖定时器
  Timer? _debounceTimer;

  /// 上一次的加载状态
  bool _lastIsLoading = false;

  /// 请求 ID 计数器
  int _requestIdCounter = 0;

  /// 获取当前活跃请求数
  int get activeRequestCount => _activeRequests.length;

  /// 是否有活跃请求
  bool get isLoading => _activeRequests.isNotEmpty;

  /// 获取加载状态流
  Stream<LoadingStateEvent> get stateStream => _stateController.stream;

  /// 获取所有活跃请求信息
  List<RequestTrackingInfo> get activeRequests =>
      List.unmodifiable(_activeRequests.values);

  /// 生成唯一请求 ID
  String generateRequestId() {
    _requestIdCounter++;
    return 'req_${DateTime.now().millisecondsSinceEpoch}_$_requestIdCounter';
  }

  /// 开始跟踪请求
  /// 返回请求 ID，用于后续结束跟踪
  String startRequest(String url, {String? method, String? requestId}) {
    final id = requestId ?? generateRequestId();

    final trackingInfo = RequestTrackingInfo(
      requestId: id,
      url: url,
      startTime: DateTime.now(),
      method: method,
    );

    _activeRequests[id] = trackingInfo;

    // 通知请求开始
    onRequestStart?.call(id, url);

    // 更新加载状态
    _notifyLoadingStateChanged(id, url);

    return id;
  }

  /// 结束跟踪请求
  void endRequest(String requestId, {bool success = true}) {
    final trackingInfo = _activeRequests.remove(requestId);

    if (trackingInfo != null) {
      // 通知请求结束
      onRequestEnd?.call(
        requestId,
        trackingInfo.url,
        trackingInfo.duration,
        success,
      );

      // 更新加载状态
      _notifyLoadingStateChanged(requestId, trackingInfo.url);
    }
  }

  /// 取消跟踪请求（不触发结束回调）
  void cancelRequest(String requestId) {
    _activeRequests.remove(requestId);
    _notifyLoadingStateChanged(requestId, null);
  }

  /// 清除所有跟踪
  void clearAll() {
    _activeRequests.clear();
    _notifyLoadingStateChanged(null, null);
  }

  /// 通知加载状态变化
  void _notifyLoadingStateChanged(String? requestId, String? url) {
    // 取消之前的防抖定时器
    _debounceTimer?.cancel();

    // 使用防抖避免快速状态变化
    _debounceTimer = Timer(debounceDelay, () {
      final currentIsLoading = isLoading;
      final activeCount = activeRequestCount;

      // 只在状态真正变化时通知
      if (currentIsLoading != _lastIsLoading || currentIsLoading) {
        _lastIsLoading = currentIsLoading;

        // 触发回调
        onLoadingStateChanged?.call(currentIsLoading, activeCount);

        // 发送事件到流
        final event = LoadingStateEvent(
          isLoading: currentIsLoading,
          activeRequests: activeCount,
          timestamp: DateTime.now(),
          requestId: requestId,
          url: url,
        );
        _stateController.add(event);
      }
    });
  }

  /// 立即通知加载状态（跳过防抖）
  void notifyImmediately() {
    _debounceTimer?.cancel();

    final currentIsLoading = isLoading;
    final activeCount = activeRequestCount;

    _lastIsLoading = currentIsLoading;
    onLoadingStateChanged?.call(currentIsLoading, activeCount);

    final event = LoadingStateEvent(
      isLoading: currentIsLoading,
      activeRequests: activeCount,
      timestamp: DateTime.now(),
    );
    _stateController.add(event);
  }

  /// 释放资源
  void dispose() {
    _debounceTimer?.cancel();
    _stateController.close();
    _activeRequests.clear();
  }

  @override
  String toString() => 'LoadingStateManager('
      'activeRequests: $activeRequestCount, '
      'isLoading: $isLoading)';
}

/// 加载状态监听器 Mixin
/// 用于在 Widget 中监听加载状态
mixin LoadingStateListener {
  LoadingStateManager? _loadingStateManager;
  StreamSubscription<LoadingStateEvent>? _subscription;

  /// 获取当前加载状态管理器
  LoadingStateManager? get loadingStateManager => _loadingStateManager;

  /// 初始化加载状态监听
  void initLoadingStateListener(LoadingStateManager manager) {
    _loadingStateManager = manager;
    _subscription = manager.stateStream.listen(_onLoadingStateChanged);
  }

  /// 处理加载状态变化
  void _onLoadingStateChanged(LoadingStateEvent event) {
    onLoadingStateChanged(event.isLoading, event.activeRequests);
  }

  /// 加载状态变化回调（子类实现）
  void onLoadingStateChanged(bool isLoading, int activeRequests);

  /// 释放监听器
  void disposeLoadingStateListener() {
    _subscription?.cancel();
    _subscription = null;
    _loadingStateManager = null;
  }
}

/// 加载状态 ValueNotifier
/// 用于与 Flutter 的 ValueListenableBuilder 配合使用
class LoadingStateNotifier extends ValueNotifier<LoadingStateEvent> {
  /// 创建加载状态 ValueNotifier
  LoadingStateNotifier()
      : super(LoadingStateEvent(
          isLoading: false,
          activeRequests: 0,
          timestamp: DateTime.now(),
        ));

  /// 从 LoadingStateManager 创建
  factory LoadingStateNotifier.fromManager(LoadingStateManager manager) {
    final notifier = LoadingStateNotifier();
    manager.stateStream.listen((event) {
      notifier.value = event;
    });
    return notifier;
  }

  /// 是否正在加载
  bool get isLoading => value.isLoading;

  /// 活跃请求数
  int get activeRequests => value.activeRequests;

  /// 更新状态
  void update(bool isLoading, int activeRequests) {
    value = LoadingStateEvent(
      isLoading: isLoading,
      activeRequests: activeRequests,
      timestamp: DateTime.now(),
    );
  }
}

/// 全局加载状态管理器单例
class GlobalLoadingState {
  GlobalLoadingState._();

  static LoadingStateManager? _instance;

  /// 获取全局加载状态管理器实例
  static LoadingStateManager get instance {
    _instance ??= LoadingStateManager();
    return _instance!;
  }

  /// 设置全局加载状态管理器
  static void setInstance(LoadingStateManager manager) {
    _instance?.dispose();
    _instance = manager;
  }

  /// 重置全局实例
  static void reset() {
    _instance?.dispose();
    _instance = null;
  }

  /// 是否正在加载
  static bool get isLoading => instance.isLoading;

  /// 活跃请求数
  static int get activeRequestCount => instance.activeRequestCount;

  /// 开始跟踪请求
  static String startRequest(String url, {String? method}) {
    return instance.startRequest(url, method: method);
  }

  /// 结束跟踪请求
  static void endRequest(String requestId, {bool success = true}) {
    instance.endRequest(requestId, success: success);
  }
}
