/// VelocityUI HTTP 拦截器系统
/// 提供请求、响应和错误拦截器的抽象接口
library velocity_http_interceptors;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'cancel_token.dart';
import 'result.dart';
import 'status_codes.dart';

/// HTTP 请求方法枚举
enum HttpMethod {
  /// GET 请求
  get,

  /// POST 请求
  post,

  /// PUT 请求
  put,

  /// DELETE 请求
  delete,

  /// PATCH 请求
  patch,

  /// HEAD 请求
  head,

  /// OPTIONS 请求
  options,
}

/// HTTP 请求配置
/// 包含请求的所有配置信息
class HttpRequestConfig {
  /// 创建 HTTP 请求配置
  HttpRequestConfig({
    required this.url,
    required this.method,
    this.headers = const {},
    this.queryParams,
    this.body,
    this.timeout = const Duration(seconds: 30),
    this.encoding = utf8,
    this.cancelToken,
  });

  /// 从 Map 反序列化
  factory HttpRequestConfig.fromJson(Map<String, dynamic> json) {
    return HttpRequestConfig(
      url: json['url'] as String,
      method: HttpMethod.values.firstWhere(
        (m) => m.name == json['method'],
        orElse: () => HttpMethod.get,
      ),
      headers: Map<String, String>.from(json['headers'] as Map? ?? {}),
      queryParams: json['queryParams'] as Map<String, dynamic>?,
      body: json['body'],
      timeout: Duration(milliseconds: json['timeout'] as int? ?? 30000),
    );
  }

  /// 请求 URL
  final String url;

  /// 请求方法
  final HttpMethod method;

  /// 请求头
  final Map<String, String> headers;

  /// URL 查询参数
  final Map<String, dynamic>? queryParams;

  /// 请求体
  final dynamic body;

  /// 请求超时时间
  final Duration timeout;

  /// 编码方式
  final Encoding encoding;

  /// 取消令牌
  final CancelToken? cancelToken;

  /// 复制请求配置并替换指定属性
  HttpRequestConfig copyWith({
    String? url,
    HttpMethod? method,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    dynamic body,
    Duration? timeout,
    Encoding? encoding,
    CancelToken? cancelToken,
  }) {
    return HttpRequestConfig(
      url: url ?? this.url,
      method: method ?? this.method,
      headers: headers ?? this.headers,
      queryParams: queryParams ?? this.queryParams,
      body: body ?? this.body,
      timeout: timeout ?? this.timeout,
      encoding: encoding ?? this.encoding,
      cancelToken: cancelToken ?? this.cancelToken,
    );
  }

  /// 序列化为 Map
  Map<String, dynamic> toJson() => {
        'url': url,
        'method': method.name,
        'headers': headers,
        'queryParams': queryParams,
        'body': body,
        'timeout': timeout.inMilliseconds,
      };

  @override
  String toString() =>
      'HttpRequestConfig(url: $url, method: ${method.name}, headers: $headers)';
}

/// HTTP 响应
/// 包含响应的所有信息
class HttpResponse<T> {
  /// 创建 HTTP 响应
  const HttpResponse({
    required this.statusCode,
    required this.headers,
    required this.request,
    this.data,
    this.rawBody,
  });

  /// HTTP 状态码
  final int statusCode;

  /// 响应头
  final Map<String, String> headers;

  /// 解析后的响应数据
  final T? data;

  /// 原始响应体
  final String? rawBody;

  /// 原始请求配置
  final HttpRequestConfig request;

  /// 是否成功响应（2xx 状态码）
  bool get isSuccess => statusCode >= 200 && statusCode < 300;

  /// 复制响应并替换指定属性
  HttpResponse<R> copyWith<R>({
    int? statusCode,
    Map<String, String>? headers,
    R? data,
    String? rawBody,
    HttpRequestConfig? request,
  }) {
    return HttpResponse<R>(
      statusCode: statusCode ?? this.statusCode,
      headers: headers ?? this.headers,
      data: data,
      rawBody: rawBody ?? this.rawBody,
      request: request ?? this.request,
    );
  }

  /// 序列化为 Map
  Map<String, dynamic> toJson([Object? Function(T)? dataToJson]) => {
        'statusCode': statusCode,
        'headers': headers,
        'data':
            dataToJson != null && data != null ? dataToJson(data as T) : data,
        'rawBody': rawBody,
        'request': request.toJson(),
      };

