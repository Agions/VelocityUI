/// VelocityUI 数据验证工具类
/// 提供邮箱、手机号、URL、数字、长度验证及自定义验证器接口
library velocity_validation_utils;

/// 验证结果
/// 包含验证是否通过及错误信息
class ValidationResult {
  /// 创建验证结果
  const ValidationResult({
    required this.isValid,
    this.errorMessage,
    this.errorCode,
  });

  /// 创建成功的验证结果
  const ValidationResult.success()
      : isValid = true,
        errorMessage = null,
        errorCode = null;

  /// 创建失败的验证结果
  const ValidationResult.failure(String message, [String? code])
      : isValid = false,
        errorMessage = message,
        errorCode = code;

  /// 验证是否通过
  final bool isValid;

  /// 错误消息
  final String? errorMessage;

  /// 错误代码
  final String? errorCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ValidationResult &&
          runtimeType == other.runtimeType &&
          isValid == other.isValid &&
          errorMessage == other.errorMessage &&
          errorCode == other.errorCode;

  @override
  int get hashCode => Object.hash(isValid, errorMessage, errorCode);

  @override
  String toString() => isValid
      ? 'ValidationResult.success()'
      : 'ValidationResult.failure($errorMessage, $errorCode)';
}

/// 验证器接口
/// 用于实现自定义验证逻辑
abstract class Validator<T> {
  /// 创建验证器
  const Validator();

  /// 验证值
  ValidationResult validate(T value);
}

/// 数据验证工具类
/// 提供常用的数据验证方法
class ValidationUtils {
  // 私有构造函数，防止实例化
  ValidationUtils._();

  // ==================== 正则表达式常量 ====================

