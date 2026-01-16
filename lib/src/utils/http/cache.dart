/// VelocityUI HTTP 响应缓存系统
/// 提供 HTTP 响应缓存功能，支持过期检查和缓存策略
library velocity_http_cache;

import 'dart:collection';

import 'interceptors.dart';

/// 缓存键生成器类型
/// 根据请求信息生成唯一的缓存键
typedef CacheKeyGenerator = String Function(
  String url,
  HttpMethod method,
  Map<String, dynamic>? params,
);

/// 默认缓存键生成器
/// 使用 URL、方法和参数生成缓存键
String defaultCacheKeyGenerator(
  String url,
  HttpMethod method,
  Map<String, dynamic>? params,
) {
  final buffer = StringBuffer();
  buffer.write(method.name.toUpperCase());
  buffer.write(':');
  buffer.write(url);

  if (params != null && params.isNotEmpty) {
    final sortedKeys = params.keys.toList()..sort();
    buffer.write('?');
    for (var i = 0; i < sortedKeys.length; i++) {
      if (i > 0) buffer.write('&');
      buffer.write(sortedKeys[i]);
      buffer.write('=');
      buffer.write(params[sortedKeys[i]]);
    }
  }

  return buffer.toString();
}

/// 缓存配置
/// 定义缓存行为和策略
class CacheConfig {
  /// 创建缓存配置
  const CacheConfig({
    this.duration = const Duration(minutes: 5),
    this.keyGenerator,
    this.maxEntries = 100,
    this.enabled = true,
    this.cacheableStatusCodes = const [200, 201, 204],
    this.cacheableMethods = const [HttpMethod.get],
  });

  /// 缓存时长
  final Duration duration;

  /// 缓存键生成器
  final CacheKeyGenerator? keyGenerator;

  /// 最大缓存条目数
  final int maxEntries;

  /// 是否启用缓存
  final bool enabled;

  /// 可缓存的状态码列表
  final List<int> cacheableStatusCodes;

  /// 可缓存的请求方法列表
  final List<HttpMethod> cacheableMethods;

  /// 获取缓存键生成器（使用自定义或默认）
  CacheKeyGenerator get effectiveKeyGenerator =>
      keyGenerator ?? defaultCacheKeyGenerator;

  /// 检查请求是否可缓存
  bool isCacheable(HttpMethod method) => cacheableMethods.contains(method);

  /// 检查响应状态码是否可缓存
  bool isStatusCodeCacheable(int statusCode) =>
      cacheableStatusCodes.contains(statusCode);

  /// 复制配置并替换指定属性
  CacheConfig copyWith({
    Duration? duration,
    CacheKeyGenerator? keyGenerator,
    int? maxEntries,
    bool? enabled,
    List<int>? cacheableStatusCodes,
    List<HttpMethod>? cacheableMethods,
  }) {
    return CacheConfig(
      duration: duration ?? this.duration,
      keyGenerator: keyGenerator ?? this.keyGenerator,
      maxEntries: maxEntries ?? this.maxEntries,
      enabled: enabled ?? this.enabled,
      cacheableStatusCodes: cacheableStatusCodes ?? this.cacheableStatusCodes,
      cacheableMethods: cacheableMethods ?? this.cacheableMethods,
    );
  }

  @override
  String toString() => 'CacheConfig('
      'duration: $duration, '
      'maxEntries: $maxEntries, '
      'enabled: $enabled)';
}

/// 缓存条目
/// 存储缓存的响应数据和元信息
class CacheEntry<T> {
  /// 创建缓存条目
  CacheEntry({
    required this.data,
    required this.createdAt,
    required this.duration,
    required this.statusCode,
    required this.headers,
    this.eTag,
    this.lastModified,
  });

  /// 从 JSON 反序列化
  factory CacheEntry.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) dataFromJson,
  ) {
    return CacheEntry<T>(
      data: dataFromJson(json['data']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      duration: Duration(milliseconds: json['duration'] as int),
      statusCode: json['statusCode'] as int,
      headers: Map<String, String>.from(json['headers'] as Map? ?? {}),
      eTag: json['eTag'] as String?,
      lastModified: json['lastModified'] as String?,
    );
  }

  /// 缓存的数据
  final T data;

  /// 创建时间
  final DateTime createdAt;

  /// 缓存时长
  final Duration duration;

  /// HTTP 状态码
  final int statusCode;

  /// 响应头
  final Map<String, String> headers;

  /// ETag 值（用于条件请求）
  final String? eTag;

  /// Last-Modified 值（用于条件请求）
  final String? lastModified;

  /// 过期时间
  DateTime get expiresAt => createdAt.add(duration);

  /// 是否已过期
  bool get isExpired => DateTime.now().isAfter(expiresAt);

  /// 是否有效（未过期）
  bool get isValid => !isExpired;

  /// 剩余有效时间
  Duration get remainingTime {
    final remaining = expiresAt.difference(DateTime.now());
    return remaining.isNegative ? Duration.zero : remaining;
  }

  /// 序列化为 JSON
  Map<String, dynamic> toJson(Object? Function(T) dataToJson) => {
        'data': dataToJson(data),
        'createdAt': createdAt.toIso8601String(),
        'duration': duration.inMilliseconds,
        'statusCode': statusCode,
        'headers': headers,
        'eTag': eTag,
        'lastModified': lastModified,
      };

  @override
  String toString() => 'CacheEntry('
      'createdAt: $createdAt, '
      'duration: $duration, '
      'isExpired: $isExpired)';
}

