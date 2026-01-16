<script setup lang="ts">
import { ref, computed } from 'vue'

interface Variant {
  name: string
  description?: string
  code: string
  preview?: string
}

const props = defineProps<{
  component: string
  description?: string
  variants?: Variant[]
  runCommand?: string
  previewPath?: string
}>()

const selectedVariant = ref(0)
const showCode = ref(true)

const currentVariant = computed(() => {
  if (props.variants && props.variants.length > 0) {
    return props.variants[selectedVariant.value]
  }
  return null
})

const copyCode = async () => {
  const code = currentVariant.value?.code || ''
  try {
    await navigator.clipboard.writeText(code)
    // Show success feedback
  } catch (err) {
    console.error('Failed to copy code:', err)
  }
}
</script>

<template>
  <div class="interactive-preview">
    <div class="preview-header">
      <div class="preview-info">
        <h4 class="preview-title">🎮 交互式预览</h4>
        <p class="preview-description" v-if="description">{{ description }}</p>
      </div>
      <div class="preview-actions">
        <button 
          class="action-btn"
          :class="{ active: showCode }"
          @click="showCode = !showCode"
          title="显示/隐藏代码"
        >
          <span class="icon">📝</span>
          {{ showCode ? '隐藏代码' : '显示代码' }}
        </button>
      </div>
    </div>

    <!-- Variant Tabs -->
    <div class="variant-tabs" v-if="variants && variants.length > 1">
      <button
        v-for="(variant, index) in variants"
        :key="variant.name"
        class="variant-tab"
        :class="{ active: selectedVariant === index }"
        @click="selectedVariant = index"
      >
        {{ variant.name }}
      </button>
    </div>

    <!-- Preview Area -->
    <div class="preview-area">
      <div class="preview-placeholder">
        <div class="placeholder-icon">📱</div>
        <p class="placeholder-text">
          运行示例项目查看实时预览
        </p>
        <code class="run-command">cd example && flutter run</code>
        <p class="placeholder-hint" v-if="previewPath">
          导航到: <strong>{{ previewPath }}</strong>
        </p>
      </div>
    </div>

    <!-- Code Panel -->
    <div class="code-panel" v-if="showCode && currentVariant">
      <div class="code-header">
        <span class="code-title">{{ currentVariant.name }}</span>
        <button class="copy-btn" @click="copyCode" title="复制代码">
          📋 复制
        </button>
      </div>
      <div class="code-content">
        <pre><code class="language-dart">{{ currentVariant.code }}</code></pre>
      </div>
    </div>

    <!-- Run Instructions -->
    <div class="run-instructions">
      <div class="instruction-icon">💡</div>
      <div class="instruction-content">
        <p><strong>如何查看交互式预览：</strong></p>
        <ol>
          <li>克隆项目并进入 <code>example</code> 目录</li>
          <li>运行 <code>flutter run</code></li>
          <li>在首页选择 "Interactive Preview" 或对应组件示例</li>
          <li>实时修改属性并查看效果变化</li>
        </ol>
      </div>
    </div>
  </div>
</template>

<style scoped>
.interactive-preview {
  border: 1px solid var(--vp-c-divider);
  border-radius: 12px;
  margin: 24px 0;
  overflow: hidden;
  background: var(--vp-c-bg);
}

.preview-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  padding: 16px 20px;
  background: linear-gradient(135deg, var(--vp-c-brand-soft) 0%, transparent 100%);
  border-bottom: 1px solid var(--vp-c-divider);
}

.preview-info {
  flex: 1;
}

.preview-title {
  margin: 0 0 4px 0;
  font-size: 16px;
  font-weight: 600;
  color: var(--vp-c-text-1);
}

.preview-description {
  margin: 0;
  font-size: 14px;
  color: var(--vp-c-text-2);
}

.preview-actions {
  display: flex;
  gap: 8px;
}

