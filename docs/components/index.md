# 组件总览

VelocityUI 提供 60+ 企业级组件，涵盖应用开发全场景。

## 组件分类

### 基础组件 Basic

构建界面的基础元素。

| 组件    | 说明                     | 文档                              |
| ------- | ------------------------ | --------------------------------- |
| Button  | 按钮，支持多种类型和状态 | [查看](/components/basic/button)  |
| Text    | 文本显示，支持多种样式   | [查看](/components/basic/text)    |
| Icon    | 图标，内置 1000+ 图标    | [查看](/components/basic/icon)    |
| Image   | 图片，支持懒加载和占位   | [查看](/components/basic/image)   |
| Chip    | 标签，用于选择和展示     | [查看](/components/basic/chip)    |
| Link    | 链接，支持外部和内部跳转 | [查看](/components/basic/link)    |
| Spinner | 加载指示器               | [查看](/components/basic/spinner) |

### 表单组件 Form

数据输入和表单处理。

| 组件       | 说明                 | 文档                                 |
| ---------- | -------------------- | ------------------------------------ |
| Input      | 输入框，支持多种类型 | [查看](/components/form/input)       |
| Select     | 选择器，单选/多选    | [查看](/components/form/select)      |
| Checkbox   | 复选框               | [查看](/components/form/checkbox)    |
| Radio      | 单选框               | [查看](/components/form/radio)       |
| Switch     | 开关                 | [查看](/components/form/switch)      |
| Slider     | 滑块                 | [查看](/components/form/slider)      |
| DatePicker | 日期选择器           | [查看](/components/form/date-picker) |
| Rate       | 评分                 | [查看](/components/form/rate)        |
| Upload     | 文件上传             | [查看](/components/form/upload)      |

### 展示组件 Display

数据展示和信息呈现。

| 组件     | 说明     | 文档                                 |
| -------- | -------- | ------------------------------------ |
| Avatar   | 头像     | [查看](/components/display/avatar)   |
| Badge    | 徽章     | [查看](/components/display/badge)    |
| Card     | 卡片容器 | [查看](/components/display/card)     |
| Carousel | 轮播图   | [查看](/components/display/carousel) |
| Collapse | 折叠面板 | [查看](/components/display/collapse) |
| Table    | 数据表格 | [查看](/components/display/table)    |
| Tag      | 标签     | [查看](/components/display/tag)      |
| Timeline | 时间线   | [查看](/components/display/timeline) |
| Tooltip  | 文字提示 | [查看](/components/display/tooltip)  |
| Tree     | 树形控件 | [查看](/components/display/tree)     |

### 反馈组件 Feedback

用户操作反馈。

| 组件         | 说明     | 文档                                      |
| ------------ | -------- | ----------------------------------------- |
| Dialog       | 对话框   | [查看](/components/feedback/dialog)       |
| Toast        | 轻提示   | [查看](/components/feedback/toast)        |
| Notification | 通知     | [查看](/components/feedback/notification) |
| Progress     | 进度条   | [查看](/components/feedback/progress)     |
| Skeleton     | 骨架屏   | [查看](/components/feedback/skeleton)     |
| Loading      | 加载状态 | [查看](/components/feedback/loading)      |

### 导航组件 Navigation

页面导航和路由。

| 组件       | 说明   | 文档                                      |
| ---------- | ------ | ----------------------------------------- |
| Tabs       | 标签页 | [查看](/components/navigation/tabs)       |
| Menu       | 菜单   | [查看](/components/navigation/menu)       |
| Breadcrumb | 面包屑 | [查看](/components/navigation/breadcrumb) |
| Pagination | 分页   | [查看](/components/navigation/pagination) |
| Stepper    | 步骤条 | [查看](/components/navigation/stepper)    |
| Drawer     | 抽屉   | [查看](/components/navigation/drawer)     |

## 使用方式

### 导入

```dart
// 导入全部组件
import 'package:velocity_ui/velocity_ui.dart';

// 按需导入
import 'package:velocity_ui/components/button.dart';
import 'package:velocity_ui/components/input.dart';
```

### 命名规范

所有组件以 `Velocity` 前缀命名：

```dart
VelocityButton    // 按钮
VelocityInput     // 输入框
VelocityCard      // 卡片
VelocityDialog    // 对话框
```

### 尺寸规范

大多数组件支持三种尺寸：

```dart
// 小尺寸
VelocityButton.primary(
  text: '小按钮',
  size: VelocitySize.small,
  onPressed: () {},
)

// 中等尺寸（默认）
VelocityButton.primary(
  text: '中按钮',
  size: VelocitySize.medium,
  onPressed: () {},
)

// 大尺寸
VelocityButton.primary(
  text: '大按钮',
  size: VelocitySize.large,
  onPressed: () {},
)
```

### 状态控制

```dart
// 禁用状态
VelocityButton.primary(
  text: '禁用',
  disabled: true,
  onPressed: () {},
)

// 加载状态
VelocityButton.primary(
  text: '加载中',
  loading: true,
  onPressed: () {},
)
```

## 交互式预览

运行示例项目体验所有组件：

```bash
cd example
flutter run
```

## 设计规范

VelocityUI 遵循以下设计规范：

- **Material Design 3** - 基础设计语言
- **8px 网格系统** - 间距和尺寸基准
- **统一圆角** - 默认 8px 圆角
- **一致的动画** - 200ms 标准过渡时长
