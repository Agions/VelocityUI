# 工具类

VelocityUI 提供了一系列实用的工具类，用于处理常见的数据操作。

## JsonUtils

JSON 序列化和反序列化工具。

### 方法

#### encode

将对象序列化为 JSON 字符串。

```dart
static String encode(dynamic value)
```

```dart
final json = JsonUtils.encode({'name': 'John', 'age': 30});
// 输出: {"name":"John","age":30}
```

#### encodePretty

将对象序列化为格式化的 JSON 字符串。

```dart
static String encodePretty(dynamic value, {int indent = 2})
```

```dart
final json = JsonUtils.encodePretty({'name': 'John', 'age': 30});
// 输出:
// {
//   "name": "John",
//   "age": 30
// }
```

#### decode

将 JSON 字符串反序列化为对象。

```dart
static dynamic decode(String json)
```

```dart
final data = JsonUtils.decode('{"name":"John","age":30}');
// data = {'name': 'John', 'age': 30}
```

#### tryDecode

安全地反序列化 JSON 字符串，失败返回 null。

```dart
static T? tryDecode<T>(String json, T Function(Map<String, dynamic>) fromJson)
```

```dart
final user = JsonUtils.tryDecode<User>(jsonString, User.fromJson);
if (user != null) {
  print('用户: ${user.name}');
}
```

#### deepMerge

深度合并两个 JSON 对象。

```dart
static Map<String, dynamic> deepMerge(
  Map<String, dynamic> base,
  Map<String, dynamic> override,
)
```

```dart
final base = {'a': 1, 'b': {'c': 2}};
final override = {'b': {'d': 3}};
final merged = JsonUtils.deepMerge(base, override);
// merged = {'a': 1, 'b': {'c': 2, 'd': 3}}
```

## DateTimeUtils

日期时间处理工具。

### 方法

#### format

格式化日期时间。

```dart
static String format(DateTime dateTime, String pattern)
```

```dart
final formatted = DateTimeUtils.format(DateTime.now(), 'yyyy-MM-dd HH:mm:ss');
// 输出: 2024-01-15 14:30:00
```

支持的格式化符号：

| 符号   | 说明          | 示例   |
| ------ | ------------- | ------ |
| `yyyy` | 四位年份      | 2024   |
| `yy`   | 两位年份      | 24     |
| `MM`   | 两位月份      | 01-12  |
| `M`    | 月份          | 1-12   |
| `dd`   | 两位日期      | 01-31  |
| `d`    | 日期          | 1-31   |
| `HH`   | 24 小时制小时 | 00-23  |
| `hh`   | 12 小时制小时 | 01-12  |
| `mm`   | 分钟          | 00-59  |
| `ss`   | 秒            | 00-59  |
| `a`    | AM/PM         | AM, PM |

#### parse

解析日期时间字符串。

```dart
static DateTime? parse(String dateString, String pattern)
```

```dart
final date = DateTimeUtils.parse('2024-01-15', 'yyyy-MM-dd');
```

#### difference

计算两个日期的时间差。

```dart
static Duration difference(DateTime from, DateTime to)
```

```dart
final diff = DateTimeUtils.difference(startDate, endDate);
print('相差 ${diff.inDays} 天');
```

#### relativeTime

获取相对时间描述。

```dart
static String relativeTime(DateTime dateTime, {DateTime? relativeTo})
```

```dart
final relative = DateTimeUtils.relativeTime(DateTime.now().subtract(Duration(hours: 2)));
// 输出: 2小时前
```

#### isSameDay

判断两个日期是否为同一天。

```dart
static bool isSameDay(DateTime a, DateTime b)
```

```dart
final same = DateTimeUtils.isSameDay(date1, date2);
```

## StringUtils

字符串处理工具。

### 方法

#### isBlank

判断字符串是否为空或空白。

```dart
static bool isBlank(String? str)
```

```dart
StringUtils.isBlank(null);    // true
StringUtils.isBlank('');      // true
StringUtils.isBlank('  ');    // true
StringUtils.isBlank('hello'); // false
```

#### isNotBlank

判断字符串是否不为空。

```dart
static bool isNotBlank(String? str)
```

#### capitalize

首字母大写。

```dart
static String capitalize(String str)
```

```dart
StringUtils.capitalize('hello'); // 'Hello'
```

#### camelToSnake

驼峰转下划线。

```dart
static String camelToSnake(String str)
```

```dart
StringUtils.camelToSnake('helloWorld'); // 'hello_world'
```

#### snakeToCamel

下划线转驼峰。

```dart
static String snakeToCamel(String str)
```

```dart
StringUtils.snakeToCamel('hello_world'); // 'helloWorld'
```

#### truncate

截断字符串。

```dart
static String truncate(String str, int maxLength, {String suffix = '...'})
```

