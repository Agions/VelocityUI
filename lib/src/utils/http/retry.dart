/// VelocityUI HTTP 自动重试机制
/// 提供请求失败时的自动重试功能，支持指数退避策略
library velocity_http_retry;

import 'dart:async';
import 'dart:math';

import 'interceptors.dart';
import 'result.dart';

/// 重试条件判断函数类型
/// 返回 true 表示应该重试
typedef RetryCondition = bool Function(VelocityError error, int attempt);

/// 重试延迟计算函数类型
/// 返回下次重试前的等待时间
typedef RetryDelayCalculator = Duration Function(
    int attempt, Duration baseDelay);

/// 默认重试条件
/// 网络错误、超时错误和部分服务器错误可重试
bool defaultRetryCondition(VelocityError error, int attempt) {
  // 网络错误可重试
  if (error is NetworkError) return true;

  // 超时错误可重试
  if (error is TimeoutError) return true;

  // 服务器错误中，503 和 504 可重试
  if (error is ServerError) {
    return error.statusCode == 503 || error.statusCode == 504;
  }

  // 取消错误和业务错误不重试
  return false;
}

/// 指数退避延迟计算
/// 每次重试延迟翻倍，并添加随机抖动
Duration exponentialBackoffDelay(int attempt, Duration baseDelay) {
  // 计算指数延迟：baseDelay * 2^attempt
  final exponentialDelay = baseDelay * pow(2, attempt).toInt();

  // 添加随机抖动（0-25% 的额外延迟）
  final random = Random();
  final jitter = exponentialDelay.inMilliseconds * random.nextDouble() * 0.25;

  return Duration(
    milliseconds: exponentialDelay.inMilliseconds + jitter.toInt(),
  );
}

/// 线性退避延迟计算
/// 每次重试延迟线性增加
Duration linearBackoffDelay(int attempt, Duration baseDelay) {
  return baseDelay * (attempt + 1);
}

/// 固定延迟计算
/// 每次重试使用相同的延迟
Duration fixedDelay(int attempt, Duration baseDelay) {
  return baseDelay;
}

/// 重试配置
/// 定义重试行为和策略
class RetryConfig {
  /// 创建重试配置
  const RetryConfig({
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 1),
    this.maxDelay = const Duration(seconds: 30),
    this.shouldRetry,
    this.delayCalculator,
    this.enabled = true,
    this.retryableStatusCodes = const [408, 429, 500, 502, 503, 504],
  });

  /// 最大重试次数
  final int maxRetries;

  /// 基础重试延迟
  final Duration retryDelay;

  /// 最大重试延迟
  final Duration maxDelay;

  /// 自定义重试条件判断
  final RetryCondition? shouldRetry;

  /// 自定义延迟计算器
  final RetryDelayCalculator? delayCalculator;

  /// 是否启用重试
  final bool enabled;

  /// 可重试的 HTTP 状态码列表
  final List<int> retryableStatusCodes;

  /// 获取有效的重试条件判断函数
  RetryCondition get effectiveShouldRetry =>
      shouldRetry ?? defaultRetryCondition;

  /// 获取有效的延迟计算器
  RetryDelayCalculator get effectiveDelayCalculator =>
      delayCalculator ?? exponentialBackoffDelay;

  /// 计算指定重试次数的延迟
  Duration getDelay(int attempt) {
    final delay = effectiveDelayCalculator(attempt, retryDelay);
    // 确保不超过最大延迟
    return delay > maxDelay ? maxDelay : delay;
  }

  /// 检查是否应该重试
  bool canRetry(VelocityError error, int attempt) {
    if (!enabled) return false;
    if (attempt >= maxRetries) return false;
    return effectiveShouldRetry(error, attempt);
  }

  /// 检查状态码是否可重试
  bool isStatusCodeRetryable(int statusCode) {
    return retryableStatusCodes.contains(statusCode);
  }

  /// 复制配置并替换指定属性
  RetryConfig copyWith({
    int? maxRetries,
    Duration? retryDelay,
    Duration? maxDelay,
    RetryCondition? shouldRetry,
    RetryDelayCalculator? delayCalculator,
    bool? enabled,
    List<int>? retryableStatusCodes,
  }) {
    return RetryConfig(
      maxRetries: maxRetries ?? this.maxRetries,
      retryDelay: retryDelay ?? this.retryDelay,
      maxDelay: maxDelay ?? this.maxDelay,
      shouldRetry: shouldRetry ?? this.shouldRetry,
      delayCalculator: delayCalculator ?? this.delayCalculator,
      enabled: enabled ?? this.enabled,
      retryableStatusCodes: retryableStatusCodes ?? this.retryableStatusCodes,
    );
  }

  @override
  String toString() => 'RetryConfig('
      'maxRetries: $maxRetries, '
      'retryDelay: $retryDelay, '
      'enabled: $enabled)';
}

