import 'localizations.g.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class CCoreL10nDe extends CCoreL10n {
  CCoreL10nDe([String locale = 'de']) : super(locale);

  @override
  String get inputError_dropdown_empty => 'Bitte wähle eine Option aus.';

  @override
  String get inputError_email_empty => 'Bitte gebe deine E-Mail-Adresse ein.';

  @override
  String get inputError_email_invalid => 'Das ist keine gültige E-Mail-Adresse.';

  @override
  String get inputError_text_empty => 'Bitte gebe einen Text ein.';

  @override
  String get userRole_collaborator => 'Kollaborateur';

  @override
  String get userRole_owner => 'Besitzer';

  @override
  String get userRole_viewer => 'Betrachter';
}
