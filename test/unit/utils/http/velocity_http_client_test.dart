import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/utils/http/velocity_http_client.dart';
import 'package:velocity_ui/src/utils/http/result.dart';
import 'package:velocity_ui/src/utils/http/cache.dart';
import 'package:velocity_ui/src/utils/http/retry.dart';
import 'package:velocity_ui/src/utils/http/cancel_token.dart';
import 'package:velocity_ui/src/utils/http/interceptors.dart';

void main() {
  group('VelocityHttpClient', () {
    late VelocityHttpClient client;

    setUp(() {
      client = VelocityHttpClient(
        baseUrl: 'https://api.example.com',
        defaultHeaders: {'Authorization': 'Bearer token'},
        timeout: const Duration(seconds: 30),
      );
    });

    group('initialization', () {
      test('creates client with default values', () {
        final defaultClient = VelocityHttpClient();
        expect(defaultClient.baseUrl, equals(''));
        expect(defaultClient.defaultHeaders, isEmpty);
        expect(defaultClient.timeout, equals(const Duration(seconds: 30)));
      });

      test('creates client with custom values', () {
        expect(client.baseUrl, equals('https://api.example.com'));
        expect(client.defaultHeaders, contains('Authorization'));
        expect(client.timeout, equals(const Duration(seconds: 30)));
      });

      test('initializes with cache config', () {
        const cacheConfig = CacheConfig(
          duration: Duration(minutes: 5),
          maxEntries: 100,
        );
        final cachedClient = VelocityHttpClient(cacheConfig: cacheConfig);
        expect(cachedClient.cacheConfig, isNotNull);
        expect(cachedClient.cacheManager, isNotNull);
      });

      test('initializes with retry config', () {
        const retryConfig = RetryConfig(
          maxRetries: 3,
          retryDelay: Duration(seconds: 1),
        );
        final retryClient = VelocityHttpClient(retryConfig: retryConfig);
        expect(retryClient.retryConfig.maxRetries, equals(3));
      });
    });

    group('interceptor management', () {
      test('adds request interceptor', () {
        final interceptor = TestRequestInterceptor();
        client.addRequestInterceptor(interceptor);
        expect(
            client.interceptorChain.requestInterceptors, contains(interceptor));
      });

      test('adds response interceptor', () {
        final interceptor = TestResponseInterceptor();
        client.addResponseInterceptor(interceptor);
        expect(client.interceptorChain.responseInterceptors,
            contains(interceptor));
      });

      test('adds error interceptor', () {
        final interceptor = TestErrorInterceptor();
        client.addErrorInterceptor(interceptor);
        expect(
            client.interceptorChain.errorInterceptors, contains(interceptor));
      });

      test('removes request interceptor', () {
        final interceptor = TestRequestInterceptor();
        client.addRequestInterceptor(interceptor);
        client.removeRequestInterceptor(interceptor);
        expect(client.interceptorChain.requestInterceptors,
            isNot(contains(interceptor)));
      });

      test('clears all interceptors', () {
        client.addRequestInterceptor(TestRequestInterceptor());
        client.addResponseInterceptor(TestResponseInterceptor());
        client.addErrorInterceptor(TestErrorInterceptor());

        client.clearInterceptors();

        expect(client.interceptorChain.requestInterceptors, isEmpty);
        expect(client.interceptorChain.responseInterceptors, isEmpty);
        expect(client.interceptorChain.errorInterceptors, isEmpty);
      });
    });

    group('cancel token', () {
      test('creates cancel token', () {
        final token = CancelToken();
        expect(token.isCancelled, isFalse);
      });

      test('cancels token', () {
        final token = CancelToken();
        token.cancel('User cancelled');
        expect(token.isCancelled, isTrue);
        expect(token.reason, equals('User cancelled'));
      });

      test('cancel token listeners are notified', () {
        final token = CancelToken();
        var listenerCalled = false;

        token.addListener(() {
          listenerCalled = true;
        });

        token.cancel();
        expect(listenerCalled, isTrue);
      });

      test('removes listener from cancel token', () {
        final token = CancelToken();
        var listenerCalled = false;

        void listener() {
          listenerCalled = true;
        }

        token.addListener(listener);
        token.removeListener(listener);
        token.cancel();

        expect(listenerCalled, isFalse);
      });
    });

    group('cache management', () {
      test('cache manager is created when cache config provided', () {
        const cacheConfig = CacheConfig(
          duration: Duration(minutes: 5),
          maxEntries: 100,
        );
        final cachedClient = VelocityHttpClient(cacheConfig: cacheConfig);
        expect(cachedClient.cacheManager, isNotNull);
      });

      test('cache manager is null when no cache config', () {
        expect(client.cacheManager, isNull);
      });
    });

    group('default headers', () {
      test('default headers are set correctly', () {
        expect(client.defaultHeaders['Authorization'], equals('Bearer token'));
      });

      test('empty default headers when not provided', () {
        final defaultClient = VelocityHttpClient();
        expect(defaultClient.defaultHeaders, isEmpty);
      });
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