.action-btn {
  display: flex;
  align-items: center;
  gap: 4px;
  padding: 6px 12px;
  border: 1px solid var(--vp-c-divider);
  border-radius: 6px;
  background: var(--vp-c-bg);
  color: var(--vp-c-text-2);
  font-size: 13px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.action-btn:hover {
  border-color: var(--vp-c-brand-1);
  color: var(--vp-c-brand-1);
}

.action-btn.active {
  background: var(--vp-c-brand-soft);
  border-color: var(--vp-c-brand-1);
  color: var(--vp-c-brand-1);
}

.variant-tabs {
  display: flex;
  gap: 0;
  padding: 0 16px;
  background: var(--vp-c-bg-soft);
  border-bottom: 1px solid var(--vp-c-divider);
  overflow-x: auto;
}

.variant-tab {
  padding: 12px 16px;
  border: none;
  background: transparent;
  color: var(--vp-c-text-2);
  font-size: 14px;
  cursor: pointer;
  border-bottom: 2px solid transparent;
  transition: all 0.2s ease;
  white-space: nowrap;
}

.variant-tab:hover {
  color: var(--vp-c-text-1);
}

.variant-tab.active {
  color: var(--vp-c-brand-1);
  border-bottom-color: var(--vp-c-brand-1);
}

.preview-area {
  padding: 32px;
  background: var(--vp-c-bg-soft);
  min-height: 150px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.preview-placeholder {
  text-align: center;
  color: var(--vp-c-text-2);
}

.placeholder-icon {
  font-size: 48px;
  margin-bottom: 16px;
}

.placeholder-text {
  margin: 0 0 12px 0;
  font-size: 14px;
}

.run-command {
  display: inline-block;
  padding: 8px 16px;
  background: var(--vp-c-bg);
  border: 1px solid var(--vp-c-divider);
  border-radius: 6px;
  font-family: var(--vp-font-family-mono);
  font-size: 13px;
  color: var(--vp-c-brand-1);
}

.placeholder-hint {
  margin: 12px 0 0 0;
  font-size: 13px;
  color: var(--vp-c-text-3);
}

.code-panel {
  border-top: 1px solid var(--vp-c-divider);
}

.code-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 8px 16px;
  background: #1e1e1e;
  border-bottom: 1px solid #333;
}

.code-title {
  font-size: 13px;
  color: #888;
}

.copy-btn {
  padding: 4px 8px;
  border: 1px solid #444;
  border-radius: 4px;
  background: transparent;
  color: #888;
  font-size: 12px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.copy-btn:hover {
  border-color: var(--vp-c-brand-1);
  color: var(--vp-c-brand-1);
}

.code-content {
  padding: 16px;
  background: #1e1e1e;
  overflow-x: auto;
}

.code-content pre {
  margin: 0;
}

.code-content code {
  font-family: var(--vp-font-family-mono);
  font-size: 13px;
  line-height: 1.6;
  color: #d4d4d4;
}

.run-instructions {
  display: flex;
  gap: 12px;
  padding: 16px 20px;
  background: var(--vp-c-bg-soft);
  border-top: 1px solid var(--vp-c-divider);
}

.instruction-icon {
  font-size: 20px;
  flex-shrink: 0;
}

.instruction-content {
  flex: 1;
}

.instruction-content p {
  margin: 0 0 8px 0;
  font-size: 14px;
  color: var(--vp-c-text-1);
}

.instruction-content ol {
  margin: 0;
  padding-left: 20px;
  font-size: 13px;
  color: var(--vp-c-text-2);
}

.instruction-content li {
  margin: 4px 0;
}

.instruction-content code {
  padding: 2px 6px;
  background: var(--vp-c-bg);
  border-radius: 4px;
  font-size: 12px;
}

@media (max-width: 640px) {
  .preview-header {
    flex-direction: column;
    gap: 12px;
  }
  
  .preview-actions {
    width: 100%;
  }
  
  .action-btn {
    flex: 1;
    justify-content: center;
  }
  
  .run-instructions {
    flex-direction: column;
  }
}
</style>
