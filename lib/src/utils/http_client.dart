/// VelocityUI HTTP客户端工具
/// 支持请求拦截和响应拦截功能
///
/// @deprecated 此模块已弃用，请使用 `package:velocity_ui/src/utils/http/index.dart`
/// 新的 HTTP 客户端提供更完整的功能，包括缓存、重试、取消等
library velocity_http_client;

import 'dart:convert';

import 'package:http/http.dart' as http;

// 导出新的 HTTP 模块
export 'http/index.dart';

/// HTTP请求方法枚举
/// @deprecated 请使用 HttpMethod
enum VelocityHttpMethod {
  /// GET请求
  get,

  /// POST请求
  post,

  /// PUT请求
  put,

  /// DELETE请求
  delete,

  /// PATCH请求
  patch,

  /// HEAD请求
  head,

  /// OPTIONS请求
  options,
}

/// HTTP请求配置
/// @deprecated 请使用 HttpRequestConfig
class VelocityHttpRequest {
  /// 创建HTTP请求配置
  VelocityHttpRequest({
    required this.url,
    required this.method,
    this.headers = const {},
    this.body,
    this.queryParameters = const {},
    this.timeout = const Duration(seconds: 30),
    this.encoding = utf8,
  });

  /// 请求URL
  final String url;

  /// 请求方法
  final VelocityHttpMethod method;

  /// 请求头
  final Map<String, String> headers;

  /// 请求体
  final dynamic body;

  /// URL查询参数
  final Map<String, dynamic> queryParameters;

  /// 请求超时时间
  final Duration timeout;

  /// 编码方式
  final Encoding encoding;

  /// 复制请求配置并替换指定属性
  VelocityHttpRequest copyWith({
    String? url,
    VelocityHttpMethod? method,
    Map<String, String>? headers,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Duration? timeout,
    Encoding? encoding,
  }) {
    return VelocityHttpRequest(
      url: url ?? this.url,
      method: method ?? this.method,
      headers: headers ?? this.headers,
      body: body ?? this.body,
      queryParameters: queryParameters ?? this.queryParameters,
      timeout: timeout ?? this.timeout,
      encoding: encoding ?? this.encoding,
    );
  }
}

/// HTTP响应
/// @deprecated 请使用 HttpResponse
class VelocityHttpResponse {
  /// 创建HTTP响应
  VelocityHttpResponse({
    required this.statusCode,
    required this.headers,
    required this.body,
    required this.request,
  });

  /// 响应状态码
  final int statusCode;

  /// 响应头
  final Map<String, String> headers;

  /// 响应体
  final dynamic body;

  /// 原始请求
  final http.BaseRequest request;

  /// 是否成功响应（2xx状态码）
  bool get isSuccess => statusCode >= 200 && statusCode < 300;

  /// 将响应体解析为JSON
  dynamic get json => body is String ? jsonDecode(body) : body;
}

/// 请求拦截器
/// @deprecated 请使用 RequestInterceptor 类
typedef VelocityRequestInterceptor = Future<VelocityHttpRequest> Function(
    VelocityHttpRequest request);

/// 响应拦截器
/// @deprecated 请使用 ResponseInterceptor 类
typedef VelocityResponseInterceptor = Future<VelocityHttpResponse> Function(
    VelocityHttpResponse response);

/// 错误拦截器
/// @deprecated 请使用 ErrorInterceptor 类
typedef VelocityErrorInterceptor = Future<dynamic> Function(
    dynamic error, VelocityHttpRequest? request);

/// 旧版 Velocity HTTP客户端
/// @deprecated 请使用新的 VelocityHttpClient（从 http/velocity_http_client.dart 导入）
class LegacyVelocityHttpClient {
  /// 创建Velocity HTTP客户端
  LegacyVelocityHttpClient({
    this.baseUrl = '',
    this.defaultHeaders = const {},
    this.timeout = const Duration(seconds: 30),
    List<VelocityRequestInterceptor>? requestInterceptors,
    List<VelocityResponseInterceptor>? responseInterceptors,
    List<VelocityErrorInterceptor>? errorInterceptors,
  })  : _requestInterceptors = requestInterceptors ?? [],
        _responseInterceptors = responseInterceptors ?? [],
        _errorInterceptors = errorInterceptors ?? [];

  /// 基础URL
  final String baseUrl;

  /// 默认请求头
  final Map<String, String> defaultHeaders;

