/// VelocityUI SharedPreferences 存储实现
/// 基于键值对的轻量级本地存储
library velocity_preferences_storage;

import 'storage_utils.dart';

/// SharedPreferences 适配器接口
///
/// 定义与 SharedPreferences 兼容的接口，
/// 允许注入真实的 SharedPreferences 实例或使用内存实现进行测试
abstract class SharedPreferencesAdapter {
  /// 获取字符串
  String? getString(String key);

  /// 设置字符串
  Future<bool> setString(String key, String value);

  /// 获取整数
  int? getInt(String key);

  /// 设置整数
  Future<bool> setInt(String key, int value);

  /// 获取双精度浮点数
  double? getDouble(String key);

  /// 设置双精度浮点数
  Future<bool> setDouble(String key, double value);

  /// 获取布尔值
  bool? getBool(String key);

  /// 设置布尔值
  Future<bool> setBool(String key, bool value);

  /// 获取字符串列表
  List<String>? getStringList(String key);

  /// 设置字符串列表
  Future<bool> setStringList(String key, List<String> value);

  /// 删除键
  Future<bool> remove(String key);

  /// 清空所有数据
  Future<bool> clear();

  /// 检查键是否存在
  bool containsKey(String key);

  /// 获取所有键
  Set<String> getKeys();
}

/// 内存存储适配器
///
/// 用于测试或不需要持久化的场景
class InMemoryPreferencesAdapter implements SharedPreferencesAdapter {
  final Map<String, dynamic> _data = {};

  @override
  String? getString(String key) => _data[key] as String?;

  @override
  Future<bool> setString(String key, String value) async {
    _data[key] = value;
    return true;
  }

  @override
  int? getInt(String key) => _data[key] as int?;

  @override
  Future<bool> setInt(String key, int value) async {
    _data[key] = value;
    return true;
  }

  @override
  double? getDouble(String key) => _data[key] as double?;

  @override
  Future<bool> setDouble(String key, double value) async {
    _data[key] = value;
    return true;
  }

  @override
  bool? getBool(String key) => _data[key] as bool?;

  @override
  Future<bool> setBool(String key, bool value) async {
    _data[key] = value;
    return true;
  }

  @override
  List<String>? getStringList(String key) {
    final value = _data[key];
    if (value is List<String>) return value;
    if (value is List) return value.cast<String>();
    return null;
  }

  @override
  Future<bool> setStringList(String key, List<String> value) async {
    _data[key] = List<String>.from(value);
    return true;
  }

  @override
  Future<bool> remove(String key) async {
    _data.remove(key);
    return true;
  }

  @override
  Future<bool> clear() async {
    _data.clear();
    return true;
  }

  @override
  bool containsKey(String key) => _data.containsKey(key);

  @override
  Set<String> getKeys() => _data.keys.toSet();
}

/// 基于 SharedPreferences 的存储实现
///
/// 提供轻量级的键值对存储，适用于存储简单的配置和用户偏好设置。
/// 数据以键值对形式存储，支持基本类型和 JSON 序列化的对象。
///
/// 使用示例:
/// ```dart
/// // 使用内存存储（测试用）
/// final storage = PreferencesStorage();
///
/// // 使用真实的 SharedPreferences（需要 shared_preferences 包）
/// // final prefs = await SharedPreferences.getInstance();
/// // final storage = PreferencesStorage(adapter: SharedPreferencesWrapper(prefs));
///
/// // 存储数据
/// await storage.setString('username', 'john');
/// await storage.setInt('age', 30);
/// await storage.setBool('isLoggedIn', true);
///
/// // 读取数据
/// final username = await storage.getString('username');
/// final age = await storage.getInt('age');
/// final isLoggedIn = await storage.getBool('isLoggedIn');
///
/// // 存储对象
/// final user = User(name: 'John', age: 30);
/// await storage.setObject('user', user, (u) => u.toJson());
///
/// // 读取对象
/// final savedUser = await storage.getObject('user', User.fromJson);
/// ```
class PreferencesStorage extends BaseStorageUtils {
  /// 创建 PreferencesStorage 实例
  ///
  /// [adapter] SharedPreferences 适配器，默认使用内存实现
  /// [keyPrefix] 可选的键前缀，用于命名空间隔离
  PreferencesStorage({
    SharedPreferencesAdapter? adapter,
    this.keyPrefix,
  }) : _adapter = adapter ?? InMemoryPreferencesAdapter();

  /// 创建使用内存存储的实例（用于测试）
  factory PreferencesStorage.inMemory({String? keyPrefix}) {
    return PreferencesStorage(
      adapter: InMemoryPreferencesAdapter(),
      keyPrefix: keyPrefix,
    );
  }

  /// SharedPreferences 适配器
  final SharedPreferencesAdapter _adapter;

  /// 键前缀，用于命名空间隔离
  final String? keyPrefix;

