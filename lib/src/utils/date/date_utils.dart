/// VelocityUI 日期时间工具类
/// 提供日期格式化、解析、时间差计算、相对时间描述等功能
library velocity_date_utils;

/// 日期时间工具类
/// 提供常用的日期时间操作方法
class VelocityDateUtils {
  VelocityDateUtils._();

  /// 默认日期格式
  static const String defaultDateFormat = 'yyyy-MM-dd';

  /// 默认时间格式
  static const String defaultTimeFormat = 'HH:mm:ss';

  /// 默认日期时间格式
  static const String defaultDateTimeFormat = 'yyyy-MM-dd HH:mm:ss';

  /// 格式化日期时间
  ///
  /// [dateTime] 要格式化的日期时间
  /// [pattern] 格式化模式，支持以下占位符：
  ///   - yyyy: 四位年份
  ///   - yy: 两位年份
  ///   - MM: 两位月份 (01-12)
  ///   - M: 月份 (1-12)
  ///   - dd: 两位日期 (01-31)
  ///   - d: 日期 (1-31)
  ///   - HH: 24小时制小时 (00-23)
  ///   - H: 24小时制小时 (0-23)
  ///   - hh: 12小时制小时 (01-12)
  ///   - h: 12小时制小时 (1-12)
  ///   - mm: 分钟 (00-59)
  ///   - m: 分钟 (0-59)
  ///   - ss: 秒 (00-59)
  ///   - s: 秒 (0-59)
  ///   - SSS: 毫秒 (000-999)
  ///   - a: AM/PM
  ///
  /// 返回格式化后的字符串
  static String format(DateTime dateTime,
      [String pattern = defaultDateTimeFormat]) {
    var result = pattern;

    // 年份
    result =
        result.replaceAll('yyyy', dateTime.year.toString().padLeft(4, '0'));
    result = result.replaceAll(
        'yy', (dateTime.year % 100).toString().padLeft(2, '0'));

    // 月份
    result = result.replaceAll('MM', dateTime.month.toString().padLeft(2, '0'));
    result =
        result.replaceAll(RegExp(r'(?<!M)M(?!M)'), dateTime.month.toString());

    // 日期
    result = result.replaceAll('dd', dateTime.day.toString().padLeft(2, '0'));
    result =
        result.replaceAll(RegExp(r'(?<!d)d(?!d)'), dateTime.day.toString());

    // 24小时制小时
    result = result.replaceAll('HH', dateTime.hour.toString().padLeft(2, '0'));
    result =
        result.replaceAll(RegExp(r'(?<!H)H(?!H)'), dateTime.hour.toString());

    // 12小时制小时
    final hour12 = dateTime.hour == 0
        ? 12
        : (dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour);
    result = result.replaceAll('hh', hour12.toString().padLeft(2, '0'));
    result = result.replaceAll(RegExp(r'(?<!h)h(?!h)'), hour12.toString());

    // 分钟
    result =
        result.replaceAll('mm', dateTime.minute.toString().padLeft(2, '0'));
    result =
        result.replaceAll(RegExp(r'(?<!m)m(?!m)'), dateTime.minute.toString());

    // 秒
    result =
        result.replaceAll('ss', dateTime.second.toString().padLeft(2, '0'));
    result =
        result.replaceAll(RegExp(r'(?<!s)s(?!s)'), dateTime.second.toString());

    // 毫秒
    result = result.replaceAll(
        'SSS', dateTime.millisecond.toString().padLeft(3, '0'));

    // AM/PM
    result = result.replaceAll('a', dateTime.hour < 12 ? 'AM' : 'PM');

    return result;
  }

  /// 解析日期时间字符串
  ///
  /// [dateString] 要解析的日期时间字符串
  /// [pattern] 格式化模式，与 [format] 方法使用相同的占位符
  ///
  /// 返回解析后的 DateTime，如果解析失败返回 null
  static DateTime? parse(String dateString,
      [String pattern = defaultDateTimeFormat]) {
    try {
      return _parseWithPattern(dateString, pattern);
    } catch (_) {
      return null;
    }
  }

