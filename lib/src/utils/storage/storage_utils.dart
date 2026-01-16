/// VelocityUI 本地存储工具抽象接口
/// 定义统一的存储操作接口，支持多种存储实现
library velocity_storage_utils;

import 'dart:convert';

/// JSON 编码器类型定义
/// 用于将对象序列化为 JSON 可存储的 Map
typedef JsonEncoder<T> = Map<String, dynamic> Function(T value);

/// JSON 解码器类型定义
/// 用于将 JSON Map 反序列化为对象
typedef JsonDecoder<T> = T Function(Map<String, dynamic> json);

/// 存储操作结果
/// 封装存储操作的成功/失败状态和错误信息
class StorageResult<T> {
  /// 创建成功结果
  factory StorageResult.success([T? data]) {
    return StorageResult._(success: true, data: data);
  }

  /// 创建失败结果
  factory StorageResult.failure(String error) {
    return StorageResult._(success: false, error: error);
  }

  const StorageResult._({
    required this.success,
    this.data,
    this.error,
  });

  /// 操作是否成功
  final bool success;

  /// 操作返回的数据（成功时）
  final T? data;

  /// 错误信息（失败时）
  final String? error;

  /// 是否失败
  bool get isFailure => !success;

  /// 获取数据，如果失败则返回默认值
  T? getOrDefault(T? defaultValue) => success ? data : defaultValue;

  @override
  String toString() {
    if (success) {
      return 'StorageResult.success($data)';
    }
    return 'StorageResult.failure($error)';
  }
}

/// 本地存储工具抽象接口
///
/// 定义统一的存储操作接口，支持：
/// - 基本类型存储（String, int, double, bool）
/// - 字符串列表存储
/// - 对象存储（通过 JSON 序列化）
/// - 键存在检查
/// - 删除和清空操作
///
/// 实现类：
/// - PreferencesStorage - 基于 SharedPreferences 的实现
/// - FileStorage - 基于文件系统的实现
abstract class StorageUtils {
  /// 存储字符串
  ///
  /// [key] 存储键
  /// [value] 要存储的字符串值
  /// 返回操作是否成功
  Future<bool> setString(String key, String value);

  /// 获取字符串
  ///
  /// [key] 存储键
  /// 返回存储的字符串值，如果不存在返回 null
  Future<String?> getString(String key);

  /// 存储整数
  ///
  /// [key] 存储键
  /// [value] 要存储的整数值
  /// 返回操作是否成功
  Future<bool> setInt(String key, int value);

  /// 获取整数
  ///
  /// [key] 存储键
  /// 返回存储的整数值，如果不存在返回 null
  Future<int?> getInt(String key);

  /// 存储双精度浮点数
  ///
  /// [key] 存储键
  /// [value] 要存储的浮点数值
  /// 返回操作是否成功
  Future<bool> setDouble(String key, double value);

  /// 获取双精度浮点数
  ///
  /// [key] 存储键
  /// 返回存储的浮点数值，如果不存在返回 null
  Future<double?> getDouble(String key);

  /// 存储布尔值
  ///
  /// [key] 存储键
  /// [value] 要存储的布尔值
  /// 返回操作是否成功
  Future<bool> setBool(String key, bool value);

  /// 获取布尔值
  ///
  /// [key] 存储键
  /// 返回存储的布尔值，如果不存在返回 null
  Future<bool?> getBool(String key);

  /// 存储字符串列表
  ///
  /// [key] 存储键
  /// [value] 要存储的字符串列表
  /// 返回操作是否成功
  Future<bool> setStringList(String key, List<String> value);

  /// 获取字符串列表
  ///
  /// [key] 存储键
  /// 返回存储的字符串列表，如果不存在返回 null
  Future<List<String>?> getStringList(String key);

  /// 存储对象（JSON 序列化）
  ///
  /// 将对象通过 encoder 序列化为 JSON 后存储。
  ///
  /// [key] 存储键
  /// [value] 要存储的对象
  /// [encoder] 将对象转换为 Map 的函数
  /// 返回操作是否成功
  ///
  /// 示例:
  /// ```dart
  /// class User {
  ///   final String name;
  ///   final int age;
  ///   User({required this.name, required this.age});
  ///   Map<String, dynamic> toJson() => {'name': name, 'age': age};
  /// }
  ///
  /// final user = User(name: 'John', age: 30);
  /// await storage.setObject('user', user, (u) => u.toJson());
  /// ```
  Future<bool> setObject<T>(String key, T value, JsonEncoder<T> encoder);

  /// 获取对象（JSON 反序列化）
  ///
  /// 从存储中读取 JSON 并通过 decoder 反序列化为对象。
  ///
  /// [key] 存储键
  /// [decoder] 将 Map 转换为对象的函数
  /// 返回反序列化后的对象，如果不存在或解析失败返回 null
  ///
  /// 示例:
  /// ```dart
  /// class User {
  ///   final String name;
  ///   final int age;
  ///   User({required this.name, required this.age});
  ///   factory User.fromJson(Map<String, dynamic> json) =>
  ///     User(name: json['name'], age: json['age']);
  /// }
  ///
  /// final user = await storage.getObject('user', User.fromJson);
  /// ```
  Future<T?> getObject<T>(String key, JsonDecoder<T> decoder);