  /// 获取完整的存储键（添加前缀）
  String _getKey(String key) {
    if (keyPrefix != null && keyPrefix!.isNotEmpty) {
      return '${keyPrefix}_$key';
    }
    return key;
  }

  /// 从完整键中移除前缀
  String _removePrefix(String key) {
    if (keyPrefix != null && keyPrefix!.isNotEmpty) {
      final prefix = '${keyPrefix}_';
      if (key.startsWith(prefix)) {
        return key.substring(prefix.length);
      }
    }
    return key;
  }

  @override
  Future<bool> setString(String key, String value) async {
    try {
      return await _adapter.setString(_getKey(key), value);
    } catch (e) {
      throw StorageException('Failed to set string for key: $key', e);
    }
  }

  @override
  Future<String?> getString(String key) async {
    try {
      return _adapter.getString(_getKey(key));
    } catch (e) {
      throw StorageException('Failed to get string for key: $key', e);
    }
  }

  @override
  Future<bool> setInt(String key, int value) async {
    try {
      return await _adapter.setInt(_getKey(key), value);
    } catch (e) {
      throw StorageException('Failed to set int for key: $key', e);
    }
  }

  @override
  Future<int?> getInt(String key) async {
    try {
      return _adapter.getInt(_getKey(key));
    } catch (e) {
      throw StorageException('Failed to get int for key: $key', e);
    }
  }

  @override
  Future<bool> setDouble(String key, double value) async {
    try {
      return await _adapter.setDouble(_getKey(key), value);
    } catch (e) {
      throw StorageException('Failed to set double for key: $key', e);
    }
  }

  @override
  Future<double?> getDouble(String key) async {
    try {
      return _adapter.getDouble(_getKey(key));
    } catch (e) {
      throw StorageException('Failed to get double for key: $key', e);
    }
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    try {
      return await _adapter.setBool(_getKey(key), value);
    } catch (e) {
      throw StorageException('Failed to set bool for key: $key', e);
    }
  }

  @override
  Future<bool?> getBool(String key) async {
    try {
      return _adapter.getBool(_getKey(key));
    } catch (e) {
      throw StorageException('Failed to get bool for key: $key', e);
    }
  }

  @override
  Future<bool> setStringList(String key, List<String> value) async {
    try {
      return await _adapter.setStringList(_getKey(key), value);
    } catch (e) {
      throw StorageException('Failed to set string list for key: $key', e);
    }
  }

  @override
  Future<List<String>?> getStringList(String key) async {
    try {
      return _adapter.getStringList(_getKey(key));
    } catch (e) {
      throw StorageException('Failed to get string list for key: $key', e);
    }
  }

  @override
  Future<bool> remove(String key) async {
    try {
      return await _adapter.remove(_getKey(key));
    } catch (e) {
      throw StorageException('Failed to remove key: $key', e);
    }
  }

  @override
  Future<bool> clear() async {
    try {
      if (keyPrefix != null && keyPrefix!.isNotEmpty) {
        // 只清除带有当前前缀的键
        final keys = _adapter.getKeys();
        final prefix = '${keyPrefix}_';
        for (final key in keys) {
          if (key.startsWith(prefix)) {
            await _adapter.remove(key);
          }
        }
        return true;
      }
      return await _adapter.clear();
    } catch (e) {
      throw StorageException('Failed to clear storage', e);
    }
  }

  @override
  Future<bool> containsKey(String key) async {
    try {
      return _adapter.containsKey(_getKey(key));
    } catch (e) {
      throw StorageException('Failed to check key existence: $key', e);
    }
  }

  @override
  Future<Set<String>> getKeys() async {
    try {
      final allKeys = _adapter.getKeys();
      if (keyPrefix != null && keyPrefix!.isNotEmpty) {
        final prefix = '${keyPrefix}_';
        return allKeys
            .where((key) => key.startsWith(prefix))
            .map(_removePrefix)
            .toSet();
      }
      return allKeys;
    } catch (e) {
      throw StorageException('Failed to get keys', e);
    }
  }

  @override
  Future<Map<String, dynamic>> getAll(List<String> keys) async {
    final result = <String, dynamic>{};
    for (final key in keys) {
      final fullKey = _getKey(key);

      // 尝试获取不同类型的值
      var value = _adapter.getString(fullKey);
      if (value != null) {
        result[key] = value;
        continue;
      }

      final intValue = _adapter.getInt(fullKey);
      if (intValue != null) {
        result[key] = intValue;
        continue;
      }

      final doubleValue = _adapter.getDouble(fullKey);
      if (doubleValue != null) {
        result[key] = doubleValue;
        continue;
      }

      final boolValue = _adapter.getBool(fullKey);
      if (boolValue != null) {
        result[key] = boolValue;
        continue;
      }

      final listValue = _adapter.getStringList(fullKey);
      if (listValue != null) {
        result[key] = listValue;
      }
    }
    return result;
  }
}