/// 重试状态
/// 跟踪当前重试的状态信息
class RetryState {
  /// 创建重试状态
  RetryState({
    this.attempt = 0,
    this.lastError,
    this.startTime,
    this.errors = const [],
  });

  /// 当前重试次数（从 0 开始）
  final int attempt;

  /// 最后一次错误
  final VelocityError? lastError;

  /// 开始时间
  final DateTime? startTime;

  /// 所有错误记录
  final List<RetryErrorRecord> errors;

  /// 是否是首次尝试
  bool get isFirstAttempt => attempt == 0;

  /// 总耗时
  Duration get totalDuration {
    if (startTime == null) return Duration.zero;
    return DateTime.now().difference(startTime!);
  }

  /// 创建下一次重试的状态
  RetryState nextAttempt(VelocityError error) {
    return RetryState(
      attempt: attempt + 1,
      lastError: error,
      startTime: startTime ?? DateTime.now(),
      errors: [
        ...errors,
        RetryErrorRecord(
          attempt: attempt,
          error: error,
          timestamp: DateTime.now(),
        ),
      ],
    );
  }

  /// 重置状态
  RetryState reset() {
    return RetryState();
  }

  @override
  String toString() => 'RetryState('
      'attempt: $attempt, '
      'lastError: $lastError, '
      'totalDuration: $totalDuration)';
}

/// 重试错误记录
class RetryErrorRecord {
  /// 创建重试错误记录
  const RetryErrorRecord({
    required this.attempt,
    required this.error,
    required this.timestamp,
  });

  /// 重试次数
  final int attempt;

  /// 错误信息
  final VelocityError error;

  /// 发生时间
  final DateTime timestamp;

  @override
  String toString() => 'RetryErrorRecord('
      'attempt: $attempt, '
      'error: $error, '
      'timestamp: $timestamp)';
}

/// 重试回调
/// 用于在重试过程中接收通知
class RetryCallbacks {
  /// 创建重试回调
  const RetryCallbacks({
    this.onRetry,
    this.onRetryExhausted,
    this.onRetrySuccess,
  });

  /// 重试前回调
  /// 参数：错误、当前重试次数、下次重试延迟
  final void Function(VelocityError error, int attempt, Duration delay)?
      onRetry;

  /// 重试次数耗尽回调
  /// 参数：最终错误、总重试次数、重试状态
  final void Function(VelocityError error, int totalAttempts, RetryState state)?
      onRetryExhausted;

  /// 重试成功回调
  /// 参数：成功的重试次数、重试状态
  final void Function(int successAttempt, RetryState state)? onRetrySuccess;
}

/// 重试执行器
/// 执行带重试逻辑的操作
class RetryExecutor {
  /// 创建重试执行器
  RetryExecutor({
    required this.config,
    this.callbacks,
  });

  /// 重试配置
  final RetryConfig config;

  /// 重试回调
  final RetryCallbacks? callbacks;

