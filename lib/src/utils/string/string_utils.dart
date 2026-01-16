/// VelocityUI 字符串工具类
/// 提供字符串判空、大小写转换、命名风格转换、截断、哈希、编解码等功能
library velocity_string_utils;

import 'dart:convert';

/// 字符串工具类
/// 提供常用的字符串操作方法
class StringUtils {
  // 私有构造函数，防止实例化
  StringUtils._();

  // ==================== 字符串判空方法 ====================

  /// 判断字符串是否为空或空白
  ///
  /// [str] 要判断的字符串
  /// 返回 true 如果字符串为 null、空字符串或仅包含空白字符
  ///
  /// 示例:
  /// ```dart
  /// StringUtils.isBlank(null);    // true
  /// StringUtils.isBlank('');      // true
  /// StringUtils.isBlank('  ');    // true
  /// StringUtils.isBlank('hello'); // false
  /// ```
  static bool isBlank(String? str) {
    return str == null || str.trim().isEmpty;
  }

  /// 判断字符串是否不为空
  ///
  /// [str] 要判断的字符串
  /// 返回 true 如果字符串不为 null 且包含非空白字符
  ///
  /// 示例:
  /// ```dart
  /// StringUtils.isNotBlank(null);    // false
  /// StringUtils.isNotBlank('');      // false
  /// StringUtils.isNotBlank('  ');    // false
  /// StringUtils.isNotBlank('hello'); // true
  /// ```
  static bool isNotBlank(String? str) {
    return !isBlank(str);
  }

  /// 判断字符串是否为空（不考虑空白字符）
  ///
  /// [str] 要判断的字符串
  /// 返回 true 如果字符串为 null 或空字符串
  ///
  /// 示例:
  /// ```dart
  /// StringUtils.isEmpty(null);    // true
  /// StringUtils.isEmpty('');      // true
  /// StringUtils.isEmpty('  ');    // false
  /// StringUtils.isEmpty('hello'); // false
  /// ```
  static bool isEmpty(String? str) {
    return str == null || str.isEmpty;
  }

  /// 判断字符串是否不为空（不考虑空白字符）
  ///
  /// [str] 要判断的字符串
  /// 返回 true 如果字符串不为 null 且不为空字符串
  static bool isNotEmpty(String? str) {
    return !isEmpty(str);
  }

  // ==================== 大小写转换方法 ====================

  /// 首字母大写
  ///
  /// [str] 要转换的字符串
  /// 返回首字母大写的字符串
  ///
  /// 示例:
  /// ```dart
  /// StringUtils.capitalize('hello');  // 'Hello'
  /// StringUtils.capitalize('HELLO');  // 'HELLO'
  /// StringUtils.capitalize('');       // ''
  /// ```
  static String capitalize(String str) {
    if (str.isEmpty) return str;
    return str[0].toUpperCase() + str.substring(1);
  }

  /// 首字母小写
  ///
  /// [str] 要转换的字符串
  /// 返回首字母小写的字符串
  ///
  /// 示例:
  /// ```dart
  /// StringUtils.uncapitalize('Hello');  // 'hello'
  /// StringUtils.uncapitalize('HELLO');  // 'hELLO'
  /// StringUtils.uncapitalize('');       // ''
  /// ```
  static String uncapitalize(String str) {
    if (str.isEmpty) return str;
    return str[0].toLowerCase() + str.substring(1);
  }