  /// 邮箱正则表达式
  /// 支持标准邮箱格式，如 user@example.com
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    caseSensitive: false,
  );

  /// URL 正则表达式
  /// 支持 http/https 协议的 URL
  static final RegExp _urlRegex = RegExp(
    r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    caseSensitive: false,
  );

  /// 中国大陆手机号正则表达式
  /// 支持 13x, 14x, 15x, 16x, 17x, 18x, 19x 开头的 11 位手机号
  static final RegExp _cnPhoneRegex = RegExp(r'^1[3-9]\d{9}$');

  /// 美国手机号正则表达式
  /// 支持 xxx-xxx-xxxx 或 xxxxxxxxxx 格式
  static final RegExp _usPhoneRegex = RegExp(
    r'^(\+1)?[\s.-]?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$',
  );

  /// 国际手机号正则表达式
  /// 支持 +国家代码 格式
  static final RegExp _internationalPhoneRegex = RegExp(
    r'^\+?[1-9]\d{1,14}$',
  );

  /// 数字正则表达式（包括小数和负数）
  static final RegExp _numericRegex = RegExp(r'^-?\d+\.?\d*$');

  /// 整数正则表达式（包括负数）
  static final RegExp _integerRegex = RegExp(r'^-?\d+$');

  /// 正整数正则表达式
  static final RegExp _positiveIntegerRegex = RegExp(r'^\d+$');

  /// 身份证号正则表达式（中国大陆 18 位）
  static final RegExp _cnIdCardRegex = RegExp(
    r'^[1-9]\d{5}(18|19|20)\d{2}(0[1-9]|1[0-2])(0[1-9]|[12]\d|3[01])\d{3}[\dXx]$',
  );

  /// IPv4 地址正则表达式
  static final RegExp _ipv4Regex = RegExp(
    r'^((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$',
  );

  // ==================== 邮箱验证 ====================

  /// 验证邮箱格式
  ///
  /// [str] 要验证的字符串
  /// 返回 true 如果是有效的邮箱格式
  ///
  /// 示例:
  /// ```dart
  /// ValidationUtils.isEmail('user@example.com');  // true
  /// ValidationUtils.isEmail('invalid-email');     // false
  /// ```
  static bool isEmail(String str) {
    if (str.isEmpty) return false;
    return _emailRegex.hasMatch(str);
  }

  /// 验证邮箱并返回详细结果
  ///
  /// [str] 要验证的字符串
  /// 返回 ValidationResult 包含验证结果和错误信息
  static ValidationResult validateEmail(String str) {
    if (str.isEmpty) {
      return const ValidationResult.failure('邮箱不能为空', 'EMAIL_EMPTY');
    }
    if (!_emailRegex.hasMatch(str)) {
      return const ValidationResult.failure('邮箱格式不正确', 'EMAIL_INVALID');
    }
    return const ValidationResult.success();
  }

  // ==================== 手机号验证 ====================

  /// 验证手机号格式
  ///
  /// [str] 要验证的字符串
  /// [countryCode] 国家代码，默认为 'CN'（中国大陆）
  /// 支持的国家代码: CN（中国）, US（美国）, INTL（国际格式）
  /// 返回 true 如果是有效的手机号格式
  ///
  /// 示例:
  /// ```dart
  /// ValidationUtils.isPhone('13812345678');                    // true (CN)
  /// ValidationUtils.isPhone('123-456-7890', countryCode: 'US'); // true (US)
  /// ValidationUtils.isPhone('+8613812345678', countryCode: 'INTL'); // true
  /// ```
  static bool isPhone(String str, {String countryCode = 'CN'}) {
    if (str.isEmpty) return false;

    switch (countryCode.toUpperCase()) {
      case 'CN':
        return _cnPhoneRegex.hasMatch(str);
      case 'US':
        return _usPhoneRegex.hasMatch(str);
      case 'INTL':
        return _internationalPhoneRegex.hasMatch(str);
      default:
        // 默认使用国际格式验证
        return _internationalPhoneRegex.hasMatch(str);
    }
  }

  /// 验证手机号并返回详细结果
  ///
  /// [str] 要验证的字符串
  /// [countryCode] 国家代码，默认为 'CN'
  /// 返回 ValidationResult 包含验证结果和错误信息
  static ValidationResult validatePhone(String str,
      {String countryCode = 'CN'}) {
    if (str.isEmpty) {
      return const ValidationResult.failure('手机号不能为空', 'PHONE_EMPTY');
    }
    if (!isPhone(str, countryCode: countryCode)) {
      return ValidationResult.failure(
        '手机号格式不正确 (国家代码: $countryCode)',
        'PHONE_INVALID',
      );
    }
    return const ValidationResult.success();
  }

  // ==================== URL 验证 ====================

  /// 验证 URL 格式
  ///
  /// [str] 要验证的字符串
  /// 返回 true 如果是有效的 URL 格式
  ///
  /// 示例:
  /// ```dart
  /// ValidationUtils.isUrl('https://example.com');       // true
  /// ValidationUtils.isUrl('http://www.example.com/path'); // true
  /// ValidationUtils.isUrl('invalid-url');               // false
  /// ```
  static bool isUrl(String str) {
    if (str.isEmpty) return false;
    return _urlRegex.hasMatch(str);
  }

  /// 验证 URL 并返回详细结果
  ///
  /// [str] 要验证的字符串
  /// 返回 ValidationResult 包含验证结果和错误信息
  static ValidationResult validateUrl(String str) {
    if (str.isEmpty) {
      return const ValidationResult.failure('URL 不能为空', 'URL_EMPTY');
    }
    if (!_urlRegex.hasMatch(str)) {
      return const ValidationResult.failure('URL 格式不正确', 'URL_INVALID');
    }
    return const ValidationResult.success();
  }

  // ==================== 数字验证 ====================

  /// 验证是否为数字（包括小数和负数）
  ///
  /// [str] 要验证的字符串
  /// 返回 true 如果是有效的数字格式
  ///
  /// 示例:
  /// ```dart
  /// ValidationUtils.isNumeric('123');     // true
  /// ValidationUtils.isNumeric('-123.45'); // true
  /// ValidationUtils.isNumeric('abc');     // false
  /// ```
  static bool isNumeric(String str) {
    if (str.isEmpty) return false;
    return _numericRegex.hasMatch(str);
  }

  /// 验证是否为整数（包括负数）
  ///
  /// [str] 要验证的字符串
  /// 返回 true 如果是有效的整数格式
  ///
  /// 示例:
  /// ```dart
  /// ValidationUtils.isInteger('123');   // true
  /// ValidationUtils.isInteger('-123');  // true
  /// ValidationUtils.isInteger('123.45'); // false
  /// ```
  static bool isInteger(String str) {
    if (str.isEmpty) return false;
    return _integerRegex.hasMatch(str);
  }

  /// 验证是否为正整数
  ///
  /// [str] 要验证的字符串
  /// 返回 true 如果是有效的正整数格式
  ///
  /// 示例:
  /// ```dart
  /// ValidationUtils.isPositiveInteger('123');  // true
  /// ValidationUtils.isPositiveInteger('-123'); // false
  /// ValidationUtils.isPositiveInteger('0');    // true
  /// ```
  static bool isPositiveInteger(String str) {
    if (str.isEmpty) return false;
    return _positiveIntegerRegex.hasMatch(str);
  }

  /// 验证数字并返回详细结果
  ///
  /// [str] 要验证的字符串
  /// 返回 ValidationResult 包含验证结果和错误信息
  static ValidationResult validateNumeric(String str) {
    if (str.isEmpty) {
      return const ValidationResult.failure('数字不能为空', 'NUMERIC_EMPTY');
    }
    if (!_numericRegex.hasMatch(str)) {
      return const ValidationResult.failure('不是有效的数字格式', 'NUMERIC_INVALID');
    }
    return const ValidationResult.success();
  }

  // ==================== 长度验证 ====================

  /// 验证字符串长度是否在指定范围内
  ///
  /// [str] 要验证的字符串
  /// [min] 最小长度
  /// [max] 最大长度
  /// 返回 true 如果长度在范围内
  ///
  /// 示例:
  /// ```dart
  /// ValidationUtils.isLengthInRange('hello', 1, 10);  // true
  /// ValidationUtils.isLengthInRange('hi', 5, 10);     // false
  /// ```
  static bool isLengthInRange(String str, int min, int max) {
    final length = str.length;
    return length >= min && length <= max;
  }

  /// 验证字符串长度并返回详细结果
  ///
  /// [str] 要验证的字符串
  /// [min] 最小长度
  /// [max] 最大长度
  /// 返回 ValidationResult 包含验证结果和错误信息
  static ValidationResult validateLength(String str, int min, int max) {
    if (min < 0 || max < 0) {
      return const ValidationResult.failure(
        '长度范围参数无效',
        'LENGTH_PARAMS_INVALID',
      );
    }
    if (min > max) {
      return const ValidationResult.failure(
        '最小长度不能大于最大长度',
        'LENGTH_RANGE_INVALID',
      );
    }
    final length = str.length;
    if (length < min) {
      return ValidationResult.failure(
        '长度不能小于 $min 个字符',
        'LENGTH_TOO_SHORT',
      );
    }
    if (length > max) {
      return ValidationResult.failure(
        '长度不能大于 $max 个字符',
        'LENGTH_TOO_LONG',
      );
    }
    return const ValidationResult.success();
  }

  // ==================== 其他验证方法 ====================

  /// 验证中国大陆身份证号
  ///
  /// [str] 要验证的字符串
  /// 返回 true 如果是有效的 18 位身份证号格式
  ///
  /// 示例:
  /// ```dart
  /// ValidationUtils.isIdCard('110101199003077758');  // true (格式正确)
  /// ValidationUtils.isIdCard('123456789012345678');  // false
  /// ```
  static bool isIdCard(String str) {
    if (str.isEmpty) return false;
    if (!_cnIdCardRegex.hasMatch(str)) return false;

    // 验证校验码
    return _validateIdCardChecksum(str);
  }

  /// 验证 IPv4 地址
  ///
  /// [str] 要验证的字符串
  /// 返回 true 如果是有效的 IPv4 地址格式
  ///
  /// 示例:
  /// ```dart
  /// ValidationUtils.isIPv4('192.168.1.1');   // true
  /// ValidationUtils.isIPv4('256.1.1.1');     // false
  /// ```
  static bool isIPv4(String str) {
    if (str.isEmpty) return false;
    return _ipv4Regex.hasMatch(str);
  }

  /// 验证是否为空或空白
  ///
  /// [str] 要验证的字符串
  /// 返回 true 如果字符串为 null、空字符串或仅包含空白字符
  static bool isBlank(String? str) {
    return str == null || str.trim().isEmpty;
  }

  /// 验证是否不为空
  ///
  /// [str] 要验证的字符串
  /// 返回 true 如果字符串不为 null 且包含非空白字符
  static bool isNotBlank(String? str) {
    return !isBlank(str);
  }

  // ==================== 自定义验证 ====================

  /// 使用验证器列表验证值
  ///
  /// [value] 要验证的值
  /// [validators] 验证器列表
  /// 返回第一个失败的验证结果，如果全部通过则返回成功
  ///
  /// 示例:
  /// ```dart
  /// final result = ValidationUtils.validate(
  ///   'test@example.com',
  ///   [RequiredValidator(), EmailValidator()],
  /// );
  /// ```
  static ValidationResult validate<T>(T value, List<Validator<T>> validators) {
    for (final validator in validators) {
      final result = validator.validate(value);
      if (!result.isValid) {
        return result;
      }
    }
    return const ValidationResult.success();
  }

  /// 使用验证器列表验证值，返回所有错误
  ///
  /// [value] 要验证的值
  /// [validators] 验证器列表
  /// 返回所有失败的验证结果列表
  static List<ValidationResult> validateAll<T>(
      T value, List<Validator<T>> validators) {
    final errors = <ValidationResult>[];
    for (final validator in validators) {
      final result = validator.validate(value);
      if (!result.isValid) {
        errors.add(result);
      }
    }
    return errors;
  }

  // ==================== 私有辅助方法 ====================

  /// 验证身份证校验码
  static bool _validateIdCardChecksum(String idCard) {
    if (idCard.length != 18) return false;

    // 加权因子
    const weights = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2];
    // 校验码对应值
    const checkCodes = ['1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2'];

    var sum = 0;
    for (var i = 0; i < 17; i++) {
      final digit = int.tryParse(idCard[i]);
      if (digit == null) return false;
      sum += digit * weights[i];
    }

    final checkCode = checkCodes[sum % 11];
    return idCard[17].toUpperCase() == checkCode;
  }
}

