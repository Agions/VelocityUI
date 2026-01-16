# Carousel 轮播图

轮播图组件用于循环播放一组图片或内容。

## 基础用法

```dart
VelocityCarousel(
  items: [
    Image.network('https://example.com/image1.jpg'),
    Image.network('https://example.com/image2.jpg'),
    Image.network('https://example.com/image3.jpg'),
  ],
)
```

## 自动播放

```dart
VelocityCarousel(
  items: images,
  autoPlay: true,
  autoPlayInterval: Duration(seconds: 3),
)
```

## 指示器

```dart
VelocityCarousel(
  items: images,
  showIndicators: true,
  indicatorPosition: VelocityCarouselIndicatorPosition.bottom,
)
```

## 无限循环

```dart
VelocityCarousel(
  items: images,
  infinite: true,
)
```

## API

### 属性

| 属性                | 类型                                | 默认值                                      | 说明         |
| ------------------- | ----------------------------------- | ------------------------------------------- | ------------ |
| `items`             | `List<Widget>`                      | -                                           | 轮播项列表   |
| `height`            | `double?`                           | `200`                                       | 高度         |
| `autoPlay`          | `bool`                              | `false`                                     | 自动播放     |
| `autoPlayInterval`  | `Duration`                          | `Duration(seconds: 3)`                      | 播放间隔     |
| `infinite`          | `bool`                              | `true`                                      | 无限循环     |
| `showIndicators`    | `bool`                              | `true`                                      | 显示指示器   |
| `indicatorPosition` | `VelocityCarouselIndicatorPosition` | `VelocityCarouselIndicatorPosition.bottom` | 指示器位置   |
| `onChanged`         | `ValueChanged<int>?`                | -                                           | 切换回调     |
