# Upload 上传

上传组件用于文件上传功能。

## 基础用法

```dart
VelocityUpload(
  onUpload: (file) async {
    // 处理文件上传
    print('上传文件: ${file.name}');
  },
)
```

## 拖拽上传

```dart
VelocityUpload(
  type: VelocityUploadType.drag,
  hint: '将文件拖到此处，或点击上传',
  onUpload: (file) async {},
)
```

## 图片上传

```dart
VelocityUpload(
  type: VelocityUploadType.image,
  accept: ['image/*'],
  maxSize: 5 * 1024 * 1024,  // 5MB
  onUpload: (file) async {},
)
```

## 多文件上传

```dart
VelocityUpload(
  multiple: true,
  maxFiles: 5,
  onUpload: (file) async {},
)
```

## 文件列表

```dart
List<UploadFile> fileList = [];

VelocityUpload(
  fileList: fileList,
  showFileList: true,
  onUpload: (file) async {
    setState(() {
      fileList.add(file);
    });
  },
  onRemove: (file) {
    setState(() {
      fileList.remove(file);
    });
  },
)
```

## 限制文件类型

```dart
VelocityUpload(
  accept: ['.pdf', '.doc', '.docx'],
  onUpload: (file) async {},
)
```

## 自定义上传逻辑

```dart
VelocityUpload(
  customUpload: true,
  onUpload: (file) async {
    // 自定义上传逻辑
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path),
    });

    final response = await dio.post('/upload', data: formData);
    return response.data['url'];
  },
)
```

## 上传前校验

```dart
VelocityUpload(
  beforeUpload: (file) {
    if (file.size > 10 * 1024 * 1024) {
      VelocityToast.error('文件大小不能超过10MB');
      return false;
    }
    return true;
  },
  onUpload: (file) async {},
)
```

## 上传进度

```dart
VelocityUpload(
  showProgress: true,
  onUpload: (file) async {
    // 上传逻辑
  },
  onProgress: (progress) {
    print('上传进度: ${progress}%');
  },
)
```

## API

### 属性

| 属性           | 类型                          | 默认值                      | 说明               |
| -------------- | ----------------------------- | --------------------------- | ------------------ |
| `type`         | `VelocityUploadType`          | `VelocityUploadType.button` | 上传类型           |
| `accept`       | `List<String>?`               | -                           | 接受的文件类型     |
| `multiple`     | `bool`                        | `false`                     | 是否多选           |
| `maxFiles`     | `int?`                        | -                           | 最大文件数         |
| `maxSize`      | `int?`                        | -                           | 最大文件大小(字节) |
| `hint`         | `String?`                     | -                           | 提示文本           |
| `fileList`     | `List<UploadFile>?`           | -                           | 文件列表           |
| `showFileList` | `bool`                        | `true`                      | 显示文件列表       |
| `showProgress` | `bool`                        | `true`                      | 显示上传进度       |
| `customUpload` | `bool`                        | `false`                     | 自定义上传         |
| `beforeUpload` | `bool Function(UploadFile)?`  | -                           | 上传前钩子         |
| `onUpload`     | `Future Function(UploadFile)` | -                           | 上传回调           |
| `onProgress`   | `ValueChanged<double>?`       | -                           | 进度回调           |
| `onRemove`     | `ValueChanged<UploadFile>?`   | -                           | 移除文件回调       |
| `onPreview`    | `ValueChanged<UploadFile>?`   | -                           | 预览文件回调       |

### VelocityUploadType

| 值       | 说明         |
| -------- | ------------ |
| `button` | 按钮上传     |
| `drag`   | 拖拽上传     |
| `image`  | 图片卡片上传 |