```dart
StringUtils.truncate('Hello World', 8); // 'Hello...'
```

#### md5

计算 MD5 哈希。

```dart
static String md5(String str)
```

```dart
StringUtils.md5('hello'); // '5d41402abc4b2a76b9719d911017c592'
```

#### base64Encode

Base64 编码。

```dart
static String base64Encode(String str)
```

```dart
StringUtils.base64Encode('hello'); // 'aGVsbG8='
```

#### base64Decode

Base64 解码。

```dart
static String base64Decode(String str)
```

```dart
StringUtils.base64Decode('aGVsbG8='); // 'hello'
```

#### matches

正则匹配。

```dart
static bool matches(String str, String pattern)
```

```dart
StringUtils.matches('hello@example.com', r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'); // true
```

## ValidationUtils

数据验证工具。

### 方法

#### isEmail

验证邮箱格式。

```dart
static bool isEmail(String str)
```

```dart
ValidationUtils.isEmail('hello@example.com'); // true
ValidationUtils.isEmail('invalid-email');     // false
```

#### isPhone

验证手机号格式。

```dart
static bool isPhone(String str, {String countryCode = 'CN'})
```

```dart
ValidationUtils.isPhone('13800138000');           // true (中国)
ValidationUtils.isPhone('+1234567890', countryCode: 'US'); // true (美国)
```

#### isUrl

验证 URL 格式。

```dart
static bool isUrl(String str)
```

```dart
ValidationUtils.isUrl('https://example.com'); // true
ValidationUtils.isUrl('not-a-url');           // false
```

#### isNumeric

验证是否为数字。

```dart
static bool isNumeric(String str)
```

```dart
ValidationUtils.isNumeric('123');   // true
ValidationUtils.isNumeric('12.34'); // true
ValidationUtils.isNumeric('abc');   // false
```

#### isInteger

验证是否为整数。

```dart
static bool isInteger(String str)
```

```dart
ValidationUtils.isInteger('123');   // true
ValidationUtils.isInteger('12.34'); // false
```

#### isLengthInRange

验证字符串长度是否在范围内。

```dart
static bool isLengthInRange(String str, int min, int max)
```

```dart
ValidationUtils.isLengthInRange('hello', 1, 10); // true
ValidationUtils.isLengthInRange('hi', 5, 10);    // false
```

#### validate

使用自定义验证器验证。

```dart
static ValidationResult validate(dynamic value, List<Validator> validators)
```

```dart
final result = ValidationUtils.validate(
  'hello@example.com',
  [
    RequiredValidator(),
    EmailValidator(),
  ],
);

if (result.isValid) {
  print('验证通过');
} else {
  print('验证失败: ${result.errors}');
}
```

## StorageUtils

本地存储工具。

### 接口定义

```dart
abstract class StorageUtils {
  Future<bool> setString(String key, String value);
  Future<String?> getString(String key);
  Future<bool> setObject<T>(String key, T value, JsonEncoder<T> encoder);
  Future<T?> getObject<T>(String key, JsonDecoder<T> decoder);
  Future<bool> remove(String key);
  Future<bool> clear();
  Future<bool> containsKey(String key);
}
```

### PreferencesStorage

基于 SharedPreferences 的存储实现。

```dart
final storage = PreferencesStorage();

// 存储字符串
await storage.setString('username', 'John');

// 获取字符串
final username = await storage.getString('username');

// 存储对象
await storage.setObject('user', user, (u) => u.toJson());

// 获取对象
final user = await storage.getObject('user', User.fromJson);

// 删除
await storage.remove('username');

// 清空
await storage.clear();
```

### FileStorage

基于文件系统的存储实现。

```dart
final storage = FileStorage(directory: '/path/to/storage');

// 使用方式与 PreferencesStorage 相同
await storage.setString('data', 'value');
```

## 完整示例

```dart
import 'package:velocity_ui/velocity_ui.dart';

void main() async {
  // JSON 处理
  final user = {'name': 'John', 'age': 30};
  final json = JsonUtils.encode(user);
  final decoded = JsonUtils.decode(json);

  // 日期处理
  final now = DateTime.now();
  final formatted = DateTimeUtils.format(now, 'yyyy-MM-dd');
  final relative = DateTimeUtils.relativeTime(now.subtract(Duration(hours: 1)));

  // 字符串处理
  final encoded = StringUtils.base64Encode('hello');
  final decoded = StringUtils.base64Decode(encoded);
  final hash = StringUtils.md5('password');

  // 验证
  final isValidEmail = ValidationUtils.isEmail('test@example.com');
  final isValidPhone = ValidationUtils.isPhone('13800138000');

  // 存储
  final storage = PreferencesStorage();
  await storage.setString('token', 'abc123');
  final token = await storage.getString('token');
}
```
