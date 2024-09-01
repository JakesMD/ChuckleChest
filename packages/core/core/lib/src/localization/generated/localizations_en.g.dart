import 'localizations.g.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class CCoreL10nEn extends CCoreL10n {
  CCoreL10nEn([String locale = 'en']) : super(locale);

  @override
  String get inputError_dropdown_empty => 'Please select an option.';

  @override
  String get inputError_email_empty => 'Please enter your email address.';

  @override
  String get inputError_email_invalid => 'That\'s not a valid email address.';

  @override
  String get inputError_text_empty => 'Please enter some text.';
}
