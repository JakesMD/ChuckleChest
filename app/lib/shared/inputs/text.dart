import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';

/// The error type for the [CTextInput].
enum CTextInputError {
  /// The input is empty.
  empty;

  /// Returns the error message for the given error in the context locale.
  String localize(BuildContext context) => switch (this) {
        CTextInputError.empty => context.cAppL10n.inputError_text_empty,
      };
}

/// {@template CTextInput}
///
/// An input for normal text fields.
///
/// {@endtemplate}
class CTextInput extends CFormInput<String, CTextInputError> {
  /// {@macro CTextInput}
  CTextInput({super.initialValue = ''});

  @override
  CTextInputError? validate() {
    return value == null || value!.trim().isEmpty
        ? CTextInputError.empty
        : null;
  }
}

/// Provides extension methods for [CTextInput].
extension CTextInputX on CTextInput {
  /// Use this with the `validator` parameter of a [FormField] to show
  /// the error message for the input.
  String? formFieldValidator(String? value, BuildContext context) {
    if (value == null) return null;
    return validator(value)?.localize(context);
  }
}
