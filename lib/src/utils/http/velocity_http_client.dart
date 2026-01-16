/// VelocityUI 企业级 HTTP 客户端
/// 整合缓存、重试、拦截器和加载状态管理的完整 HTTP 客户端
library velocity_http_client_enhanced;

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'cache.dart';
import 'cancel_token.dart';
import 'interceptors.dart';
import 'loading_state.dart';
import 'result.dart';
import 'retry.dart';

/// 响应解析器类型
typedef ResponseParser<T> = T Function(dynamic data);

/// 企业级 HTTP 客户端
/// 提供完整的 HTTP 请求功能，包括：
/// - 请求/响应/错误拦截器
/// - 响应缓存
/// - 自动重试
/// - 请求取消
/// - 全局加载状态管理
/// - JSON 序列化/反序列化
class VelocityHttpClient {
  /// 创建企业级 HTTP 客户端
  VelocityHttpClient({
    this.baseUrl = '',
    this.defaultHeaders = const {},
    this.timeout = const Duration(seconds: 30),
    CacheConfig? cacheConfig,
    RetryConfig? retryConfig,
    LoadingStateManager? loadingStateManager,
    List<RequestInterceptor>? requestInterceptors,
    List<ResponseInterceptor>? responseInterceptors,
    List<ErrorInterceptor>? errorInterceptors,
    http.Client? httpClient,
  })  : _cacheConfig = cacheConfig,
        _retryConfig = retryConfig ?? const RetryConfig(),
        _loadingStateManager = loadingStateManager,
        _interceptorChain = InterceptorChain(
          requestInterceptors: requestInterceptors,
          responseInterceptors: responseInterceptors,
          errorInterceptors: errorInterceptors,
        ),
        _httpClient = httpClient ?? http.Client() {
    // 初始化缓存管理器
    if (_cacheConfig != null) {
      _cacheManager = CacheManager(config: _cacheConfig);
    }
  }

  /// 基础 URL
  final String baseUrl;

  /// 默认请求头
  final Map<String, String> defaultHeaders;

  /// 默认超时时间
  final Duration timeout;

  /// 缓存配置
  final CacheConfig? _cacheConfig;

  /// 重试配置
  final RetryConfig _retryConfig;

  /// 加载状态管理器
  final LoadingStateManager? _loadingStateManager;

  /// 拦截器链
  final InterceptorChain _interceptorChain;

  /// HTTP 客户端
  final http.Client _httpClient;

  /// 缓存管理器
  CacheManager? _cacheManager;

  /// 获取缓存配置
  CacheConfig? get cacheConfig => _cacheConfig;

  /// 获取重试配置
  RetryConfig get retryConfig => _retryConfig;

  /// 获取缓存管理器
  CacheManager? get cacheManager => _cacheManager;

  /// 获取加载状态管理器
  LoadingStateManager? get loadingStateManager => _loadingStateManager;

  /// 获取拦截器链
  InterceptorChain get interceptorChain => _interceptorChain;

  // ==================== 拦截器管理 ====================

  /// 添加请求拦截器
  void addRequestInterceptor(RequestInterceptor interceptor) {
    _interceptorChain.addRequestInterceptor(interceptor);
  }

  /// 添加响应拦截器
  void addResponseInterceptor(ResponseInterceptor interceptor) {
    _interceptorChain.addResponseInterceptor(interceptor);
  }

  /// 添加错误拦截器
  void addErrorInterceptor(ErrorInterceptor interceptor) {
    _interceptorChain.addErrorInterceptor(interceptor);
  }

  /// 移除请求拦截器
  void removeRequestInterceptor(RequestInterceptor interceptor) {
    _interceptorChain.removeRequestInterceptor(interceptor);
  }

  /// 移除响应拦截器
  void removeResponseInterceptor(ResponseInterceptor interceptor) {
    _interceptorChain.removeResponseInterceptor(interceptor);
  }

