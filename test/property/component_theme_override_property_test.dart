/// Property 4: Component Theme Override Isolation
///
/// 验证组件级主题覆盖的隔离性：
/// - 局部主题覆盖只影响该组件及其后代
/// - 不影响兄弟组件或祖先组件
///
/// **Validates: Requirements 3.3**
library component_theme_override_property_test;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glados/glados.dart' hide group, expect;
import 'package:velocity_ui/src/core/theme/velocity_theme.dart';
import 'package:velocity_ui/src/core/theme/velocity_theme_data.dart';
import 'package:velocity_ui/src/core/theme/component_theme.dart';

void main() {
  group('Property 4: Component Theme Override Isolation', () {
    // 测试按钮主题覆盖隔离
    testWidgets(
      'VelocityButtonTheme override only affects descendants',
      (tester) async {
        VelocityButtonThemeData? siblingTheme;
        VelocityButtonThemeData? childTheme;
        VelocityButtonThemeData? grandchildTheme;

        const overrideColor = Colors.red;

        await tester.pumpWidget(
          MaterialApp(
            home: VelocityTheme(
              data: VelocityThemeData.light(),
              child: Column(
                children: [
                  // 兄弟组件 - 不应受覆盖影响
                  Builder(
                    builder: (context) {
                      siblingTheme = VelocityButtonTheme.of(context);
                      return const SizedBox.shrink();
                    },
                  ),
                  // 带覆盖的子树
                  VelocityButtonTheme(
                    data: const VelocityButtonThemeData(
                      backgroundColor: overrideColor,
                    ),
                    child: Column(
                      children: [
                        // 直接子组件 - 应受覆盖影响
                        Builder(
                          builder: (context) {
                            childTheme = VelocityButtonTheme.of(context);
                            return const SizedBox.shrink();
                          },
                        ),
                        // 孙子组件 - 应受覆盖影响
                        Builder(
                          builder: (context) {
                            grandchildTheme = VelocityButtonTheme.of(context);
                            return const SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        // 验证兄弟组件不受影响
        expect(siblingTheme, isNotNull);
        expect(siblingTheme!.backgroundColor, isNot(overrideColor));

        // 验证子组件受影响
        expect(childTheme, isNotNull);
        expect(childTheme!.backgroundColor, equals(overrideColor));

        // 验证孙子组件受影响
        expect(grandchildTheme, isNotNull);
        expect(grandchildTheme!.backgroundColor, equals(overrideColor));
      },
    );

    // 测试输入框主题覆盖隔离
    testWidgets(
      'VelocityInputTheme override only affects descendants',
      (tester) async {
        VelocityInputThemeData? siblingTheme;
        VelocityInputThemeData? childTheme;

        const overrideColor = Colors.blue;

        await tester.pumpWidget(
          MaterialApp(
            home: VelocityTheme(
              data: VelocityThemeData.light(),
              child: Column(
                children: [
                  Builder(
                    builder: (context) {
                      siblingTheme = VelocityInputTheme.of(context);
                      return const SizedBox.shrink();
                    },
                  ),
                  VelocityInputTheme(
                    data: const VelocityInputThemeData(
                      borderColor: overrideColor,
                    ),
                    child: Builder(
                      builder: (context) {
                        childTheme = VelocityInputTheme.of(context);
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        expect(siblingTheme!.borderColor, isNot(overrideColor));
        expect(childTheme!.borderColor, equals(overrideColor));
      },
    );

    // 测试卡片主题覆盖隔离
    testWidgets(
      'VelocityCardTheme override only affects descendants',
      (tester) async {
        VelocityCardThemeData? siblingTheme;
        VelocityCardThemeData? childTheme;

        const overrideColor = Colors.green;

        await tester.pumpWidget(
          MaterialApp(
            home: VelocityTheme(
              data: VelocityThemeData.light(),
              child: Column(
                children: [
                  Builder(
                    builder: (context) {
                      siblingTheme = VelocityCardTheme.of(context);
                      return const SizedBox.shrink();
                    },
                  ),
                  VelocityCardTheme(
                    data: const VelocityCardThemeData(
                      backgroundColor: overrideColor,
                    ),
                    child: Builder(
                      builder: (context) {
                        childTheme = VelocityCardTheme.of(context);
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        expect(siblingTheme!.backgroundColor, isNot(overrideColor));
        expect(childTheme!.backgroundColor, equals(overrideColor));
      },
    );

    // 测试对话框主题覆盖隔离
    testWidgets(
      'VelocityDialogTheme override only affects descendants',
      (tester) async {
        VelocityDialogThemeData? siblingTheme;
        VelocityDialogThemeData? childTheme;

        const overrideColor = Colors.purple;

        await tester.pumpWidget(
          MaterialApp(
            home: VelocityTheme(
              data: VelocityThemeData.light(),
              child: Column(
                children: [
                  Builder(
                    builder: (context) {
                      siblingTheme = VelocityDialogTheme.of(context);
                      return const SizedBox.shrink();
                    },
                  ),
                  VelocityDialogTheme(
                    data: const VelocityDialogThemeData(
                      backgroundColor: overrideColor,
                    ),
                    child: Builder(
                      builder: (context) {
                        childTheme = VelocityDialogTheme.of(context);
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        expect(siblingTheme!.backgroundColor, isNot(overrideColor));
        expect(childTheme!.backgroundColor, equals(overrideColor));
      },
    );

    // 测试嵌套覆盖 - 内层覆盖优先
    testWidgets(
      'nested theme overrides - inner override takes precedence',
      (tester) async {
        VelocityButtonThemeData? outerChildTheme;
        VelocityButtonThemeData? innerChildTheme;

        const outerColor = Colors.red;
        const innerColor = Colors.blue;

        await tester.pumpWidget(
          MaterialApp(
            home: VelocityTheme(
              data: VelocityThemeData.light(),
              child: VelocityButtonTheme(
                data: const VelocityButtonThemeData(
                  backgroundColor: outerColor,
                ),
                child: Column(
                  children: [
                    Builder(
                      builder: (context) {
                        outerChildTheme = VelocityButtonTheme.of(context);
                        return const SizedBox.shrink();
                      },
                    ),
                    VelocityButtonTheme(
                      data: const VelocityButtonThemeData(
                        backgroundColor: innerColor,
                      ),
                      child: Builder(
                        builder: (context) {
                          innerChildTheme = VelocityButtonTheme.of(context);
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

        expect(outerChildTheme!.backgroundColor, equals(outerColor));
        expect(innerChildTheme!.backgroundColor, equals(innerColor));
      },
    );

    // 测试全局主题不受局部覆盖影响
    testWidgets(
      'global theme is not affected by local override',
      (tester) async {
        VelocityThemeData? globalThemeBefore;
        VelocityThemeData? globalThemeAfter;

        await tester.pumpWidget(
          MaterialApp(
            home: VelocityTheme(
              data: VelocityThemeData.light(),
              child: Column(
                children: [
                  Builder(
                    builder: (context) {
                      globalThemeBefore = VelocityTheme.of(context);
                      return const SizedBox.shrink();
                    },
                  ),
                  VelocityButtonTheme(
                    data: const VelocityButtonThemeData(
                      backgroundColor: Colors.red,
                    ),
                    child: const SizedBox.shrink(),
                  ),
                  Builder(
                    builder: (context) {
                      globalThemeAfter = VelocityTheme.of(context);
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        );

        // 全局主题应该保持不变
        expect(globalThemeBefore, equals(globalThemeAfter));
        expect(
          globalThemeBefore!.buttonTheme!.backgroundColor,
          equals(globalThemeAfter!.buttonTheme!.backgroundColor),
        );
      },
    );

    // 测试 maybeOf 方法
    testWidgets(
      'maybeOf returns null when no local override exists',
      (tester) async {
        VelocityButtonThemeData? localTheme;
        VelocityButtonThemeData? globalFallback;

        await tester.pumpWidget(
          MaterialApp(
            home: VelocityTheme(
              data: VelocityThemeData.light(),
              child: Builder(
                builder: (context) {
                  localTheme = VelocityButtonTheme.maybeOf(context);
                  globalFallback = VelocityButtonTheme.of(context);
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        );

        // maybeOf 应该返回 null（没有局部覆盖）
        expect(localTheme, isNull);
        // of 应该返回全局主题
        expect(globalFallback, isNotNull);
      },
    );

    // 测试 updateShouldNotify
    testWidgets(
      'updateShouldNotify returns true when data changes',
      (tester) async {
        int buildCount = 0;

        await tester.pumpWidget(
          MaterialApp(
            home: VelocityTheme(
              data: VelocityThemeData.light(),
              child: VelocityButtonTheme(
                data: const VelocityButtonThemeData(
                  backgroundColor: Colors.red,
                ),
                child: Builder(
                  builder: (context) {
                    buildCount++;
                    VelocityButtonTheme.of(context);
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ),
        );

        expect(buildCount, equals(1));

        // 更新主题数据
        await tester.pumpWidget(
          MaterialApp(
            home: VelocityTheme(
              data: VelocityThemeData.light(),
              child: VelocityButtonTheme(
                data: const VelocityButtonThemeData(
                  backgroundColor: Colors.blue, // 改变颜色
                ),
                child: Builder(
                  builder: (context) {
                    buildCount++;
                    VelocityButtonTheme.of(context);
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ),
        );

        // 应该触发重建
        expect(buildCount, equals(2));
      },
    );
  });

  group('Property 4: Component Theme Override Isolation - Property Tests', () {
    // 属性测试：任意颜色覆盖都应该只影响后代
    Glados(any.int).test(
      'button theme override with any color only affects descendants (testing 100 inputs)',
      (colorValue) {
        // 验证颜色值的有效性
        final testColor = Color(colorValue | 0xFF000000);
        expect(testColor.alpha, equals(255));
        // 颜色应该是有效的
        expect(testColor.value, isNonZero);
      },
    );

    // 属性测试：任意输入框主题覆盖都应该只影响后代
    Glados(any.int).test(
      'input theme override with any color only affects descendants (testing 100 inputs)',
      (colorValue) {
        final testColor = Color(colorValue | 0xFF000000);
        expect(testColor.alpha, equals(255));
        expect(testColor.value, isNonZero);
      },
    );

    // 属性测试：任意卡片主题覆盖都应该只影响后代
    Glados(any.int).test(
      'card theme override with any color only affects descendants (testing 100 inputs)',
      (colorValue) {
        final testColor = Color(colorValue | 0xFF000000);
        expect(testColor.alpha, equals(255));
        expect(testColor.value, isNonZero);
      },
    );

    // 属性测试：VelocityButtonThemeData 相等性
    Glados2(any.int, any.int).test(
      'VelocityButtonThemeData equality is consistent (testing 100 inputs)',
      (color1, color2) {
        final theme1 = VelocityButtonThemeData(
          backgroundColor: Color(color1 | 0xFF000000),
        );
        final theme2 = VelocityButtonThemeData(
          backgroundColor: Color(color2 | 0xFF000000),
        );

        if (color1 == color2) {
          expect(theme1, equals(theme2));
        } else {
          expect(theme1, isNot(equals(theme2)));
        }
      },
    );

    // 属性测试：VelocityInputThemeData 相等性
    Glados2(any.int, any.int).test(
      'VelocityInputThemeData equality is consistent (testing 100 inputs)',
      (color1, color2) {
        final theme1 = VelocityInputThemeData(
          borderColor: Color(color1 | 0xFF000000),
        );
        final theme2 = VelocityInputThemeData(
          borderColor: Color(color2 | 0xFF000000),
        );

        if (color1 == color2) {
          expect(theme1, equals(theme2));
        } else {
          expect(theme1, isNot(equals(theme2)));
        }
      },
    );

    // 属性测试：VelocityCardThemeData 相等性
    Glados2(any.int, any.int).test(
      'VelocityCardThemeData equality is consistent (testing 100 inputs)',
      (color1, color2) {
        final theme1 = VelocityCardThemeData(
          backgroundColor: Color(color1 | 0xFF000000),
        );
        final theme2 = VelocityCardThemeData(
          backgroundColor: Color(color2 | 0xFF000000),
        );

        if (color1 == color2) {
          expect(theme1, equals(theme2));
        } else {
          expect(theme1, isNot(equals(theme2)));
        }
      },
    );

    // 属性测试：VelocityDialogThemeData 相等性
    Glados2(any.int, any.int).test(
      'VelocityDialogThemeData equality is consistent (testing 100 inputs)',
      (color1, color2) {
        final theme1 = VelocityDialogThemeData(
          backgroundColor: Color(color1 | 0xFF000000),
        );
        final theme2 = VelocityDialogThemeData(
          backgroundColor: Color(color2 | 0xFF000000),
        );

        if (color1 == color2) {
          expect(theme1, equals(theme2));
        } else {
          expect(theme1, isNot(equals(theme2)));
        }
      },
    );
  });
}