// ==================== 内置验证器 ====================

/// 必填验证器
class RequiredValidator extends Validator<String?> {
  /// 创建必填验证器
  const RequiredValidator({this.message = '此字段为必填项'});

  /// 错误消息
  final String message;

  @override
  ValidationResult validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return ValidationResult.failure(message, 'REQUIRED');
    }
    return const ValidationResult.success();
  }
}

/// 邮箱验证器
class EmailValidator extends Validator<String> {
  /// 创建邮箱验证器
  const EmailValidator({this.message = '邮箱格式不正确'});

  /// 错误消息
  final String message;

  @override
  ValidationResult validate(String value) {
    if (!ValidationUtils.isEmail(value)) {
      return ValidationResult.failure(message, 'EMAIL_INVALID');
    }
    return const ValidationResult.success();
  }
}

/// 手机号验证器
class PhoneValidator extends Validator<String> {
  /// 创建手机号验证器
  const PhoneValidator({
    this.countryCode = 'CN',
    this.message = '手机号格式不正确',
  });

  /// 国家代码
  final String countryCode;

  /// 错误消息
  final String message;

  @override
  ValidationResult validate(String value) {
    if (!ValidationUtils.isPhone(value, countryCode: countryCode)) {
      return ValidationResult.failure(message, 'PHONE_INVALID');
    }
    return const ValidationResult.success();
  }
}

