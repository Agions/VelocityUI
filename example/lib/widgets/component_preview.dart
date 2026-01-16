/// Interactive Component Preview Widget
///
/// 交互式组件预览组件，用于在文档中展示组件的实时预览和源代码。
/// 支持属性修改和实时更新。
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 组件预览配置
class ComponentPreviewConfig {
  const ComponentPreviewConfig({
    required this.title,
    required this.description,
    this.sourceCode,
    this.variants = const [],
  });

  /// 组件标题
  final String title;

  /// 组件描述
  final String description;

  /// 源代码
  final String? sourceCode;

  /// 组件变体列表
  final List<ComponentVariant> variants;
}

/// 组件变体
class ComponentVariant {
  const ComponentVariant({
    required this.name,
    required this.builder,
    this.sourceCode,
  });

  /// 变体名称
  final String name;

  /// 组件构建器
  final Widget Function(BuildContext context) builder;

  /// 变体源代码
  final String? sourceCode;
}

/// 属性控制器
abstract class PropertyController<T> {
  PropertyController({
    required this.name,
    required this.initialValue,
    this.description,
  }) : _value = initialValue;

  /// 属性名称
  final String name;

  /// 初始值
  final T initialValue;

  /// 属性描述
  final String? description;

  /// 当前值
  T _value;
  T get value => _value;
  set value(T newValue) {
    _value = newValue;
    _onChanged?.call(newValue);
  }

  /// 值变化回调
  ValueChanged<T>? _onChanged;
  void setOnChanged(ValueChanged<T>? callback) => _onChanged = callback;

  /// 构建控制器UI
  Widget buildController(BuildContext context);

  /// 重置为初始值
  void reset() => value = initialValue;
}

/// 布尔属性控制器
class BoolPropertyController extends PropertyController<bool> {
  BoolPropertyController({
    required super.name,
    required super.initialValue,
    super.description,
  });

  @override
  Widget buildController(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return SwitchListTile(
          title: Text(name),
          subtitle: description != null ? Text(description!) : null,
          value: value,
          onChanged: (newValue) {
            setState(() => value = newValue);
          },
          dense: true,
          contentPadding: EdgeInsets.zero,
        );
      },
    );
  }
}

/// 字符串属性控制器
class StringPropertyController extends PropertyController<String> {
  StringPropertyController({
    required super.name,
    required super.initialValue,
    super.description,
    this.maxLines = 1,
  });

  final int maxLines;

  @override
  Widget buildController(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return TextField(
          decoration: InputDecoration(
            labelText: name,
            helperText: description,
            border: const OutlineInputBorder(),
            isDense: true,
          ),
          controller: TextEditingController(text: value),
          maxLines: maxLines,
          onChanged: (newValue) {
            setState(() => value = newValue);
          },
        );
      },
    );
  }
}

/// 数值属性控制器
class NumberPropertyController extends PropertyController<double> {
  NumberPropertyController({
    required super.name,
    required super.initialValue,
    super.description,
    this.min = 0,
    this.max = 100,
    this.divisions,
  });

  final double min;
  final double max;
  final int? divisions;

  @override
  Widget buildController(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(name),
                const Spacer(),
                Text(value.toStringAsFixed(1)),
              ],
            ),
            if (description != null)
              Text(
                description!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            Slider(
              value: value.clamp(min, max),
              min: min,
              max: max,
              divisions: divisions,
              onChanged: (newValue) {
                setState(() => value = newValue);
              },
            ),
          ],
        );
      },
    );
  }
}

/// 枚举属性控制器
class EnumPropertyController<T> extends PropertyController<T> {
  EnumPropertyController({
    required super.name,
    required super.initialValue,
    required this.options,
    super.description,
  });

  final List<T> options;

  @override
  Widget buildController(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name),
            if (description != null)
              Text(
                description!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: options.map((option) {
                final isSelected = option == value;
                return ChoiceChip(
                  label: Text(option.toString().split('.').last),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() => value = option);
                    }
                  },
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}

/// 颜色属性控制器
class ColorPropertyController extends PropertyController<Color> {
  ColorPropertyController({
    required super.name,
    required super.initialValue,
    super.description,
    this.colors = const [
      Colors.red,
      Colors.pink,
      Colors.purple,
      Colors.blue,
      Colors.cyan,
      Colors.teal,
      Colors.green,
      Colors.orange,
      Colors.grey,
      Colors.black,
    ],
  });