  /// 移除错误拦截器
  void removeErrorInterceptor(ErrorInterceptor interceptor) {
    _interceptorChain.removeErrorInterceptor(interceptor);
  }

  /// 清空所有拦截器
  void clearInterceptors() {
    _interceptorChain.clear();
  }

  // ==================== 核心请求方法 ====================

  /// 发送 HTTP 请求并返回 Result 类型
  ///
  /// [path] 请求路径（相对于 baseUrl 或完整 URL）
  /// [method] HTTP 请求方法
  /// [queryParams] URL 查询参数
  /// [body] 请求体（自动序列化为 JSON）
  /// [headers] 请求头（与 defaultHeaders 合并）
  /// [cancelToken] 取消令牌
  /// [parser] 响应数据解析器
  /// [requestTimeout] 请求超时时间（覆盖默认值）
  /// [useCache] 是否使用缓存
  /// [cacheDuration] 缓存时长（覆盖默认值）
  /// [enableRetry] 是否启用重试
  /// [maxRetries] 最大重试次数（覆盖默认值）
  Future<Result<T>> request<T>({
    required String path,
    required HttpMethod method,
    Map<String, dynamic>? queryParams,
    dynamic body,
    Map<String, String>? headers,
    CancelToken? cancelToken,
    ResponseParser<T>? parser,
    Duration? requestTimeout,
    bool? useCache,
    Duration? cacheDuration,
    bool? enableRetry,
    int? maxRetries,
  }) async {
    String? requestId;

    try {
      // 检查是否已取消
      cancelToken?.throwIfCancelled();

      // 构建完整 URL
      final fullUrl = _buildUrl(path, queryParams);

      // 合并请求头
      final mergedHeaders = {
        ...defaultHeaders,
        ...?headers,
      };

      // 创建请求配置
      var requestConfig = HttpRequestConfig(
        url: fullUrl,
        method: method,
        headers: mergedHeaders,
        queryParams: queryParams,
        body: body,
        timeout: requestTimeout ?? timeout,
        cancelToken: cancelToken,
      );

      // 检查缓存
      final shouldUseCache = useCache ?? (_cacheConfig?.enabled ?? false);
      if (shouldUseCache && _cacheManager != null) {
        final cachedEntry = _cacheManager!.getCachedResponse<T>(requestConfig);
        if (cachedEntry != null && cachedEntry.isValid) {
          return Success<T>(
            cachedEntry.data,
            cachedEntry.statusCode,
            cachedEntry.headers,
          );
        }
      }

      // 开始跟踪加载状态
      requestId = _loadingStateManager?.startRequest(
        fullUrl,
        method: method.name,
      );

      // 执行请求拦截器
      requestConfig =
          await _interceptorChain.executeRequestInterceptors(requestConfig);

      // 检查是否已取消
      cancelToken?.throwIfCancelled();

      // 执行请求（带重试）
      final shouldRetry = enableRetry ?? _retryConfig.enabled;
      final retryConfig = shouldRetry
          ? _retryConfig.copyWith(
              maxRetries: maxRetries ?? _retryConfig.maxRetries,
            )
          : RetryStrategies.none;

      final result = await _executeWithRetry<T>(
        requestConfig: requestConfig,
        parser: parser,
        retryConfig: retryConfig,
        cancelToken: cancelToken,
      );

      // 缓存成功响应
      if (result.isSuccess && shouldUseCache && _cacheManager != null) {
        final success = result as Success<T>;
        final response = HttpResponse<T>(
          statusCode: success.statusCode,
          headers: success.headers,
          data: success.data,
          request: requestConfig,
        );
        _cacheManager!.cacheResponse(
          requestConfig,
          response,
          duration: cacheDuration,
        );
      }

      // 结束跟踪加载状态
      if (requestId != null) {
        _loadingStateManager?.endRequest(requestId, success: result.isSuccess);
      }

      return result;
    } catch (e) {
      // 结束跟踪加载状态
      if (requestId != null) {
        _loadingStateManager?.endRequest(requestId, success: false);
      }

      // 处理错误
      final error = await _interceptorChain.executeErrorInterceptors(e, null);
      return Failure<T>(error);
    }
  }