/// URL 验证器
class UrlValidator extends Validator<String> {
  /// 创建 URL 验证器
  const UrlValidator({this.message = 'URL 格式不正确'});

  /// 错误消息
  final String message;

  @override
  ValidationResult validate(String value) {
    if (!ValidationUtils.isUrl(value)) {
      return ValidationResult.failure(message, 'URL_INVALID');
    }
    return const ValidationResult.success();
  }
}

/// 长度验证器
class LengthValidator extends Validator<String> {
  /// 创建长度验证器
  const LengthValidator({
    required this.min,
    required this.max,
    this.minMessage,
    this.maxMessage,
  });

  /// 最小长度
  final int min;

  /// 最大长度
  final int max;

  /// 最小长度错误消息
  final String? minMessage;

  /// 最大长度错误消息
  final String? maxMessage;

  @override
  ValidationResult validate(String value) {
    if (value.length < min) {
      return ValidationResult.failure(
        minMessage ?? '长度不能小于 $min 个字符',
        'LENGTH_TOO_SHORT',
      );
    }
    if (value.length > max) {
      return ValidationResult.failure(
        maxMessage ?? '长度不能大于 $max 个字符',
        'LENGTH_TOO_LONG',
      );
    }
    return const ValidationResult.success();
  }
}

/// 数字验证器
class NumericValidator extends Validator<String> {
  /// 创建数字验证器
  const NumericValidator({this.message = '请输入有效的数字'});

