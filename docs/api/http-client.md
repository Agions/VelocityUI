# HTTP 客户端

VelocityUI 提供了企业级的 HTTP 客户端，支持拦截器、缓存、重试、取消等功能。

## VelocityHttpClient

### 基础用法

```dart
import 'package:velocity_ui/velocity_ui.dart';

final client = VelocityHttpClient(
  baseUrl: 'https://api.example.com',
  timeout: Duration(seconds: 30),
);

// GET 请求
final result = await client.get<Map<String, dynamic>>('/users');

result.when(
  success: (data, statusCode, headers) {
    print('获取成功: $data');
  },
  failure: (error) {
    print('获取失败: ${error.message}');
  },
);
```

### 构造函数

```dart
VelocityHttpClient({
  required String baseUrl,
  Duration timeout = const Duration(seconds: 30),
  Map<String, String>? defaultHeaders,
  List<RequestInterceptor>? requestInterceptors,
  List<ResponseInterceptor>? responseInterceptors,
  List<ErrorInterceptor>? errorInterceptors,
  CacheConfig? cacheConfig,
  RetryConfig? retryConfig,
  LoadingStateCallback? onLoadingStateChanged,
})
```

### 参数说明

| 参数                    | 类型                         | 默认值 | 说明         |
| ----------------------- | ---------------------------- | ------ | ------------ |
| `baseUrl`               | `String`                     | -      | API 基础 URL |
| `timeout`               | `Duration`                   | `30s`  | 请求超时时间 |
| `defaultHeaders`        | `Map<String, String>?`       | -      | 默认请求头   |
| `requestInterceptors`   | `List<RequestInterceptor>?`  | -      | 请求拦截器   |
| `responseInterceptors`  | `List<ResponseInterceptor>?` | -      | 响应拦截器   |
| `errorInterceptors`     | `List<ErrorInterceptor>?`    | -      | 错误拦截器   |
| `cacheConfig`           | `CacheConfig?`               | -      | 缓存配置     |
| `retryConfig`           | `RetryConfig?`               | -      | 重试配置     |
| `onLoadingStateChanged` | `LoadingStateCallback?`      | -      | 加载状态回调 |

### 请求方法

#### GET 请求

```dart
Future<Result<T>> get<T>(
  String path, {
  Map<String, dynamic>? queryParams,
  Map<String, String>? headers,
  CancelToken? cancelToken,
  ResponseParser<T>? parser,
})
```

#### POST 请求

```dart
Future<Result<T>> post<T>(
  String path, {
  dynamic body,
  Map<String, dynamic>? queryParams,
  Map<String, String>? headers,
  CancelToken? cancelToken,
  ResponseParser<T>? parser,
})
```

#### PUT 请求

```dart
Future<Result<T>> put<T>(
  String path, {
  dynamic body,
  Map<String, dynamic>? queryParams,
  Map<String, String>? headers,
  CancelToken? cancelToken,
  ResponseParser<T>? parser,
})
```

#### DELETE 请求

```dart
Future<Result<T>> delete<T>(
  String path, {
  Map<String, dynamic>? queryParams,
  Map<String, String>? headers,
  CancelToken? cancelToken,
  ResponseParser<T>? parser,
})
```

#### PATCH 请求

```dart
Future<Result<T>> patch<T>(
  String path, {
  dynamic body,
  Map<String, dynamic>? queryParams,
  Map<String, String>? headers,
  CancelToken? cancelToken,
  ResponseParser<T>? parser,
})
```

## Result

统一的结果类型，用于处理成功和失败情况。

### 定义

```dart
sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T data;
  final int statusCode;
  final Map<String, String> headers;
  const Success(this.data, this.statusCode, this.headers);
}

class Failure<T> extends Result<T> {
  final VelocityError error;
  const Failure(this.error);
}
```

### 使用方式

```dart
final result = await client.get<User>('/user/1');

// 方式 1: when 方法
result.when(
  success: (data, statusCode, headers) {
    print('用户: ${data.name}');
  },
  failure: (error) {
    print('错误: ${error.message}');
  },
);

// 方式 2: 模式匹配
switch (result) {
  case Success(:final data):
    print('用户: ${data.name}');
  case Failure(:final error):
    print('错误: ${error.message}');
}

// 方式 3: 类型检查
if (result is Success<User>) {
  print('用户: ${result.data.name}');
} else if (result is Failure<User>) {
  print('错误: ${result.error.message}');
}
```

## VelocityError

错误类型层级结构。

### 定义

```dart
sealed class VelocityError {
  final String message;
  final String? code;
  const VelocityError(this.message, [this.code]);
}

class NetworkError extends VelocityError {
  const NetworkError(super.message, [super.code]);
}

class ServerError extends VelocityError {
  final int statusCode;
  const ServerError(super.message, this.statusCode, [super.code]);
}

class BusinessError extends VelocityError {
  final dynamic data;
  const BusinessError(super.message, this.data, [super.code]);
}

class TimeoutError extends VelocityError {
  const TimeoutError(super.message, [super.code]);
}

class CancelError extends VelocityError {
  const CancelError(super.message, [super.code]);
}
```

### 错误处理

```dart
result.when(
  success: (data, _, _) => handleSuccess(data),
  failure: (error) {
    switch (error) {
      case NetworkError():
        showToast('网络连接失败，请检查网络');
      case ServerError(:final statusCode):
        showToast('服务器错误: $statusCode');
      case BusinessError(:final data):
        showToast('业务错误: ${data['message']}');
      case TimeoutError():
        showToast('请求超时，请重试');
      case CancelError():
        // 用户取消，不显示提示
        break;
    }
  },
);
```

## CancelToken

请求取消令牌。