  /// 使用模式解析日期字符串
  static DateTime _parseWithPattern(String dateString, String pattern) {
    var year = 1970;
    var month = 1;
    var day = 1;
    var hour = 0;
    var minute = 0;
    var second = 0;
    var millisecond = 0;
    var isPM = false;
    var has12HourFormat = false;

    // 构建正则表达式并提取值
    var regexPattern = RegExp.escape(pattern);
    var workingPattern = pattern; // 用于跟踪已处理的占位符

    // 定义占位符及其对应的正则和处理
    final placeholders = <String, _PlaceholderInfo>{
      'yyyy': _PlaceholderInfo(r'(\d{4})', (v) => year = int.parse(v)),
      'yy': _PlaceholderInfo(r'(\d{2})', (v) {
        final y = int.parse(v);
        year = y < 70 ? 2000 + y : 1900 + y;
      }),
      'MM': _PlaceholderInfo(r'(\d{2})', (v) => month = int.parse(v)),
      'dd': _PlaceholderInfo(r'(\d{2})', (v) => day = int.parse(v)),
      'HH': _PlaceholderInfo(r'(\d{2})', (v) => hour = int.parse(v)),
      'hh': _PlaceholderInfo(r'(\d{2})', (v) {
        hour = int.parse(v);
        has12HourFormat = true;
      }),
      'mm': _PlaceholderInfo(r'(\d{2})', (v) => minute = int.parse(v)),
      'ss': _PlaceholderInfo(r'(\d{2})', (v) => second = int.parse(v)),
      'SSS': _PlaceholderInfo(r'(\d{3})', (v) => millisecond = int.parse(v)),
      'a': _PlaceholderInfo(r'(AM|PM)', (v) => isPM = v == 'PM'),
    };

    // 按长度排序，先处理长的占位符（避免 yyyy 被 yy 替换等问题）
    final sortedKeys = placeholders.keys.toList()
      ..sort((a, b) => b.length.compareTo(a.length));

    // 记录每个占位符在模式中的位置和处理器
    final placeholderMatches = <_PlaceholderMatch>[];

    for (final key in sortedKeys) {
      final info = placeholders[key]!;
      // 查找占位符在工作模式中的位置
      final position = workingPattern.indexOf(key);
      if (position != -1) {
        placeholderMatches.add(_PlaceholderMatch(
          position: position,
          key: key,
          handler: info.handler,
        ));
        // 用占位符替换已处理的部分，避免重复匹配（如 yyyy 中的 yy）
        workingPattern = workingPattern.replaceFirst(key, '\x00' * key.length);
        regexPattern = regexPattern.replaceFirst(key, info.regex);
      }
    }

    // 按位置排序处理器，确保按模式中出现的顺序调用
    placeholderMatches.sort((a, b) => a.position.compareTo(b.position));
    final handlers = placeholderMatches.map((m) => m.handler).toList();

    final regex = RegExp('^$regexPattern\$');
    final match = regex.firstMatch(dateString);

    if (match == null) {
      throw FormatException('Cannot parse date string: $dateString');
    }

    for (var i = 0; i < handlers.length; i++) {
      handlers[i](match.group(i + 1)!);
    }

    // 处理12小时制
    if (has12HourFormat && isPM && hour < 12) {
      hour += 12;
    } else if (has12HourFormat && !isPM && hour == 12) {
      hour = 0;
    }

    return DateTime(year, month, day, hour, minute, second, millisecond);
  }

  /// 计算两个日期时间之间的差值
  ///
  /// [from] 起始日期时间
  /// [to] 结束日期时间
  ///
  /// 返回时间差 Duration
  static Duration difference(DateTime from, DateTime to) {
    return to.difference(from);
  }

  /// 获取相对时间描述
  ///
  /// [dateTime] 要描述的日期时间
  /// [relativeTo] 相对于哪个时间，默认为当前时间
  /// [locale] 语言环境，支持 'zh' (中文) 和 'en' (英文)，默认为中文
  ///
  /// 返回相对时间描述字符串，如 "3分钟前"、"2小时后"
  static String relativeTime(
    DateTime dateTime, {
    DateTime? relativeTo,
    String locale = 'zh',
  }) {
    final now = relativeTo ?? DateTime.now();
    final diff = dateTime.difference(now);
    final absDiff = diff.abs();

    final isFuture = diff.isNegative == false && diff.inMicroseconds != 0;
    final isPast = diff.isNegative;

    // 获取本地化文本
    final texts = _getLocaleTexts(locale);

    String timeUnit;
    int value;

    if (absDiff.inSeconds < 60) {
      if (absDiff.inSeconds < 10) {
        return texts['justNow']!;
      }
      value = absDiff.inSeconds;
      timeUnit = texts['seconds']!;
    } else if (absDiff.inMinutes < 60) {
      value = absDiff.inMinutes;
      timeUnit = texts['minutes']!;
    } else if (absDiff.inHours < 24) {
      value = absDiff.inHours;
      timeUnit = texts['hours']!;
    } else if (absDiff.inDays < 30) {
      value = absDiff.inDays;
      timeUnit = texts['days']!;
    } else if (absDiff.inDays < 365) {
      value = (absDiff.inDays / 30).floor();
      timeUnit = texts['months']!;
    } else {
      value = (absDiff.inDays / 365).floor();
      timeUnit = texts['years']!;
    }

    if (isFuture) {
      return texts['future']!
          .replaceAll('{value}', '$value')
          .replaceAll('{unit}', timeUnit);
    } else if (isPast) {
      return texts['past']!
          .replaceAll('{value}', '$value')
          .replaceAll('{unit}', timeUnit);
    } else {
      return texts['justNow']!;
    }
  }

