/// Switch Component Examples
///
/// 展示 VelocitySwitch 组件的所有主要用例和配置。
library;

import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 开关组件示例
class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool _switch1 = false;
  bool _switch2 = true;
  bool _notifications = true;
  bool _darkMode = false;
  bool _autoSave = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 基础开关
        _buildSubsection(
          title: '基础开关 (Basic Switch)',
          child: Column(
            children: [
              VelocitySwitch(
                value: _switch1,
                onChanged: (value) {
                  setState(() => _switch1 = value);
                },
              ),
              const SizedBox(height: 8),
              VelocitySwitch(
                value: _switch2,
                onChanged: (value) {
                  setState(() => _switch2 = value);
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 带标签的开关
        _buildSubsection(
          title: '带标签开关 (Switch with Label)',
          child: Column(
            children: [
              VelocitySwitch(
                label: 'Enable notifications',
                value: _notifications,
                onChanged: (value) {
                  setState(() => _notifications = value);
                },
              ),
              const SizedBox(height: 8),
              VelocitySwitch(
                label: 'Dark mode',
                value: _darkMode,
                onChanged: (value) {
                  setState(() => _darkMode = value);
                },
              ),
              const SizedBox(height: 8),
              VelocitySwitch(
                label: 'Auto save',
                value: _autoSave,
                onChanged: (value) {
                  setState(() => _autoSave = value);
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 禁用状态
        _buildSubsection(
          title: '禁用状态 (Disabled State)',
          child: const Column(
            children: [
              VelocitySwitch(
                label: 'Disabled (off)',
                value: false,
                disabled: true,
                onChanged: null,
              ),
              SizedBox(height: 8),
              VelocitySwitch(
                label: 'Disabled (on)',
                value: true,
                disabled: true,
                onChanged: null,
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 自定义样式
        _buildSubsection(
          title: '自定义样式 (Custom Style)',
          child: Column(
            children: [
              VelocitySwitch(
                label: 'Green track',
                value: _switch1,
                style: const VelocitySwitchStyle(
                  activeTrackColor: Colors.green,
                ),
                onChanged: (value) {
                  setState(() => _switch1 = value);
                },
              ),
              const SizedBox(height: 8),
              VelocitySwitch(
                label: 'Orange track',
                value: _switch2,
                style: const VelocitySwitchStyle(
                  activeTrackColor: Colors.orange,
                ),
                onChanged: (value) {
                  setState(() => _switch2 = value);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSubsection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}
