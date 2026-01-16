# Toast 轻提示

轻提示组件用于显示简短的消息提示，会自动消失。

<InteractivePreview
  component="VelocityToast"
  description="支持多种类型和位置的轻量级提示组件"
  preview-path="Feedback Examples > Toast"
  :variants="[
    {
      name: 'Basic',
      code: `VelocityToast.show(
  context,
  message: '操作成功',
);`
    },
    {
      name: 'Success',
      code: `VelocityToast.success(
  context,
  message: '保存成功',
);`
    },
    {
      name: 'Error',
      code: `VelocityToast.error(
  context,
  message: '操作失败',
);`
    },
    {
      name: 'Warning',
      code: `VelocityToast.warning(
  context,
  message: '请注意',
);`
    },
    {
      name: 'With Action',
      code: `VelocityToast.show(
  context,
  message: '文件已删除',
  action: ToastAction(
    label: '撤销',
    onPressed: () {},
  ),
);`
    },
    {
      name: 'Loading',
      code: `VelocityToast.loading(
  context,
  message: '加载中...',
);`
    }
  ]"
/>

## 基础用法

```dart
VelocityToast.show(
  context,
  message: '操作成功',
);
```

## 提示类型

```dart
// 成功提示
VelocityToast.success(
  context,
  message: '保存成功',
);

// 错误提示
VelocityToast.error(
  context,
  message: '操作失败',
);

// 警告提示
VelocityToast.warning(
  context,
  message: '请注意',
);

// 信息提示
VelocityToast.info(
  context,
  message: '新消息',
);
```

## 显示位置

```dart
// 顶部
VelocityToast.show(
  context,
  message: '顶部提示',
  position: ToastPosition.top,
);

// 中间
VelocityToast.show(
  context,
  message: '中间提示',
  position: ToastPosition.center,
);

// 底部
VelocityToast.show(
  context,
  message: '底部提示',
  position: ToastPosition.bottom,
);
```

## 显示时长

```dart
// 短时间（2秒）
VelocityToast.show(
  context,
  message: '短提示',
  duration: ToastDuration.short,
);

// 正常时间（3秒）
VelocityToast.show(
  context,
  message: '正常提示',
  duration: ToastDuration.normal,
);

// 长时间（5秒）
VelocityToast.show(
  context,
  message: '长提示',
  duration: ToastDuration.long,
);

// 自定义时长
VelocityToast.show(
  context,
  message: '自定义时长',
  duration: Duration(seconds: 10),
);
```

## 带图标

```dart
VelocityToast.show(
  context,
  message: '已复制到剪贴板',
  icon: Icons.content_copy,
);
```

## 带操作按钮

```dart
VelocityToast.show(
  context,
  message: '文件已删除',
  action: ToastAction(
    label: '撤销',
    onPressed: () {
      // 撤销删除
    },
  ),
);
```

## 加载提示

```dart
// 显示加载
VelocityToast.loading(
  context,
  message: '加载中...',
);

// 隐藏加载
VelocityToast.hideLoading(context);
```

## 手动关闭

```dart
final toast = VelocityToast.show(
  context,
  message: '手动关闭的提示',
  duration: null,  // 不自动关闭
);

// 手动关闭
toast.dismiss();
```

## 全局配置

```dart
VelocityToastConfig(
  defaultPosition: ToastPosition.bottom,
  defaultDuration: ToastDuration.normal,
  maxVisible: 3,  // 最多同时显示3个
  child: MyApp(),
)
```

## API

### VelocityToast.show

| 参数       | 类型            | 默认值   | 说明     |
| ---------- | --------------- | -------- | -------- |
| `context`  | `BuildContext`  | -        | 上下文   |
| `message`  | `String`        | -        | 消息内容 |
| `type`     | `ToastType`     | `info`   | 提示类型 |
| `position` | `ToastPosition` | `bottom` | 显示位置 |
| `duration` | `Duration?`     | `3s`     | 显示时长 |
| `icon`     | `IconData?`     | -        | 图标     |
| `action`   | `ToastAction?`  | -        | 操作按钮 |

### ToastType

| 值        | 说明     |
| --------- | -------- |
| `info`    | 信息提示 |
| `success` | 成功提示 |
| `warning` | 警告提示 |
| `error`   | 错误提示 |

### ToastPosition

| 值       | 说明 |
| -------- | ---- |
| `top`    | 顶部 |
| `center` | 中间 |
| `bottom` | 底部 |

### ToastDuration

| 值       | 时长 |
| -------- | ---- |
| `short`  | 2 秒 |
| `normal` | 3 秒 |
| `long`   | 5 秒 |

- 使用 `aria-live="polite"` 属性