  /// 默认超时时间
  final Duration timeout;

  /// 请求拦截器列表
  final List<VelocityRequestInterceptor> _requestInterceptors;

  /// 响应拦截器列表
  final List<VelocityResponseInterceptor> _responseInterceptors;

  /// 错误拦截器列表
  final List<VelocityErrorInterceptor> _errorInterceptors;

  /// HTTP客户端实例
  final http.Client _client = http.Client();

  /// 添加请求拦截器
  void addRequestInterceptor(VelocityRequestInterceptor interceptor) {
    _requestInterceptors.add(interceptor);
  }

  /// 添加响应拦截器
  void addResponseInterceptor(VelocityResponseInterceptor interceptor) {
    _responseInterceptors.add(interceptor);
  }

  /// 添加错误拦截器
  void addErrorInterceptor(VelocityErrorInterceptor interceptor) {
    _errorInterceptors.add(interceptor);
  }

  /// 移除请求拦截器
  void removeRequestInterceptor(VelocityRequestInterceptor interceptor) {
    _requestInterceptors.remove(interceptor);
  }

  /// 移除响应拦截器
  void removeResponseInterceptor(VelocityResponseInterceptor interceptor) {
    _responseInterceptors.remove(interceptor);
  }

  /// 移除错误拦截器
  void removeErrorInterceptor(VelocityErrorInterceptor interceptor) {
    _errorInterceptors.remove(interceptor);
  }

  /// 清空请求拦截器
  void clearRequestInterceptors() {
    _requestInterceptors.clear();
  }

  /// 清空响应拦截器
  void clearResponseInterceptors() {
    _responseInterceptors.clear();
  }

  /// 清空错误拦截器
  void clearErrorInterceptors() {
    _errorInterceptors.clear();
  }

  /// 构建完整URL
  String _buildUrl(String url, Map<String, dynamic> queryParameters) {
    final Uri uri;

    // 如果是完整URL，直接使用
    if (url.startsWith('http://') || url.startsWith('https://')) {
      uri = Uri.parse(url);
    } else {
      // 否则拼接baseUrl
      final baseUri = Uri.parse(baseUrl);
      uri = baseUri.resolve(url);
    }

    // 添加查询参数
    if (queryParameters.isNotEmpty) {
      final stringParams = queryParameters.map(
        (key, value) => MapEntry(key, value?.toString() ?? ''),
      );
      return uri.replace(queryParameters: {
        ...uri.queryParameters,
        ...stringParams,
      }).toString();
    }

    return uri.toString();
  }

  /// 发送HTTP请求
  Future<VelocityHttpResponse> request({
    required String url,
    required VelocityHttpMethod method,
    Map<String, String> headers = const {},
    dynamic body,
    Map<String, dynamic> queryParameters = const {},
    Duration? timeout,
    Encoding encoding = utf8,
  }) async {
    try {
      // 构建完整URL
      final fullUrl = _buildUrl(url, queryParameters);

      // 合并headers
      final mergedHeaders = {
        ...defaultHeaders,
        ...headers,
      };

      // 创建请求配置
      var requestConfig = VelocityHttpRequest(
        url: fullUrl,
        method: method,
        headers: mergedHeaders,
        body: body,
        queryParameters: queryParameters,
        timeout: timeout ?? this.timeout,
        encoding: encoding,
      );

      // 执行请求拦截器
      for (final interceptor in _requestInterceptors) {
        requestConfig = await interceptor(requestConfig);
      }

      // 根据请求方法发送请求
      http.Response response;
      switch (requestConfig.method) {
        case VelocityHttpMethod.get:
          response = await _client
              .get(
                Uri.parse(requestConfig.url),
                headers: requestConfig.headers,
              )
              .timeout(requestConfig.timeout);
        case VelocityHttpMethod.post:
          response = await _client
              .post(
                Uri.parse(requestConfig.url),
                headers: requestConfig.headers,
                body: requestConfig.body,
                encoding: requestConfig.encoding,
              )
              .timeout(requestConfig.timeout);
        case VelocityHttpMethod.put:
          response = await _client
              .put(
                Uri.parse(requestConfig.url),
                headers: requestConfig.headers,
                body: requestConfig.body,
                encoding: requestConfig.encoding,
              )
              .timeout(requestConfig.timeout);
        case VelocityHttpMethod.delete:
          response = await _client
              .delete(
                Uri.parse(requestConfig.url),
                headers: requestConfig.headers,
                body: requestConfig.body,
                encoding: requestConfig.encoding,
              )
              .timeout(requestConfig.timeout);
        case VelocityHttpMethod.patch:
          response = await _client
              .patch(
                Uri.parse(requestConfig.url),
                headers: requestConfig.headers,
                body: requestConfig.body,
                encoding: requestConfig.encoding,
              )
              .timeout(requestConfig.timeout);
        case VelocityHttpMethod.head:
          final headResponse = await _client
              .head(
                Uri.parse(requestConfig.url),
                headers: requestConfig.headers,
              )
              .timeout(requestConfig.timeout);
          response = http.Response('', headResponse.statusCode,
              headers: headResponse.headers);
        case VelocityHttpMethod.options:
          final optionsResponse = await _client
              .send(
                http.Request('OPTIONS', Uri.parse(requestConfig.url))
                  ..headers.addAll(requestConfig.headers),
              )
              .timeout(requestConfig.timeout);
          response = await http.Response.fromStream(optionsResponse);
      }

      // 解析响应体
      dynamic responseBody;
      try {
        responseBody = jsonDecode(response.body);
      } catch (e) {
        responseBody = response.body;
      }

      // 创建响应对象
      var httpResponse = VelocityHttpResponse(
        statusCode: response.statusCode,
        headers: response.headers,
        body: responseBody,
        request: response.request!,
      );

      // 执行响应拦截器
      for (final interceptor in _responseInterceptors) {
        httpResponse = await interceptor(httpResponse);
      }

      return httpResponse;
    } catch (error) {
      // 执行错误拦截器
      for (final interceptor in _errorInterceptors) {
        await interceptor(error, null);
      }
      rethrow;
    }
  }

