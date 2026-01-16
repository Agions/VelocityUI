import 'package:flutter/widgets.dart';
import 'velocity_controller.dart';

/// A controller for managing text input state in VelocityUI input components.
///
/// This controller wraps a [TextEditingController] and provides convenient
/// methods for text manipulation while ensuring proper resource disposal.
///
/// Example usage:
/// ```dart
/// final controller = VelocityInputController(text: 'Initial text');
///
/// // Use with VelocityInput
/// VelocityInput(
///   controller: controller,
///   onChanged: (value) => print('Text changed: $value'),
/// )
///
/// // Access and modify text
/// print(controller.text);
/// controller.text = 'New text';
/// controller.clear();
///
/// // Don't forget to dispose when done
/// controller.dispose();
/// ```
///
/// **Validates: Requirements 10.2**
class VelocityInputController extends VelocityController {
  /// Creates a [VelocityInputController] with optional initial text.
  ///
  /// The [text] parameter sets the initial text value.
  VelocityInputController({String? text})
      : _textController = TextEditingController(text: text);

  /// Creates a [VelocityInputController] from an existing [TextEditingController].
  ///
  /// Note: When using this constructor, the provided [TextEditingController]
  /// will be disposed when this controller is disposed.
  VelocityInputController.fromController(TextEditingController controller)
      : _textController = controller;

  final TextEditingController _textController;

  /// The underlying [TextEditingController].
  ///
  /// Use this to access advanced features of [TextEditingController]
  /// or to pass to Flutter widgets that require it.
  TextEditingController get textController => _textController;

  /// The current text value.
  String get text => _textController.text;

  /// Sets the text value and notifies listeners.
  ///
  /// If the controller is disposed, this is a no-op.
  set text(String value) {
    if (isDisposed) return;
    if (_textController.text != value) {
      _textController.text = value;
      safeNotifyListeners();
    }
  }

  /// The current text selection.
  TextSelection get selection => _textController.selection;

  /// Sets the text selection.
  ///
  /// If the controller is disposed, this is a no-op.
  set selection(TextSelection value) {
    if (isDisposed) return;
    _textController.selection = value;
    safeNotifyListeners();
  }

  /// Whether the text is empty.
  bool get isEmpty => _textController.text.isEmpty;

  /// Whether the text is not empty.
  bool get isNotEmpty => _textController.text.isNotEmpty;

  /// The length of the current text.
  int get length => _textController.text.length;

  /// Clears the text and notifies listeners.
  ///
  /// If the controller is disposed, this is a no-op.
  void clear() {
    if (isDisposed) return;
    if (_textController.text.isNotEmpty) {
      _textController.clear();
      safeNotifyListeners();
    }
  }

  /// Appends text to the current value and notifies listeners.
  ///
  /// If the controller is disposed, this is a no-op.
  void append(String text) {
    if (isDisposed) return;
    if (text.isNotEmpty) {
      _textController.text = _textController.text + text;
      safeNotifyListeners();
    }
  }

  /// Inserts text at the current cursor position and notifies listeners.
  ///
  /// If there's a selection, the selected text is replaced.
  /// If the controller is disposed, this is a no-op.
  void insert(String text) {
    if (isDisposed) return;
    if (text.isEmpty) return;

    final currentText = _textController.text;
    final selection = _textController.selection;

    if (selection.isValid) {
      final newText = currentText.replaceRange(
        selection.start,
        selection.end,
        text,
      );
      _textController.text = newText;
      _textController.selection = TextSelection.collapsed(
        offset: selection.start + text.length,
      );
    } else {
      _textController.text = currentText + text;
    }
    safeNotifyListeners();
  }

  /// Selects all text.
  ///
  /// If the controller is disposed, this is a no-op.
  void selectAll() {
    if (isDisposed) return;
    _textController.selection = TextSelection(
      baseOffset: 0,
      extentOffset: _textController.text.length,
    );
    safeNotifyListeners();
  }

  /// Moves the cursor to the end of the text.
  ///
  /// If the controller is disposed, this is a no-op.
  void moveCursorToEnd() {
    if (isDisposed) return;
    _textController.selection = TextSelection.collapsed(
      offset: _textController.text.length,
    );
    safeNotifyListeners();
  }

  /// Moves the cursor to the start of the text.
  ///
  /// If the controller is disposed, this is a no-op.
  void moveCursorToStart() {
    if (isDisposed) return;
    _textController.selection = const TextSelection.collapsed(offset: 0);
    safeNotifyListeners();
  }

  /// Adds a listener to the underlying [TextEditingController].
  ///
  /// This is useful for listening to text changes directly from the
  /// text controller, in addition to the [VelocityController] listeners.
  void addTextListener(VoidCallback listener) {
    _textController.addListener(listener);
  }

  /// Removes a listener from the underlying [TextEditingController].
  void removeTextListener(VoidCallback listener) {
    _textController.removeListener(listener);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