  /// 执行带重试的请求
  Future<Result<T>> _executeWithRetry<T>({
    required HttpRequestConfig requestConfig,
    required ResponseParser<T>? parser,
    required RetryConfig retryConfig,
    CancelToken? cancelToken,
  }) async {
    var attempt = 0;
    VelocityError? lastError;

    while (true) {
      try {
        // 检查是否已取消
        cancelToken?.throwIfCancelled();

        // 执行实际请求
        final result = await _executeRequest<T>(
          requestConfig: requestConfig,
          parser: parser,
          cancelToken: cancelToken,
        );

        return result;
      } catch (e) {
        lastError = ErrorHandler.classify(e, requestConfig);

        // 检查是否可以重试
        if (!retryConfig.canRetry(lastError, attempt)) {
          return Failure<T>(lastError);
        }

        // 等待重试延迟
        final delay = retryConfig.getDelay(attempt);
        await Future<void>.delayed(delay);

        attempt++;
      }
    }
  }

  /// 执行实际的 HTTP 请求
  Future<Result<T>> _executeRequest<T>({
    required HttpRequestConfig requestConfig,
    required ResponseParser<T>? parser,
    CancelToken? cancelToken,
  }) async {
    try {
      // 准备请求体（自动 JSON 序列化）
      dynamic requestBody = requestConfig.body;
      if (requestBody != null && requestBody is! String) {
        requestBody = jsonEncode(requestBody);
      }

      // 发送请求
      http.Response response;
      final uri = Uri.parse(requestConfig.url);

      final Future<http.Response> requestFuture;

      switch (requestConfig.method) {
        case HttpMethod.get:
          requestFuture = _httpClient.get(uri, headers: requestConfig.headers);
        case HttpMethod.post:
          requestFuture = _httpClient.post(
            uri,
            headers: requestConfig.headers,
            body: requestBody,
            encoding: requestConfig.encoding,
          );
        case HttpMethod.put:
          requestFuture = _httpClient.put(
            uri,
            headers: requestConfig.headers,
            body: requestBody,
            encoding: requestConfig.encoding,
          );
        case HttpMethod.delete:
          requestFuture = _httpClient.delete(
            uri,
            headers: requestConfig.headers,
            body: requestBody,
            encoding: requestConfig.encoding,
          );
        case HttpMethod.patch:
          requestFuture = _httpClient.patch(
            uri,
            headers: requestConfig.headers,
            body: requestBody,
            encoding: requestConfig.encoding,
          );
        case HttpMethod.head:
          requestFuture = _httpClient.head(uri, headers: requestConfig.headers);
        case HttpMethod.options:
          final request = http.Request('OPTIONS', uri);
          request.headers.addAll(requestConfig.headers);
          final streamedResponse = await _httpClient.send(request);
          requestFuture = http.Response.fromStream(streamedResponse);
      }

      // 应用超时和取消
      if (cancelToken != null) {
        response = await requestFuture
            .timeout(requestConfig.timeout)
            .withCancelToken(cancelToken);
      } else {
        response = await requestFuture.timeout(requestConfig.timeout);
      }

      // 解析响应体（自动 JSON 反序列化）
      dynamic responseData;
      try {
        if (response.body.isNotEmpty) {
          responseData = jsonDecode(response.body);
        }
      } catch (_) {
        responseData = response.body;
      }

      // 创建响应对象
      var httpResponse = HttpResponse<dynamic>(
        statusCode: response.statusCode,
        headers: response.headers,
        data: responseData,
        rawBody: response.body,
        request: requestConfig,
      );

      // 执行响应拦截器
      httpResponse =
          await _interceptorChain.executeResponseInterceptors(httpResponse);

      // 检查状态码
      if (!httpResponse.isSuccess) {
        final error = ErrorHandler.fromStatusCode(
          httpResponse.statusCode,
          httpResponse.data,
        );
        return Failure<T>(error);
      }

      // 解析数据
      T parsedData;
      if (parser != null) {
        parsedData = parser(httpResponse.data);
      } else {
        parsedData = httpResponse.data as T;
      }

      return Success<T>(
        parsedData,
        httpResponse.statusCode,
        httpResponse.headers,
      );
    } on CancelledException catch (e) {
      return Failure<T>(CancelError(e.message, 'CANCELLED'));
    } on TimeoutException catch (e) {
      return Failure<T>(TimeoutError(
        '请求超时: ${e.message ?? "连接超时"}',
        'TIMEOUT',
      ));
    } catch (e) {
      final error = ErrorHandler.classify(e, requestConfig);
      return Failure<T>(error);
    }
  }

