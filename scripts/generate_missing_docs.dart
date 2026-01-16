#!/usr/bin/env dart

import 'dart:io';

void main() {
  final docsToCreate = {
    // Display components
    'docs/components/display/carousel.md': carouselDoc,
    'docs/components/display/collapse.md': collapseDoc,
    'docs/components/display/table.md': tableDoc,
    'docs/components/display/tag.md': tagDoc,
    'docs/components/display/timeline.md': timelineDoc,
    'docs/components/display/tooltip.md': tooltipDoc,
    'docs/components/display/tree.md': treeDoc,

    // Feedback components
    'docs/components/feedback/toast.md': toastDoc,
    'docs/components/feedback/notification.md': notificationDoc,
    'docs/components/feedback/progress.md': progressDoc,
    'docs/components/feedback/skeleton.md': skeletonDoc,
    'docs/components/feedback/loading.md': loadingDoc,

    // Navigation components
    'docs/components/navigation/tabs.md': tabsDoc,
    'docs/components/navigation/menu.md': menuDoc,
    'docs/components/navigation/breadcrumb.md': breadcrumbDoc,
    'docs/components/navigation/pagination.md': paginationDoc,
    'docs/components/navigation/stepper.md': stepperDoc,
    'docs/components/navigation/drawer.md': drawerDoc,
  };

  for (final entry in docsToCreate.entries) {
    final file = File(entry.key);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
      file.writeAsStringSync(entry.value);
      print('✅ Created: ${entry.key}');
    } else {
      print('⏭️  Skipped (exists): ${entry.key}');
    }
  }

  print('\n🎉 Documentation generation complete!');
}

const carouselDoc = '''# Carousel 轮播图

轮播图组件用于循环播放一组图片或内容。

## 基础用法

\`\`\`dart
VelocityCarousel(
  items: [
    Image.network('https://example.com/image1.jpg'),
    Image.network('https://example.com/image2.jpg'),
    Image.network('https://example.com/image3.jpg'),
  ],
)
\`\`\`

## 自动播放

\`\`\`dart
VelocityCarousel(
  items: images,
  autoPlay: true,
  autoPlayInterval: Duration(seconds: 3),
)
\`\`\`

## 指示器

\`\`\`dart
VelocityCarousel(
  items: images,
  showIndicators: true,
  indicatorPosition: VelocityCarouselIndicatorPosition.bottom,
)
\`\`\`

## 无限循环

\`\`\`dart
VelocityCarousel(
  items: images,
  infinite: true,
)
\`\`\`

## API

### 属性

| 属性                | 类型                                | 默认值                                      | 说明         |
| ------------------- | ----------------------------------- | ------------------------------------------- | ------------ |
| \`items\`             | \`List<Widget>\`                      | -                                           | 轮播项列表   |
| \`height\`            | \`double?\`                           | \`200\`                                       | 高度         |
| \`autoPlay\`          | \`bool\`                              | \`false\`                                     | 自动播放     |
| \`autoPlayInterval\`  | \`Duration\`                          | \`Duration(seconds: 3)\`                      | 播放间隔     |
| \`infinite\`          | \`bool\`                              | \`true\`                                      | 无限循环     |
| \`showIndicators\`    | \`bool\`                              | \`true\`                                      | 显示指示器   |
| \`indicatorPosition\` | \`VelocityCarouselIndicatorPosition\` | \`VelocityCarouselIndicatorPosition.bottom\` | 指示器位置   |
| \`onChanged\`         | \`ValueChanged<int>?\`                | -                                           | 切换回调     |
''';