  /// 从 Map 反序列化
  static HttpResponse<T> fromJson<T>(
    Map<String, dynamic> json, [
    T Function(Object?)? dataFromJson,
  ]) {
    return HttpResponse<T>(
      statusCode: json['statusCode'] as int,
      headers: Map<String, String>.from(json['headers'] as Map? ?? {}),
      data: dataFromJson != null
          ? dataFromJson(json['data'])
          : json['data'] as T?,
      rawBody: json['rawBody'] as String?,
      request:
          HttpRequestConfig.fromJson(json['request'] as Map<String, dynamic>),
    );
  }

  @override
  String toString() => 'HttpResponse(statusCode: $statusCode, data: $data)';
}

// ==================== 请求拦截器 ====================

/// 请求拦截器抽象类
/// 用于在请求发送前对请求进行处理
abstract class RequestInterceptor {
  /// 拦截器名称，用于调试和日志
  String get name => runtimeType.toString();

  /// 拦截器优先级，数值越小优先级越高
  int get priority => 0;

  /// 拦截请求
  /// 返回修改后的请求配置
  Future<HttpRequestConfig> onRequest(HttpRequestConfig config);
}

/// 请求头注入拦截器
/// 用于向请求中添加通用请求头
class HeaderInjectionInterceptor extends RequestInterceptor {
  /// 创建请求头注入拦截器
  HeaderInjectionInterceptor({
    required this.headersProvider,
    this.interceptorName = 'HeaderInjectionInterceptor',
  });

  /// 请求头提供器
  /// 返回要注入的请求头
  final FutureOr<Map<String, String>> Function() headersProvider;

  /// 拦截器名称
  final String interceptorName;

  @override
  String get name => interceptorName;

  @override
  Future<HttpRequestConfig> onRequest(HttpRequestConfig config) async {
    final headers = await headersProvider();
    return config.copyWith(
      headers: {
        ...config.headers,
        ...headers,
      },
    );
  }
}

/// 授权拦截器
/// 用于向请求中添加授权头
class AuthorizationInterceptor extends RequestInterceptor {
  /// 创建授权拦截器
  AuthorizationInterceptor({
    required this.tokenProvider,
    this.tokenType = 'Bearer',
    this.headerName = 'Authorization',
  });

  /// Token 提供器
  final FutureOr<String?> Function() tokenProvider;

  /// Token 类型（如 Bearer）
  final String tokenType;

  /// 请求头名称
  final String headerName;

  @override
  String get name => 'AuthorizationInterceptor';

  @override
  int get priority => -100; // 高优先级

  @override
  Future<HttpRequestConfig> onRequest(HttpRequestConfig config) async {
    final token = await tokenProvider();
    if (token == null || token.isEmpty) {
      return config;
    }

    return config.copyWith(
      headers: {
        ...config.headers,
        headerName: '$tokenType $token',
      },
    );
  }
}

/// 请求参数转换拦截器
/// 用于转换请求参数
class RequestTransformInterceptor extends RequestInterceptor {
  /// 创建请求参数转换拦截器
  RequestTransformInterceptor({
    required this.transformer,
    this.interceptorName = 'RequestTransformInterceptor',
  });

  /// 参数转换器
  final FutureOr<HttpRequestConfig> Function(HttpRequestConfig config)
      transformer;

  /// 拦截器名称
  final String interceptorName;

  @override
  String get name => interceptorName;

  @override
  Future<HttpRequestConfig> onRequest(HttpRequestConfig config) async {
    return transformer(config);
  }
}

/// 内容类型拦截器
/// 用于设置请求的 Content-Type
class ContentTypeInterceptor extends RequestInterceptor {
  /// 创建内容类型拦截器
  ContentTypeInterceptor({
    this.contentType = 'application/json',
    this.acceptType = 'application/json',
  });

  /// Content-Type 值
  final String contentType;

  /// Accept 值
  final String acceptType;

  @override
  String get name => 'ContentTypeInterceptor';

  @override
  Future<HttpRequestConfig> onRequest(HttpRequestConfig config) async {
    final headers = Map<String, String>.from(config.headers);

    // 只有在有请求体时才设置 Content-Type
    if (config.body != null && !headers.containsKey('Content-Type')) {
      headers['Content-Type'] = contentType;
    }

    // 设置 Accept
    if (!headers.containsKey('Accept')) {
      headers['Accept'] = acceptType;
    }

    return config.copyWith(headers: headers);
  }
}

// ==================== 响应拦截器 ====================

/// 响应拦截器抽象类
/// 用于在收到响应后对响应进行处理
abstract class ResponseInterceptor {
  /// 拦截器名称，用于调试和日志
  String get name => runtimeType.toString();

