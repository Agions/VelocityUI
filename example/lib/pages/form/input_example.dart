/// Input Component Examples
///
/// 展示 VelocityInput 组件的所有主要用例和配置。
library;

import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 输入框组件示例
class InputExample extends StatefulWidget {
  const InputExample({super.key});

  @override
  State<InputExample> createState() => _InputExampleState();
}

class _InputExampleState extends State<InputExample> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _emailError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateEmail(String value) {
    setState(() {
      if (value.isEmpty) {
        _emailError = null;
      } else if (!value.contains('@')) {
        _emailError = '请输入有效的邮箱地址';
      } else {
        _emailError = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 基础输入框
        _buildSubsection(
          title: '基础输入框 (Basic Input)',
          child: const VelocityInput(
            label: 'Username',
            hint: 'Enter your username',
            semanticLabel: 'Username input field',
          ),
        ),

        const SizedBox(height: 16),

        // 带图标的输入框
        _buildSubsection(
          title: '带图标输入框 (Input with Icons)',
          child: Column(
            children: [
              VelocityInput(
                label: 'Email',
                hint: 'Enter your email',
                prefixIcon: Icons.email,
                controller: _emailController,
                error: _emailError,
                onChanged: _validateEmail,
                keyboardType: TextInputType.emailAddress,
                semanticLabel: 'Email input field',
              ),
              const SizedBox(height: 12),
              const VelocityInput(
                label: 'Search',
                hint: 'Search...',
                prefixIcon: Icons.search,
                suffixIcon: Icons.clear,
                semanticLabel: 'Search input field',
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 密码输入框
        _buildSubsection(
          title: '密码输入框 (Password Input)',
          child: VelocityInput(
            label: 'Password',
            hint: 'Enter your password',
            obscureText: true,
            controller: _passwordController,
            prefixIcon: Icons.lock,
            semanticLabel: 'Password input field',
          ),
        ),

        const SizedBox(height: 16),

        // 输入框尺寸
        _buildSubsection(
          title: '输入框尺寸 (Input Sizes)',
          child: const Column(
            children: [
              VelocityInput(
                hint: 'Small input',
                size: VelocityInputSize.small,
                semanticLabel: 'Small size input',
              ),
              SizedBox(height: 12),
              VelocityInput(
                hint: 'Medium input (default)',
                size: VelocityInputSize.medium,
                semanticLabel: 'Medium size input',
              ),
              SizedBox(height: 12),
              VelocityInput(
                hint: 'Large input',
                size: VelocityInputSize.large,
                semanticLabel: 'Large size input',
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 带帮助文本
        _buildSubsection(
          title: '帮助文本 (Helper Text)',
          child: const VelocityInput(
            label: 'Phone Number',
            hint: 'Enter your phone number',
            helper: 'We will never share your phone number',
            prefixIcon: Icons.phone,
            semanticLabel: 'Phone number input field',
          ),
        ),

        const SizedBox(height: 16),

        // 错误状态
        _buildSubsection(
          title: '错误状态 (Error State)',
          child: const VelocityInput(
            label: 'Email',
            hint: 'Enter your email',
            error: 'Please enter a valid email address',
            prefixIcon: Icons.email,
            semanticLabel: 'Email input with error',
          ),
        ),

        const SizedBox(height: 16),

        // 禁用和只读状态
        _buildSubsection(
          title: '禁用和只读状态 (Disabled & ReadOnly)',
          child: const Column(
            children: [
              VelocityInput(
                label: 'Disabled Input',
                hint: 'This input is disabled',
                enabled: false,
                semanticLabel: 'Disabled input field',
              ),
              SizedBox(height: 12),
              VelocityInput(
                label: 'Read Only Input',
                hint: 'This input is read only',
                readOnly: true,
                semanticLabel: 'Read only input field',
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 多行文本输入
        _buildSubsection(
          title: '多行文本输入 (TextArea)',
          child: const VelocityTextArea(
            label: 'Description',
            hint: 'Enter a description...',
            maxLines: 4,
            minLines: 3,
            semanticLabel: 'Description text area',
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