const collapseDoc = '''# Collapse 折叠面板

折叠面板组件用于折叠/展开内容区域。

## 基础用法

\`\`\`dart
VelocityCollapse(
  items: [
    CollapseItem(
      title: '标题1',
      content: Text('内容1'),
    ),
    CollapseItem(
      title: '标题2',
      content: Text('内容2'),
    ),
  ],
)
\`\`\`

## 手风琴模式

\`\`\`dart
VelocityCollapse(
  accordion: true,
  items: items,
)
\`\`\`

## 默认展开

\`\`\`dart
VelocityCollapse(
  defaultActiveKeys: ['1', '2'],
  items: items,
)
\`\`\`

## API

### 属性

| 属性                 | 类型                    | 默认值  | 说明           |
| -------------------- | ----------------------- | ------- | -------------- |
| \`items\`              | \`List<CollapseItem>\`    | -       | 折叠项列表     |
| \`accordion\`          | \`bool\`                  | \`false\` | 手风琴模式     |
| \`defaultActiveKeys\`  | \`List<String>?\`         | -       | 默认展开的面板 |
| \`onChange\`           | \`ValueChanged<List<String>>?\` | -       | 切换回调       |
''';

const tableDoc = '''# Table 表格

表格组件用于展示结构化数据。

## 基础用法

\`\`\`dart
VelocityTable(
  columns: [
    TableColumn(title: '姓名', dataIndex: 'name'),
    TableColumn(title: '年龄', dataIndex: 'age'),
    TableColumn(title: '地址', dataIndex: 'address'),
  ],
  dataSource: [
    {'name': '张三', 'age': 28, 'address': '北京'},
    {'name': '李四', 'age': 32, 'address': '上海'},
  ],
)
\`\`\`

## 可排序

\`\`\`dart
VelocityTable(
  columns: [
    TableColumn(
      title: '年龄',
      dataIndex: 'age',
      sortable: true,
    ),
  ],
  dataSource: data,
)
\`\`\`

## 可选择

\`\`\`dart
VelocityTable(
  columns: columns,
  dataSource: data,
  selectable: true,
  onSelectionChanged: (selectedRows) {
    print('选中: \$selectedRows');
  },
)
\`\`\`

## API

### 属性

| 属性                 | 类型                              | 默认值  | 说明         |
| -------------------- | --------------------------------- | ------- | ------------ |
| \`columns\`            | \`List<TableColumn>\`               | -       | 列配置       |
| \`dataSource\`         | \`List<Map<String, dynamic>>\`      | -       | 数据源       |
| \`selectable\`         | \`bool\`                            | \`false\` | 可选择       |
| \`loading\`            | \`bool\`                            | \`false\` | 加载状态     |
| \`onSelectionChanged\` | \`ValueChanged<List<int>>?\`        | -       | 选择变化回调 |
''';

const tagDoc = '''# Tag 标签

标签组件用于标记和分类。

## 基础用法

\`\`\`dart
VelocityTag(
  text: '标签',
)
\`\`\`

## 不同类型

\`\`\`dart
VelocityTag(text: '默认', type: VelocityTagType.default_),
VelocityTag(text: '主要', type: VelocityTagType.primary),
VelocityTag(text: '成功', type: VelocityTagType.success),
VelocityTag(text: '警告', type: VelocityTagType.warning),
VelocityTag(text: '危险', type: VelocityTagType.danger),
\`\`\`

## 可关闭

\`\`\`dart
VelocityTag(
  text: '可关闭',
  closable: true,
  onClose: () {
    print('标签被关闭');
  },
)
\`\`\`

## API

### 属性

| 属性       | 类型                | 默认值                    | 说明     |
| ---------- | ------------------- | ------------------------- | -------- |
| \`text\`     | \`String\`            | -                         | 文本     |
| \`type\`     | \`VelocityTagType\`   | \`VelocityTagType.default_\` | 类型     |
| \`closable\` | \`bool\`              | \`false\`                   | 可关闭   |
| \`onClose\`  | \`VoidCallback?\`     | -                         | 关闭回调 |
''';

