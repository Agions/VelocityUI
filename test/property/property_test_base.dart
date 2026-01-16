/// Property-based testing base utilities for VelocityUI
///
/// This file provides common generators and utilities for property-based tests
/// using the glados library.
library property_test_base;

import 'package:flutter/material.dart';
import 'package:glados/glados.dart';

/// Custom generators for VelocityUI property tests
extension VelocityGenerators on Any {
  /// Generate a random Color
  Generator<Color> get color => any.choose([
        Colors.red,
        Colors.green,
        Colors.blue,
        Colors.yellow,
        Colors.purple,
        Colors.orange,
        Colors.cyan,
        Colors.pink,
        Colors.teal,
        Colors.indigo,
        Colors.amber,
        Colors.lime,
        Colors.brown,
        Colors.grey,
        Colors.black,
        Colors.white,
      ]);

  /// Generate a random EdgeInsets
  Generator<EdgeInsets> get edgeInsets => any.positiveIntOrZero
      .map((value) => EdgeInsets.all((value % 33).toDouble()));

  /// Generate a random BorderRadius
  Generator<BorderRadius> get borderRadius => any.positiveIntOrZero
      .map((value) => BorderRadius.circular((value % 25).toDouble()));

  /// Generate a random Duration (100-500ms)
  Generator<Duration> get duration => any.positiveIntOrZero
      .map((value) => Duration(milliseconds: 100 + (value % 401)));

  /// Generate a random double between 0 and 1
  Generator<double> get opacity =>
      any.positiveIntOrZero.map((value) => (value % 101) / 100.0);

  /// Generate a random non-empty string
  Generator<String> get nonEmptyString =>
      any.lowercaseLetters.map((s) => s.isEmpty ? 'a' : s);
}

/// Test configuration for property-based tests
class PropertyTestConfig {
  /// Default number of test iterations
  static const int defaultIterations = 100;

  /// Minimum iterations for quick tests
  static const int minIterations = 50;

  /// Maximum iterations for thorough tests
  static const int maxIterations = 200;
}
