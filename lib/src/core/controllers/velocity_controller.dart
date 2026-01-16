import 'package:flutter/foundation.dart';

/// Base class for all VelocityUI component controllers.
///
/// Provides safe lifecycle management with proper disposal handling
/// to prevent memory leaks and exceptions when notifying listeners
/// after disposal.
///
/// Example usage:
/// ```dart
/// class MyController extends VelocityController {
///   int _count = 0;
///   int get count => _count;
///
///   void increment() {
///     _count++;
///     safeNotifyListeners();
///   }
/// }
/// ```
///
/// **Validates: Requirements 10.2, 10.3**
abstract class VelocityController extends ChangeNotifier {
  bool _disposed = false;

  /// Returns `true` if this controller has been disposed.
  ///
  /// After disposal, the controller should not be used and
  /// [safeNotifyListeners] will be a no-op.
  bool get isDisposed => _disposed;

  /// Disposes of this controller and releases any resources.
  ///
  /// After calling this method:
  /// - [isDisposed] will return `true`
  /// - [safeNotifyListeners] will be a no-op
  /// - The controller should not be used
  ///
  /// Subclasses should override this method to dispose of any
  /// additional resources, but must call `super.dispose()`.
  @override
  @mustCallSuper
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  /// Safely notifies all registered listeners.
  ///
  /// Unlike [notifyListeners], this method checks if the controller
  /// has been disposed before notifying listeners. If the controller
  /// is disposed, this method is a no-op and logs a debug warning.
  ///
  /// This prevents exceptions that would occur when calling
  /// [notifyListeners] on a disposed controller.
  ///
  /// Subclasses should use this method instead of [notifyListeners]
  /// to ensure safe notification.
  @protected
  void safeNotifyListeners() {
    if (_disposed) {
      debugPrint(
        'Warning: Attempted to notify listeners on disposed '
        '${runtimeType.toString()} controller',
      );
      return;
    }
    notifyListeners();
  }
}
