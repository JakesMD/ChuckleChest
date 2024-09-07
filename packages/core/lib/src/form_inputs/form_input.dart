import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

/// Base class for parsing user input into a typed value.
///
/// Implements common functionality like tracking raw input, validation,
/// and parsing to a typed value. Subclasses should implement parsing and
/// validation logic.
base class CFormInput<T> {
  T? _input;

  /// Returns the raw input string entered by the user.
  T? get input => _input;

  // coverage:ignore-start

  /// Returns the parsed and validated value for this input,
  /// given the current context.
  // ignore: null_check_on_nullable_type_parameter
  T value(BuildContext context) => parse(input: _input!, context: context);

  /// Parses the raw input string into the typed [T] value for this input.
  @mustBeOverridden
  T parse({required T input, required BuildContext context}) {
    throw UnimplementedError();
  }

  /// Validates the input value in the given context.
  ///
  /// Returns and error text if validation fails, null if valid.
  @mustBeOverridden
  String? validator({required T? input, required BuildContext context}) {
    throw UnimplementedError();
  }

  // coverage:ignore-end

  /// Updates the raw input value.
  // ignore: use_setters_to_change_properties
  void onChanged(T? input) => _input = input;
}
