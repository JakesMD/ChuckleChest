import 'package:intl/intl.dart' as intl;

import 'localizations.g.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class CAppL10nDe extends CAppL10n {
  CAppL10nDe([String locale = 'de']) : super(locale);

  @override
  String get cancel => 'Abbrechen';

  @override
  String get chestCreationDialog_createButton => 'Erstellen';

  @override
  String get chestCreationDialog_label_chestName => 'Name der Truhe';

  @override
  String get chestCreationDialog_title => 'Neue Truhe erstellen';

  @override
  String get homePage_bottomNav_collections => 'Sammlungen';

  @override
  String get homePage_bottomNav_settings => 'Einstellungen';

  @override
  String get close => 'Schließen';

  @override
  String get delete => 'Löschen';

  @override
  String get editGemPage_addNarrationButton => 'Neue Erzählung';

  @override
  String get editGemPage_addQuoteButton => 'Neues Zitat';

  @override
  String get editGemPage_dateTile_title => 'Datum';

  @override
  String get editGemPage_editLineDialog_hint_line => 'Dialogzeile';

  @override
  String get editGemPage_editLineDialog_hint_person => 'Person';

  @override
  String get editGemPage_editLineDialog_title_createNarration =>
      'Neue Erzählung';

  @override
  String get editGemPage_editLineDialog_title_createQuote => 'Neues Zitat';

  @override
  String get editGemPage_editLineDialog_title_editNarration =>
      'Erzählung bearbeiten';

  @override
  String get editGemPage_editLineDialog_title_editQuote => 'Zitat bearbeiten';

  @override
  String get editGemPage_helperMessage =>
      'Tippe auf etwas, um es zu bearbeiten.';

  @override
  String get editGemPage_title_create => 'Gemme erstellen';

  @override
  String get editGemPage_title_edit => 'Gemme bearbeiten';

  @override
  String gem_share_message(Object link) {
    return 'Schau dir diese Gemme auf ChuckleChest an! 😂 $link';
  }

  @override
  String get gem_share_subject => 'Das ist so gut! 😂';

  @override
  String get getStartedPage_createChestButton => 'Neue Truhe erstellen';

  @override
  String get getStartedPage_logoutButton => 'Ausloggen';

  @override
  String get getStartedPage_title => 'Legen wir los!';

  @override
  String get ok => 'Ok';

  @override
  String get otpVerificationPage_error_invalidToken =>
      'Dieser Code ist ungültig. Bitte versuche es erneut.';

  @override
  String get otpVerificationPage_message =>
      'Bitte gebe den Code ein, den wir dir per E-Mail geschickt haben.';

  @override
  String get otpVerificationPage_title => 'Ein-Mal-Code-Bestätigung';

  @override
  String quoteItem_person(Object nickname, int age) {
    String _temp0 = intl.Intl.pluralLogic(
      age,
      locale: localeName,
      other: 'Jahre',
      one: 'Jahr',
      zero: 'Jahre',
    );
    return '$nickname • $age $_temp0 alt';
  }

  @override
  String get save => 'Speichern';

  @override
  String get signinPage_disabledBanner =>
      'Aus rechtlichen Gründen vorübergehend deaktiviert. Bitte deinen großartigen Bruder dir ein Konto zu erstellen.';

  @override
  String get signinPage_error_emailRateLimitExceeded =>
      'Wir haben unser stündliches Anmelde-Limit erreicht. Bitte versuche es später erneut.';

  @override
  String get signinPage_error_userNotFound => 'Wir konnten dich nicht finden.';

  @override
  String get signinPage_hint_email => 'E-Mail-Adresse';

  @override
  String get signinPage_hint_username => 'Benutzername';

  @override
  String get signinPage_loginButton => 'Einloggen';

  @override
  String get signinPage_signupButton => 'Registrieren';

  @override
  String get signinPage_tab_login => 'Einloggen';

  @override
  String get signinPage_tab_signup => 'Registrieren';

  @override
  String get signinPage_title => 'Willkommen!';

  @override
  String get snackBar_error_defaultMessage =>
      'Hoppla! Etwas ist schiefgelaufen. Bitte überprüfe deine Internetverbindung und versuche es erneut.';

  @override
  String get stagingBanner_button => 'Zur Endversion';

  @override
  String get stagingBanner_message => 'Du nutzt die Vorabversion.';
}