  /// 存储对象列表（JSON 序列化）
  ///
  /// [key] 存储键
  /// [value] 要存储的对象列表
  /// [encoder] 将单个对象转换为 Map 的函数
  /// 返回操作是否成功
  Future<bool> setObjectList<T>(
    String key,
    List<T> value,
    JsonEncoder<T> encoder,
  );

  /// 获取对象列表（JSON 反序列化）
  ///
  /// [key] 存储键
  /// [decoder] 将 Map 转换为单个对象的函数
  /// 返回反序列化后的对象列表，如果不存在或解析失败返回 null
  Future<List<T>?> getObjectList<T>(String key, JsonDecoder<T> decoder);

  /// 删除指定键的数据
  ///
  /// [key] 要删除的键
  /// 返回操作是否成功
  Future<bool> remove(String key);

  /// 清空所有存储数据
  ///
  /// 返回操作是否成功
  Future<bool> clear();

  /// 检查键是否存在
  ///
  /// [key] 要检查的键
  /// 返回键是否存在
  Future<bool> containsKey(String key);

  /// 获取所有存储的键
  ///
  /// 返回所有键的集合
  Future<Set<String>> getKeys();

  /// 批量存储多个键值对
  ///
  /// [entries] 要存储的键值对 Map
  /// 返回操作是否全部成功
  Future<bool> setAll(Map<String, dynamic> entries);

  /// 批量获取多个键的值
  ///
  /// [keys] 要获取的键列表
  /// 返回键值对 Map，不存在的键不会包含在结果中
  Future<Map<String, dynamic>> getAll(List<String> keys);

  /// 批量删除多个键
  ///
  /// [keys] 要删除的键列表
  /// 返回操作是否全部成功
  Future<bool> removeAll(List<String> keys);
}

/// 存储工具基类
///
/// 提供一些通用的辅助方法实现，子类可以继承并复用
abstract class BaseStorageUtils implements StorageUtils {
  /// JSON 编码器
  final JsonCodec _jsonCodec = const JsonCodec();

  /// 将对象编码为 JSON 字符串
  String encodeJson(dynamic value) {
    return _jsonCodec.encode(value);
  }

  /// 将 JSON 字符串解码为对象
  dynamic decodeJson(String json) {
    return _jsonCodec.decode(json);
  }

  /// 安全解码 JSON，失败返回 null
  Map<String, dynamic>? tryDecodeJson(String json) {
    try {
      final decoded = _jsonCodec.decode(json);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// 安全解码 JSON 列表，失败返回 null
  List<dynamic>? tryDecodeJsonList(String json) {
    try {
      final decoded = _jsonCodec.decode(json);
      if (decoded is List<dynamic>) {
        return decoded;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> setObject<T>(
    String key,
    T value,
    JsonEncoder<T> encoder,
  ) async {
    try {
      final json = encodeJson(encoder(value));
      return await setString(key, json);
    } catch (_) {
      return false;
    }
  }

  @override
  Future<T?> getObject<T>(String key, JsonDecoder<T> decoder) async {
    try {
      final json = await getString(key);
      if (json == null) return null;

      final map = tryDecodeJson(json);
      if (map == null) return null;

      return decoder(map);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> setObjectList<T>(
    String key,
    List<T> value,
    JsonEncoder<T> encoder,
  ) async {
    try {
      final list = value.map((item) => encoder(item)).toList();
      final json = encodeJson(list);
      return await setString(key, json);
    } catch (_) {
      return false;
    }
  }

  @override
  Future<List<T>?> getObjectList<T>(String key, JsonDecoder<T> decoder) async {
    try {
      final json = await getString(key);
      if (json == null) return null;

      final list = tryDecodeJsonList(json);
      if (list == null) return null;

      return list
          .whereType<Map<String, dynamic>>()
          .map((item) => decoder(item))
          .toList();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> setAll(Map<String, dynamic> entries) async {
    try {
      for (final entry in entries.entries) {
        final value = entry.value;
        var success = false;

        if (value is String) {
          success = await setString(entry.key, value);
        } else if (value is int) {
          success = await setInt(entry.key, value);
        } else if (value is double) {
          success = await setDouble(entry.key, value);
        } else if (value is bool) {
          success = await setBool(entry.key, value);
        } else if (value is List<String>) {
          success = await setStringList(entry.key, value);
        } else {
          // 尝试作为 JSON 存储
          success = await setString(entry.key, encodeJson(value));
        }

        if (!success) return false;
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<Map<String, dynamic>> getAll(List<String> keys) async {
    final result = <String, dynamic>{};
    for (final key in keys) {
      final value = await getString(key);
      if (value != null) {
        result[key] = value;
      }
    }
    return result;
  }

  @override
  Future<bool> removeAll(List<String> keys) async {
    try {
      for (final key in keys) {
        final success = await remove(key);
        if (!success) return false;
      }
      return true;
    } catch (_) {
      return false;
    }
  }
}

/// 存储异常
class StorageException implements Exception {
  /// 创建存储异常
  const StorageException(this.message, [this.originalError]);

  /// 错误消息
  final String message;

  /// 原始异常
  final dynamic originalError;

  @override
  String toString() => 'StorageException: $message';
}
