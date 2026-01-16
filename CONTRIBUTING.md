# 贡献指南

感谢你对 VelocityUI 的关注！我们欢迎任何形式的贡献，包括但不限于：

- 报告 Bug
- 提交 Pull Request
- 提出新功能建议
- 改进文档
- 帮助回答问题

## 行为准则

请遵守我们的[行为准则](CODE_OF_CONDUCT.md)，确保所有参与者都能在一个开放和友好的环境中交流。

## 开发环境设置

1. Fork 项目仓库
2. 克隆到本地：

   ```bash
   git clone https://github.com/agions/velocity-ui.git
   ```

3. 安装依赖：

   ```bash
   cd velocity-ui
   flutter pub get
   ```

## 项目结构

VelocityUI 遵循标准的 Flutter 包结构：

```
lib/
├── components/           # 组件实现
│   ├── basic/           # 基础组件
│   ├── form/            # 表单组件
│   ├── navigation/      # 导航组件
│   ├── feedback/        # 反馈组件
│   ├── display/         # 展示组件
│   ├── layout/          # 布局组件
│   └── advanced/        # 高级组件
├── core/                 # 核心系统
│   ├── theme/           # 主题系统
│   ├── constants/       # 常量定义
│   ├── extensions/      # 扩展方法
│   └── utils/           # 工具类
├── zephyr_ui.dart        # 主库导出文件
└── ...
doc/                     # 文档
test/                    # 测试文件
test_goldens/            # 视觉测试文件
assets/                  # 静态资源
example/                 # 示例应用
.gitignore               # Git 忽略文件
analysis_options.yaml    # 代码分析配置
pubspec.yaml             # 包配置文件
README.md                # 项目说明
CHANGELOG.md             # 更新日志
LICENSE                  # 许可证
CONTRIBUTING.md          # 贡献指南
CODE_OF_CONDUCT.md       # 行为准则

## 代码规范

### 代码风格

我们遵循 Flutter 和 Dart 的官方编码规范：

- 使用 `dart format` 格式化代码
- 遵循 [Effective Dart](https://dart.dev/guides/language/effective-dart) 指南
- 参考项目文档中的组件开发规范

### 命名规范

#### 组件命名
- 所有组件必须使用 `Zephyr` 前缀
- 组件名称使用 PascalCase（大驼峰命名法）
- 示例：`ZephyrButton`、`ZephyrInput`、`ZephyrCard`

#### 文件命名
- 文件名使用 snake_case（下划线命名法）
- 与组件名称保持一致
- 示例：`button.dart`、`input.dart`、`card.dart`

#### 目录结构
- 组件按功能分类存放
- 每个组件目录包含主文件、主题文件和工具文件
- 示例：`components/basic/button/`

### 提交信息规范

我们使用 [Conventional Commits](https://www.conventionalcommits.org/) 规范：

```

<type>[optional scope]: <description>

[optional body]

[optional footer(s)]

```

常见的提交类型：

- `feat`: 新功能
- `fix`: 修复 Bug
- `docs`: 文档更新
- `style`: 代码格式调整（不影响代码含义）
- `refactor`: 代码重构
- `perf`: 性能优化
- `test`: 测试相关
- `chore`: 构建过程或辅助工具的变动

示例：
```

feat(button): 添加新的按钮变体

- 添加 outline 变体
- 添加 ghost 变体
- 更新文档和示例

````

## 开发流程

### 1. 创建 Issue

在开始开发之前，请先创建一个 Issue 描述你要解决的问题或要实现的功能。

基于 `main` 分支创建新分支：

```bash
git checkout -b feature/your-feature-name
# 或
git checkout -b fix/your-bug-fix
````

### 3. 开发

- 遵循项目文档中的组件开发规范
- 编写相应的测试
- 更新相关文档
- 确保所有测试通过

### 4. 提交代码

```bash
git add .
git commit -m "feat: describe your changes"
```

### 5. 推送并创建 Pull Request

```bash
git push origin feature/your-feature-name
```

然后在 GitHub 上创建 Pull Request。

## 测试

### 单元测试

运行所有单元测试：

```bash
flutter test
```

### 视觉回归测试

运行视觉回归测试：

```bash
flutter test test_goldens
```

### 测试覆盖率

检查测试覆盖率：

```bash
flutter test --coverage
```

## 文档

### API 文档

所有公共 API 都应该有完整的文档注释，遵循 Dartdoc 格式。

### Markdown 文档

在 `doc/` 目录下维护相关文档，确保内容准确且易于理解。

## Pull Request 指南

### PR 标题

使用清晰简洁的标题描述变更内容。

### PR 描述

在 PR 描述中包含以下内容：

1. 变更的背景和目的
2. 实现方式的简要说明
3. 相关的 Issue 编号（如果有）
4. 测试情况说明

### 代码审查

所有 PR 都需要至少一个维护者的审查和批准才能合并。

## 发布流程

VelocityUI 遵循 [Semantic Versioning](https://semver.org/) 规范：

- 主版本号（MAJOR）：不兼容的 API 修改
- 次版本号（MINOR）：向后兼容的功能性新增
- 修订号（PATCH）：向后兼容的问题修正

发布由维护者负责执行。

## 问题报告

### Bug 报告

请使用提供的模板创建 Issue，包含以下信息：

1. 问题描述
2. 复现步骤
3. 预期行为
4. 实际行为
5. 环境信息（Flutter 版本、设备信息等）
6. 相关代码片段或截图

### 功能请求

请描述你希望添加的功能：

1. 功能描述
2. 使用场景
3. 可能的实现方式
4. 替代方案

## 社区

- [GitHub Issues](https://github.com/agions/velocity-ui/issues)
- [GitHub Discussions](https://github.com/agions/velocity-ui/discussions)

感谢你的贡献！
