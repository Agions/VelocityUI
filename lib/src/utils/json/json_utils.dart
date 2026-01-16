/// VelocityUI JSON 工具类
/// 提供 JSON 序列化、反序列化和操作功能
library velocity_json_utils;

import 'dart:convert';

/// JSON 工具类
/// 提供 JSON 编解码、格式化输出、安全解析和深度合并功能
class JsonUtils {
  // 私有构造函数，防止实例化
  JsonUtils._();

  /// 序列化为 JSON 字符串
  ///
  /// 将 Dart 对象序列化为紧凑的 JSON 字符串。
  /// 支持 Map、List、String、num、bool、null 等基本类型，
  /// 以及实现了 toJson() 方法的自定义对象。
  ///
  /// [value] 要序列化的值
  /// 返回 JSON 字符串
  ///
  /// 示例:
  /// ```dart
  /// final json = JsonUtils.encode({'name': 'John', 'age': 30});
  /// // 输出: {"name":"John","age":30}
  /// ```
  static String encode(dynamic value) {
    return jsonEncode(value);
  }

  /// 序列化为格式化的 JSON 字符串 (pretty print)
  ///
  /// 将 Dart 对象序列化为带缩进的 JSON 字符串，便于阅读和调试。
  ///
  /// [value] 要序列化的值
  /// [indent] 缩进空格数，默认为 2
  /// 返回格式化的 JSON 字符串
  ///
  /// 示例:
  /// ```dart
  /// final json = JsonUtils.encodePretty({'name': 'John', 'age': 30});
  /// // 输出:
  /// // {
  /// //   "name": "John",
  /// //   "age": 30
  /// // }
  /// ```
  static String encodePretty(dynamic value, {int indent = 2}) {
    final encoder = JsonEncoder.withIndent(' ' * indent);
    return encoder.convert(value);
  }

  /// 反序列化 JSON 字符串
  ///
  /// 将 JSON 字符串解析为 Dart 对象。
  /// 返回类型取决于 JSON 内容：对象返回 Map<String, dynamic>，
  /// 数组返回 List<dynamic>，其他返回对应的基本类型。
  ///
  /// [json] JSON 字符串
  /// 返回解析后的 Dart 对象
  /// 如果 JSON 格式无效，抛出 FormatException
  ///
  /// 示例:
  /// ```dart
  /// final data = JsonUtils.decode('{"name":"John","age":30}');
  /// // data 为 Map<String, dynamic>
  /// ```
  static dynamic decode(String json) {
    return jsonDecode(json);
  }

