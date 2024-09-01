import 'package:ccore/ccore.dart';
import 'package:flutter/widgets.dart';

/// Validates that the input string can be parsed as an email.
final class CEmailInput extends CFormInput<String> {
  @override
  String parse({required String input, required BuildContext context}) {
    return input.trim();
  }

  @override
  String? validator({required String? input, required BuildContext context}) {
    final email = input?.trim() ?? '';
    onChanged(email);

    if (email.isEmpty) return context.cCoreL10n.inputError_email_empty;

    if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email)) {
      return context.cCoreL10n.inputError_email_invalid;
    }

    return null;
  }
}
