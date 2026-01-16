# VelocityUI 文档

VelocityUI 官方文档站点，基于 VitePress 构建。

## 本地开发

### 安装依赖

```bash
cd docs
npm install
```

### 启动开发服务器

```bash
npm run docs:dev
```

访问 http://localhost:5173

### 构建生产版本

```bash
npm run docs:build
```

### 预览生产版本

```bash
npm run docs:preview
```

## 文档结构

```
docs/
├── .vitepress/          # VitePress 配置
│   ├── config.ts        # 站点配置
│   └── theme/           # 主题定制
│       ├── custom.css   # 自定义样式
│       └── index.ts     # 主题入口
├── getting-started/     # 入门指南
│   ├── index.md         # 介绍
│   ├── installation.md  # 安装
│   ├── quick-start.md   # 快速开始
│   └── configuration.md # 配置
├── components/          # 组件文档
│   ├── basic/           # 基础组件
│   ├── form/            # 表单组件
│   ├── display/         # 展示组件
│   ├── feedback/        # 反馈组件
│   └── navigation/      # 导航组件
├── api/                 # API 文档
│   ├── http-client.md   # HTTP 客户端
│   ├── utilities.md     # 工具类
│   ├── theme.md         # 主题系统
│   └── types.md         # 类型定义
├── public/              # 静态资源
├── index.md             # 首页
└── faq.md               # 常见问题
```

## 编写文档

### Markdown 扩展

VitePress 支持丰富的 Markdown 扩展：

#### 代码块

````markdown
```dart
VelocityButton.primary(
  text: '按钮',
  onPressed: () {},
)
```
````

#### 自定义容器

```markdown
::: tip 提示
这是一个提示
:::

::: warning 警告
这是一个警告
:::

::: danger 危险
这是一个危险提示
:::
```

#### 表格

```markdown
| 属性 | 类型   | 说明     |
| ---- | ------ | -------- |
| text | String | 按钮文本 |
```

### 组件文档模板

每个组件文档应包含：

1. **标题和简介** - 组件名称和用途
2. **基础用法** - 最简单的使用示例
3. **变体展示** - 不同类型/状态的示例
4. **API 参考** - 完整的属性列表
5. **最佳实践** - 使用建议和注意事项
6. **示例代码** - 完整的可运行示例

### 样式指南

- 使用清晰的标题层级
- 代码示例要完整可运行
- 表格用于展示 API 参数
- 使用自定义容器突出重要信息
- 添加适当的代码注释

## 主题定制

### 颜色系统

在 `custom.css` 中定义：

```css
:root {
  --vp-c-brand-1: #10b981; /* 主色调 */
  --vp-c-brand-2: #059669; /* 深色 */
  --vp-c-brand-3: #047857; /* 更深 */
}
```

### 组件样式

为特定组件添加样式：

```css
.vp-doc .custom-component {
  /* 自定义样式 */
}
```

## 部署

### GitHub Pages

```bash
npm run docs:build
# 将 .vitepress/dist 目录部署到 GitHub Pages
```

### Vercel

1. 连接 GitHub 仓库
2. 设置构建命令：`cd docs && npm run docs:build`
3. 设置输出目录：`docs/.vitepress/dist`

### Netlify

1. 连接 GitHub 仓库
2. 设置构建命令：`cd docs && npm run docs:build`
3. 设置发布目录：`docs/.vitepress/dist`

## 贡献

欢迎贡献文档改进！

1. Fork 仓库
2. 创建分支：`git checkout -b docs/improve-xxx`
3. 提交更改：`git commit -m 'docs: improve xxx'`
4. 推送分支：`git push origin docs/improve-xxx`
5. 提交 Pull Request

## 许可证

MIT License
