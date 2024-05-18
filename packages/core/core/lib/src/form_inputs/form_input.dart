import 'package:cpub/meta.dart';
import 'package:flutter/widgets.dart';

/// Base class for parsing user input into a typed value.
///
/// Implements common functionality like tracking raw input, validation,
/// and parsing to a typed value. Subclasses should implement parsing and
/// validation logic.
base class CFormInput<T> {
  String? _input;

  /// Returns the raw input string entered by the user.
  String? get input => _input;

  // coverage:ignore-start

  /// Returns the parsed and validated value for this input,
  /// given the current context.
  T value(BuildContext context) => parse(input: _input!, context: context);

  /// Parses the raw input string into the typed [T] value for this input.
  @mustBeOverridden
  T parse({required String input, required BuildContext context}) {
    throw UnimplementedError();
  }

  /// Validates the input value in the given context.
  ///
  /// Returns and error text if validation fails, null if valid.
  @mustBeOverridden
  String? validator({required String? input, required BuildContext context}) {
    throw UnimplementedError();
  }

  // coverage:ignore-end

  /// Updates the raw input value, trimming whitespace.
  void onChanged(String? input) => _input = input?.trim();
}