  /// 转换为标题格式（每个单词首字母大写）
  ///
  /// [str] 要转换的字符串
  /// 返回标题格式的字符串
  ///
  /// 示例:
  /// ```dart
  /// StringUtils.toTitleCase('hello world');  // 'Hello World'
  /// StringUtils.toTitleCase('HELLO WORLD');  // 'Hello World'
  /// ```
  static String toTitleCase(String str) {
    if (str.isEmpty) return str;
    return str.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  // ==================== 命名风格转换方法 ====================

  /// 驼峰命名转下划线命名 (snake_case)
  ///
  /// [str] 驼峰命名的字符串
  /// 返回下划线命名的字符串
  ///
  /// 示例:
  /// ```dart
  /// StringUtils.camelToSnake('helloWorld');     // 'hello_world'
  /// StringUtils.camelToSnake('HelloWorld');     // 'hello_world'
  /// StringUtils.camelToSnake('helloWorldTest'); // 'hello_world_test'
  /// StringUtils.camelToSnake('HTTPClient');     // 'http_client'
  /// ```
  static String camelToSnake(String str) {
    if (str.isEmpty) return str;

    final buffer = StringBuffer();
    var previousWasUpperCase = false;

    for (var i = 0; i < str.length; i++) {
      final char = str[i];
      final isUpperCase =
          char == char.toUpperCase() && char != char.toLowerCase();

      if (isUpperCase) {
        // 检查是否是连续大写字母的情况（如 HTTP）
        final nextIsLowerCase = i + 1 < str.length &&
            str[i + 1] == str[i + 1].toLowerCase() &&
            str[i + 1] != str[i + 1].toUpperCase();

        if (i > 0 && (!previousWasUpperCase || nextIsLowerCase)) {
          buffer.write('_');
        }
        buffer.write(char.toLowerCase());
        previousWasUpperCase = true;
      } else {
        buffer.write(char);
        previousWasUpperCase = false;
      }
    }

    return buffer.toString();
  }

  /// 下划线命名转驼峰命名 (camelCase)
  ///
  /// [str] 下划线命名的字符串
  /// [upperFirst] 是否首字母大写（PascalCase），默认为 false
  /// 返回驼峰命名的字符串
  ///
  /// 示例:
  /// ```dart
  /// StringUtils.snakeToCamel('hello_world');       // 'helloWorld'
  /// StringUtils.snakeToCamel('hello_world', true); // 'HelloWorld'
  /// StringUtils.snakeToCamel('http_client');       // 'httpClient'
  /// ```
  static String snakeToCamel(String str, [bool upperFirst = false]) {
    if (str.isEmpty) return str;

    final parts = str.split('_');
    final buffer = StringBuffer();

    for (var i = 0; i < parts.length; i++) {
      final part = parts[i];
      if (part.isEmpty) continue;

      if (i == 0 && !upperFirst) {
        buffer.write(part.toLowerCase());
      } else {
        buffer.write(capitalize(part.toLowerCase()));
      }
    }

    return buffer.toString();
  }

  /// 驼峰命名转短横线命名 (kebab-case)
  ///
  /// [str] 驼峰命名的字符串
  /// 返回短横线命名的字符串
  ///
  /// 示例:
  /// ```dart
  /// StringUtils.camelToKebab('helloWorld');  // 'hello-world'
  /// StringUtils.camelToKebab('HelloWorld');  // 'hello-world'
  /// ```
  static String camelToKebab(String str) {
    return camelToSnake(str).replaceAll('_', '-');
  }

  /// 短横线命名转驼峰命名
  ///
  /// [str] 短横线命名的字符串
  /// [upperFirst] 是否首字母大写（PascalCase），默认为 false
  /// 返回驼峰命名的字符串
  ///
  /// 示例:
  /// ```dart
  /// StringUtils.kebabToCamel('hello-world');       // 'helloWorld'
  /// StringUtils.kebabToCamel('hello-world', true); // 'HelloWorld'
  /// ```
  static String kebabToCamel(String str, [bool upperFirst = false]) {
    return snakeToCamel(str.replaceAll('-', '_'), upperFirst);
  }

  // ==================== 截断方法 ====================

  /// 截断字符串
  ///
  /// [str] 要截断的字符串
  /// [maxLength] 最大长度
  /// [suffix] 截断后的后缀，默认为 '...'
  /// 返回截断后的字符串
  ///
  /// 示例:
  /// ```dart
  /// StringUtils.truncate('Hello World', 8);           // 'Hello...'
  /// StringUtils.truncate('Hello World', 8, '…');      // 'Hello W…'
  /// StringUtils.truncate('Hello', 10);                // 'Hello'
  /// ```
  static String truncate(String str, int maxLength, {String suffix = '...'}) {
    if (str.length <= maxLength) return str;
    if (maxLength <= suffix.length) return suffix.substring(0, maxLength);
    return str.substring(0, maxLength - suffix.length) + suffix;
  }

  /// 从中间截断字符串
  ///
  /// [str] 要截断的字符串
  /// [maxLength] 最大长度
  /// [separator] 中间分隔符，默认为 '...'
  /// 返回截断后的字符串
  ///
  /// 示例:
  /// ```dart
  /// StringUtils.truncateMiddle('Hello World Test', 10);  // 'Hel...est'
  /// ```
  static String truncateMiddle(String str, int maxLength,
      {String separator = '...'}) {
    if (str.length <= maxLength) return str;
    if (maxLength <= separator.length) {
      return separator.substring(0, maxLength);
    }

    final availableLength = maxLength - separator.length;
    final startLength = (availableLength / 2).ceil();
    final endLength = availableLength - startLength;

    return str.substring(0, startLength) +
        separator +
        str.substring(str.length - endLength);
  }

  // ==================== 哈希方法 ====================

  /// 计算字符串的 MD5 哈希值
  ///
  /// [str] 要计算哈希的字符串
  /// 返回 32 位小写十六进制 MD5 哈希字符串
  ///
  /// 示例:
  /// ```dart
  /// StringUtils.md5('hello');  // '5d41402abc4b2a76b9719d911017c592'
  /// ```
  static String md5(String str) {
    // 使用简单的 MD5 实现，避免外部依赖
    return _md5Hash(utf8.encode(str));
  }

  // ==================== Base64 编解码方法 ====================

  /// Base64 编码
  ///
  /// [str] 要编码的字符串
  /// 返回 Base64 编码后的字符串
  ///
  /// 示例:
  /// ```dart
  /// StringUtils.base64Encode('hello');  // 'aGVsbG8='
  /// ```
  static String base64Encode(String str) {
    return base64.encode(utf8.encode(str));
  }

  /// Base64 解码
  ///
  /// [str] Base64 编码的字符串
  /// 返回解码后的字符串
  /// 如果输入不是有效的 Base64 字符串，抛出 FormatException
  ///
  /// 示例:
  /// ```dart
  /// StringUtils.base64Decode('aGVsbG8=');  // 'hello'
  /// ```
  static String base64Decode(String str) {
    return utf8.decode(base64.decode(str));
  }

  /// 安全的 Base64 解码
  ///
  /// [str] Base64 编码的字符串
  /// 返回解码后的字符串，如果解码失败返回 null
  ///
  /// 示例:
  /// ```dart
  /// StringUtils.tryBase64Decode('aGVsbG8=');  // 'hello'
  /// StringUtils.tryBase64Decode('invalid');   // null
  /// ```
  static String? tryBase64Decode(String str) {
    try {
      return base64Decode(str);
    } catch (_) {
      return null;
    }
  }

  // ==================== 正则匹配方法 ====================

  /// 检查字符串是否匹配正则表达式
  ///
  /// [str] 要检查的字符串
  /// [pattern] 正则表达式模式
  /// 返回 true 如果字符串匹配正则表达式
  ///
  /// 示例:
  /// ```dart
  /// StringUtils.matches('hello123', r'^[a-z]+\d+$');  // true
  /// StringUtils.matches('hello', r'^\d+$');           // false
  /// ```
  static bool matches(String str, String pattern) {
    return RegExp(pattern).hasMatch(str);
  }

  /// 检查字符串是否完全匹配正则表达式
  ///
  /// [str] 要检查的字符串
  /// [pattern] 正则表达式模式
  /// 返回 true 如果整个字符串完全匹配正则表达式
  ///
  /// 示例:
  /// ```dart
  /// StringUtils.matchesFully('hello', r'[a-z]+');     // true
  /// StringUtils.matchesFully('hello123', r'[a-z]+');  // false
  /// ```
  static bool matchesFully(String str, String pattern) {
    final regex = RegExp('^$pattern\$');
    return regex.hasMatch(str);
  }

  /// 提取所有匹配的内容
  ///
  /// [str] 要搜索的字符串
  /// [pattern] 正则表达式模式
  /// 返回所有匹配的字符串列表
  ///
  /// 示例:
  /// ```dart
  /// StringUtils.extractMatches('a1b2c3', r'\d');  // ['1', '2', '3']
  /// StringUtils.extractMatches('hello', r'\d');  // []
  /// ```
  static List<String> extractMatches(String str, String pattern) {
    final regex = RegExp(pattern);
    return regex.allMatches(str).map((m) => m.group(0)!).toList();
  }

  /// 提取第一个匹配的内容
  ///
  /// [str] 要搜索的字符串
  /// [pattern] 正则表达式模式
  /// 返回第一个匹配的字符串，如果没有匹配返回 null
  ///
  /// 示例:
  /// ```dart
  /// StringUtils.extractFirst('a1b2c3', r'\d');  // '1'
  /// StringUtils.extractFirst('hello', r'\d');  // null
  /// ```
  static String? extractFirst(String str, String pattern) {
    final regex = RegExp(pattern);
    final match = regex.firstMatch(str);
    return match?.group(0);
  }

  /// 提取匹配的分组
  ///
  /// [str] 要搜索的字符串
  /// [pattern] 带分组的正则表达式模式
  /// 返回所有分组的列表，如果没有匹配返回空列表
  ///
  /// 示例:
  /// ```dart
  /// StringUtils.extractGroups('John:30', r'(\w+):(\d+)');  // ['John', '30']
  /// ```
  static List<String> extractGroups(String str, String pattern) {
    final regex = RegExp(pattern);
    final match = regex.firstMatch(str);
    if (match == null) return [];

    final groups = <String>[];
    for (var i = 1; i <= match.groupCount; i++) {
      final group = match.group(i);
      if (group != null) groups.add(group);
    }
    return groups;
  }

  /// 替换所有匹配的内容
  ///
  /// [str] 要处理的字符串
  /// [pattern] 正则表达式模式
  /// [replacement] 替换内容
  /// 返回替换后的字符串
  ///
  /// 示例:
  /// ```dart
  /// StringUtils.replaceAll('a1b2c3', r'\d', 'X');  // 'aXbXcX'
  /// ```
  static String replaceAllPattern(
      String str, String pattern, String replacement) {
    return str.replaceAll(RegExp(pattern), replacement);
  }

  // ==================== 其他实用方法 ====================

  /// 反转字符串
  ///
  /// [str] 要反转的字符串
  /// 返回反转后的字符串
  ///
  /// 示例:
  /// ```dart
  /// StringUtils.reverse('hello');  // 'olleh'
  /// ```
  static String reverse(String str) {
    return String.fromCharCodes(str.runes.toList().reversed);
  }

  /// 重复字符串
  ///
  /// [str] 要重复的字符串
  /// [times] 重复次数
  /// 返回重复后的字符串
  ///
  /// 示例:
  /// ```dart
  /// StringUtils.repeat('ab', 3);  // 'ababab'
  /// ```
  static String repeat(String str, int times) {
    if (times <= 0) return '';
    return str * times;
  }

  /// 左填充字符串
  ///
  /// [str] 要填充的字符串
  /// [length] 目标长度
  /// [padChar] 填充字符，默认为空格
  /// 返回填充后的字符串
  ///
  /// 示例:
  /// ```dart
  /// StringUtils.padLeft('5', 3, '0');  // '005'
  /// ```
  static String padLeft(String str, int length, [String padChar = ' ']) {
    return str.padLeft(length, padChar);
  }

  /// 右填充字符串
  ///
  /// [str] 要填充的字符串
  /// [length] 目标长度
  /// [padChar] 填充字符，默认为空格
  /// 返回填充后的字符串
  ///
  /// 示例:
  /// ```dart
  /// StringUtils.padRight('5', 3, '0');  // '500'
  /// ```
  static String padRight(String str, int length, [String padChar = ' ']) {
    return str.padRight(length, padChar);
  }

  /// 移除字符串两端的指定字符
  ///
  /// [str] 要处理的字符串
  /// [chars] 要移除的字符集合
  /// 返回处理后的字符串
  ///
  /// 示例:
  /// ```dart
  /// StringUtils.strip('##hello##', '#');  // 'hello'
  /// ```
  static String strip(String str, String chars) {
    final pattern = RegExp('^[$chars]+|[$chars]+\$');
    return str.replaceAll(pattern, '');
  }

  /// 统计子字符串出现次数
  ///
  /// [str] 要搜索的字符串
  /// [substring] 要统计的子字符串
  /// 返回出现次数
  ///
  /// 示例:
  /// ```dart
  /// StringUtils.countOccurrences('hello hello', 'hello');  // 2
  /// ```
  static int countOccurrences(String str, String substring) {
    if (substring.isEmpty) return 0;
    var count = 0;
    var index = 0;
    while ((index = str.indexOf(substring, index)) != -1) {
      count++;
      index += substring.length;
    }
    return count;
  }
}

// ==================== MD5 实现 ====================

/// MD5 哈希计算（纯 Dart 实现，无外部依赖）
String _md5Hash(List<int> data) {
  // MD5 初始化常量
  const s = [
    7, 12, 17, 22, 7, 12, 17, 22, 7, 12, 17, 22, 7, 12, 17, 22, // round 1
    5, 9, 14, 20, 5, 9, 14, 20, 5, 9, 14, 20, 5, 9, 14, 20, // round 2
    4, 11, 16, 23, 4, 11, 16, 23, 4, 11, 16, 23, 4, 11, 16, 23, // round 3
    6, 10, 15, 21, 6, 10, 15, 21, 6, 10, 15, 21, 6, 10, 15, 21, // round 4
  ];

  const k = [
    0xd76aa478, 0xe8c7b756, 0x242070db, 0xc1bdceee, // round 1
    0xf57c0faf, 0x4787c62a, 0xa8304613, 0xfd469501,
    0x698098d8, 0x8b44f7af, 0xffff5bb1, 0x895cd7be,
    0x6b901122, 0xfd987193, 0xa679438e, 0x49b40821,
    0xf61e2562, 0xc040b340, 0x265e5a51, 0xe9b6c7aa, // round 2
    0xd62f105d, 0x02441453, 0xd8a1e681, 0xe7d3fbc8,
    0x21e1cde6, 0xc33707d6, 0xf4d50d87, 0x455a14ed,
    0xa9e3e905, 0xfcefa3f8, 0x676f02d9, 0x8d2a4c8a,
    0xfffa3942, 0x8771f681, 0x6d9d6122, 0xfde5380c, // round 3
    0xa4beea44, 0x4bdecfa9, 0xf6bb4b60, 0xbebfbc70,
    0x289b7ec6, 0xeaa127fa, 0xd4ef3085, 0x04881d05,
    0xd9d4d039, 0xe6db99e5, 0x1fa27cf8, 0xc4ac5665,
    0xf4292244, 0x432aff97, 0xab9423a7, 0xfc93a039, // round 4
    0x655b59c3, 0x8f0ccc92, 0xffeff47d, 0x85845dd1,
    0x6fa87e4f, 0xfe2ce6e0, 0xa3014314, 0x4e0811a1,
    0xf7537e82, 0xbd3af235, 0x2ad7d2bb, 0xeb86d391,
  ];

  // 初始哈希值
  var a0 = 0x67452301;
  var b0 = 0xefcdab89;
  var c0 = 0x98badcfe;
  var d0 = 0x10325476;

  // 预处理：添加填充位
  final originalLength = data.length;
  final bitLength = originalLength * 8;

  // 添加 0x80 字节
  final paddedData = List<int>.from(data)..add(0x80);

  // 填充到 56 mod 64 字节
  while (paddedData.length % 64 != 56) {
    paddedData.add(0);
  }

  // 添加原始长度（64位小端序）
  for (var i = 0; i < 8; i++) {
    paddedData.add((bitLength >> (i * 8)) & 0xff);
  }

  // 处理每个 512 位块
  for (var chunkStart = 0; chunkStart < paddedData.length; chunkStart += 64) {
    // 将块分解为 16 个 32 位字
    final m = List<int>.filled(16, 0);
    for (var i = 0; i < 16; i++) {
      final offset = chunkStart + i * 4;
      m[i] = paddedData[offset] |
          (paddedData[offset + 1] << 8) |
          (paddedData[offset + 2] << 16) |
          (paddedData[offset + 3] << 24);
    }

    var a = a0;
    var b = b0;
    var c = c0;
    var d = d0;

    for (var i = 0; i < 64; i++) {
      int f, g;

      if (i < 16) {
        f = (b & c) | ((~b) & d);
        g = i;
      } else if (i < 32) {
        f = (d & b) | ((~d) & c);
        g = (5 * i + 1) % 16;
      } else if (i < 48) {
        f = b ^ c ^ d;
        g = (3 * i + 5) % 16;
      } else {
        f = c ^ (b | (~d));
        g = (7 * i) % 16;
      }

      f = _add32(f, _add32(a, _add32(k[i], m[g])));
      a = d;
      d = c;
      c = b;
      b = _add32(b, _rotateLeft32(f, s[i]));
    }

    a0 = _add32(a0, a);
    b0 = _add32(b0, b);
    c0 = _add32(c0, c);
    d0 = _add32(d0, d);
  }

  // 生成最终哈希值
  return _toHex32(a0) + _toHex32(b0) + _toHex32(c0) + _toHex32(d0);
}

/// 32位加法（处理溢出）
int _add32(int a, int b) {
  return (a + b) & 0xffffffff;
}

/// 32位左旋转
int _rotateLeft32(int x, int n) {
  return ((x << n) | (x >> (32 - n))) & 0xffffffff;
}

/// 将32位整数转换为小端序十六进制字符串
String _toHex32(int value) {
  final bytes = [
    value & 0xff,
    (value >> 8) & 0xff,
    (value >> 16) & 0xff,
    (value >> 24) & 0xff,
  ];
  return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
}
