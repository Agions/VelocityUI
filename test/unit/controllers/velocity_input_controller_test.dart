/// Unit tests for VelocityInputController
///
/// Tests resource disposal and text manipulation functionality.
/// **Validates: Requirements 10.2, 10.3**
library velocity_input_controller_test;

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/core/controllers/velocity_input_controller.dart';

void main() {
  group('VelocityInputController', () {
    group('Initialization', () {
      test('creates with empty text by default', () {
        final controller = VelocityInputController();
        expect(controller.text, isEmpty);
        expect(controller.isEmpty, isTrue);
        expect(controller.isNotEmpty, isFalse);
        controller.dispose();
      });

      test('creates with initial text', () {
        final controller = VelocityInputController(text: 'Hello');
        expect(controller.text, equals('Hello'));
        expect(controller.isEmpty, isFalse);
        expect(controller.isNotEmpty, isTrue);
        expect(controller.length, equals(5));
        controller.dispose();
      });

      test('creates from existing TextEditingController', () {
        final textController = TextEditingController(text: 'Existing');
        final controller =
            VelocityInputController.fromController(textController);
        expect(controller.text, equals('Existing'));
        expect(controller.textController, same(textController));
        controller.dispose();
      });
    });

    group('Text Manipulation', () {
      test('sets text and notifies listeners', () {
        final controller = VelocityInputController();
        var notificationCount = 0;
        controller.addListener(() => notificationCount++);

        controller.text = 'New text';

        expect(controller.text, equals('New text'));
        expect(notificationCount, equals(1));
        controller.dispose();
      });

      test('does not notify when setting same text', () {
        final controller = VelocityInputController(text: 'Same');
        var notificationCount = 0;
        controller.addListener(() => notificationCount++);

        controller.text = 'Same';

        expect(notificationCount, equals(0));
        controller.dispose();
      });

      test('clears text and notifies listeners', () {
        final controller = VelocityInputController(text: 'To clear');
        var notificationCount = 0;
        controller.addListener(() => notificationCount++);

        controller.clear();

        expect(controller.text, isEmpty);
        expect(notificationCount, equals(1));
        controller.dispose();
      });

      test('does not notify when clearing empty text', () {
        final controller = VelocityInputController();
        var notificationCount = 0;
        controller.addListener(() => notificationCount++);

        controller.clear();

        expect(notificationCount, equals(0));
        controller.dispose();
      });

      test('appends text and notifies listeners', () {
        final controller = VelocityInputController(text: 'Hello');
        var notificationCount = 0;
        controller.addListener(() => notificationCount++);

        controller.append(' World');

        expect(controller.text, equals('Hello World'));
        expect(notificationCount, equals(1));
        controller.dispose();
      });

      test('does not notify when appending empty string', () {
        final controller = VelocityInputController(text: 'Hello');
        var notificationCount = 0;
        controller.addListener(() => notificationCount++);

        controller.append('');

        expect(controller.text, equals('Hello'));
        expect(notificationCount, equals(0));
        controller.dispose();
      });
    });

    group('Selection', () {
      test('selects all text', () {
        final controller = VelocityInputController(text: 'Select me');
        controller.selectAll();

        expect(controller.selection.start, equals(0));
        expect(controller.selection.end, equals(9));
        controller.dispose();
      });

      test('moves cursor to end', () {
        final controller = VelocityInputController(text: 'Hello');
        controller.moveCursorToEnd();

        expect(controller.selection.baseOffset, equals(5));
        expect(controller.selection.extentOffset, equals(5));
        controller.dispose();
      });

      test('moves cursor to start', () {
        final controller = VelocityInputController(text: 'Hello');
        controller.moveCursorToStart();

        expect(controller.selection.baseOffset, equals(0));
        expect(controller.selection.extentOffset, equals(0));
        controller.dispose();
      });

      test('sets selection and notifies listeners', () {
        final controller = VelocityInputController(text: 'Hello World');
        var notificationCount = 0;
        controller.addListener(() => notificationCount++);

        controller.selection = const TextSelection(
          baseOffset: 0,
          extentOffset: 5,
        );

        expect(controller.selection.start, equals(0));
        expect(controller.selection.end, equals(5));
        expect(notificationCount, equals(1));
        controller.dispose();
      });
    });

    group('Insert', () {
      test('inserts text at cursor position', () {
        final controller = VelocityInputController(text: 'Hello World');
        controller.textController.selection = const TextSelection.collapsed(
          offset: 5,
        );

        controller.insert(' Beautiful');

        expect(controller.text, equals('Hello Beautiful World'));
        controller.dispose();
      });

      test('replaces selected text', () {
        final controller = VelocityInputController(text: 'Hello World');
        controller.textController.selection = const TextSelection(
          baseOffset: 6,
          extentOffset: 11,
        );

        controller.insert('Flutter');

        expect(controller.text, equals('Hello Flutter'));
        controller.dispose();
      });

      test('does not insert empty string', () {
        final controller = VelocityInputController(text: 'Hello');
        var notificationCount = 0;
        controller.addListener(() => notificationCount++);

        controller.insert('');

        expect(controller.text, equals('Hello'));
        expect(notificationCount, equals(0));
        controller.dispose();
      });
    });

    group('Text Listeners', () {
      test('adds and removes text listeners', () {
        final controller = VelocityInputController();
        var listenerCalled = false;
        void listener() => listenerCalled = true;

        controller.addTextListener(listener);
        controller.textController.text = 'Changed';
        expect(listenerCalled, isTrue);

        listenerCalled = false;
        controller.removeTextListener(listener);
        controller.textController.text = 'Changed again';
        expect(listenerCalled, isFalse);

        controller.dispose();
      });
    });

    group('Resource Disposal - Requirements 10.3', () {
      test('disposes underlying TextEditingController', () {
        final controller = VelocityInputController(text: 'Test');
        controller.dispose();

        expect(controller.isDisposed, isTrue);
        // Accessing textController after dispose should still work
        // but the controller itself is disposed
      });

      test('safeNotifyListeners does not throw after dispose', () {
        final controller = VelocityInputController(text: 'Test');
        controller.dispose();

        // These should not throw
        expect(() => controller.text = 'New', returnsNormally);
        expect(() => controller.clear(), returnsNormally);
        expect(() => controller.append('More'), returnsNormally);
      });

      test('listeners are not notified after dispose', () {
        final controller = VelocityInputController(text: 'Test');
        var notificationCount = 0;
        controller.addListener(() => notificationCount++);

        controller.text = 'Changed';
        expect(notificationCount, equals(1));

        controller.dispose();

        // These should not increment the count
        controller.text = 'After dispose';
        controller.clear();
        controller.append('More');

        expect(notificationCount, equals(1));
      });

      test('isDisposed returns correct state', () {
        final controller = VelocityInputController();
        expect(controller.isDisposed, isFalse);

        controller.dispose();
        expect(controller.isDisposed, isTrue);
      });
    });
  });
}