  /// 发送GET请求
  Future<VelocityHttpResponse> get(
    String url,
    Map<String, dynamic> queryParameters,
    Map<String, String> headers,
  ) async {
    return request(
      url: url,
      method: VelocityHttpMethod.get,
      headers: headers,
      queryParameters: queryParameters,
    );
  }

  /// 发送POST请求
  Future<VelocityHttpResponse> post(
    String url,
    dynamic body,
    Map<String, String> headers,
    Map<String, dynamic> queryParameters,
  ) async {
    return request(
      url: url,
      method: VelocityHttpMethod.post,
      headers: headers,
      body: body,
      queryParameters: queryParameters,
    );
  }

  /// 发送PUT请求
  Future<VelocityHttpResponse> put(
    String url,
    dynamic body,
    Map<String, String> headers,
    Map<String, dynamic> queryParameters,
  ) async {
    return request(
      url: url,
      method: VelocityHttpMethod.put,
      headers: headers,
      body: body,
      queryParameters: queryParameters,
    );
  }

  /// 发送DELETE请求
  Future<VelocityHttpResponse> delete(
    String url,
    Map<String, String> headers,
    Map<String, dynamic> queryParameters,
  ) async {
    return request(
      url: url,
      method: VelocityHttpMethod.delete,
      headers: headers,
      queryParameters: queryParameters,
    );
  }

  /// 发送PATCH请求
  Future<VelocityHttpResponse> patch(
    String url,
    dynamic body,
    Map<String, String> headers,
    Map<String, dynamic> queryParameters,
  ) async {
    return request(
      url: url,
      method: VelocityHttpMethod.patch,
      headers: headers,
      body: body,
      queryParameters: queryParameters,
    );
  }

  /// 发送HEAD请求
  Future<VelocityHttpResponse> head(
    String url,
    Map<String, String> headers,
    Map<String, dynamic> queryParameters,
  ) async {
    return request(
      url: url,
      method: VelocityHttpMethod.head,
      headers: headers,
      queryParameters: queryParameters,
    );
  }

  /// 发送OPTIONS请求
  Future<VelocityHttpResponse> options(
    String url,
    Map<String, String> headers,
    Map<String, dynamic> queryParameters,
  ) async {
    return request(
      url: url,
      method: VelocityHttpMethod.options,
      headers: headers,
      queryParameters: queryParameters,
    );
  }

  /// 关闭HTTP客户端
  void close() {
    _client.close();
  }
}

/// 全局HTTP客户端实例（旧版）
/// @deprecated 请使用 globalHttpClient
final velocityHttpClient = LegacyVelocityHttpClient();
