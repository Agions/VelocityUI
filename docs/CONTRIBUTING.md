# 文档贡献指南

感谢你对 VelocityUI 文档的贡献！

## 开始之前

在开始贡献之前，请：

1. 阅读 [行为准则](../CODE_OF_CONDUCT.md)
2. 查看 [现有 Issues](https://github.com/Agions/velocity-ui/issues)
3. 了解文档结构和编写规范

## 本地开发

### 环境准备

```bash
# 克隆仓库
git clone https://github.com/Agions/velocity-ui.git
cd velocity-ui/docs

# 安装依赖
npm install

# 启动开发服务器
npm run docs:dev
```

### 创建分支

```bash
git checkout -b docs/your-feature-name
```

## 文档类型

### 1. 组件文档

位置：`docs/components/[category]/[component].md`

必须包含：

- 组件介绍
- 基础用法
- API 参考
- 使用示例
- 最佳实践

模板：

```markdown
# ComponentName 组件名

组件简介和用途说明。

## 基础用法

最简单的使用示例。

\`\`\`dart
VelocityComponent(
// 示例代码
)
\`\`\`

## API 参考

| 属性 | 类型 | 默认值  | 说明 |
| ---- | ---- | ------- | ---- |
| prop | Type | default | 说明 |

## 最佳实践

::: tip 推荐
推荐的使用方式
:::

::: warning 注意
需要注意的事项
:::
```

### 2. API 文档

位置：`docs/api/[module].md`

必须包含：

- 模块介绍
- 类/函数签名
- 参数说明
- 返回值说明
- 使用示例

### 3. 指南文档

位置：`docs/getting-started/[guide].md`

必须包含：

- 清晰的步骤说明
- 完整的代码示例
- 常见问题解答

## 编写规范

### Markdown 规范

1. **标题层级**

   - 使用 `#` 表示一级标题（页面标题）
   - 使用 `##` 表示二级标题（主要章节）
   - 使用 `###` 表示三级标题（子章节）
   - 不要跳级使用标题

2. **代码块**

   - 始终指定语言：````dart`
   - 代码要完整可运行
   - 添加必要的注释

3. **链接**

   - 内部链接使用相对路径：`[文本](/path/to/page)`
   - 外部链接使用完整 URL

4. **表格**
   - 用于展示结构化数据
   - 保持列对齐
   - 表头使用粗体

### 代码示例规范

1. **完整性**

   ```dart
   // ✅ 好的示例 - 完整可运行
   import 'package:velocity_ui/velocity_ui.dart';

   VelocityButton.primary(
     text: '按钮',
     onPressed: () {
       print('Clicked');
     },
   )

   // ❌ 不好的示例 - 不完整
   VelocityButton(text: '按钮')
   ```

2. **简洁性**

   - 只展示相关代码
   - 移除不必要的导入和配置

3. **注释**
   ```dart
   // 创建主要按钮
   VelocityButton.primary(
     text: '提交',
     loading: isLoading,  // 显示加载状态
     onPressed: _handleSubmit,
   )
   ```

### 术语规范

| 中文 | 英文      | 说明           |
| ---- | --------- | -------------- |
| 组件 | Component | Flutter Widget |
| 属性 | Property  | 组件参数       |
| 回调 | Callback  | 函数参数       |
| 状态 | State     | 组件状态       |
| 主题 | Theme     | 样式配置       |

## 提交规范

### Commit Message

遵循 [Conventional Commits](https://www.conventionalcommits.org/)：

```
docs: 简短描述

详细说明（可选）

Closes #123
```

类型：

- `docs`: 文档更新
- `fix`: 修复文档错误
- `feat`: 添加新文档
- `style`: 格式调整
- `refactor`: 文档重构

示例：

```
docs: 添加 Button 组件的高级用法示例

- 添加自定义样式示例
- 添加组合使用示例
- 更新 API 表格

Closes #456
```

### Pull Request

1. **标题**

   - 清晰描述改动内容
   - 使用中文或英文

2. **描述**

   - 说明改动原因
   - 列出主要变更
   - 添加截图（如有必要）

3. **检查清单**
   - [ ] 本地测试通过
   - [ ] 无拼写错误
   - [ ] 链接正确
   - [ ] 代码示例可运行
   - [ ] 遵循编写规范

## 审查流程

1. 提交 PR 后，维护者会进行审查
2. 根据反馈进行修改
3. 审查通过后合并

## 常见问题

### 如何添加新组件文档？

1. 在对应分类目录创建 `.md` 文件
2. 按照模板编写文档
3. 在 `config.ts` 中添加侧边栏配置
4. 提交 PR

### 如何更新现有文档？

1. 找到对应的 `.md` 文件
2. 进行修改
3. 本地预览确认
4. 提交 PR

### 如何添加图片？

1. 将图片放在 `docs/public/images/` 目录
2. 在文档中引用：`![描述](/images/xxx.png)`

## 获取帮助

- [GitHub Discussions](https://github.com/Agions/velocity-ui/discussions)
- [Issues](https://github.com/Agions/velocity-ui/issues)

## 致谢

感谢所有贡献者！你的贡献让 VelocityUI 变得更好。
