# Input 输入框

输入框组件用于文本输入，支持多种类型和验证。

<InteractivePreview
  component="VelocityInput"
  description="支持多种输入类型、验证和状态的输入框组件"
  preview-path="Form Examples > Input"
  :variants="[
    {
      name: 'Basic',
      code: `VelocityInput(
  label: '用户名',
  placeholder: '请输入用户名',
)`
    },
    {
      name: 'With Prefix Icon',
      code: `VelocityInput(
  label: '搜索',
  placeholder: '请输入关键词',
  prefixIcon: Icon(Icons.search),
)`
    },
    {
      name: 'Password',
      code: `VelocityInput(
  label: '密码',
  placeholder: '请输入密码',
  suffixIcon: Icon(Icons.visibility),
  obscureText: true,
)`
    },
    {
      name: 'Multiline',
      code: `VelocityInput(
  label: '备注',
  maxLines: 4,
)`
    },
    {
      name: 'With Validation',
      code: `VelocityInput(
  label: '邮箱',
  placeholder: '请输入邮箱',
  validator: (value) {
    if (value == null || value.isEmpty) {
      return '请输入邮箱';
    }
    return null;
  },
)`
    },
    {
      name: 'Disabled',
      code: `VelocityInput(
  label: '禁用输入框',
  disabled: true,
  value: '不可编辑',
)`
    }
  ]"
/>

## 基础用法

```dart
VelocityInput(
  label: '用户名',
  placeholder: '请输入用户名',
)
```

## 带图标

```dart
// 前置图标
VelocityInput(
  label: '搜索',
  placeholder: '请输入关键词',
  prefixIcon: Icon(Icons.search),
)

// 后置图标
VelocityInput(
  label: '密码',
  placeholder: '请输入密码',
  suffixIcon: Icon(Icons.visibility),
  obscureText: true,
)
```

## 输入类型

```dart
// 文本输入
VelocityInput(
  label: '姓名',
  keyboardType: TextInputType.text,
)

// 邮箱输入
VelocityInput(
  label: '邮箱',
  keyboardType: TextInputType.emailAddress,
)

// 数字输入
VelocityInput(
  label: '年龄',
  keyboardType: TextInputType.number,
)

// 电话输入
VelocityInput(
  label: '电话',
  keyboardType: TextInputType.phone,
)

// 密码输入
VelocityInput(
  label: '密码',
  obscureText: true,
)

// 多行输入
VelocityInput(
  label: '备注',
  maxLines: 4,
)
```

## 输入验证

```dart
VelocityInput(
  label: '邮箱',
  placeholder: '请输入邮箱',
  validator: (value) {
    if (value == null || value.isEmpty) {
      return '请输入邮箱';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return '请输入有效的邮箱地址';
    }
    return null;
  },
)
```

## 状态

```dart
// 禁用状态
VelocityInput(
  label: '禁用输入框',
  disabled: true,
  value: '不可编辑',
)

// 只读状态
VelocityInput(
  label: '只读输入框',
  readOnly: true,
  value: '只读内容',
)

// 错误状态
VelocityInput(
  label: '错误输入框',
  error: '输入内容有误',
)

// 成功状态
VelocityInput(
  label: '成功输入框',
  success: true,
)
```

## 字数限制

```dart
VelocityInput(
  label: '简介',
  maxLength: 100,
  showCounter: true,  // 显示字数统计
)
```

## 清除按钮

```dart
VelocityInput(
  label: '搜索',
  clearable: true,  // 显示清除按钮
)
```

## 尺寸

```dart
// 小尺寸
VelocityInput(
  label: '小输入框',
  size: VelocitySize.small,
)

// 中等尺寸
VelocityInput(
  label: '中输入框',
  size: VelocitySize.medium,
)

// 大尺寸
VelocityInput(
  label: '大输入框',
  size: VelocitySize.large,
)
```

## 控制器

```dart
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VelocityInput(
      label: '用户名',
      controller: _controller,
      onChanged: (value) {
        print('输入内容: $value');
      },
    );
  }
}
```

## API

### 属性

| 属性           | 类型                          | 默认值   | 说明         |
| -------------- | ----------------------------- | -------- | ------------ |
| `label`        | `String?`                     | -        | 标签文本     |
| `placeholder`  | `String?`                     | -        | 占位文本     |
| `value`        | `String?`                     | -        | 输入值       |
| `controller`   | `TextEditingController?`      | -        | 控制器       |
| `prefixIcon`   | `Widget?`                     | -        | 前置图标     |
| `suffixIcon`   | `Widget?`                     | -        | 后置图标     |
| `keyboardType` | `TextInputType?`              | -        | 键盘类型     |
| `obscureText`  | `bool`                        | `false`  | 密码模式     |
| `maxLines`     | `int`                         | `1`      | 最大行数     |
| `maxLength`    | `int?`                        | -        | 最大长度     |
| `showCounter`  | `bool`                        | `false`  | 显示计数器   |
| `clearable`    | `bool`                        | `false`  | 显示清除按钮 |
| `disabled`     | `bool`                        | `false`  | 禁用状态     |
| `readOnly`     | `bool`                        | `false`  | 只读状态     |
| `error`        | `String?`                     | -        | 错误信息     |
| `success`      | `bool`                        | `false`  | 成功状态     |
| `size`         | `VelocitySize`                | `medium` | 尺寸         |
| `validator`    | `FormFieldValidator<String>?` | -        | 验证函数     |
| `onChanged`    | `ValueChanged<String>?`       | -        | 值变化回调   |
| `onSubmitted`  | `ValueChanged<String>?`       | -        | 提交回调     |

- 输入框自动关联标签
- 禁用状态会设置 `aria-disabled`