  /// 执行带重试的操作
  /// [operation] 要执行的操作
  /// [onError] 错误处理函数，将异常转换为 VelocityError
  Future<Result<T>> execute<T>(
    Future<Result<T>> Function() operation, {
    VelocityError Function(dynamic error)? onError,
  }) async {
    var state = RetryState(startTime: DateTime.now());

    while (true) {
      try {
        final result = await operation();

        // 如果成功，通知回调并返回
        if (result.isSuccess) {
          if (!state.isFirstAttempt) {
            callbacks?.onRetrySuccess?.call(state.attempt, state);
          }
          return result;
        }

        // 如果失败，检查是否可以重试
        final error = result.errorOrNull!;
        if (!config.canRetry(error, state.attempt)) {
          if (state.attempt > 0) {
            callbacks?.onRetryExhausted?.call(error, state.attempt, state);
          }
          return result;
        }

        // 准备重试
        state = state.nextAttempt(error);
        final delay = config.getDelay(state.attempt - 1);

        // 通知重试回调
        callbacks?.onRetry?.call(error, state.attempt, delay);

        // 等待延迟后重试
        await Future<void>.delayed(delay);
      } catch (e) {
        // 处理异常
        final error = onError?.call(e) ?? ErrorHandler.classify(e);

        if (!config.canRetry(error, state.attempt)) {
          if (state.attempt > 0) {
            callbacks?.onRetryExhausted?.call(error, state.attempt, state);
          }
          return Failure<T>(error);
        }

        // 准备重试
        state = state.nextAttempt(error);
        final delay = config.getDelay(state.attempt - 1);

        // 通知重试回调
        callbacks?.onRetry?.call(error, state.attempt, delay);

        // 等待延迟后重试
        await Future<void>.delayed(delay);
      }
    }
  }
}

/// 重试拦截器
/// 在错误处理流程中自动进行重试
class RetryInterceptor extends ErrorInterceptor {
  /// 创建重试拦截器
  RetryInterceptor({
    required this.config,
    this.callbacks,
  });

  /// 重试配置
  final RetryConfig config;

  /// 重试回调
  final RetryCallbacks? callbacks;

  @override
  String get name => 'RetryInterceptor';

  @override
  int get priority => -100; // 高优先级

  @override
  Future<VelocityError> onError(
    dynamic error,
    HttpRequestConfig? request,
  ) async {
    final classifiedError = ErrorHandler.classify(error, request);

    // 检查是否可以重试
    // 注意：实际重试逻辑在 HTTP 客户端中实现
    // 这里只是标记错误是否可重试
    if (config.canRetry(classifiedError, 0)) {
      // 返回可重试的错误，让客户端处理重试
      return classifiedError;
    }

    return classifiedError;
  }
}

/// 预定义的重试策略
class RetryStrategies {
  RetryStrategies._();

  /// 无重试策略
  static const RetryConfig none = RetryConfig(
    maxRetries: 0,
    enabled: false,
  );

  /// 保守策略：少量重试，短延迟
  static const RetryConfig conservative = RetryConfig(
    maxRetries: 2,
    retryDelay: Duration(milliseconds: 500),
    maxDelay: Duration(seconds: 5),
  );

  /// 标准策略：适中的重试次数和延迟
  static const RetryConfig standard = RetryConfig(
    maxRetries: 3,
    retryDelay: Duration(seconds: 1),
    maxDelay: Duration(seconds: 30),
  );

  /// 激进策略：更多重试次数，更长延迟
  static const RetryConfig aggressive = RetryConfig(
    maxRetries: 5,
    retryDelay: Duration(seconds: 2),
    maxDelay: Duration(minutes: 1),
  );

  /// 仅网络错误重试策略
  static RetryConfig networkOnly = RetryConfig(
    maxRetries: 3,
    retryDelay: const Duration(seconds: 1),
    shouldRetry: (error, attempt) => error is NetworkError,
  );

  /// 仅超时重试策略
  static RetryConfig timeoutOnly = RetryConfig(
    maxRetries: 2,
    retryDelay: const Duration(seconds: 2),
    shouldRetry: (error, attempt) => error is TimeoutError,
  );
}
