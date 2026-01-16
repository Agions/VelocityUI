# Property-Based Tests

This directory contains property-based tests using the [glados](https://pub.dev/packages/glados) library.

## Overview

Property-based testing validates software correctness by testing universal properties across many generated inputs. Each property is a formal specification that should hold for all valid inputs.

## Test Structure

```
property/
├── style_merge_property_test.dart      # Style merge completeness tests
├── theme_equality_property_test.dart   # Theme equality tests
├── const_constructor_property_test.dart # Const constructor validity tests
├── color_contrast_property_test.dart   # Color contrast compliance tests
└── README.md                           # This file
```

## Running Property Tests

```bash
# Run all property tests
flutter test test/property/

# Run with coverage
flutter test test/property/ --coverage

# Run specific property test
flutter test test/property/style_merge_property_test.dart
```

## Writing Property Tests

Each property test should:

1. Reference the design document property it validates
2. Use the glados library for property generation
3. Run minimum 100 iterations
4. Include a tag with format: `Feature: velocity-ui-optimization, Property N: Property Title`

### Example

```dart
import 'package:glados/glados.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Feature: velocity-ui-optimization, Property 6: Style Merge Completeness
  Glados2(any.color, any.color).test(
    'merged style contains all non-null custom properties',
    (Color customBg, Color customFg) {
      // Test implementation
    },
  );
}
```

## Configuration

Property tests are configured to run 100 iterations by default. This can be adjusted in individual tests using the `Explore` configuration.
