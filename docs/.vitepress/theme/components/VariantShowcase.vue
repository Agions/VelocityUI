<script setup lang="ts">
import { ref } from 'vue'

interface Variant {
  name: string
  description: string
  code: string
}

const props = defineProps<{
  title: string
  variants: Variant[]
}>()

const selectedIndex = ref(0)
const copied = ref(false)

const copyCode = async (code: string) => {
  try {
    await navigator.clipboard.writeText(code)
    copied.value = true
    setTimeout(() => {
      copied.value = false
    }, 2000)
  } catch (err) {
    console.error('Failed to copy:', err)
  }
}
</script>

<template>
  <div class="variant-showcase">
    <div class="showcase-header">
      <h4 class="showcase-title">{{ title }}</h4>
    </div>
    
    <div class="variant-selector">
      <button
        v-for="(variant, index) in variants"
        :key="variant.name"
        class="variant-btn"
        :class="{ active: selectedIndex === index }"
        @click="selectedIndex = index"
      >
        {{ variant.name }}
      </button>
    </div>
    
    <div class="variant-content">
      <div class="variant-description">
        {{ variants[selectedIndex].description }}
      </div>
      
      <div class="variant-code">
        <div class="code-toolbar">
          <span class="code-lang">dart</span>
          <button 
            class="copy-btn" 
            @click="copyCode(variants[selectedIndex].code)"
          >
            {{ copied ? '✓ 已复制' : '📋 复制' }}
          </button>
        </div>
        <pre><code class="language-dart">{{ variants[selectedIndex].code }}</code></pre>
      </div>
    </div>
  </div>
</template>

<style scoped>
.variant-showcase {
  border: 1px solid var(--vp-c-divider);
  border-radius: 8px;
  margin: 16px 0;
  overflow: hidden;
}

.showcase-header {
  padding: 12px 16px;
  background: var(--vp-c-bg-soft);
  border-bottom: 1px solid var(--vp-c-divider);
}

.showcase-title {
  margin: 0;
  font-size: 14px;
  font-weight: 600;
  color: var(--vp-c-text-1);
}

.variant-selector {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  padding: 12px 16px;
  background: var(--vp-c-bg);
  border-bottom: 1px solid var(--vp-c-divider);
}

.variant-btn {
  padding: 6px 12px;
  border: 1px solid var(--vp-c-divider);
  border-radius: 16px;
  background: var(--vp-c-bg);
  color: var(--vp-c-text-2);
  font-size: 13px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.variant-btn:hover {
  border-color: var(--vp-c-brand-1);
  color: var(--vp-c-brand-1);
}

.variant-btn.active {
  background: var(--vp-c-brand-1);
  border-color: var(--vp-c-brand-1);
  color: white;
}

.variant-content {
  padding: 16px;
}

.variant-description {
  margin-bottom: 12px;
  font-size: 14px;
  color: var(--vp-c-text-2);
}

.variant-code {
  border-radius: 6px;
  overflow: hidden;
  background: #1e1e1e;
}

.code-toolbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 8px 12px;
  background: #2d2d2d;
  border-bottom: 1px solid #3d3d3d;
}

.code-lang {
  font-size: 12px;
  color: #888;
  text-transform: uppercase;
}

.copy-btn {
  padding: 4px 8px;
  border: none;
  border-radius: 4px;
  background: transparent;
  color: #888;
  font-size: 12px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.copy-btn:hover {
  background: #3d3d3d;
  color: #fff;
}

.variant-code pre {
  margin: 0;
  padding: 12px;
  overflow-x: auto;
}

.variant-code code {
  font-family: var(--vp-font-family-mono);
  font-size: 13px;
  line-height: 1.5;
  color: #d4d4d4;
}
</style>
