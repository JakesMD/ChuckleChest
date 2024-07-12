import 'localizations.g.dart';

/// The translations for German (`de`).
class CCoreL10nDe extends CCoreL10n {
  CCoreL10nDe([String locale = 'de']) : super(locale);

  @override
  String get inputError_email_empty =>
      'Bitte geben Sie Ihre E-Mail-Adresse ein.';

  @override
  String get inputError_email_invalid =>
      'Das ist keine gültige E-Mail-Adresse.';

  @override
  String get inputError_text_empty => 'Bitte geben Sie einen Text ein.';
}