  /// 拦截器优先级，数值越小优先级越高
  int get priority => 0;

  /// 拦截响应
  /// 返回修改后的响应或转换后的结果
  Future<HttpResponse<T>> onResponse<T>(HttpResponse<T> response);
}

/// 响应数据标准化拦截器
/// 将响应数据转换为统一的 Result 类型
class ResponseStandardizationInterceptor extends ResponseInterceptor {
  /// 创建响应数据标准化拦截器
  ResponseStandardizationInterceptor({
    this.successCodeRange = const (200, 299),
    this.businessErrorExtractor,
  });

  /// 成功状态码范围
  final (int, int) successCodeRange;

  /// 业务错误提取器
  /// 用于从响应数据中提取业务错误信息
  final VelocityError? Function(dynamic data, int statusCode)?
      businessErrorExtractor;

  @override
  String get name => 'ResponseStandardizationInterceptor';

  @override
  Future<HttpResponse<T>> onResponse<T>(HttpResponse<T> response) async {
    // 响应拦截器主要用于数据转换和日志记录
    // Result 类型的转换在 HTTP 客户端层面处理
    return response;
  }

  /// 将响应转换为 Result 类型
  Result<T> toResult<T>(HttpResponse<T> response) {
    final statusCode = response.statusCode;

    // 检查是否在成功状态码范围内
    if (statusCode >= successCodeRange.$1 &&
        statusCode <= successCodeRange.$2) {
      // 检查是否有业务错误
      if (businessErrorExtractor != null) {
        final businessError =
            businessErrorExtractor!(response.data, statusCode);
        if (businessError != null) {
          return Failure<T>(businessError);
        }
      }
      return Success<T>(
        response.data as T,
        statusCode,
        response.headers,
      );
    }

    // 服务器错误
    if (HttpStatusCodes.isServerError(statusCode)) {
      return Failure<T>(ServerError(
        HttpStatusCodes.getMessage(statusCode),
        statusCode,
        'SERVER_ERROR',
      ));
    }

    // 客户端错误
    return Failure<T>(BusinessError(
      HttpStatusCodes.getMessage(statusCode),
      response.data,
      'CLIENT_ERROR_$statusCode',
    ));
  }
}

/// 响应日志拦截器
/// 用于记录响应日志
class ResponseLogInterceptor extends ResponseInterceptor {
  /// 创建响应日志拦截器
  ResponseLogInterceptor({
    this.logger,
    this.logHeaders = false,
    this.logBody = true,
  });

  /// 日志记录器
  final void Function(String message)? logger;

  /// 是否记录响应头
  final bool logHeaders;

  /// 是否记录响应体
  final bool logBody;

  @override
  String get name => 'ResponseLogInterceptor';

  @override
  int get priority => 100; // 低优先级，最后执行

  @override
  Future<HttpResponse<T>> onResponse<T>(HttpResponse<T> response) async {
    final log = logger ?? print;
    final buffer = StringBuffer();

    buffer.writeln('=== HTTP Response ===');
    buffer.writeln('Status: ${response.statusCode}');
    buffer.writeln('URL: ${response.request.url}');

    if (logHeaders) {
      buffer.writeln('Headers: ${response.headers}');
    }

    if (logBody && response.data != null) {
      buffer.writeln('Body: ${response.data}');
    }

    buffer.writeln('=====================');

    log(buffer.toString());
    return response;
  }
}

// ==================== 错误拦截器 ====================

/// 错误拦截器抽象类
/// 用于处理请求过程中发生的错误
abstract class ErrorInterceptor {
  /// 拦截器名称，用于调试和日志
  String get name => runtimeType.toString();

  /// 拦截器优先级，数值越小优先级越高
  int get priority => 0;

  /// 拦截错误
  /// 可以返回修改后的错误或尝试恢复
  Future<VelocityError> onError(
    dynamic error,
    HttpRequestConfig? request,
  );
}

/// 错误处理器
/// 提供错误分类和处理功能
class ErrorHandler {
  ErrorHandler._();

