/// 测试工具库
///
/// 提供测试中常用的工具函数和辅助方法
library test_utils;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// 测试主题配置
class TestTheme {
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF2196F3),
          secondary: Color(0xFF009688),
          surface: Color(0xFFFFFFFF),
          error: Color(0xFFF44336),
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF90CAF9),
          secondary: Color(0xFF80CBC4),
          surface: Color(0xFF121212),
          error: Color(0xFFEF5350),
        ),
      );
}

/// 测试设备尺寸配置
class TestDevices {
  static const iPhone13 = Size(390, 844);
  static const iPhone13Max = Size(428, 926);
  static const iPad = Size(768, 1024);
  static const desktop = Size(1920, 1080);
  static const smallMobile = Size(320, 568);
}

/// 测试工具类
class TestUtils {
  /// 创建测试用的Widget
  static Widget wrapWithMaterialApp(
    Widget widget, {
    ThemeData? theme,
    Widget? home,
    Map<String, Widget Function(BuildContext)>? routes,
    NavigatorObserver? navigatorObserver,
  }) {
    return MaterialApp(
      theme: theme ?? TestTheme.lightTheme,
      home: home ?? widget,
      routes: routes ?? {},
      navigatorObservers: navigatorObserver != null ? [navigatorObserver] : [],
    );
  }

  /// 包装Widget用于测试
  static Widget wrapWithMaterial(
    Widget widget, {
    ThemeData? theme,
    MaterialTapTargetSize? materialTapTargetSize,
  }) {
    return MaterialApp(
      theme: theme ?? TestTheme.lightTheme,
      home: Material(
        child: widget,
      ),
    );
  }

  /// 等待指定的持续时间
  static Future<void> wait(Duration duration) {
    return Future.delayed(duration);
  }

  /// 等待一帧
  static Future<void> pumpAndSettle(WidgetTester tester) {
    return tester.pumpAndSettle();
  }

  /// 查找并点击Widget
  static Future<void> tap(WidgetTester tester, Finder finder) async {
    await tester.tap(finder);
    await pumpAndSettle(tester);
  }

  /// 查找并输入文本
  static Future<void> enterText(
    WidgetTester tester,
    Finder finder,
    String text,
  ) async {
    await tester.enterText(finder, text);
    await pumpAndSettle(tester);
  }

  /// 验证Widget是否存在
  static bool exists(WidgetTester tester, Finder finder) {
    try {
      return finder.evaluate().isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// 获取Widget的文本内容
  static String getText(WidgetTester tester, Finder finder) {
    final widget = tester.widget<Text>(finder);
    return widget.data ?? '';
  }

  /// 验证Widget的文本内容
  static void expectText(WidgetTester tester, Finder finder, String expected) {
    expect(getText(tester, finder), expected);
  }

  /// 创建测试用的Scrollable Widget
  static Widget wrapWithScrollable(Widget widget) {
    return SingleChildScrollView(
      child: widget,
    );
  }

  /// 设置测试屏幕尺寸
  static void setScreenSize(WidgetTester tester, Size size) {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1.0;
  }

  /// 重置屏幕尺寸
  static void resetScreenSize(WidgetTester tester) {
    tester.view.physicalSize = const Size(800, 600);
    tester.view.devicePixelRatio = 1.0;
  }
}

/// 测试匹配器扩展
extension TestMatchers on WidgetTester {
  /// 查找包含特定文本的Widget
  Finder findText(String text) {
    return find.text(text);
  }

  /// 查找包含特定Key的Widget
  Finder findByKey(Key key) {
    return find.byKey(key);
  }

  /// 查找特定类型的Widget
  Finder findByType<T>() {
    return find.byType(T);
  }

  /// 查找包含特定图标的Widget
  Finder findByIcon(IconData icon) {
    return find.byIcon(icon);
  }

  /// 查找包含特定语义的Widget
  Finder findBySemanticsLabel(String label) {
    return find.bySemanticsLabel(label);
  }
}

/// 测试数据生成器
class TestData {
  /// 生成随机字符串
  static String randomString([int length = 10]) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(
          DateTime.now().millisecond % chars.length,
        ),
      ),
    );
  }

  /// 生成随机数字
  static int randomNumber([int min = 0, int max = 100]) {
    return min + (DateTime.now().millisecond % (max - min + 1));
  }

  /// 生成随机布尔值
  static bool randomBool() {
    return randomNumber(0, 1) == 1;
  }

  /// 生成随机颜色
  static Color randomColor() {
    return Color.fromARGB(
      255,
      randomNumber(0, 255),
      randomNumber(0, 255),
      randomNumber(0, 255),
    );
  }

  /// 生成测试用的颜色列表
  static List<Color> get testColors => [
        Colors.red,
        Colors.green,
        Colors.blue,
        Colors.yellow,
        Colors.purple,
        Colors.orange,
        Colors.cyan,
        Colors.pink,
      ];
}

/// 性能测试工具
class PerformanceTest {
  static Future<void> measureBuildTime(
    WidgetTester tester,
    Widget widget,
    String testName, {
    int warmupRuns = 3,
    int measuredRuns = 10,
  }) async {
    // 预热
    for (var i = 0; i < warmupRuns; i++) {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
    }

    // 测量
    final stopwatch = Stopwatch()..start();
    for (var i = 0; i < measuredRuns; i++) {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
    }
    stopwatch.stop();

    final averageTime = stopwatch.elapsedMilliseconds / measuredRuns;
    debugPrint('$testName: 平均构建时间 ${averageTime.toStringAsFixed(2)}ms');

    expect(averageTime, lessThan(16), reason: '$testName 构建时间过长');
  }
}

/// Property-based testing utilities
///
/// Provides generators and utilities for property-based testing with glados
class PropertyTestUtils {
  /// Default number of iterations for property tests
  static const int defaultIterations = 100;

  /// Verify that a property holds for all generated inputs
  static void verifyProperty<T>(
    String description,
    T Function() generator,
    bool Function(T) property, {
    int iterations = defaultIterations,
  }) {
    for (var i = 0; i < iterations; i++) {
      final input = generator();
      final result = property(input);
      if (!result) {
        throw TestFailure(
          'Property "$description" failed for input: $input (iteration $i)',
        );
      }
    }
  }

  /// Generate a random size enum value
  static T randomEnumValue<T>(List<T> values) {
    return values[DateTime.now().millisecond % values.length];
  }
}

/// Custom generators for VelocityUI types
class VelocityGenerators {
  /// Generate a random EdgeInsets
  static EdgeInsets randomEdgeInsets() {
    final value = TestData.randomNumber(0, 32).toDouble();
    return EdgeInsets.all(value);
  }

  /// Generate a random BorderRadius
  static BorderRadius randomBorderRadius() {
    final value = TestData.randomNumber(0, 24).toDouble();
    return BorderRadius.circular(value);
  }

  /// Generate a random Duration
  static Duration randomDuration() {
    return Duration(milliseconds: TestData.randomNumber(100, 500));
  }

  /// Generate a random BoxShadow
  static BoxShadow randomBoxShadow() {
    final color = TestData.randomColor();
    return BoxShadow(
      color: color.withValues(alpha: 0.2),
      blurRadius: TestData.randomNumber(0, 16).toDouble(),
      offset: Offset(
        TestData.randomNumber(-4, 4).toDouble(),
        TestData.randomNumber(-4, 4).toDouble(),
      ),
    );
  }
}