/// 缓存存储
/// 管理缓存条目的存储和检索
class CacheStore {
  /// 创建缓存存储
  CacheStore({
    this.maxEntries = 100,
  });

  /// 最大缓存条目数
  final int maxEntries;

  /// 缓存存储（使用 LinkedHashMap 保持插入顺序，便于 LRU 淘汰）
  final LinkedHashMap<String, CacheEntry<dynamic>> _cache =
      LinkedHashMap<String, CacheEntry<dynamic>>();

  /// 缓存命中次数
  int _hitCount = 0;

  /// 缓存未命中次数
  int _missCount = 0;

  /// 获取缓存命中次数
  int get hitCount => _hitCount;

  /// 获取缓存未命中次数
  int get missCount => _missCount;

  /// 获取缓存命中率
  double get hitRate {
    final total = _hitCount + _missCount;
    return total > 0 ? _hitCount / total : 0.0;
  }

  /// 获取当前缓存条目数
  int get size => _cache.length;

  /// 检查缓存是否为空
  bool get isEmpty => _cache.isEmpty;

  /// 检查缓存是否不为空
  bool get isNotEmpty => _cache.isNotEmpty;

  /// 获取所有缓存键
  Iterable<String> get keys => _cache.keys;

  /// 存储缓存条目
  void put<T>(String key, CacheEntry<T> entry) {
    // 如果已存在，先移除（更新访问顺序）
    _cache.remove(key);

    // 检查是否需要淘汰旧条目
    while (_cache.length >= maxEntries) {
      _evictOldest();
    }

    _cache[key] = entry;
  }

  /// 获取缓存条目
  CacheEntry<T>? get<T>(String key) {
    final entry = _cache[key];

    if (entry == null) {
      _missCount++;
      return null;
    }

    // 检查是否过期
    if (entry.isExpired) {
      _cache.remove(key);
      _missCount++;
      return null;
    }

    // 更新访问顺序（LRU）
    _cache.remove(key);
    _cache[key] = entry;

    _hitCount++;
    return entry as CacheEntry<T>;
  }

  /// 检查是否包含指定键的有效缓存
  bool containsKey(String key) {
    final entry = _cache[key];
    if (entry == null) return false;

    if (entry.isExpired) {
      _cache.remove(key);
      return false;
    }

    return true;
  }

  /// 移除指定键的缓存
  CacheEntry<T>? remove<T>(String key) {
    return _cache.remove(key) as CacheEntry<T>?;
  }

  /// 清空所有缓存
  void clear() {
    _cache.clear();
    _hitCount = 0;
    _missCount = 0;
  }

  /// 移除所有过期的缓存条目
  int removeExpired() {
    final expiredKeys = <String>[];

    for (final entry in _cache.entries) {
      if (entry.value.isExpired) {
        expiredKeys.add(entry.key);
      }
    }

    for (final key in expiredKeys) {
      _cache.remove(key);
    }

    return expiredKeys.length;
  }

  /// 淘汰最旧的缓存条目（LRU 策略）
  void _evictOldest() {
    if (_cache.isNotEmpty) {
      _cache.remove(_cache.keys.first);
    }
  }

  /// 重置统计信息
  void resetStats() {
    _hitCount = 0;
    _missCount = 0;
  }

  /// 获取缓存统计信息
  CacheStats getStats() {
    return CacheStats(
      size: size,
      maxEntries: maxEntries,
      hitCount: _hitCount,
      missCount: _missCount,
      hitRate: hitRate,
    );
  }

  @override
  String toString() => 'CacheStore('
      'size: $size, '
      'maxEntries: $maxEntries, '
      'hitRate: ${(hitRate * 100).toStringAsFixed(1)}%)';
}

