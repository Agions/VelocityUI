import DefaultTheme from 'vitepress/theme'
import type { Theme } from 'vitepress'
import './custom.css'
import InteractivePreview from './components/InteractivePreview.vue'
import VariantShowcase from './components/VariantShowcase.vue'

export default {
  extends: DefaultTheme,
  enhanceApp({ app }) {
    // 注册全局组件
    app.component('InteractivePreview', InteractivePreview)
    app.component('VariantShowcase', VariantShowcase)
  }
} satisfies Theme
