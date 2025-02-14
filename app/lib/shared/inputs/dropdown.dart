import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';

/// The error type for the [CDropdownInput].
enum CDropdownInputError {
  /// The input is empty.
  empty;

  /// Returns the error message for the given error in the context locale.
  String localize(BuildContext context) => switch (this) {
        CDropdownInputError.empty => context.cAppL10n.inputError_dropdown_empty,
      };
}

/// {@template CDropdownInput}
///
/// An input for normal text fields.
///
/// {@endtemplate}
class CDropdownInput<T> extends CFormInput<T, CDropdownInputError> {
  /// {@macro CDropdownInput}
  CDropdownInput({super.initialValue});

  @override
  CDropdownInputError? validate() {
    return value == null ? CDropdownInputError.empty : null;
  }
}

/// Provides extension methods for [CDropdownInput].
extension CDropdownInputX<T> on CDropdownInput<T> {
  /// Use this with the `validator` parameter of a [FormField] to show
  /// the error message for the input.
  String? formFieldValidator(T? value, BuildContext context) =>
      validator(value)?.localize(context);
}
