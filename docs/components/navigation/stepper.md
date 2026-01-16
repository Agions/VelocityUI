# Stepper 步骤条

步骤条组件用于展示流程步骤。

## 基础用法

```dart
VelocityStepper(
  currentStep: 1,
  steps: [
    Step(title: '步骤1', content: Text('内容1')),
    Step(title: '步骤2', content: Text('内容2')),
    Step(title: '步骤3', content: Text('内容3')),
  ],
)
```

## API

### 属性

| 属性          | 类型          | 默认值 | 说明       |
| ------------- | ------------- | ------ | ---------- |
| `currentStep` | `int`         | `0`    | 当前步骤   |
| `steps`       | `List<Step>`  | -      | 步骤列表   |
| `onStepTapped` | `ValueChanged<int>?` | -      | 步骤点击回调 |
