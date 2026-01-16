# Loading 加载

加载组件用于显示加载状态。

## 基础用法

```dart
VelocityLoading()
```

## 全屏加载

```dart
VelocityLoading.fullscreen(
  message: '加载中...',
)
```

## API

### 方法

| 方法         | 参数                  | 说明         |
| ------------ | --------------------- | ------------ |
| `show`       | `{String? message}`   | 显示加载     |
| `hide`       | -                     | 隐藏加载     |
| `fullscreen` | `{String? message}`   | 全屏加载     |