  // ==================== 便捷请求方法 ====================

  /// 发送 GET 请求
  Future<Result<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    CancelToken? cancelToken,
    ResponseParser<T>? parser,
    bool? useCache,
    Duration? cacheDuration,
  }) {
    return request<T>(
      path: path,
      method: HttpMethod.get,
      queryParams: queryParams,
      headers: headers,
      cancelToken: cancelToken,
      parser: parser,
      useCache: useCache,
      cacheDuration: cacheDuration,
    );
  }

  /// 发送 POST 请求
  Future<Result<T>> post<T>(
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    CancelToken? cancelToken,
    ResponseParser<T>? parser,
  }) {
    return request<T>(
      path: path,
      method: HttpMethod.post,
      body: body,
      queryParams: queryParams,
      headers: headers,
      cancelToken: cancelToken,
      parser: parser,
    );
  }

  /// 发送 PUT 请求
  Future<Result<T>> put<T>(
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    CancelToken? cancelToken,
    ResponseParser<T>? parser,
  }) {
    return request<T>(
      path: path,
      method: HttpMethod.put,
      body: body,
      queryParams: queryParams,
      headers: headers,
      cancelToken: cancelToken,
      parser: parser,
    );
  }

  /// 发送 DELETE 请求
  Future<Result<T>> delete<T>(
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    CancelToken? cancelToken,
    ResponseParser<T>? parser,
  }) {
    return request<T>(
      path: path,
      method: HttpMethod.delete,
      body: body,
      queryParams: queryParams,
      headers: headers,
      cancelToken: cancelToken,
      parser: parser,
    );
  }

  /// 发送 PATCH 请求
  Future<Result<T>> patch<T>(
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    CancelToken? cancelToken,
    ResponseParser<T>? parser,
  }) {
    return request<T>(
      path: path,
      method: HttpMethod.patch,
      body: body,
      queryParams: queryParams,
      headers: headers,
      cancelToken: cancelToken,
      parser: parser,
    );
  }

  /// 发送 HEAD 请求
  Future<Result<void>> head(
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    CancelToken? cancelToken,
  }) {
    return request<void>(
      path: path,
      method: HttpMethod.head,
      queryParams: queryParams,
      headers: headers,
      cancelToken: cancelToken,
    );
  }

  /// 发送 OPTIONS 请求
  Future<Result<T>> options<T>(
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    CancelToken? cancelToken,
    ResponseParser<T>? parser,
  }) {
    return request<T>(
      path: path,
      method: HttpMethod.options,
      queryParams: queryParams,
      headers: headers,
      cancelToken: cancelToken,
      parser: parser,
    );
  }

  // ==================== 缓存管理 ====================

  /// 清除所有缓存
  void clearCache() {
    _cacheManager?.clear();
  }

  /// 清除指定路径的缓存
  void invalidateCache(String path, {Map<String, dynamic>? queryParams}) {
    if (_cacheManager == null) return;

    final fullUrl = _buildUrl(path, queryParams);
    final config = HttpRequestConfig(
      url: fullUrl,
      method: HttpMethod.get,
      queryParams: queryParams,
    );
    _cacheManager!.invalidate(config);
  }

  /// 使匹配指定模式的缓存失效
  void invalidateCachePattern(bool Function(String key) pattern) {
    _cacheManager?.invalidatePattern(pattern);
  }

  /// 移除过期缓存
  int removeExpiredCache() {
    return _cacheManager?.removeExpired() ?? 0;
  }

  /// 获取缓存统计信息
  CacheStats? getCacheStats() {
    return _cacheManager?.getStats();
  }

  // ==================== 工具方法 ====================

  /// 构建完整 URL
  String _buildUrl(String path, Map<String, dynamic>? queryParams) {
    final Uri uri;

    // 如果是完整 URL，直接使用
    if (path.startsWith('http://') || path.startsWith('https://')) {
      uri = Uri.parse(path);
    } else {
      // 否则拼接 baseUrl
      final baseUri = Uri.parse(baseUrl);
      uri = baseUri.resolve(path);
    }

    // 添加查询参数
    if (queryParams != null && queryParams.isNotEmpty) {
      final stringParams = queryParams.map(
        (key, value) => MapEntry(key, value?.toString() ?? ''),
      );
      return uri.replace(queryParameters: {
        ...uri.queryParameters,
        ...stringParams,
      }).toString();
    }

    return uri.toString();
  }

  /// 关闭客户端
  void close() {
    _httpClient.close();
    _loadingStateManager?.dispose();
    _cacheManager?.clear();
  }
}