  /// 获取本地化文本
  static Map<String, String> _getLocaleTexts(String locale) {
    switch (locale) {
      case 'en':
        return {
          'justNow': 'just now',
          'seconds': 'seconds',
          'minutes': 'minutes',
          'hours': 'hours',
          'days': 'days',
          'months': 'months',
          'years': 'years',
          'past': '{value} {unit} ago',
          'future': 'in {value} {unit}',
        };
      case 'zh':
      default:
        return {
          'justNow': '刚刚',
          'seconds': '秒',
          'minutes': '分钟',
          'hours': '小时',
          'days': '天',
          'months': '个月',
          'years': '年',
          'past': '{value}{unit}前',
          'future': '{value}{unit}后',
        };
    }
  }

  /// 时区转换
  ///
  /// [dateTime] 要转换的日期时间
  /// [timezone] 目标时区，格式为 UTC 偏移量，如 '+08:00', '-05:00', 'UTC'
  ///
  /// 返回转换后的日期时间
  static DateTime toTimezone(DateTime dateTime, String timezone) {
    final offset = _parseTimezoneOffset(timezone);
    final utcDateTime = dateTime.toUtc();
    return utcDateTime.add(offset);
  }

  /// 解析时区偏移量
  static Duration _parseTimezoneOffset(String timezone) {
    if (timezone.toUpperCase() == 'UTC' || timezone == 'Z') {
      return Duration.zero;
    }

    final regex = RegExp(r'^([+-])(\d{2}):?(\d{2})$');
    final match = regex.firstMatch(timezone);

    if (match == null) {
      throw ArgumentError(
          'Invalid timezone format: $timezone. Expected format: +HH:MM or -HH:MM');
    }

    final sign = match.group(1) == '+' ? 1 : -1;
    final hours = int.parse(match.group(2)!);
    final minutes = int.parse(match.group(3)!);

    return Duration(hours: sign * hours, minutes: sign * minutes);
  }

  /// 判断两个日期是否为同一天
  ///
  /// [a] 第一个日期
  /// [b] 第二个日期
  ///
  /// 返回是否为同一天
  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  /// 判断两个日期是否为同一月
  ///
  /// [a] 第一个日期
  /// [b] 第二个日期
  ///
  /// 返回是否为同一月
  static bool isSameMonth(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month;
  }

  /// 判断两个日期是否为同一年
  ///
  /// [a] 第一个日期
  /// [b] 第二个日期
  ///
  /// 返回是否为同一年
  static bool isSameYear(DateTime a, DateTime b) {
    return a.year == b.year;
  }