const timelineDoc = '''# Timeline 时间线

时间线组件用于展示时间流信息。

## 基础用法

\`\`\`dart
VelocityTimeline(
  items: [
    TimelineItem(
      title: '创建订单',
      time: '2024-01-15 10:00',
    ),
    TimelineItem(
      title: '支付完成',
      time: '2024-01-15 10:05',
    ),
    TimelineItem(
      title: '发货',
      time: '2024-01-15 14:00',
    ),
  ],
)
\`\`\`

## 自定义图标

\`\`\`dart
VelocityTimeline(
  items: [
    TimelineItem(
      title: '完成',
      icon: Icons.check_circle,
      iconColor: Colors.green,
    ),
  ],
)
\`\`\`

## API

### 属性

| 属性    | 类型                  | 默认值 | 说明         |
| ------- | --------------------- | ------ | ------------ |
| \`items\` | \`List<TimelineItem>\` | -      | 时间线项列表 |
''';

const tooltipDoc = '''# Tooltip 提示

提示组件用于显示简短的提示信息。

## 基础用法

\`\`\`dart
VelocityTooltip(
  message: '这是提示信息',
  child: Icon(Icons.help),
)
\`\`\`

## 不同位置

\`\`\`dart
VelocityTooltip(
  message: '顶部提示',
  position: VelocityTooltipPosition.top,
  child: Text('悬停查看'),
)
\`\`\`

## API

### 属性

| 属性       | 类型                      | 默认值                      | 说明     |
| ---------- | ------------------------- | --------------------------- | -------- |
| \`message\`  | \`String\`                  | -                           | 提示文本 |
| \`position\` | \`VelocityTooltipPosition\` | \`VelocityTooltipPosition.top\` | 位置     |
| \`child\`    | \`Widget\`                  | -                           | 子组件   |
''';

const treeDoc = '''# Tree 树形控件

树形控件用于展示层级结构数据。

## 基础用法

\`\`\`dart
VelocityTree(
  nodes: [
    TreeNode(
      title: '父节点1',
      children: [
        TreeNode(title: '子节点1-1'),
        TreeNode(title: '子节点1-2'),
      ],
    ),
  ],
)
\`\`\`

## 可选择

\`\`\`dart
VelocityTree(
  nodes: nodes,
  selectable: true,
  onSelect: (node) {
    print('选中: \${node.title}');
  },
)
\`\`\`

## API

### 属性

| 属性         | 类型                      | 默认值  | 说明         |
| ------------ | ------------------------- | ------- | ------------ |
| \`nodes\`      | \`List<TreeNode>\`          | -       | 树节点列表   |
| \`selectable\` | \`bool\`                    | \`false\` | 可选择       |
| \`onSelect\`   | \`ValueChanged<TreeNode>?\` | -       | 选择回调     |
''';

const toastDoc = '''# Toast 轻提示

轻提示组件用于显示简短的消息提示。

## 基础用法

\`\`\`dart
VelocityToast.show('这是一条提示消息');
\`\`\`

## 不同类型

\`\`\`dart
VelocityToast.success('操作成功');
VelocityToast.error('操作失败');
VelocityToast.warning('警告信息');
VelocityToast.info('提示信息');
\`\`\`

## 自定义时长

\`\`\`dart
VelocityToast.show(
  '自定义时长',
  duration: Duration(seconds: 5),
);
\`\`\`

## API

### 方法

| 方法        | 参数                                    | 说明         |
| ----------- | --------------------------------------- | ------------ |
| \`show\`      | \`String message, {Duration? duration}\`  | 显示提示     |
| \`success\`   | \`String message, {Duration? duration}\`  | 显示成功提示 |
| \`error\`     | \`String message, {Duration? duration}\`  | 显示错误提示 |
| \`warning\`   | \`String message, {Duration? duration}\`  | 显示警告提示 |
| \`info\`      | \`String message, {Duration? duration}\`  | 显示信息提示 |
''';

