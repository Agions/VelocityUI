# Dialog 对话框

对话框组件用于显示模态窗口，需要用户进行确认或输入。

<InteractivePreview
  component="VelocityDialog"
  description="支持确认、警告、输入等多种类型的对话框组件"
  preview-path="Feedback Examples > Dialog"
  :variants="[
    {
      name: 'Basic',
      code: `VelocityDialog.show(
  context,
  title: '提示',
  content: '确定要执行此操作吗？',
  onConfirm: () {
    print('已确认');
  },
);`
    },
    {
      name: 'Confirm',
      code: `VelocityDialog.confirm(
  context,
  title: '确认删除',
  content: '删除后将无法恢复，确定要删除吗？',
  confirmText: '删除',
  cancelText: '取消',
  onConfirm: () {},
);`
    },
    {
      name: 'Alert',
      code: `VelocityDialog.alert(
  context,
  title: '警告',
  content: '您的账户存在安全风险。',
  confirmText: '知道了',
);`
    },
    {
      name: 'Prompt',
      code: `final result = await VelocityDialog.prompt(
  context,
  title: '请输入',
  placeholder: '请输入您的姓名',
);`
    },
    {
      name: 'Bottom Sheet',
      code: `VelocityDialog.bottom(
  context,
  title: '选择操作',
  content: Column(
    children: [
      ListTile(title: Text('分享')),
      ListTile(title: Text('编辑')),
      ListTile(title: Text('删除')),
    ],
  ),
);`
    }
  ]"
/>

## 基础用法

```dart
VelocityDialog.show(
  context,
  title: '提示',
  content: '确定要执行此操作吗？',
  onConfirm: () {
    print('已确认');
  },
);
```

## 确认对话框

```dart
VelocityDialog.confirm(
  context,
  title: '确认删除',
  content: '删除后将无法恢复，确定要删除吗？',
  confirmText: '删除',
  cancelText: '取消',
  onConfirm: () {
    print('已确认删除');
  },
  onCancel: () {
    print('已取消');
  },
);
```

## 警告对话框

```dart
VelocityDialog.alert(
  context,
  title: '警告',
  content: '您的账户存在安全风险，请及时修改密码。',
  confirmText: '知道了',
);
```

## 输入对话框

```dart
final result = await VelocityDialog.prompt(
  context,
  title: '请输入',
  placeholder: '请输入您的姓名',
  validator: (value) {
    if (value == null || value.isEmpty) {
      return '姓名不能为空';
    }
    return null;
  },
);

if (result != null) {
  print('输入的内容: $result');
}
```

## 自定义内容

```dart
VelocityDialog.show(
  context,
  title: '选择日期',
  content: VelocityDatePicker(
    onChanged: (date) {
      selectedDate = date;
    },
  ),
  onConfirm: () {
    print('选择的日期: $selectedDate');
  },
);
```

## 自定义操作按钮

```dart
VelocityDialog.show(
  context,
  title: '操作',
  content: Text('请选择操作'),
  actions: [
    VelocityButton(
      text: '稍后再说',
      type: VelocityButtonType.text,
      onPressed: () => Navigator.pop(context),
    ),
    VelocityButton(
      text: '不再提醒',
      type: VelocityButtonType.outlined,
      onPressed: () {
        // 处理不再提醒
        Navigator.pop(context);
      },
    ),
    VelocityButton(
      text: '立即处理',
      type: VelocityButtonType.primary,
      onPressed: () {
        // 处理操作
        Navigator.pop(context);
      },
    ),
  ],
);
```

## 全屏对话框

```dart
VelocityDialog.fullscreen(
  context,
  title: '编辑文章',
  content: ArticleEditor(),
  onSave: () {
    // 保存操作
  },
);
```

## 底部弹出

```dart
VelocityDialog.bottom(
  context,
  title: '选择操作',
  content: Column(
    children: [
      ListTile(
        leading: Icon(Icons.share),
        title: Text('分享'),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(Icons.edit),
        title: Text('编辑'),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(Icons.delete),
        title: Text('删除'),
        onTap: () {},
      ),
    ],
  ),
);
```

## 配置选项

```dart
VelocityDialog.show(
  context,
  title: '提示',
  content: Text('内容'),
  barrierDismissible: false,  // 点击遮罩不关闭
  closeOnConfirm: true,       // 确认后自动关闭
  showCloseButton: true,      // 显示关闭按钮
);
```

## API

### VelocityDialog.show

| 参数                 | 类型            | 默认值   | 说明         |
| -------------------- | --------------- | -------- | ------------ |
| `context`            | `BuildContext`  | -        | 上下文       |
| `title`              | `String?`       | -        | 标题         |
| `content`            | `Widget?`       | -        | 内容         |
| `actions`            | `List<Widget>?` | -        | 操作按钮     |
| `confirmText`        | `String`        | `'确定'` | 确认按钮文本 |
| `cancelText`         | `String`        | `'取消'` | 取消按钮文本 |
| `onConfirm`          | `VoidCallback?` | -        | 确认回调     |
| `onCancel`           | `VoidCallback?` | -        | 取消回调     |
| `barrierDismissible` | `bool`          | `true`   | 点击遮罩关闭 |
| `closeOnConfirm`     | `bool`          | `true`   | 确认后关闭   |
| `showCloseButton`    | `bool`          | `false`  | 显示关闭按钮 |

### VelocityDialog.confirm

| 参数          | 类型            | 默认值   | 说明         |
| ------------- | --------------- | -------- | ------------ |
| `context`     | `BuildContext`  | -        | 上下文       |
| `title`       | `String`        | -        | 标题         |
| `content`     | `String`        | -        | 内容文本     |
| `confirmText` | `String`        | `'确定'` | 确认按钮文本 |
| `cancelText`  | `String`        | `'取消'` | 取消按钮文本 |
| `onConfirm`   | `VoidCallback?` | -        | 确认回调     |
| `onCancel`    | `VoidCallback?` | -        | 取消回调     |
| `danger`      | `bool`          | `false`  | 危险操作样式 |

### VelocityDialog.prompt

| 参数           | 类型                          | 默认值 | 说明         |
| -------------- | ----------------------------- | ------ | ------------ |
| `context`      | `BuildContext`                | -      | 上下文       |
| `title`        | `String`                      | -      | 标题         |
| `placeholder`  | `String?`                     | -      | 输入框占位符 |
| `initialValue` | `String?`                     | -      | 初始值       |
| `validator`    | `FormFieldValidator<String>?` | -      | 验证函数     |
| `keyboardType` | `TextInputType?`              | -      | 键盘类型     |

- 对话框打开时焦点会移动到对话框内
- 关闭时焦点会返回到触发元素
- 支持 Escape 键关闭
- 遮罩层会阻止背景内容的交互