  /// 错误消息
  final String message;

  @override
  ValidationResult validate(String value) {
    if (!ValidationUtils.isNumeric(value)) {
      return ValidationResult.failure(message, 'NUMERIC_INVALID');
    }
    return const ValidationResult.success();
  }
}

/// 整数验证器
class IntegerValidator extends Validator<String> {
  /// 创建整数验证器
  const IntegerValidator({this.message = '请输入有效的整数'});

  /// 错误消息
  final String message;

  @override
  ValidationResult validate(String value) {
    if (!ValidationUtils.isInteger(value)) {
      return ValidationResult.failure(message, 'INTEGER_INVALID');
    }
    return const ValidationResult.success();
  }
}

/// 正则表达式验证器
class PatternValidator extends Validator<String> {
  /// 创建正则表达式验证器
  const PatternValidator({
    required this.pattern,
    this.message = '格式不正确',
  });

  /// 正则表达式模式
  final String pattern;

  /// 错误消息
  final String message;

  @override
  ValidationResult validate(String value) {
    if (!RegExp(pattern).hasMatch(value)) {
      return ValidationResult.failure(message, 'PATTERN_MISMATCH');
    }
    return const ValidationResult.success();
  }
}

/// 范围验证器（数值范围）
class RangeValidator extends Validator<num> {
  /// 创建范围验证器
  const RangeValidator({
    this.min,
    this.max,
    this.minMessage,
    this.maxMessage,
  });

  /// 最小值
  final num? min;

  /// 最大值
  final num? max;

  /// 最小值错误消息
  final String? minMessage;

  /// 最大值错误消息
  final String? maxMessage;

  @override
  ValidationResult validate(num value) {
    if (min != null && value < min!) {
      return ValidationResult.failure(
        minMessage ?? '值不能小于 $min',
        'VALUE_TOO_SMALL',
      );
    }
    if (max != null && value > max!) {
      return ValidationResult.failure(
        maxMessage ?? '值不能大于 $max',
        'VALUE_TOO_LARGE',
      );
    }
    return const ValidationResult.success();
  }
}

/// 自定义验证器
/// 允许使用函数进行验证
class CustomValidator<T> extends Validator<T> {
  /// 创建自定义验证器
  const CustomValidator({
    required this.validateFn,
    this.message = '验证失败',
    this.errorCode = 'CUSTOM_VALIDATION_FAILED',
  });

  /// 验证函数
  final bool Function(T value) validateFn;

  /// 错误消息
  final String message;

  /// 错误代码
  final String errorCode;

  @override
  ValidationResult validate(T value) {
    if (!validateFn(value)) {
      return ValidationResult.failure(message, errorCode);
    }
    return const ValidationResult.success();
  }
}