### 使用方式

```dart
final cancelToken = CancelToken();

// 发起请求
final result = await client.get<User>(
  '/user/1',
  cancelToken: cancelToken,
);

// 取消请求
cancelToken.cancel('用户取消');

// 检查是否已取消
if (cancelToken.isCancelled) {
  print('请求已取消: ${cancelToken.reason}');
}
```

### API

| 属性/方法                      | 类型      | 说明         |
| ------------------------------ | --------- | ------------ |
| `isCancelled`                  | `bool`    | 是否已取消   |
| `reason`                       | `String?` | 取消原因     |
| `cancel([String? reason])`     | `void`    | 取消请求     |
| `addListener(VoidCallback)`    | `void`    | 添加取消监听 |
| `removeListener(VoidCallback)` | `void`    | 移除取消监听 |

## 拦截器

### RequestInterceptor

请求拦截器，在请求发送前处理。

```dart
abstract class RequestInterceptor {
  Future<HttpRequestConfig> onRequest(HttpRequestConfig config);
}

// 示例：添加认证头
class AuthInterceptor extends RequestInterceptor {
  final String token;
  AuthInterceptor(this.token);

  @override
  Future<HttpRequestConfig> onRequest(HttpRequestConfig config) async {
    return config.copyWith(
      headers: {
        ...config.headers,
        'Authorization': 'Bearer $token',
      },
    );
  }
}
```

### ResponseInterceptor

响应拦截器，在收到响应后处理。

```dart
abstract class ResponseInterceptor {
  Future<HttpResponse<T>> onResponse<T>(HttpResponse<T> response);
}

// 示例：日志记录
class LoggingInterceptor extends ResponseInterceptor {
  @override
  Future<HttpResponse<T>> onResponse<T>(HttpResponse<T> response) async {
    print('Response: ${response.statusCode}');
    return response;
  }
}
```

### ErrorInterceptor

错误拦截器，在发生错误时处理。

```dart
abstract class ErrorInterceptor {
  Future<VelocityError> onError(VelocityError error, HttpRequestConfig? config);
}

// 示例：错误上报
class ErrorReportInterceptor extends ErrorInterceptor {
  @override
  Future<VelocityError> onError(VelocityError error, HttpRequestConfig? config) async {
    await reportError(error, config);
    return error;
  }
}
```

## CacheConfig

缓存配置。

```dart
class CacheConfig {
  final Duration duration;
  final CacheKeyGenerator? keyGenerator;
  final int maxEntries;
  final bool enabled;

  const CacheConfig({
    this.duration = const Duration(minutes: 5),
    this.keyGenerator,
    this.maxEntries = 100,
    this.enabled = true,
  });
}
```

### 使用示例

```dart
final client = VelocityHttpClient(
  baseUrl: 'https://api.example.com',
  cacheConfig: CacheConfig(
    duration: Duration(minutes: 10),
    maxEntries: 50,
    keyGenerator: (url, method, params) {
      return '$method:$url:${params?.toString()}';
    },
  ),
);
```

## RetryConfig

重试配置。

```dart
class RetryConfig {
  final int maxRetries;
  final Duration retryDelay;
  final RetryCondition? shouldRetry;
  final bool exponentialBackoff;

  const RetryConfig({
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 1),
    this.shouldRetry,
    this.exponentialBackoff = true,
  });
}
```

### 使用示例

```dart
final client = VelocityHttpClient(
  baseUrl: 'https://api.example.com',
  retryConfig: RetryConfig(
    maxRetries: 3,
    retryDelay: Duration(seconds: 1),
    exponentialBackoff: true,
    shouldRetry: (error, attempt) {
      // 只重试网络错误和超时错误
      return error is NetworkError || error is TimeoutError;
    },
  ),
);
```

## HttpStatusCodes

HTTP 状态码管理。

```dart
class HttpStatusCodes {
  static const Map<int, String> messages = {
    200: 'OK',
    201: 'Created',
    204: 'No Content',
    400: 'Bad Request',
    401: 'Unauthorized',
    403: 'Forbidden',
    404: 'Not Found',
    408: 'Request Timeout',
    500: 'Internal Server Error',
    502: 'Bad Gateway',
    503: 'Service Unavailable',
    504: 'Gateway Timeout',
  };

  static String getMessage(int code) => messages[code] ?? 'Unknown Error';

  static bool isSuccess(int code) => code >= 200 && code < 300;
  static bool isClientError(int code) => code >= 400 && code < 500;
  static bool isServerError(int code) => code >= 500;
}
```

## 完整示例

```dart
// 创建客户端
final client = VelocityHttpClient(
  baseUrl: 'https://api.example.com',
  timeout: Duration(seconds: 30),
  defaultHeaders: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  },
  requestInterceptors: [
    AuthInterceptor(authToken),
  ],
  responseInterceptors: [
    LoggingInterceptor(),
  ],
  errorInterceptors: [
    ErrorReportInterceptor(),
  ],
  cacheConfig: CacheConfig(
    duration: Duration(minutes: 5),
  ),
  retryConfig: RetryConfig(
    maxRetries: 3,
  ),
  onLoadingStateChanged: (isLoading) {
    if (isLoading) {
      showLoading();
    } else {
      hideLoading();
    }
  },
);

// 发起请求
final cancelToken = CancelToken();

final result = await client.post<User>(
  '/users',
  body: {
    'name': 'John',
    'email': 'john@example.com',
  },
  cancelToken: cancelToken,
  parser: (json) => User.fromJson(json),
);

result.when(
  success: (user, statusCode, headers) {
    print('创建用户成功: ${user.name}');
  },
  failure: (error) {
    print('创建用户失败: ${error.message}');
  },
);
```
