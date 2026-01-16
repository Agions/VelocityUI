import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/utils/http/velocity_http_client.dart';
import 'package:velocity_ui/src/utils/http/result.dart';
import 'package:velocity_ui/src/utils/http/cache.dart';
import 'package:velocity_ui/src/utils/http/retry.dart';
import 'package:velocity_ui/src/utils/http/interceptors.dart';

void main() {
  group('HTTP Client Integration Tests', () {
    late VelocityHttpClient client;

    setUp(() {
      client = VelocityHttpClient(
        baseUrl: 'https://api.example.com',
        defaultHeaders: {'Authorization': 'Bearer test-token'},
        timeout: const Duration(seconds: 30),
      );
    });

    test('client initializes with correct configuration', () {
      expect(client.baseUrl, equals('https://api.example.com'));
      expect(
          client.defaultHeaders['Authorization'], equals('Bearer test-token'));
      expect(client.timeout, equals(const Duration(seconds: 30)));
    });

    test('client supports adding multiple interceptors', () {
      final requestInterceptor = TestRequestInterceptor();
      final responseInterceptor = TestResponseInterceptor();
      final errorInterceptor = TestErrorInterceptor();

      client.addRequestInterceptor(requestInterceptor);
      client.addResponseInterceptor(responseInterceptor);
      client.addErrorInterceptor(errorInterceptor);

      expect(client.interceptorChain.requestInterceptors,
          contains(requestInterceptor));
      expect(client.interceptorChain.responseInterceptors,
          contains(responseInterceptor));
      expect(client.interceptorChain.errorInterceptors,
          contains(errorInterceptor));
    });

    test('client supports cache configuration', () {
      const cacheConfig = CacheConfig(
        duration: Duration(minutes: 5),
        maxEntries: 100,
      );
      final cachedClient = VelocityHttpClient(cacheConfig: cacheConfig);

      expect(cachedClient.cacheConfig, isNotNull);
      expect(cachedClient.cacheManager, isNotNull);
    });

    test('client supports retry configuration', () {
      const retryConfig = RetryConfig(
        maxRetries: 3,
        retryDelay: Duration(seconds: 1),
      );
      final retryClient = VelocityHttpClient(retryConfig: retryConfig);

      expect(retryClient.retryConfig.maxRetries, equals(3));
      expect(retryClient.retryConfig.retryDelay,
          equals(const Duration(seconds: 1)));
    });

    test('client can clear all interceptors', () {
      client.addRequestInterceptor(TestRequestInterceptor());
      client.addResponseInterceptor(TestResponseInterceptor());
      client.addErrorInterceptor(TestErrorInterceptor());

      expect(client.interceptorChain.requestInterceptors, isNotEmpty);
      expect(client.interceptorChain.responseInterceptors, isNotEmpty);
      expect(client.interceptorChain.errorInterceptors, isNotEmpty);

      client.clearInterceptors();

      expect(client.interceptorChain.requestInterceptors, isEmpty);
      expect(client.interceptorChain.responseInterceptors, isEmpty);
      expect(client.interceptorChain.errorInterceptors, isEmpty);
    });

    test('client supports header injection interceptor', () {
      final headerInterceptor = HeaderInjectionInterceptor(
        headersProvider: () => {'X-Custom-Header': 'custom-value'},
      );

      client.addRequestInterceptor(headerInterceptor);

      expect(client.interceptorChain.requestInterceptors,
          contains(headerInterceptor));
    });

    test('client supports authorization interceptor', () {
      final authInterceptor = AuthorizationInterceptor(
        tokenProvider: () => 'test-token',
        tokenType: 'Bearer',
      );

      client.addRequestInterceptor(authInterceptor);

      expect(client.interceptorChain.requestInterceptors,
          contains(authInterceptor));
    });

    test('client supports content type interceptor', () {
      final contentTypeInterceptor = ContentTypeInterceptor(
        contentType: 'application/json',
        acceptType: 'application/json',
      );

      client.addRequestInterceptor(contentTypeInterceptor);

      expect(client.interceptorChain.requestInterceptors,
          contains(contentTypeInterceptor));
    });

    test('client can be configured with multiple features', () {
      const cacheConfig = CacheConfig(
        duration: Duration(minutes: 5),
        maxEntries: 100,
      );
      const retryConfig = RetryConfig(
        maxRetries: 3,
        retryDelay: Duration(seconds: 1),
      );

      final fullClient = VelocityHttpClient(
        baseUrl: 'https://api.example.com',
        defaultHeaders: {'Authorization': 'Bearer token'},
        timeout: const Duration(seconds: 30),
        cacheConfig: cacheConfig,
        retryConfig: retryConfig,
      );

      expect(fullClient.baseUrl, equals('https://api.example.com'));
      expect(fullClient.cacheConfig, isNotNull);
      expect(fullClient.cacheManager, isNotNull);
      expect(fullClient.retryConfig.maxRetries, equals(3));
    });
  });
}

// Test helpers
class TestRequestInterceptor extends RequestInterceptor {
  @override
  Future<HttpRequestConfig> onRequest(HttpRequestConfig config) async {
    return config;
  }
}

class TestResponseInterceptor extends ResponseInterceptor {
  @override
  Future<HttpResponse<T>> onResponse<T>(HttpResponse<T> response) async {
    return response;
  }
}

class TestErrorInterceptor extends ErrorInterceptor {
  @override
  Future<VelocityError> onError(
      dynamic error, HttpRequestConfig? request) async {
    if (error is VelocityError) {
      return error;
    }
    return ErrorHandler.classify(error, request);
  }
}