  /// 处理异常并分类
  /// 将各种异常转换为统一的 VelocityError 类型
  static VelocityError classify(dynamic error, [HttpRequestConfig? request]) {
    // 已经是 VelocityError，直接返回
    if (error is VelocityError) {
      return error;
    }

    // 取消异常
    if (error is CancelledException) {
      return CancelError(error.message, 'CANCELLED');
    }

    // 超时异常
    if (error is TimeoutException) {
      return TimeoutError(
        '请求超时: ${error.message ?? "连接超时"}',
        'TIMEOUT',
      );
    }

    // Socket 异常（网络连接问题）
    if (error is SocketException) {
      return NetworkError(
        '网络连接失败: ${error.message}',
        'NETWORK_ERROR',
      );
    }

    // HTTP 异常
    if (error is HttpException) {
      return NetworkError(
        'HTTP 错误: ${error.message}',
        'HTTP_ERROR',
      );
    }

    // 格式异常（JSON 解析等）
    if (error is FormatException) {
      return BusinessError(
        '数据格式错误: ${error.message}',
        null,
        'FORMAT_ERROR',
      );
    }

    // 类型错误
    if (error is TypeError) {
      return BusinessError(
        '类型错误: ${error.toString()}',
        null,
        'TYPE_ERROR',
      );
    }

    // 其他异常
    return NetworkError(
      '未知错误: ${error.toString()}',
      'UNKNOWN_ERROR',
    );
  }

  /// 根据 HTTP 状态码创建错误
  static VelocityError fromStatusCode(int statusCode, [dynamic data]) {
    if (HttpStatusCodes.isServerError(statusCode)) {
      return ServerError(
        HttpStatusCodes.getMessage(statusCode),
        statusCode,
        'SERVER_ERROR',
      );
    }

    if (HttpStatusCodes.isClientError(statusCode)) {
      return BusinessError(
        HttpStatusCodes.getMessage(statusCode),
        data,
        'CLIENT_ERROR_$statusCode',
      );
    }

    return NetworkError(
      HttpStatusCodes.getMessage(statusCode),
      'HTTP_$statusCode',
    );
  }

  /// 判断错误是否可重试
  static bool isRetryable(VelocityError error) {
    // 网络错误和超时错误可以重试
    if (error is NetworkError || error is TimeoutError) {
      return true;
    }

    // 服务器错误（5xx）可以重试
    if (error is ServerError) {
      // 503 Service Unavailable 和 504 Gateway Timeout 可以重试
      return error.statusCode == 503 || error.statusCode == 504;
    }

    // 取消错误和业务错误不应重试
    return false;
  }
}

/// 默认错误拦截器
/// 提供基本的错误分类功能
class DefaultErrorInterceptor extends ErrorInterceptor {
  /// 创建默认错误拦截器
  DefaultErrorInterceptor({
    this.onErrorCallback,
  });

  /// 错误回调
  final void Function(VelocityError error, HttpRequestConfig? request)?
      onErrorCallback;

  @override
  String get name => 'DefaultErrorInterceptor';

  @override
  Future<VelocityError> onError(
    dynamic error,
    HttpRequestConfig? request,
  ) async {
    final classifiedError = ErrorHandler.classify(error, request);

    // 调用错误回调
    onErrorCallback?.call(classifiedError, request);

    return classifiedError;
  }
}

/// 错误日志拦截器
/// 用于记录错误日志
class ErrorLogInterceptor extends ErrorInterceptor {
  /// 创建错误日志拦截器
  ErrorLogInterceptor({
    this.logger,
    this.logStackTrace = true,
  });

  /// 日志记录器
  final void Function(String message)? logger;

  /// 是否记录堆栈跟踪
  final bool logStackTrace;

  @override
  String get name => 'ErrorLogInterceptor';

  @override
  int get priority => 100; // 低优先级，最后执行

  @override
  Future<VelocityError> onError(
    dynamic error,
    HttpRequestConfig? request,
  ) async {
    final log = logger ?? print;
    final buffer = StringBuffer();

    buffer.writeln('=== HTTP Error ===');
    if (request != null) {
      buffer.writeln('URL: ${request.url}');
      buffer.writeln('Method: ${request.method.name}');
    }
    buffer.writeln('Error: $error');

    if (logStackTrace && error is Error) {
      buffer.writeln('StackTrace: ${error.stackTrace}');
    }

    buffer.writeln('==================');

    log(buffer.toString());

    return ErrorHandler.classify(error, request);
  }
}

