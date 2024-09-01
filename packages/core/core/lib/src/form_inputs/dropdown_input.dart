import 'package:ccore/ccore.dart';
import 'package:flutter/widgets.dart';

/// Validates that the input is not empty or null.
final class CDropdownInput<T> extends CFormInput<T> {
  @override
  T parse({required T input, required BuildContext context}) => input;

  @override
  String? validator({required T? input, required BuildContext context}) {
    onChanged(input);

    if (input == null) return context.cCoreL10n.inputError_dropdown_empty;

    return null;
  }
}