const notificationDoc = '''# Notification 通知

通知组件用于显示全局通知消息。

## 基础用法

\`\`\`dart
VelocityNotification.show(
  title: '通知标题',
  message: '这是通知内容',
);
\`\`\`

## 不同类型

\`\`\`dart
VelocityNotification.success(
  title: '成功',
  message: '操作成功完成',
);

VelocityNotification.error(
  title: '错误',
  message: '操作失败',
);
\`\`\`

## 自定义位置

\`\`\`dart
VelocityNotification.show(
  title: '通知',
  message: '内容',
  position: VelocityNotificationPosition.topRight,
);
\`\`\`

## API

### 方法

| 方法      | 参数                                                      | 说明         |
| --------- | --------------------------------------------------------- | ------------ |
| \`show\`    | \`{String title, String message, Duration? duration}\`      | 显示通知     |
| \`success\` | \`{String title, String message, Duration? duration}\`      | 显示成功通知 |
| \`error\`   | \`{String title, String message, Duration? duration}\`      | 显示错误通知 |
| \`warning\` | \`{String title, String message, Duration? duration}\`      | 显示警告通知 |
''';

const progressDoc = '''# Progress 进度条

进度条组件用于展示操作进度。

## 基础用法

\`\`\`dart
VelocityProgress(
  value: 0.6,
)
\`\`\`

## 环形进度条

\`\`\`dart
VelocityProgress.circle(
  value: 0.75,
)
\`\`\`

## 显示百分比

\`\`\`dart
VelocityProgress(
  value: 0.6,
  showPercentage: true,
)
\`\`\`

## API

### 属性

| 属性             | 类型     | 默认值  | 说明       |
| ---------------- | -------- | ------- | ---------- |
| \`value\`          | \`double\` | -       | 进度值0-1  |
| \`showPercentage\` | \`bool\`   | \`false\` | 显示百分比 |
| \`color\`          | \`Color?\` | -       | 进度条颜色 |
''';

const skeletonDoc = '''# Skeleton 骨架屏

骨架屏组件用于在内容加载前显示占位图。

## 基础用法

\`\`\`dart
VelocitySkeleton(
  loading: true,
  child: YourContent(),
)
\`\`\`

## 不同类型

\`\`\`dart
VelocitySkeleton.text(lines: 3)
VelocitySkeleton.avatar()
VelocitySkeleton.card()
\`\`\`

## API

### 属性

| 属性      | 类型     | 默认值 | 说明       |
| --------- | -------- | ------ | ---------- |
| \`loading\` | \`bool\`   | \`true\` | 加载状态   |
| \`child\`   | \`Widget?\` | -      | 实际内容   |
''';

const loadingDoc = '''# Loading 加载

加载组件用于显示加载状态。

## 基础用法

\`\`\`dart
VelocityLoading()
\`\`\`

## 全屏加载

\`\`\`dart
VelocityLoading.fullscreen(
  message: '加载中...',
)
\`\`\`

## API

### 方法

| 方法         | 参数                  | 说明         |
| ------------ | --------------------- | ------------ |
| \`show\`       | \`{String? message}\`   | 显示加载     |
| \`hide\`       | -                     | 隐藏加载     |
| \`fullscreen\` | \`{String? message}\`   | 全屏加载     |
''';

const tabsDoc = '''# Tabs 标签页

标签页组件用于内容分类展示。

## 基础用法

\`\`\`dart
VelocityTabs(
  tabs: [
    Tab(text: '标签1'),
    Tab(text: '标签2'),
    Tab(text: '标签3'),
  ],
  children: [
    Center(child: Text('内容1')),
    Center(child: Text('内容2')),
    Center(child: Text('内容3')),
  ],
)
\`\`\`

## API

### 属性

| 属性       | 类型           | 默认值 | 说明       |
| ---------- | -------------- | ------ | ---------- |
| \`tabs\`     | \`List<Tab>\`    | -      | 标签列表   |
| \`children\` | \`List<Widget>\` | -      | 内容列表   |
| \`onChanged\` | \`ValueChanged<int>?\` | -      | 切换回调   |
''';