/// 错误重试拦截器
/// 用于在发生可重试错误时进行重试
class RetryErrorInterceptor extends ErrorInterceptor {
  /// 创建错误重试拦截器
  RetryErrorInterceptor({
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 1),
    this.shouldRetry,
    this.onRetry,
  });

  /// 最大重试次数
  final int maxRetries;

  /// 重试延迟
  final Duration retryDelay;

  /// 自定义重试条件
  final bool Function(VelocityError error, int attempt)? shouldRetry;

  /// 重试回调
  final void Function(VelocityError error, int attempt)? onRetry;

  @override
  String get name => 'RetryErrorInterceptor';

  @override
  int get priority => -50; // 较高优先级

  @override
  Future<VelocityError> onError(
    dynamic error,
    HttpRequestConfig? request,
  ) async {
    final classifiedError = ErrorHandler.classify(error, request);

    // 检查是否应该重试
    final canRetry = shouldRetry?.call(classifiedError, 0) ??
        ErrorHandler.isRetryable(classifiedError);

    if (!canRetry) {
      return classifiedError;
    }

    // 通知重试
    onRetry?.call(classifiedError, 0);

    // 返回错误，实际重试逻辑在 HTTP 客户端中实现
    return classifiedError;
  }
}

// ==================== 拦截器链 ====================

/// 拦截器链
/// 管理和执行拦截器
class InterceptorChain {
  /// 创建拦截器链
  InterceptorChain({
    List<RequestInterceptor>? requestInterceptors,
    List<ResponseInterceptor>? responseInterceptors,
    List<ErrorInterceptor>? errorInterceptors,
  })  : _requestInterceptors = requestInterceptors ?? [],
        _responseInterceptors = responseInterceptors ?? [],
        _errorInterceptors = errorInterceptors ?? [];

  final List<RequestInterceptor> _requestInterceptors;
  final List<ResponseInterceptor> _responseInterceptors;
  final List<ErrorInterceptor> _errorInterceptors;

  /// 获取请求拦截器列表
  List<RequestInterceptor> get requestInterceptors =>
      List.unmodifiable(_requestInterceptors);

  /// 获取响应拦截器列表
  List<ResponseInterceptor> get responseInterceptors =>
      List.unmodifiable(_responseInterceptors);

  /// 获取错误拦截器列表
  List<ErrorInterceptor> get errorInterceptors =>
      List.unmodifiable(_errorInterceptors);

  /// 添加请求拦截器
  void addRequestInterceptor(RequestInterceptor interceptor) {
    _requestInterceptors.add(interceptor);
    _sortRequestInterceptors();
  }

  /// 添加响应拦截器
  void addResponseInterceptor(ResponseInterceptor interceptor) {
    _responseInterceptors.add(interceptor);
    _sortResponseInterceptors();
  }

  /// 添加错误拦截器
  void addErrorInterceptor(ErrorInterceptor interceptor) {
    _errorInterceptors.add(interceptor);
    _sortErrorInterceptors();
  }

  /// 移除请求拦截器
  void removeRequestInterceptor(RequestInterceptor interceptor) {
    _requestInterceptors.remove(interceptor);
  }

  /// 移除响应拦截器
  void removeResponseInterceptor(ResponseInterceptor interceptor) {
    _responseInterceptors.remove(interceptor);
  }

  /// 移除错误拦截器
  void removeErrorInterceptor(ErrorInterceptor interceptor) {
    _errorInterceptors.remove(interceptor);
  }

  /// 清空所有拦截器
  void clear() {
    _requestInterceptors.clear();
    _responseInterceptors.clear();
    _errorInterceptors.clear();
  }

  /// 执行请求拦截器链
  Future<HttpRequestConfig> executeRequestInterceptors(
    HttpRequestConfig config,
  ) async {
    var currentConfig = config;
    for (final interceptor in _requestInterceptors) {
      currentConfig = await interceptor.onRequest(currentConfig);
    }
    return currentConfig;
  }

  /// 执行响应拦截器链
  Future<HttpResponse<T>> executeResponseInterceptors<T>(
    HttpResponse<T> response,
  ) async {
    var currentResponse = response;
    for (final interceptor in _responseInterceptors) {
      currentResponse = await interceptor.onResponse(currentResponse);
    }
    return currentResponse;
  }

  /// 执行错误拦截器链
  Future<VelocityError> executeErrorInterceptors(
    dynamic error,
    HttpRequestConfig? request,
  ) async {
    var currentError = ErrorHandler.classify(error, request);
    for (final interceptor in _errorInterceptors) {
      currentError = await interceptor.onError(currentError, request);
    }
    return currentError;
  }

  void _sortRequestInterceptors() {
    _requestInterceptors.sort((a, b) => a.priority.compareTo(b.priority));
  }

  void _sortResponseInterceptors() {
    _responseInterceptors.sort((a, b) => a.priority.compareTo(b.priority));
  }

  void _sortErrorInterceptors() {
    _errorInterceptors.sort((a, b) => a.priority.compareTo(b.priority));
  }
}