  /// 获取某月的第一天
  ///
  /// [dateTime] 日期时间
  ///
  /// 返回该月第一天的日期时间
  static DateTime firstDayOfMonth(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, 1);
  }

  /// 获取某月的最后一天
  ///
  /// [dateTime] 日期时间
  ///
  /// 返回该月最后一天的日期时间
  static DateTime lastDayOfMonth(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month + 1, 0);
  }

  /// 获取某周的第一天（周一）
  ///
  /// [dateTime] 日期时间
  ///
  /// 返回该周第一天（周一）的日期时间
  static DateTime firstDayOfWeek(DateTime dateTime) {
    final weekday = dateTime.weekday;
    return DateTime(dateTime.year, dateTime.month, dateTime.day - weekday + 1);
  }

  /// 获取某周的最后一天（周日）
  ///
  /// [dateTime] 日期时间
  ///
  /// 返回该周最后一天（周日）的日期时间
  static DateTime lastDayOfWeek(DateTime dateTime) {
    final weekday = dateTime.weekday;
    return DateTime(
        dateTime.year, dateTime.month, dateTime.day + (7 - weekday));
  }

  /// 判断是否为闰年
  ///
  /// [year] 年份
  ///
  /// 返回是否为闰年
  static bool isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  /// 获取某月的天数
  ///
  /// [year] 年份
  /// [month] 月份
  ///
  /// 返回该月的天数
  static int daysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  /// 添加天数
  ///
  /// [dateTime] 日期时间
  /// [days] 要添加的天数（可为负数）
  ///
  /// 返回添加后的日期时间
  static DateTime addDays(DateTime dateTime, int days) {
    return dateTime.add(Duration(days: days));
  }

  /// 添加月份
  ///
  /// [dateTime] 日期时间
  /// [months] 要添加的月份数（可为负数）
  ///
  /// 返回添加后的日期时间
  static DateTime addMonths(DateTime dateTime, int months) {
    var newYear = dateTime.year;
    var newMonth = dateTime.month + months;

    while (newMonth > 12) {
      newMonth -= 12;
      newYear++;
    }
    while (newMonth < 1) {
      newMonth += 12;
      newYear--;
    }

    final maxDay = daysInMonth(newYear, newMonth);
    final newDay = dateTime.day > maxDay ? maxDay : dateTime.day;

    return DateTime(
      newYear,
      newMonth,
      newDay,
      dateTime.hour,
      dateTime.minute,
      dateTime.second,
      dateTime.millisecond,
      dateTime.microsecond,
    );
  }

  /// 添加年份
  ///
  /// [dateTime] 日期时间
  /// [years] 要添加的年份数（可为负数）
  ///
  /// 返回添加后的日期时间
  static DateTime addYears(DateTime dateTime, int years) {
    return addMonths(dateTime, years * 12);
  }

  /// 判断日期是否在指定范围内
  ///
  /// [dateTime] 要判断的日期时间
  /// [start] 范围起始日期
  /// [end] 范围结束日期
  /// [inclusive] 是否包含边界，默认为 true
  ///
  /// 返回是否在范围内
  static bool isInRange(
    DateTime dateTime,
    DateTime start,
    DateTime end, {
    bool inclusive = true,
  }) {
    if (inclusive) {
      return !dateTime.isBefore(start) && !dateTime.isAfter(end);
    } else {
      return dateTime.isAfter(start) && dateTime.isBefore(end);
    }
  }

  /// 获取两个日期之间的天数差
  ///
  /// [from] 起始日期
  /// [to] 结束日期
  ///
  /// 返回天数差（忽略时间部分）
  static int daysBetween(DateTime from, DateTime to) {
    final fromDate = DateTime(from.year, from.month, from.day);
    final toDate = DateTime(to.year, to.month, to.day);
    return toDate.difference(fromDate).inDays;
  }

  /// 获取星期几的名称
  ///
  /// [weekday] 星期几 (1-7, 1=周一)
  /// [locale] 语言环境，支持 'zh' (中文) 和 'en' (英文)
  /// [short] 是否使用简写
  ///
  /// 返回星期几的名称
  static String weekdayName(int weekday,
      {String locale = 'zh', bool short = false}) {
    if (weekday < 1 || weekday > 7) {
      throw ArgumentError('Weekday must be between 1 and 7');
    }

    final names = locale == 'en'
        ? (short
            ? ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
            : [
                'Monday',
                'Tuesday',
                'Wednesday',
                'Thursday',
                'Friday',
                'Saturday',
                'Sunday'
              ])
        : (short
            ? ['周一', '周二', '周三', '周四', '周五', '周六', '周日']
            : ['星期一', '星期二', '星期三', '星期四', '星期五', '星期六', '星期日']);

    return names[weekday - 1];
  }

  /// 获取月份名称
  ///
  /// [month] 月份 (1-12)
  /// [locale] 语言环境，支持 'zh' (中文) 和 'en' (英文)
  /// [short] 是否使用简写
  ///
  /// 返回月份名称
  static String monthName(int month,
      {String locale = 'zh', bool short = false}) {
    if (month < 1 || month > 12) {
      throw ArgumentError('Month must be between 1 and 12');
    }

    final names = locale == 'en'
        ? (short
            ? [
                'Jan',
                'Feb',
                'Mar',
                'Apr',
                'May',
                'Jun',
                'Jul',
                'Aug',
                'Sep',
                'Oct',
                'Nov',
                'Dec'
              ]
            : [
                'January',
                'February',
                'March',
                'April',
                'May',
                'June',
                'July',
                'August',
                'September',
                'October',
                'November',
                'December'
              ])
        : (short
            ? [
                '1月',
                '2月',
                '3月',
                '4月',
                '5月',
                '6月',
                '7月',
                '8月',
                '9月',
                '10月',
                '11月',
                '12月'
              ]
            : [
                '一月',
                '二月',
                '三月',
                '四月',
                '五月',
                '六月',
                '七月',
                '八月',
                '九月',
                '十月',
                '十一月',
                '十二月'
              ]);

    return names[month - 1];
  }
}

/// 占位符信息
class _PlaceholderInfo {
  _PlaceholderInfo(this.regex, this.handler);

  final String regex;
  final void Function(String) handler;
}

/// 占位符匹配信息
class _PlaceholderMatch {
  _PlaceholderMatch({
    required this.position,
    required this.key,
    required this.handler,
  });

  final int position;
  final String key;
  final void Function(String) handler;
}