const menuDoc = '''# Menu 菜单

菜单组件用于导航。

## 基础用法

\`\`\`dart
VelocityMenu(
  items: [
    MenuItem(title: '首页', icon: Icons.home),
    MenuItem(title: '设置', icon: Icons.settings),
  ],
  onSelect: (item) {
    print('选中: \${item.title}');
  },
)
\`\`\`

## API

### 属性

| 属性       | 类型                      | 默认值 | 说明       |
| ---------- | ------------------------- | ------ | ---------- |
| \`items\`    | \`List<MenuItem>\`          | -      | 菜单项列表 |
| \`onSelect\` | \`ValueChanged<MenuItem>?\` | -      | 选择回调   |
''';

const breadcrumbDoc = '''# Breadcrumb 面包屑

面包屑组件用于显示当前页面路径。

## 基础用法

\`\`\`dart
VelocityBreadcrumb(
  items: [
    BreadcrumbItem(text: '首页', onTap: () {}),
    BreadcrumbItem(text: '列表', onTap: () {}),
    BreadcrumbItem(text: '详情'),
  ],
)
\`\`\`

## API

### 属性

| 属性      | 类型                    | 默认值 | 说明           |
| --------- | ----------------------- | ------ | -------------- |
| \`items\`   | \`List<BreadcrumbItem>\` | -      | 面包屑项列表   |
| \`separator\` | \`String\`                | \`'/'\`  | 分隔符         |
''';

const paginationDoc = '''# Pagination 分页

分页组件用于数据分页展示。

## 基础用法

\`\`\`dart
VelocityPagination(
  total: 100,
  pageSize: 10,
  currentPage: 1,
  onPageChanged: (page) {
    print('切换到第\$page页');
  },
)
\`\`\`

## API

### 属性

| 属性            | 类型                   | 默认值 | 说明         |
| --------------- | ---------------------- | ------ | ------------ |
| \`total\`         | \`int\`                  | -      | 总条数       |
| \`pageSize\`      | \`int\`                  | \`10\`   | 每页条数     |
| \`currentPage\`   | \`int\`                  | \`1\`    | 当前页       |
| \`onPageChanged\` | \`ValueChanged<int>?\`   | -      | 页码变化回调 |
''';

const stepperDoc = '''# Stepper 步骤条

步骤条组件用于展示流程步骤。

## 基础用法

\`\`\`dart
VelocityStepper(
  currentStep: 1,
  steps: [
    Step(title: '步骤1', content: Text('内容1')),
    Step(title: '步骤2', content: Text('内容2')),
    Step(title: '步骤3', content: Text('内容3')),
  ],
)
\`\`\`

## API

### 属性

| 属性          | 类型          | 默认值 | 说明       |
| ------------- | ------------- | ------ | ---------- |
| \`currentStep\` | \`int\`         | \`0\`    | 当前步骤   |
| \`steps\`       | \`List<Step>\`  | -      | 步骤列表   |
| \`onStepTapped\` | \`ValueChanged<int>?\` | -      | 步骤点击回调 |
''';

const drawerDoc = '''# Drawer 抽屉

抽屉组件用于侧边栏展示。

## 基础用法

\`\`\`dart
VelocityDrawer.show(
  context,
  child: YourDrawerContent(),
)
\`\`\`

## 不同位置

\`\`\`dart
VelocityDrawer.show(
  context,
  position: VelocityDrawerPosition.right,
  child: content,
)
\`\`\`

## API

### 方法

| 方法   | 参数                                                | 说明       |
| ------ | --------------------------------------------------- | ---------- |
| \`show\` | \`BuildContext context, {Widget child, VelocityDrawerPosition position}\` | 显示抽屉   |
''';
