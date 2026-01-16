/// Display Components Examples Page
///
/// 展示所有展示组件的使用示例，包括：
/// - Card: 卡片组件
/// - Avatar: 头像组件
/// - Badge: 徽章组件
/// - Tag: 标签组件
/// - Tooltip: 提示组件
/// - Empty: 空状态组件
/// - Carousel: 轮播图组件
/// - Collapse: 折叠面板组件
/// - Countdown: 倒计时组件
/// - Descriptions: 描述列表组件
/// - List: 列表组件
/// - Statistic: 统计数值组件
/// - Table: 表格组件
/// - Timeline: 时间线组件
/// - Tree: 树形组件
library;

import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 展示组件示例页面
class DisplayExamplesPage extends StatefulWidget {
  const DisplayExamplesPage({super.key});

  @override
  State<DisplayExamplesPage> createState() => _DisplayExamplesPageState();
}

class _DisplayExamplesPageState extends State<DisplayExamplesPage> {
  // Countdown controller for demo
  final VelocityCountDownController _countdownController =
      VelocityCountDownController();

  @override
  void dispose() {
    _countdownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display Components'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Card 示例
          _buildCardSection(context),
          const SizedBox(height: 24),

          // Avatar 示例
          _buildAvatarSection(),
          const SizedBox(height: 24),

          // Badge 示例
          _buildBadgeSection(),
          const SizedBox(height: 24),

          // Tag 示例
          _buildTagSection(),
          const SizedBox(height: 24),

          // Tooltip 示例
          _buildTooltipSection(),
          const SizedBox(height: 24),

          // Empty 示例
          _buildEmptySection(),
          const SizedBox(height: 24),

          // Carousel 示例
          _buildCarouselSection(),
          const SizedBox(height: 24),

          // Collapse 示例
          _buildCollapseSection(),
          const SizedBox(height: 24),

          // Countdown 示例
          _buildCountdownSection(),
          const SizedBox(height: 24),

          // Descriptions 示例
          _buildDescriptionsSection(),
          const SizedBox(height: 24),

          // List 示例
          _buildListSection(),
          const SizedBox(height: 24),

          // Statistic 示例
          _buildStatisticSection(),
          const SizedBox(height: 24),

          // Table 示例
          _buildTableSection(),
          const SizedBox(height: 24),

          // Timeline 示例
          _buildTimelineSection(),
          const SizedBox(height: 24),

          // Tree 示例
          _buildTreeSection(),
        ],
      ),
    );
  }

  /// Card 卡片组件示例
  Widget _buildCardSection(BuildContext context) {
    return _buildSection(
      title: 'Card',
      description: '卡片组件，用于展示内容块，支持多种变体',
      child: Column(
        children: [
          // 基础卡片 - 使用 VelocityCardStyle 配置内边距
          const VelocityCard(
            style: VelocityCardStyle(
              padding: EdgeInsets.all(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Card Title',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text('This is a basic card with some content.'),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // 可点击卡片 - 支持 onTap 回调
          VelocityCard(
            style: const VelocityCardStyle(
              padding: EdgeInsets.all(16),
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Card tapped!')),
              );
            },
            child: const Row(
              children: [
                Icon(Icons.touch_app, color: Colors.blue),
                SizedBox(width: 12),
                Text('Tap me!'),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // 轮廓卡片 - 使用 VelocityOutlinedCard
          const VelocityOutlinedCard(
            style: VelocityCardStyle(
              padding: EdgeInsets.all(16),
            ),
            child: Text('Outlined Card'),
          ),
          const SizedBox(height: 12),

          // 填充卡片 - 使用 VelocityFilledCard
          const VelocityFilledCard(
            style: VelocityCardStyle(
              padding: EdgeInsets.all(16),
            ),
            child: Text('Filled Card'),
          ),
        ],
      ),
    );
  }

  /// Avatar 头像组件示例
  Widget _buildAvatarSection() {
    return _buildSection(
      title: 'Avatar',
      description: '头像组件，支持不同尺寸、文字和图标',
      child: const Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          // 不同尺寸的头像
          VelocityAvatar(
            size: VelocitySize.small,
            name: 'S',
          ),
          VelocityAvatar(
            size: VelocitySize.medium,
            name: 'M',
          ),
          VelocityAvatar(
            size: VelocitySize.large,
            name: 'L',
          ),
          // 带图标的头像
          VelocityAvatar(
            size: VelocitySize.medium,
            icon: Icons.person,
          ),
        ],
      ),
    );
  }

  /// Badge 徽章组件示例
  Widget _buildBadgeSection() {
    return _buildSection(
      title: 'Badge',
      description: '徽章组件，用于展示状态或数量，支持数字和圆点模式',
      child: const Wrap(
        spacing: 24,
        runSpacing: 12,
        children: [
          // 基础数字徽章
          VelocityBadge(
            count: 5,
            child: Icon(Icons.mail, size: 32),
          ),
          // 较大数字
          VelocityBadge(
            count: 99,
            child: Icon(Icons.notifications, size: 32),
          ),
          // 超出最大值显示 max+
          VelocityBadge(
            count: 999,
            max: 99,
            child: Icon(Icons.shopping_cart, size: 32),
          ),
          // 圆点模式
          VelocityBadge(
            dot: true,
            child: Icon(Icons.chat, size: 32),
          ),
        ],
      ),
    );
  }

  /// Tag 标签组件示例
  Widget _buildTagSection() {
    return _buildSection(
      title: 'Tag',
      description: '标签组件，用于分类和标记，支持多种类型和样式',
      child: const Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          // 不同类型的标签
          VelocityTag(text: 'Default'),
          VelocityTag(text: 'Primary', type: VelocityTagType.primary),
          VelocityTag(text: 'Success', type: VelocityTagType.success),
          VelocityTag(text: 'Warning', type: VelocityTagType.warning),
          VelocityTag(text: 'Error', type: VelocityTagType.error),
          // 带图标的标签
          VelocityTag(
            text: 'With Icon',
            icon: Icons.star,
            type: VelocityTagType.primary,
          ),
          // 轮廓样式标签
          VelocityTag(
            text: 'Outlined',
            type: VelocityTagType.primary,
            outlined: true,
          ),
        ],
      ),
    );
  }

  /// Tooltip 提示组件示例
  Widget _buildTooltipSection() {
    return _buildSection(
      title: 'Tooltip',
      description: '提示组件，用于展示额外信息',
      child: Wrap(
        spacing: 16,
        runSpacing: 12,
        children: [
          // 按钮上的提示
          VelocityTooltip(
            message: 'This is a tooltip',
            child: VelocityButton.text(
              text: 'Hover me',
              onPressed: () {},
            ),
          ),
          // 图标上的提示
          const VelocityTooltip(
            message: 'Icon tooltip',
            child: Icon(Icons.info_outline),
          ),
        ],
      ),
    );
  }

  /// Empty 空状态组件示例
  Widget _buildEmptySection() {
    return _buildSection(
      title: 'Empty',
      description: '空状态组件，用于展示无数据状态',
      child: const Column(
        children: [
          // 无数据状态
          VelocityEmpty(
            type: VelocityEmptyType.noData,
          ),
          SizedBox(height: 24),
          // 无搜索结果状态
          VelocityEmpty(
            type: VelocityEmptyType.noSearch,
          ),
        ],
      ),
    );
  }

  /// Carousel 轮播图组件示例
  Widget _buildCarouselSection() {
    return _buildSection(
      title: 'Carousel',
      description: '轮播图组件，支持自动播放和指示器',
      child: VelocityCarousel(
        height: 180,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        showIndicator: true,
        onPageChanged: (index) {
          // 页面切换回调
        },
        items: [
          // 轮播项 - 使用 Container 包装内容
          Container(
            color: Colors.blue,
            child: const Center(
              child: Text(
                'Slide 1',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          Container(
            color: Colors.green,
            child: const Center(
              child: Text(
                'Slide 2',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          Container(
            color: Colors.orange,
            child: const Center(
              child: Text(
                'Slide 3',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Collapse 折叠面板组件示例
  Widget _buildCollapseSection() {
    return _buildSection(
      title: 'Collapse',
      description: '折叠面板组件，支持展开/折叠动画',
      child: Column(
        children: [
          // 单个折叠面板
          const VelocityCollapse(
            title: Text('Click to expand'),
            initiallyExpanded: false,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'This is the collapsed content. '
                'It will be shown when the panel is expanded.',
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 手风琴组件 - 多个面板，默认只展开一个
          VelocityAccordion(
            allowMultiple: false,
            items: const [
              VelocityAccordionItem(
                title: Text('Section 1'),
                initiallyExpanded: true,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Content for section 1'),
                ),
              ),
              VelocityAccordionItem(
                title: Text('Section 2'),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Content for section 2'),
                ),
              ),
              VelocityAccordionItem(
                title: Text('Section 3'),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Content for section 3'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Countdown 倒计时组件示例
  Widget _buildCountdownSection() {
    return _buildSection(
      title: 'Countdown',
      description: '倒计时组件，支持控制器和多种显示格式',
      child: Column(
        children: [
          // 基础倒计时 - 10分钟
          VelocityCountDown(
            duration: 10 * 60 * 1000, // 10分钟（毫秒）
            autoStart: true,
            showDays: false,
            showHours: true,
            showMinutes: true,
            showSeconds: true,
            showMilliseconds: false,
            onEnd: () {
              // 倒计时结束回调
            },
          ),
          const SizedBox(height: 16),

          // 带控制器的倒计时
          VelocityCountDown(
            duration: 5 * 60 * 1000, // 5分钟
            controller: _countdownController,
            autoStart: false,
            showLabels: true,
          ),
          const SizedBox(height: 8),

          // 控制按钮
          Wrap(
            spacing: 8,
            children: [
              ElevatedButton(
                onPressed: () => _countdownController.start(),
                child: const Text('Start'),
              ),
              ElevatedButton(
                onPressed: () => _countdownController.pause(),
                child: const Text('Pause'),
              ),
              ElevatedButton(
                onPressed: () => _countdownController.reset(),
                child: const Text('Reset'),
              ),
              ElevatedButton(
                onPressed: () => _countdownController.restart(),
                child: const Text('Restart'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Descriptions 描述列表组件示例
  Widget _buildDescriptionsSection() {
    return _buildSection(
      title: 'Descriptions',
      description: '描述列表组件，用于展示键值对信息',
      child: const VelocityDescriptions(
        title: 'User Information',
        column: 2,
        layout: VelocityDescriptionsLayout.horizontal,
        items: [
          VelocityDescriptionsItem(
            title: 'Name',
            content: 'John Doe',
          ),
          VelocityDescriptionsItem(
            title: 'Email',
            content: 'john@example.com',
          ),
          VelocityDescriptionsItem(
            title: 'Phone',
            content: '+1 234 567 890',
          ),
          VelocityDescriptionsItem(
            title: 'Address',
            content: '123 Main St, City',
            span: 2, // 占据两列
          ),
        ],
      ),
    );
  }

  /// List 列表组件示例
  Widget _buildListSection() {
    return _buildSection(
      title: 'List',
      description: '列表组件，支持分组和自定义样式',
      child: VelocityListGroup(
        header: const Text('Settings'),
        divider: true,
        children: [
          VelocityListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            subtitle: const Text('View and edit your profile'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          VelocityListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            subtitle: const Text('Manage notification settings'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          VelocityListTile(
            leading: const Icon(Icons.security),
            title: const Text('Security'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  /// Statistic 统计数值组件示例
  Widget _buildStatisticSection() {
    return _buildSection(
      title: 'Statistic',
      description: '统计数值组件，用于展示数据统计',
      child: const Wrap(
        spacing: 32,
        runSpacing: 16,
        children: [
          // 基础统计
          VelocityStatistic(
            title: 'Total Users',
            value: 12345,
          ),
          // 带前缀
          VelocityStatistic(
            title: 'Revenue',
            value: 9876.54,
            precision: 2,
            prefix: Text('\$'),
          ),
          // 带后缀
          VelocityStatistic(
            title: 'Growth',
            value: 23.5,
            precision: 1,
            suffix: '%',
          ),
          // 带趋势
          VelocityStatistic(
            title: 'Sales',
            value: 1234,
            trend: VelocityStatisticTrend.up,
            trendValue: '12%',
          ),
          VelocityStatistic(
            title: 'Costs',
            value: 567,
            trend: VelocityStatisticTrend.down,
            trendValue: '5%',
          ),
        ],
      ),
    );
  }

  /// Table 表格组件示例
  Widget _buildTableSection() {
    return _buildSection(
      title: 'Table',
      description: '表格组件，支持斑马纹和边框',
      child: VelocityTable(
        striped: true,
        bordered: true,
        columns: const [
          VelocityTableColumn(title: 'Name', flex: 2),
          VelocityTableColumn(title: 'Age', flex: 1, align: TextAlign.center),
          VelocityTableColumn(title: 'Email', flex: 3),
        ],
        rows: [
          VelocityTableRow(
            cells: const ['John Doe', 28, 'john@example.com'],
            onTap: () {},
          ),
          const VelocityTableRow(
            cells: ['Jane Smith', 32, 'jane@example.com'],
          ),
          const VelocityTableRow(
            cells: ['Bob Johnson', 45, 'bob@example.com'],
          ),
        ],
      ),
    );
  }

  /// Timeline 时间线组件示例
  Widget _buildTimelineSection() {
    return _buildSection(
      title: 'Timeline',
      description: '时间线组件，用于展示时间顺序的事件',
      child: const VelocityTimeline(
        items: [
          VelocityTimelineItem(
            label: 'Order Placed',
            time: '2024-01-15 10:00',
            content: Text('Your order has been placed successfully.'),
            color: Colors.blue,
          ),
          VelocityTimelineItem(
            label: 'Processing',
            time: '2024-01-15 14:30',
            content: Text('Your order is being processed.'),
            color: Colors.orange,
            icon: Icons.sync,
          ),
          VelocityTimelineItem(
            label: 'Shipped',
            time: '2024-01-16 09:00',
            content: Text('Your order has been shipped.'),
            color: Colors.green,
            icon: Icons.local_shipping,
          ),
          VelocityTimelineItem(
            label: 'Delivered',
            time: '2024-01-17 15:00',
            hollow: true, // 空心圆点
          ),
        ],
      ),
    );
  }

  /// Tree 树形组件示例
  Widget _buildTreeSection() {
    return _buildSection(
      title: 'Tree',
      description: '树形组件，支持展开/折叠和复选',
      child: SizedBox(
        height: 300,
        child: VelocityTree(
          expandAll: false,
          checkable: true,
          showLines: true,
          defaultExpandedKeys: const ['1'],
          onNodeClick: (node) {
            // 节点点击回调
          },
          onNodeCheck: (checkedKeys) {
            // 复选回调
          },
          data: const [
            VelocityTreeNode(
              key: '1',
              title: 'Documents',
              icon: Icons.folder,
              children: [
                VelocityTreeNode(
                  key: '1-1',
                  title: 'Work',
                  icon: Icons.folder,
                  children: [
                    VelocityTreeNode(
                      key: '1-1-1',
                      title: 'Report.pdf',
                      icon: Icons.description,
                      isLeaf: true,
                    ),
                    VelocityTreeNode(
                      key: '1-1-2',
                      title: 'Presentation.pptx',
                      icon: Icons.slideshow,
                      isLeaf: true,
                    ),
                  ],
                ),
                VelocityTreeNode(
                  key: '1-2',
                  title: 'Personal',
                  icon: Icons.folder,
                  children: [
                    VelocityTreeNode(
                      key: '1-2-1',
                      title: 'Photo.jpg',
                      icon: Icons.image,
                      isLeaf: true,
                    ),
                  ],
                ),
              ],
            ),
            VelocityTreeNode(
              key: '2',
              title: 'Downloads',
              icon: Icons.download,
              children: [
                VelocityTreeNode(
                  key: '2-1',
                  title: 'Software.zip',
                  icon: Icons.archive,
                  isLeaf: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 构建示例区块
  Widget _buildSection({
    required String title,
    required String description,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 16),
        child,
      ],
    );
  }
}
