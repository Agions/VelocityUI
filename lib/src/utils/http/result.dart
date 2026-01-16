/// VelocityUI HTTP 统一结果类型
/// 提供类型安全的请求结果处理
library velocity_http_result;

/// 统一结果类型
/// 使用 sealed class 确保类型安全的模式匹配
sealed class Result<T> {
  const Result();

  /// 是否成功
  bool get isSuccess => this is Success<T>;

  /// 是否失败
  bool get isFailure => this is Failure<T>;

  /// 获取成功数据，失败时返回 null
  T? get dataOrNull => switch (this) {
        Success<T>(:final data) => data,
        Failure<T>() => null,
      };

  /// 获取错误，成功时返回 null
  VelocityError? get errorOrNull => switch (this) {
        Success<T>() => null,
        Failure<T>(:final error) => error,
      };

  /// 映射成功结果
  Result<R> map<R>(R Function(T data) mapper) => switch (this) {
        Success<T>(:final data, :final statusCode, :final headers) =>
          Success<R>(mapper(data), statusCode, headers),
        Failure<T>(:final error) => Failure<R>(error),
      };

  /// 映射失败结果
  Result<T> mapError(VelocityError Function(VelocityError error) mapper) =>
      switch (this) {
        Success<T>() => this,
        Failure<T>(:final error) => Failure<T>(mapper(error)),
      };

  /// 处理结果
  R fold<R>({
    required R Function(T data, int statusCode, Map<String, String> headers)
        onSuccess,
    required R Function(VelocityError error) onFailure,
  }) =>
      switch (this) {
        Success<T>(:final data, :final statusCode, :final headers) =>
          onSuccess(data, statusCode, headers),
        Failure<T>(:final error) => onFailure(error),
      };

  /// 获取数据或抛出异常
  T getOrThrow() => switch (this) {
        Success<T>(:final data) => data,
        Failure<T>(:final error) =>
          throw VelocityHttpException(error.message, error.code),
      };

  /// 获取数据或返回默认值
  T getOrElse(T defaultValue) => switch (this) {
        Success<T>(:final data) => data,
        Failure<T>() => defaultValue,
      };
}

/// 成功结果
class Success<T> extends Result<T> {
  /// 创建成功结果
  const Success(this.data, this.statusCode, this.headers);

  /// 响应数据
  final T data;

  /// HTTP 状态码
  final int statusCode;

  /// 响应头
  final Map<String, String> headers;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Success<T> &&
          runtimeType == other.runtimeType &&
          data == other.data &&
          statusCode == other.statusCode;

  @override
  int get hashCode => Object.hash(data, statusCode);

  @override
  String toString() => 'Success(data: $data, statusCode: $statusCode)';
}

/// 失败结果
class Failure<T> extends Result<T> {
  /// 创建失败结果
  const Failure(this.error);

  /// 错误信息
  final VelocityError error;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure<T> &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;

  @override
  String toString() => 'Failure(error: $error)';
}

/// 错误基类
/// 使用 sealed class 确保错误分类完整性
sealed class VelocityError {
  /// 创建错误
  const VelocityError(this.message, [this.code]);

  /// 错误消息
  final String message;

  /// 错误代码
  final String? code;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VelocityError &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          code == other.code;

  @override
  int get hashCode => Object.hash(message, code);
}

/// 网络错误
/// 表示网络连接失败、DNS 解析失败等网络层面的错误
class NetworkError extends VelocityError {
  /// 创建网络错误
  const NetworkError(super.message, [super.code]);

  @override
  String toString() => 'NetworkError(message: $message, code: $code)';
}

/// 服务器错误
/// 表示服务器返回 5xx 状态码的错误
class ServerError extends VelocityError {
  /// 创建服务器错误
  const ServerError(super.message, this.statusCode, [super.code]);

  /// HTTP 状态码
  final int statusCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServerError &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          code == other.code &&
          statusCode == other.statusCode;

  @override
  int get hashCode => Object.hash(message, code, statusCode);

  @override
  String toString() =>
      'ServerError(message: $message, statusCode: $statusCode, code: $code)';
}

/// 业务错误
/// 表示业务逻辑层面的错误，如参数校验失败、权限不足等
class BusinessError extends VelocityError {
  /// 创建业务错误
  const BusinessError(super.message, this.data, [super.code]);

  /// 附加数据
  final dynamic data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusinessError &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          code == other.code &&
          data == other.data;

  @override
  int get hashCode => Object.hash(message, code, data);

  @override
  String toString() =>
      'BusinessError(message: $message, data: $data, code: $code)';
}

/// 超时错误
/// 表示请求超时的错误
class TimeoutError extends VelocityError {
  /// 创建超时错误
  const TimeoutError(super.message, [super.code]);

  @override
  String toString() => 'TimeoutError(message: $message, code: $code)';
}

/// 取消错误
/// 表示请求被用户主动取消的错误
class CancelError extends VelocityError {
  /// 创建取消错误
  const CancelError(super.message, [super.code]);

  @override
  String toString() => 'CancelError(message: $message, code: $code)';
}

/// HTTP 异常
/// 用于在需要抛出异常的场景中使用
class VelocityHttpException implements Exception {
  /// 创建 HTTP 异常
  const VelocityHttpException(this.message, [this.code]);

  /// 错误消息
  final String message;

  /// 错误代码
  final String? code;

  @override
  String toString() => 'VelocityHttpException: $message (code: $code)';
}
