import 'package:meta/meta.dart';

/// {@template CFormInput}
///
/// A form input that validates its value.
///
/// {@endtemplate}
class CFormInput<T, E> {
  /// {@macro CFormInput}
  CFormInput({T? initialValue}) : _value = initialValue;

  T? _value;

  /// The current value.
  T? get value => _value;

  /// Saves the new value, validates it and returns the validation result.
  E? validator(T? newValue) {
    _value = newValue;
    return validate();
  }

  /// Validates the current value and returns the validation result.
  @mustBeOverridden
  E? validate() => null;
}
