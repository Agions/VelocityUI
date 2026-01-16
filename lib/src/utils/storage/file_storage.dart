/// VelocityUI 文件存储实现
/// 基于文件系统的本地存储
library velocity_file_storage;

import 'dart:convert';
import 'dart:io';

import 'storage_utils.dart';

/// 文件系统适配器接口
///
/// 定义文件操作接口，允许注入真实的文件系统或使用内存实现进行测试
abstract class FileSystemAdapter {
  /// 读取文件内容
  Future<String?> readFile(String path);

  /// 写入文件内容
  Future<bool> writeFile(String path, String content);

  /// 删除文件
  Future<bool> deleteFile(String path);

  /// 检查文件是否存在
  Future<bool> fileExists(String path);

  /// 列出目录中的文件
  Future<List<String>> listFiles(String directory);

  /// 创建目录
  Future<bool> createDirectory(String path);

  /// 删除目录
  Future<bool> deleteDirectory(String path);
}

/// 真实文件系统适配器
///
/// 使用 dart:io 进行实际的文件操作
class RealFileSystemAdapter implements FileSystemAdapter {
  @override
  Future<String?> readFile(String path) async {
    try {
      final file = File(path);
      if (await file.exists()) {
        return await file.readAsString();
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> writeFile(String path, String content) async {
    try {
      final file = File(path);
      final parent = file.parent;
      if (!await parent.exists()) {
        await parent.create(recursive: true);
      }
      await file.writeAsString(content);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> deleteFile(String path) async {
    try {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> fileExists(String path) async {
    try {
      return await File(path).exists();
    } catch (_) {
      return false;
    }
  }

  @override
  Future<List<String>> listFiles(String directory) async {
    try {
      final dir = Directory(directory);
      if (!await dir.exists()) {
        return [];
      }
      final entities = await dir.list().toList();
      return entities.whereType<File>().map((f) => f.path).toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<bool> createDirectory(String path) async {
    try {
      final dir = Directory(path);
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> deleteDirectory(String path) async {
    try {
      final dir = Directory(path);
      if (await dir.exists()) {
        await dir.delete(recursive: true);
      }
      return true;
    } catch (_) {
      return false;
    }
  }
}

/// 内存文件系统适配器
///
/// 用于测试或不需要持久化的场景
class InMemoryFileSystemAdapter implements FileSystemAdapter {
  final Map<String, String> _files = {};
  final Set<String> _directories = {};

  @override
  Future<String?> readFile(String path) async {
    return _files[path];
  }

  @override
  Future<bool> writeFile(String path, String content) async {
    _files[path] = content;
    return true;
  }

  @override
  Future<bool> deleteFile(String path) async {
    _files.remove(path);
    return true;
  }

  @override
  Future<bool> fileExists(String path) async {
    return _files.containsKey(path);
  }

  @override
  Future<List<String>> listFiles(String directory) async {
    final normalizedDir = directory.endsWith('/') ? directory : '$directory/';
    return _files.keys.where((path) => path.startsWith(normalizedDir)).toList();
  }

  @override
  Future<bool> createDirectory(String path) async {
    _directories.add(path);
    return true;
  }

  @override
  Future<bool> deleteDirectory(String path) async {
    _directories.remove(path);
    // 删除目录下的所有文件
    final normalizedDir = path.endsWith('/') ? path : '$path/';
    _files.removeWhere((key, _) => key.startsWith(normalizedDir));
    return true;
  }

  /// 清空所有数据（用于测试）
  void clear() {
    _files.clear();
    _directories.clear();
  }
}

/// 基于文件系统的存储实现
///
/// 将数据以 JSON 文件形式存储在指定目录中。
/// 每个键对应一个独立的文件，适用于存储较大的数据或需要持久化的场景。
///
/// 使用示例:
/// ```dart
/// // 使用真实文件系统
/// final storage = FileStorage(
///   basePath: '/path/to/storage',
/// );
///
/// // 使用内存文件系统（测试用）
/// final storage = FileStorage.inMemory(basePath: '/test');
///
/// // 存储数据
/// await storage.setString('config', '{"theme": "dark"}');
/// await storage.setInt('counter', 42);
///
/// // 读取数据
/// final config = await storage.getString('config');
/// final counter = await storage.getInt('counter');
///
/// // 存储对象
/// final user = User(name: 'John', age: 30);
/// await storage.setObject('user', user, (u) => u.toJson());
///
/// // 读取对象
/// final savedUser = await storage.getObject('user', User.fromJson);
/// ```
class FileStorage extends BaseStorageUtils {
  /// 创建 FileStorage 实例
  ///
  /// [basePath] 存储根目录路径
  /// [adapter] 文件系统适配器，默认使用真实文件系统
  /// [fileExtension] 文件扩展名，默认为 .json
  FileStorage({
    required this.basePath,
    FileSystemAdapter? adapter,
    this.fileExtension = '.json',
  }) : _adapter = adapter ?? RealFileSystemAdapter();

  /// 创建使用内存文件系统的实例（用于测试）
  factory FileStorage.inMemory({
    required String basePath,
    String fileExtension = '.json',
  }) {
    return FileStorage(
      basePath: basePath,
      adapter: InMemoryFileSystemAdapter(),
      fileExtension: fileExtension,
    );
  }

  /// 文件系统适配器
  final FileSystemAdapter _adapter;

  /// 存储根目录
  final String basePath;

  /// 文件扩展名
  final String fileExtension;

  /// 获取键对应的文件路径
  String _getFilePath(String key) {
    // 对键进行安全处理，移除不安全的字符
    final safeKey = key.replaceAll(RegExp(r'[^\w\-.]'), '_');
    return '$basePath/$safeKey$fileExtension';
  }

  /// 从文件路径提取键名
  String _getKeyFromPath(String path) {
    final fileName = path.split('/').last;
    if (fileName.endsWith(fileExtension)) {
      return fileName.substring(0, fileName.length - fileExtension.length);
    }
    return fileName;
  }

  /// 存储数据的内部结构
  Map<String, dynamic> _wrapValue(String type, dynamic value) {
    return {
      '_type': type,
      '_value': value,
      '_timestamp': DateTime.now().toIso8601String(),
    };
  }

  /// 解析存储的数据
  dynamic _unwrapValue(String content, String expectedType) {
    try {
      final data = jsonDecode(content);
      if (data is Map<String, dynamic>) {
        if (data['_type'] == expectedType) {
          return data['_value'];
        }
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> setString(String key, String value) async {
    try {
      final content = jsonEncode(_wrapValue('string', value));
      return await _adapter.writeFile(_getFilePath(key), content);
    } catch (e) {
      throw StorageException('Failed to set string for key: $key', e);
    }
  }

  @override
  Future<String?> getString(String key) async {
    try {
      final content = await _adapter.readFile(_getFilePath(key));
      if (content == null) return null;
      return _unwrapValue(content, 'string') as String?;
    } catch (e) {
      throw StorageException('Failed to get string for key: $key', e);
    }
  }

  @override
  Future<bool> setInt(String key, int value) async {
    try {
      final content = jsonEncode(_wrapValue('int', value));
      return await _adapter.writeFile(_getFilePath(key), content);
    } catch (e) {
      throw StorageException('Failed to set int for key: $key', e);
    }
  }

  @override
  Future<int?> getInt(String key) async {
    try {
      final content = await _adapter.readFile(_getFilePath(key));
      if (content == null) return null;
      final value = _unwrapValue(content, 'int');
      if (value is int) return value;
      if (value is num) return value.toInt();
      return null;
    } catch (e) {
      throw StorageException('Failed to get int for key: $key', e);
    }
  }

  @override
  Future<bool> setDouble(String key, double value) async {
    try {
      final content = jsonEncode(_wrapValue('double', value));
      return await _adapter.writeFile(_getFilePath(key), content);
    } catch (e) {
      throw StorageException('Failed to set double for key: $key', e);
    }
  }

  @override
  Future<double?> getDouble(String key) async {
    try {
      final content = await _adapter.readFile(_getFilePath(key));
      if (content == null) return null;
      final value = _unwrapValue(content, 'double');
      if (value is double) return value;
      if (value is num) return value.toDouble();
      return null;
    } catch (e) {
      throw StorageException('Failed to get double for key: $key', e);
    }
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    try {
      final content = jsonEncode(_wrapValue('bool', value));
      return await _adapter.writeFile(_getFilePath(key), content);
    } catch (e) {
      throw StorageException('Failed to set bool for key: $key', e);
    }
  }

  @override
  Future<bool?> getBool(String key) async {
    try {
      final content = await _adapter.readFile(_getFilePath(key));
      if (content == null) return null;
      return _unwrapValue(content, 'bool') as bool?;
    } catch (e) {
      throw StorageException('Failed to get bool for key: $key', e);
    }
  }

  @override
  Future<bool> setStringList(String key, List<String> value) async {
    try {
      final content = jsonEncode(_wrapValue('stringList', value));
      return await _adapter.writeFile(_getFilePath(key), content);
    } catch (e) {
      throw StorageException('Failed to set string list for key: $key', e);
    }
  }

  @override
  Future<List<String>?> getStringList(String key) async {
    try {
      final content = await _adapter.readFile(_getFilePath(key));
      if (content == null) return null;
      final value = _unwrapValue(content, 'stringList');
      if (value is List) {
        return value.cast<String>();
      }
      return null;
    } catch (e) {
      throw StorageException('Failed to get string list for key: $key', e);
    }
  }

  @override
  Future<bool> setObject<T>(
    String key,
    T value,
    JsonEncoder<T> encoder,
  ) async {
    try {
      final content = jsonEncode(_wrapValue('object', encoder(value)));
      return await _adapter.writeFile(_getFilePath(key), content);
    } catch (e) {
      throw StorageException('Failed to set object for key: $key', e);
    }
  }

  @override
  Future<T?> getObject<T>(String key, JsonDecoder<T> decoder) async {
    try {
      final content = await _adapter.readFile(_getFilePath(key));
      if (content == null) return null;
      final value = _unwrapValue(content, 'object');
      if (value is Map<String, dynamic>) {
        return decoder(value);
      }
      return null;
    } catch (e) {
      throw StorageException('Failed to get object for key: $key', e);
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
      final content = jsonEncode(_wrapValue('objectList', list));
      return await _adapter.writeFile(_getFilePath(key), content);
    } catch (e) {
      throw StorageException('Failed to set object list for key: $key', e);
    }
  }

  @override
  Future<List<T>?> getObjectList<T>(String key, JsonDecoder<T> decoder) async {
    try {
      final content = await _adapter.readFile(_getFilePath(key));
      if (content == null) return null;
      final value = _unwrapValue(content, 'objectList');
      if (value is List) {
        return value
            .whereType<Map<String, dynamic>>()
            .map((item) => decoder(item))
            .toList();
      }
      return null;
    } catch (e) {
      throw StorageException('Failed to get object list for key: $key', e);
    }
  }

  @override
  Future<bool> remove(String key) async {
    try {
      return await _adapter.deleteFile(_getFilePath(key));
    } catch (e) {
      throw StorageException('Failed to remove key: $key', e);
    }
  }

  @override
  Future<bool> clear() async {
    try {
      return await _adapter.deleteDirectory(basePath);
    } catch (e) {
      throw StorageException('Failed to clear storage', e);
    }
  }

  @override
  Future<bool> containsKey(String key) async {
    try {
      return await _adapter.fileExists(_getFilePath(key));
    } catch (e) {
      throw StorageException('Failed to check key existence: $key', e);
    }
  }

  @override
  Future<Set<String>> getKeys() async {
    try {
      final files = await _adapter.listFiles(basePath);
      return files
          .where((path) => path.endsWith(fileExtension))
          .map(_getKeyFromPath)
          .toSet();
    } catch (e) {
      throw StorageException('Failed to get keys', e);
    }
  }

  /// 获取存储目录的大小（字节）
  ///
  /// 注意：此方法仅在使用真实文件系统时有效
  Future<int> getStorageSize() async {
    try {
      final files = await _adapter.listFiles(basePath);
      var totalSize = 0;
      for (final path in files) {
        final content = await _adapter.readFile(path);
        if (content != null) {
          totalSize += utf8.encode(content).length;
        }
      }
      return totalSize;
    } catch (_) {
      return 0;
    }
  }

  /// 获取存储的文件数量
  Future<int> getFileCount() async {
    try {
      final files = await _adapter.listFiles(basePath);
      return files.where((path) => path.endsWith(fileExtension)).length;
    } catch (_) {
      return 0;
    }
  }
}