  /// 安全反序列化，失败返回 null
  ///
  /// 尝试将 JSON 字符串解析为指定类型的对象。
  /// 如果解析失败（格式错误、类型不匹配等），返回 null 而不是抛出异常。
  ///
  /// [json] JSON 字符串
  /// [fromJson] 将 Map 转换为目标类型的函数
  /// 返回解析后的对象，失败时返回 null
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
  /// final user = JsonUtils.tryDecode<User>(
  ///   '{"name":"John","age":30}',
  ///   User.fromJson,
  /// );
  /// ```
  static T? tryDecode<T>(
    String json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    try {
      final decoded = jsonDecode(json);
      if (decoded is Map<String, dynamic>) {
        return fromJson(decoded);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// 安全解析 JSON 字符串为 Map
  ///
  /// 尝试将 JSON 字符串解析为 Map<String, dynamic>。
  /// 如果解析失败，返回 null。
  ///
  /// [json] JSON 字符串
  /// 返回解析后的 Map，失败时返回 null
  static Map<String, dynamic>? tryDecodeMap(String json) {
    try {
      final decoded = jsonDecode(json);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// 安全解析 JSON 字符串为 List
  ///
  /// 尝试将 JSON 字符串解析为 List<dynamic>。
  /// 如果解析失败，返回 null。
  ///
  /// [json] JSON 字符串
  /// 返回解析后的 List，失败时返回 null
  static List<dynamic>? tryDecodeList(String json) {
    try {
      final decoded = jsonDecode(json);
      if (decoded is List<dynamic>) {
        return decoded;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// 深度合并两个 JSON 对象
  ///
  /// 将 override 中的值合并到 base 中。
  /// 对于嵌套的 Map，会递归合并；对于其他类型，override 的值会覆盖 base 的值。
  ///
  /// [base] 基础 Map
  /// [override] 要合并的 Map，其值会覆盖 base 中的同名键
  /// 返回合并后的新 Map（不修改原始 Map）
  ///
  /// 示例:
  /// ```dart
  /// final base = {
  ///   'name': 'John',
  ///   'settings': {'theme': 'dark', 'fontSize': 14}
  /// };
  /// final override = {
  ///   'age': 30,
  ///   'settings': {'theme': 'light'}
  /// };
  /// final merged = JsonUtils.deepMerge(base, override);
  /// // 结果: {
  /// //   'name': 'John',
  /// //   'age': 30,
  /// //   'settings': {'theme': 'light', 'fontSize': 14}
  /// // }
  /// ```
  static Map<String, dynamic> deepMerge(
    Map<String, dynamic> base,
    Map<String, dynamic> override,
  ) {
    final result = Map<String, dynamic>.from(base);

    for (final entry in override.entries) {
      final key = entry.key;
      final overrideValue = entry.value;
      final baseValue = result[key];

      if (baseValue is Map<String, dynamic> &&
          overrideValue is Map<String, dynamic>) {
        // 递归合并嵌套的 Map
        result[key] = deepMerge(baseValue, overrideValue);
      } else {
        // 直接覆盖
        result[key] = overrideValue;
      }
    }

    return result;
  }

  /// 检查字符串是否为有效的 JSON
  ///
  /// [json] 要检查的字符串
  /// 返回 true 如果是有效的 JSON，否则返回 false
  static bool isValidJson(String json) {
    try {
      jsonDecode(json);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// 获取 JSON 对象中的嵌套值
  ///
  /// 使用点分隔的路径获取嵌套值。
  ///
  /// [json] JSON Map 对象
  /// [path] 点分隔的路径，如 'user.profile.name'
  /// 返回路径对应的值，如果路径不存在返回 null
  ///
  /// 示例:
  /// ```dart
  /// final data = {
  ///   'user': {
  ///     'profile': {'name': 'John'}
  ///   }
  /// };
  /// final name = JsonUtils.getNestedValue(data, 'user.profile.name');
  /// // name = 'John'
  /// ```
  static dynamic getNestedValue(Map<String, dynamic> json, String path) {
    final keys = path.split('.');
    dynamic current = json;

    for (final key in keys) {
      if (current is Map<String, dynamic> && current.containsKey(key)) {
        current = current[key];
      } else {
        return null;
      }
    }

    return current;
  }

  /// 设置 JSON 对象中的嵌套值
  ///
  /// 使用点分隔的路径设置嵌套值。如果路径中的中间节点不存在，会自动创建。
  ///
  /// [json] JSON Map 对象
  /// [path] 点分隔的路径，如 'user.profile.name'
  /// [value] 要设置的值
  /// 返回修改后的新 Map（不修改原始 Map）
  ///
  /// 示例:
  /// ```dart
  /// final data = {'user': {}};
  /// final updated = JsonUtils.setNestedValue(data, 'user.profile.name', 'John');
  /// // updated = {'user': {'profile': {'name': 'John'}}}
  /// ```
  static Map<String, dynamic> setNestedValue(
    Map<String, dynamic> json,
    String path,
    dynamic value,
  ) {
    final result = Map<String, dynamic>.from(json);
    final keys = path.split('.');

    if (keys.isEmpty) return result;

    if (keys.length == 1) {
      result[keys.first] = value;
      return result;
    }

    var current = result;
    for (var i = 0; i < keys.length - 1; i++) {
      final key = keys[i];
      if (current[key] is Map<String, dynamic>) {
        current[key] = Map<String, dynamic>.from(current[key] as Map);
        current = current[key] as Map<String, dynamic>;
      } else {
        current[key] = <String, dynamic>{};
        current = current[key] as Map<String, dynamic>;
      }
    }

    current[keys.last] = value;
    return result;
  }
}
