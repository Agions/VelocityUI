# API 参考

VelocityUI 完整 API 文档，包括核心模块、工具类和类型定义。

## 模块概览

| 模块        | 说明                     | 文档                     |
| ----------- | ------------------------ | ------------------------ |
| HTTP 客户端 | 网络请求、拦截器、缓存   | [查看](/api/http-client) |
| 工具类      | JSON、日期、字符串、验证 | [查看](/api/utilities)   |
| 主题系统    | 颜色、排版、间距         | [查看](/api/theme)       |
| 类型定义    | 枚举、接口、类型         | [查看](/api/types)       |

## HTTP 客户端

企业级 HTTP 请求模块。

```dart
import 'package:velocity_ui/http.dart';

final client = VelocityHttpClient(
  baseUrl: 'https://api.example.com',
  timeout: const Duration(seconds: 30),
);

// GET 请求
final result = await client.get<User>('/users/1');
result.when(
  success: (user) => print(user.name),
  failure: (error) => print(error.message),
);

// POST 请求
final createResult = await client.post<User>(
  '/users',
  data: {'name': 'John', 'email': 'john@example.com'},
);
```

[查看完整文档 →](/api/http-client)

## 工具类

常用工具函数集合。

```dart
import 'package:velocity_ui/utils.dart';

// JSON 工具
final json = JsonUtils.encode(data);
final data = JsonUtils.decode<User>(json);

// 日期工具
final formatted = DateTimeUtils.format(DateTime.now(), 'yyyy-MM-dd');
final relative = DateTimeUtils.relative(DateTime.now());

// 字符串工具
final masked = StringUtils.maskPhone('13800138000'); // 138****8000
final truncated = StringUtils.truncate(text, 100);

// 验证工具
final isValid = ValidationUtils.isEmail('test@example.com');
final isPhone = ValidationUtils.isPhone('13800138000');
```

[查看完整文档 →](/api/utilities)

## 主题系统

完整的主题定制能力。

```dart
import 'package:velocity_ui/theme.dart';

// 获取主题
final theme = VelocityTheme.of(context);

// 使用颜色
Container(color: theme.primaryColor)

// 使用间距
Padding(padding: EdgeInsets.all(VelocitySpacing.md))

// 使用圆角
Container(
  decoration: BoxDecoration(
    borderRadius: VelocityRadius.md,
  ),
)
```

[查看完整文档 →](/api/theme)

## 类型定义

核心类型和枚举。

```dart
import 'package:velocity_ui/types.dart';

// 尺寸枚举
enum VelocitySize { small, medium, large }

// 状态枚举
enum VelocityState { normal, hover, active, disabled }

// 变体枚举
enum VelocityVariant { primary, secondary, outline, text }

// 结果类型
sealed class Result<T> {
  const Result();
}
class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}
class Failure<T> extends Result<T> {
  final VelocityError error;
  const Failure(this.error);
}
```

[查看完整文档 →](/api/types)

## 快速索引

### 核心类

| 类名                 | 说明         |
| -------------------- | ------------ |
| `VelocityApp`        | 应用根组件   |
| `VelocityTheme`      | 主题配置     |
| `VelocityHttpClient` | HTTP 客户端  |
| `Result<T>`          | 统一结果类型 |

### 工具类

| 类名              | 说明         |
| ----------------- | ------------ |
| `JsonUtils`       | JSON 序列化  |
| `DateTimeUtils`   | 日期时间处理 |
| `StringUtils`     | 字符串处理   |
| `ValidationUtils` | 数据验证     |
| `StorageUtils`    | 本地存储     |

### 枚举类型

| 枚举               | 说明     |
| ------------------ | -------- |
| `VelocitySize`     | 组件尺寸 |
| `VelocityState`    | 组件状态 |
| `VelocityVariant`  | 组件变体 |
| `VelocityPosition` | 位置定义 |