/// EnhancedHttpClient 别名（向后兼容）
/// @deprecated 请使用 VelocityHttpClient
typedef EnhancedHttpClient = VelocityHttpClient;

/// 创建默认配置的 HTTP 客户端
VelocityHttpClient createHttpClient({
  String? baseUrl,
  Map<String, String>? defaultHeaders,
  Duration? timeout,
  CacheConfig? cacheConfig,
  RetryConfig? retryConfig,
  bool enableLoadingState = false,
}) {
  return VelocityHttpClient(
    baseUrl: baseUrl ?? '',
    defaultHeaders: defaultHeaders ?? const {},
    timeout: timeout ?? const Duration(seconds: 30),
    cacheConfig: cacheConfig,
    retryConfig: retryConfig,
    loadingStateManager: enableLoadingState ? LoadingStateManager() : null,
  );
}

/// 创建带完整功能的 HTTP 客户端
VelocityHttpClient createFullFeaturedHttpClient({
  required String baseUrl,
  Map<String, String>? defaultHeaders,
  Duration timeout = const Duration(seconds: 30),
  Duration cacheDuration = const Duration(minutes: 5),
  int maxCacheEntries = 100,
  int maxRetries = 3,
  Duration retryDelay = const Duration(seconds: 1),
  LoadingStateCallback? onLoadingStateChanged,
}) {
  return VelocityHttpClient(
    baseUrl: baseUrl,
    defaultHeaders: defaultHeaders ?? const {},
    timeout: timeout,
    cacheConfig: CacheConfig(
      duration: cacheDuration,
      maxEntries: maxCacheEntries,
      enabled: true,
    ),
    retryConfig: RetryConfig(
      maxRetries: maxRetries,
      retryDelay: retryDelay,
      enabled: true,
    ),
    loadingStateManager: onLoadingStateChanged != null
        ? LoadingStateManager(onLoadingStateChanged: onLoadingStateChanged)
        : null,
  );
}

/// 全局 HTTP 客户端实例
/// 使用默认配置，可通过 setGlobalHttpClient 替换
VelocityHttpClient _globalHttpClient = VelocityHttpClient();

/// 获取全局 HTTP 客户端实例
VelocityHttpClient get globalHttpClient => _globalHttpClient;

/// 设置全局 HTTP 客户端实例
void setGlobalHttpClient(VelocityHttpClient client) {
  _globalHttpClient.close();
  _globalHttpClient = client;
}

/// 重置全局 HTTP 客户端为默认配置
void resetGlobalHttpClient() {
  _globalHttpClient.close();
  _globalHttpClient = VelocityHttpClient();
}
