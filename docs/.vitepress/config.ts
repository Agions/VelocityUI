import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'VelocityUI',
  description: '高性能企业级 Flutter UI 组件库',
  lang: 'zh-CN',

  head: [
    ['link', { rel: 'icon', href: '/logo.png' }],
    ['meta', { name: 'theme-color', content: '#3eaf7c' }],
    ['meta', { name: 'apple-mobile-web-app-capable', content: 'yes' }],
    ['meta', { name: 'apple-mobile-web-app-status-bar-style', content: 'black' }]
  ],

  themeConfig: {
    logo: '/logo.png',

    nav: [
      { text: '首页', link: '/' },
      { text: '快速开始', link: '/getting-started/' },
      { text: '组件', link: '/components/' },
      { text: 'API', link: '/api/' },
      { text: 'FAQ', link: '/faq' }
    ],

    sidebar: {
      '/getting-started/': [
        {
          text: '入门指南',
          items: [
            { text: '介绍', link: '/getting-started/' },
            { text: '安装', link: '/getting-started/installation' },
            { text: '快速开始', link: '/getting-started/quick-start' },
            { text: '配置', link: '/getting-started/configuration' },
            { text: '交互式预览', link: '/getting-started/interactive-preview' }
          ]
        }
      ],
      '/components/': [
        {
          text: '基础组件',
          collapsed: false,
          items: [
            { text: '概览', link: '/components/' },
            { text: 'Button 按钮', link: '/components/basic/button' },
            { text: 'Text 文本', link: '/components/basic/text' },
            { text: 'Icon 图标', link: '/components/basic/icon' },
            { text: 'Image 图片', link: '/components/basic/image' },
            { text: 'Chip 标签', link: '/components/basic/chip' },
            { text: 'Link 链接', link: '/components/basic/link' },
            { text: 'Spinner 加载', link: '/components/basic/spinner' }
          ]
        },
        {
          text: '表单组件',
          collapsed: false,
          items: [
            { text: 'Input 输入框', link: '/components/form/input' },
            { text: 'Select 选择器', link: '/components/form/select' },
            { text: 'Checkbox 复选框', link: '/components/form/checkbox' },
            { text: 'Radio 单选框', link: '/components/form/radio' },
            { text: 'Switch 开关', link: '/components/form/switch' },
            { text: 'Slider 滑块', link: '/components/form/slider' },
            { text: 'DatePicker 日期选择', link: '/components/form/date-picker' },
            { text: 'Rate 评分', link: '/components/form/rate' },
            { text: 'Upload 上传', link: '/components/form/upload' }
          ]
        },
        {
          text: '展示组件',
          collapsed: false,
          items: [
            { text: 'Avatar 头像', link: '/components/display/avatar' },
            { text: 'Badge 徽章', link: '/components/display/badge' },
            { text: 'Card 卡片', link: '/components/display/card' },
            { text: 'Carousel 轮播', link: '/components/display/carousel' },
            { text: 'Collapse 折叠面板', link: '/components/display/collapse' },
            { text: 'Table 表格', link: '/components/display/table' },
            { text: 'Tag 标签', link: '/components/display/tag' },
            { text: 'Timeline 时间线', link: '/components/display/timeline' },
            { text: 'Tooltip 提示', link: '/components/display/tooltip' },
            { text: 'Tree 树形控件', link: '/components/display/tree' }
          ]
        },
        {
          text: '反馈组件',
          collapsed: false,
          items: [
            { text: 'Dialog 对话框', link: '/components/feedback/dialog' },
            { text: 'Toast 轻提示', link: '/components/feedback/toast' },
            { text: 'Notification 通知', link: '/components/feedback/notification' },
            { text: 'Progress 进度条', link: '/components/feedback/progress' },
            { text: 'Skeleton 骨架屏', link: '/components/feedback/skeleton' },
            { text: 'Loading 加载', link: '/components/feedback/loading' }
          ]
        },
        {
          text: '导航组件',
          collapsed: false,
          items: [
            { text: 'Tabs 标签页', link: '/components/navigation/tabs' },
            { text: 'Menu 菜单', link: '/components/navigation/menu' },
            { text: 'Breadcrumb 面包屑', link: '/components/navigation/breadcrumb' },
            { text: 'Pagination 分页', link: '/components/navigation/pagination' },
            { text: 'Stepper 步骤条', link: '/components/navigation/stepper' },
            { text: 'Drawer 抽屉', link: '/components/navigation/drawer' }
          ]
        }
      ],
      '/api/': [
        {
          text: 'API 参考',
          items: [
            { text: '概览', link: '/api/' },
            { text: 'HTTP 客户端', link: '/api/http-client' },
            { text: '工具类', link: '/api/utilities' },
            { text: '主题系统', link: '/api/theme' },
            { text: '类型定义', link: '/api/types' }
          ]
        }
      ]
    },

    socialLinks: [
      { icon: 'github', link: 'https://github.com/Agions/velocity-ui' }
    ],

    footer: {
      message: '基于 MIT 协议发布',
      copyright: 'Copyright © 2024 Agions'
    },

    search: {
      provider: 'local',
      options: {
        locales: {
          root: {
            translations: {
              button: {
                buttonText: '搜索文档',
                buttonAriaLabel: '搜索文档'
              },
              modal: {
                noResultsText: '无法找到相关结果',
                resetButtonTitle: '清除查询条件',
                footer: {
                  selectText: '选择',
                  navigateText: '切换'
                }
              }
            }
          }
        }
      }
    },

    outline: {
      label: '页面导航',
      level: [2, 3]
    },

    docFooter: {
      prev: '上一页',
      next: '下一页'
    },

    lastUpdated: {
      text: '最后更新于',
      formatOptions: {
        dateStyle: 'short',
        timeStyle: 'medium'
      }
    },

    editLink: {
      pattern: 'https://github.com/Agions/velocity-ui/edit/main/docs/:path',
      text: '在 GitHub 上编辑此页面'
    }
  },

  markdown: {
    lineNumbers: true,
    theme: {
      light: 'one-dark-pro',
      dark: 'one-dark-pro'
    }
  }
})
