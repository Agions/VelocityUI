# 类型定义

VelocityUI 的核心类型和枚举定义。

## VelocitySize

组件尺寸枚举。

```dart
enum VelocitySize {
  small,
  medium,
  large,
}
```

### 使用示例

```dart
VelocityButton(
  text: '按钮',
  size: VelocitySize.small,
)

VelocityInput(
  label: '输入框',
  size: VelocitySize.large,
)
```

### 尺寸对照

| 组件        | small | medium | large |
| ----------- | ----- | ------ | ----- |
| Button 高度 | 32px  | 40px   | 48px  |
| Input 高度  | 32px  | 40px   | 48px  |
| Icon 大小   | 16px  | 24px   | 32px  |

## VelocityButtonType

按钮类型枚举。

```dart
enum VelocityButtonType {
  primary,
  secondary,
  outlined,
  text,
  danger,
}
```

### 说明

| 类型        | 说明     | 使用场景               |
| ----------- | -------- | ---------------------- |
| `primary`   | 主要按钮 | 主要操作，如提交、确认 |
| `secondary` | 次要按钮 | 次要操作，如取消       |
| `outlined`  | 边框按钮 | 一般操作               |
| `text`      | 文字按钮 | 辅助操作，如链接       |
| `danger`    | 危险按钮 | 危险操作，如删除       |

## VelocityTextVariant

文本变体枚举。

```dart
enum VelocityTextVariant {
  h1,
  h2,
  h3,
  h4,
  h5,
  h6,
  body1,
  body2,
  caption,
  overline,
}
```

## VelocityCardVariant

卡片变体枚举。

```dart
enum VelocityCardVariant {
  elevated,
  outlined,
  filled,
}
```

### 说明

| 类型       | 说明           |
| ---------- | -------------- |
| `elevated` | 带阴影的卡片   |
| `outlined` | 带边框的卡片   |
| `filled`   | 填充背景的卡片 |

## ToastType

Toast 类型枚举。

```dart
enum ToastType {
  info,
  success,
  warning,
  error,
}
```

## ToastPosition

Toast 位置枚举。

```dart
enum ToastPosition {
  top,
  center,
  bottom,
}
```

## ToastDuration

Toast 时长枚举。

```dart
enum ToastDuration {
  short,   // 2秒
  normal,  // 3秒
  long,    // 5秒
}
```

## HttpMethod

HTTP 请求方法枚举。

```dart
enum HttpMethod {
  get,
  post,
  put,
  delete,
  patch,
  head,
  options,
}
```

## ComponentSize

组件尺寸类型定义。

```dart
class ComponentSize {
  final double width;
  final double height;
  final EdgeInsets padding;
  final double fontSize;
  final double iconSize;

  const ComponentSize({
    required this.width,
    required this.height,
    required this.padding,
    required this.fontSize,
    required this.iconSize,
  });

  static const small = ComponentSize(
    width: double.infinity,
    height: 32,
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    fontSize: 12,
    iconSize: 16,
  );

  static const medium = ComponentSize(
    width: double.infinity,
    height: 40,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    fontSize: 14,
    iconSize: 20,
  );

  static const large = ComponentSize(
    width: double.infinity,
    height: 48,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    fontSize: 16,
    iconSize: 24,
  );
}
```

## DisabledState

禁用状态类型定义。

```dart
class DisabledState {
  final bool isDisabled;
  final String? reason;

  const DisabledState({
    this.isDisabled = false,
    this.reason,
  });

  static const enabled = DisabledState(isDisabled: false);
  static const disabled = DisabledState(isDisabled: true);

  factory DisabledState.withReason(String reason) {
    return DisabledState(isDisabled: true, reason: reason);
  }
}
```

## ValidationResult

验证结果类型定义。

```dart
class ValidationResult {
  final bool isValid;
  final List<String> errors;

  const ValidationResult({
    required this.isValid,
    this.errors = const [],
  });

  static const valid = ValidationResult(isValid: true);

  factory ValidationResult.invalid(List<String> errors) {
    return ValidationResult(isValid: false, errors: errors);
  }
}
```

## SelectOption

选择器选项类型定义。

```dart
class SelectOption<T> {
  final String label;
  final T value;
  final bool disabled;
  final Widget? icon;

  const SelectOption({
    required this.label,
    required this.value,
    this.disabled = false,
    this.icon,
  });
}
```

## SelectGroup

选择器分组类型定义。

```dart
class SelectGroup<T> {
  final String label;
  final List<SelectOption<T>> options;

  const SelectGroup({
    required this.label,
    required this.options,
  });
}
```

## BreadcrumbItem

面包屑项类型定义。

```dart
class BreadcrumbItem {
  final String label;
  final VoidCallback? onTap;
  final IconData? icon;

  const BreadcrumbItem({
    required this.label,
    this.onTap,
    this.icon,
  });
}
```

## ToastAction

Toast 操作按钮类型定义。

```dart
class ToastAction {
  final String label;
  final VoidCallback onPressed;

  const ToastAction({
    required this.label,
    required this.onPressed,
  });
}
```

## 类型别名

```dart
/// JSON 编码器
typedef JsonEncoder<T> = Map<String, dynamic> Function(T value);

/// JSON 解码器
typedef JsonDecoder<T> = T Function(Map<String, dynamic> json);

/// 响应解析器
typedef ResponseParser<T> = T Function(dynamic json);

/// 加载状态回调
typedef LoadingStateCallback = void Function(bool isLoading);

/// 重试条件
typedef RetryCondition = bool Function(VelocityError error, int attempt);

/// 缓存键生成器
typedef CacheKeyGenerator = String Function(
  String url,
  HttpMethod method,
  Map<String, dynamic>? params,
);

/// 表单验证器
typedef FormFieldValidator<T> = String? Function(T? value);

/// 值变化回调
typedef ValueChanged<T> = void Function(T value);
```
