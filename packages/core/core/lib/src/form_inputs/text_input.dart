import 'package:ccore/ccore.dart';
import 'package:flutter/widgets.dart';

/// Validates that the input string can be parsed as text.
final class CTextInput extends CFormInput<String> {
  @override
  String parse({required String input, required BuildContext context}) {
    return input.trim();
  }

  @override
  String? validator({required String? input, required BuildContext context}) {
    onChanged(input);
    final text = input?.trim();

    if (text == null || text.isEmpty) {
      return context.cCoreL10n.inputError_text_empty;
    }
    return null;
  }
}
