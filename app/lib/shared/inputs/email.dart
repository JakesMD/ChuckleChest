import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';

/// The error type for the [CEmailInput].
enum CEmailInputError {
  /// The email is empty.
  empty,

  /// The email is invalid.
  invalid;

  /// Returns the error message for the given error in the context locale.
  String localize(BuildContext context) => switch (this) {
        CEmailInputError.empty => context.cAppL10n.inputError_email_empty,
        CEmailInputError.invalid => context.cAppL10n.inputError_email_invalid,
      };
}

/// {@template CCEmailInput}
///
/// An input for email addresses.
///
/// {@endtemplate}
class CEmailInput extends CFormInput<String, CEmailInputError> {
  /// {@macro CCEmailInput}
  CEmailInput({super.initialValue = ''});

  static final _emailRegExp = RegExp(
    r'^[a-zA-Z\d.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z\d-]+(?:\.[a-zA-Z\d-]+)*$',
  );

  @override
  CEmailInputError? validate() {
    if (value == null) return null;

    final trimmedValue = value!.trim();
    if (trimmedValue.isEmpty) return CEmailInputError.empty;

    return _emailRegExp.hasMatch(trimmedValue)
        ? null
        : CEmailInputError.invalid;
  }
}

/// Provides extension methods for [CEmailInput].
extension CEmailInputX on CEmailInput {
  /// Use this with the `validator` parameter of a [FormField] to show
  /// the error message for the input.
  String? formFieldValidator(String? value, BuildContext context) =>
      validator(value)?.localize(context);
}