  final List<Color> colors;

  @override
  Widget buildController(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name),
            if (description != null)
              Text(
                description!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: colors.map((color) {
                final isSelected = color.value == value.value;
                return GestureDetector(
                  onTap: () => setState(() => value = color),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? Colors.black : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: isSelected
                        ? Icon(
                            Icons.check,
                            size: 16,
                            color: color.computeLuminance() > 0.5
                                ? Colors.black
                                : Colors.white,
                          )
                        : null,
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}

/// 交互式组件预览
class ComponentPreview extends StatefulWidget {
  const ComponentPreview({
    required this.config,
    super.key,
    this.properties = const [],
    this.builder,
    this.initialVariantIndex = 0,
    this.showCode = true,
    this.showProperties = true,
  });

  /// 预览配置
  final ComponentPreviewConfig config;

  /// 属性控制器列表
  final List<PropertyController> properties;

  /// 自定义组件构建器
  final Widget Function(BuildContext context, List<PropertyController>)?
      builder;

  /// 初始变体索引
  final int initialVariantIndex;

  /// 是否显示代码
  final bool showCode;

  /// 是否显示属性面板
  final bool showProperties;

  @override
  State<ComponentPreview> createState() => _ComponentPreviewState();
}

class _ComponentPreviewState extends State<ComponentPreview>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedVariantIndex = 0;
  bool _showCode = false;

  @override
  void initState() {
    super.initState();
    _selectedVariantIndex = widget.initialVariantIndex;
    _tabController = TabController(
      length:
          widget.config.variants.isEmpty ? 1 : widget.config.variants.length,
      vsync: this,
      initialIndex: _selectedVariantIndex,
    );
    _tabController.addListener(_onTabChanged);

    // 设置属性变化监听
    for (final property in widget.properties) {
      property.setOnChanged((_) => setState(() {}));
    }
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) {
      setState(() => _selectedVariantIndex = _tabController.index);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          if (widget.config.variants.isNotEmpty) _buildVariantTabs(),
          _buildPreviewArea(),
          if (widget.showProperties && widget.properties.isNotEmpty)
            _buildPropertiesPanel(),
          if (widget.showCode && _showCode) _buildCodePanel(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.config.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  widget.config.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),
          ),
          if (widget.showCode)
            IconButton(
              icon: Icon(_showCode ? Icons.code_off : Icons.code),
              onPressed: () => setState(() => _showCode = !_showCode),
              tooltip: _showCode ? 'Hide Code' : 'Show Code',
            ),
          if (widget.properties.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _resetProperties,
              tooltip: 'Reset Properties',
            ),
        ],
      ),
    );
  }

  Widget _buildVariantTabs() {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      tabs: widget.config.variants
          .map((variant) => Tab(text: variant.name))
          .toList(),
    );
  }

  Widget _buildPreviewArea() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border.symmetric(
          horizontal: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Center(
        child: _buildComponent(),
      ),
    );
  }

  Widget _buildComponent() {
    if (widget.builder != null) {
      return widget.builder!(context, widget.properties);
    }

    if (widget.config.variants.isNotEmpty) {
      return widget.config.variants[_selectedVariantIndex].builder(context);
    }

    return const Text('No component to preview');
  }

  Widget _buildPropertiesPanel() {
    return ExpansionTile(
      title: const Text('Properties'),
      initiallyExpanded: true,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: widget.properties
                .map((property) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: property.buildController(context),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildCodePanel() {
    final sourceCode = _getCurrentSourceCode();
    if (sourceCode == null) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Source Code',
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.copy, color: Colors.white70, size: 18),
                onPressed: () => _copyCode(sourceCode),
                tooltip: 'Copy Code',
              ),
            ],
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SelectableText(
              sourceCode,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                color: Colors.white,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? _getCurrentSourceCode() {
    if (widget.config.variants.isNotEmpty) {
      return widget.config.variants[_selectedVariantIndex].sourceCode ??
          widget.config.sourceCode;
    }
    return widget.config.sourceCode;
  }

  void _copyCode(String code) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Code copied to clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _resetProperties() {
    for (final property in widget.properties) {
      property.reset();
    }
    setState(() {});
  }
}