/// 缓存统计信息
class CacheStats {
  /// 创建缓存统计信息
  const CacheStats({
    required this.size,
    required this.maxEntries,
    required this.hitCount,
    required this.missCount,
    required this.hitRate,
  });

  /// 当前缓存条目数
  final int size;

  /// 最大缓存条目数
  final int maxEntries;

  /// 缓存命中次数
  final int hitCount;

  /// 缓存未命中次数
  final int missCount;

  /// 缓存命中率
  final double hitRate;

  /// 总请求次数
  int get totalRequests => hitCount + missCount;

  /// 缓存使用率
  double get usageRate => maxEntries > 0 ? size / maxEntries : 0.0;

  @override
  String toString() => 'CacheStats('
      'size: $size/$maxEntries, '
      'hitRate: ${(hitRate * 100).toStringAsFixed(1)}%, '
      'hits: $hitCount, '
      'misses: $missCount)';
}

/// 缓存管理器
/// 提供高级缓存操作和策略管理
class CacheManager {
  /// 创建缓存管理器
  CacheManager({
    CacheConfig? config,
  }) : _config = config ?? const CacheConfig();

  /// 缓存配置
  CacheConfig _config;

  /// 缓存存储
  late final CacheStore _store = CacheStore(maxEntries: _config.maxEntries);

  /// 获取缓存配置
  CacheConfig get config => _config;

  /// 更新缓存配置
  void updateConfig(CacheConfig config) {
    _config = config;
  }

  /// 获取缓存存储
  CacheStore get store => _store;

  /// 生成缓存键
  String generateKey(
    String url,
    HttpMethod method,
    Map<String, dynamic>? params,
  ) {
    return _config.effectiveKeyGenerator(url, method, params);
  }

  /// 检查请求是否应该使用缓存
  bool shouldCache(HttpRequestConfig request) {
    if (!_config.enabled) return false;
    return _config.isCacheable(request.method);
  }

  /// 检查响应是否应该被缓存
  bool shouldCacheResponse(int statusCode) {
    if (!_config.enabled) return false;
    return _config.isStatusCodeCacheable(statusCode);
  }

  /// 获取缓存的响应
  CacheEntry<T>? getCachedResponse<T>(HttpRequestConfig request) {
    if (!shouldCache(request)) return null;

    final key = generateKey(
      request.url,
      request.method,
      request.queryParams,
    );

    return _store.get<T>(key);
  }

  /// 缓存响应
  void cacheResponse<T>(
    HttpRequestConfig request,
    HttpResponse<T> response, {
    Duration? duration,
  }) {
    if (!shouldCache(request)) return;
    if (!shouldCacheResponse(response.statusCode)) return;

    final key = generateKey(
      request.url,
      request.method,
      request.queryParams,
    );

    final entry = CacheEntry<T>(
      data: response.data as T,
      createdAt: DateTime.now(),
      duration: duration ?? _config.duration,
      statusCode: response.statusCode,
      headers: response.headers,
      eTag: response.headers['etag'],
      lastModified: response.headers['last-modified'],
    );

    _store.put(key, entry);
  }

  /// 使指定请求的缓存失效
  void invalidate(HttpRequestConfig request) {
    final key = generateKey(
      request.url,
      request.method,
      request.queryParams,
    );
    _store.remove(key);
  }

  /// 使匹配指定模式的缓存失效
  void invalidatePattern(bool Function(String key) pattern) {
    final keysToRemove = _store.keys.where(pattern).toList();
    for (final key in keysToRemove) {
      _store.remove(key);
    }
  }

  /// 清空所有缓存
  void clear() {
    _store.clear();
  }

  /// 移除过期缓存
  int removeExpired() {
    return _store.removeExpired();
  }

  /// 获取缓存统计信息
  CacheStats getStats() {
    return _store.getStats();
  }
}

/// 缓存拦截器
/// 在请求/响应流程中自动处理缓存
class CacheInterceptor extends RequestInterceptor {
  /// 创建缓存拦截器
  CacheInterceptor({
    required this.cacheManager,
    this.onCacheHit,
    this.onCacheMiss,
  });

  /// 缓存管理器
  final CacheManager cacheManager;

  /// 缓存命中回调
  final void Function(String key, CacheEntry<dynamic> entry)? onCacheHit;

  /// 缓存未命中回调
  final void Function(String key)? onCacheMiss;

  @override
  String get name => 'CacheInterceptor';

  @override
  int get priority => -200; // 高优先级，在其他拦截器之前执行

  @override
  Future<HttpRequestConfig> onRequest(HttpRequestConfig config) async {
    // 缓存拦截器主要用于标记请求，实际缓存逻辑在 HTTP 客户端中处理
    return config;
  }
}
