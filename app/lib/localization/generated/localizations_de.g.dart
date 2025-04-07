// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.g.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class CAppL10nDe extends CAppL10n {
  CAppL10nDe([String locale = 'de']) : super(locale);

  @override
  String get cancel => 'Abbrechen';

  @override
  String get changesPropagationBanner_message =>
      'Änderungen werden beim nächsten Öffnen der App von anderen Benutzern übernommen.';

  @override
  String get close => 'Schließen';

  @override
  String get collectionView_noGemsTitle => 'Keine Gemme zu zeigen';

  @override
  String get collectionView_shareSheet_createLinkButton => 'Link erstellen';

  @override
  String get collectionView_shareSheet_deleteLinkButton => 'Link löschen';

  @override
  String get collectionView_shareSheet_shareLinkButton => 'Link teilen';

  @override
  String get collectionsPage_collection_random => 'Zufällig ausgewählt';

  @override
  String get collectionsPage_collection_recents => 'Zuletzt hinzugefügt';

  @override
  String get collectionsPage_noGemsMessage =>
      'Erstelle eine neue Gemme, um loszulegen.';

  @override
  String get collectionsPage_section_title_other => 'Sonstige';

  @override
  String get collectionsPage_section_title_years => 'Springe zu Jahr';

  @override
  String get copiedToClipboard => 'In die Zwischenablage kopiert.';

  @override
  String get createChestPage_createButton => 'Erstellen';

  @override
  String get createChestPage_hint_chestName => 'Name der Truhe';

  @override
  String get createChestPage_title => 'Neue Truhe erstellen';

  @override
  String get delete => 'Löschen';

  @override
  String get editAvatarPage_pickPhotoButton => 'Foto auswählen';

  @override
  String editAvatarPage_title(int year) {
    return 'Bild Für $year Bearbeiten';
  }

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
  String get editPersonPage_dateOfBirthTile_title => 'Geburtsdatum';

  @override
  String get editPersonPage_editNicknameDialog_title => 'Spitzname bearbeiten';

  @override
  String get editPersonPage_nicknameTile_title => 'Spitzname';

  @override
  String get editPersonPage_title => 'Person bearbeiten';

  @override
  String get gem_restartMessage => 'Zum Neustart ziehen.';

  @override
  String gem_share_message(Object link) {
    return 'Schau dir diese Gemme auf ChuckleChest an! 😂 $link';
  }

  @override
  String get gem_share_subject => 'Das ist so gut! 😂';

  @override
  String get gem_swipeMessage => 'Wischen, um das nächste zu sehen.';

  @override
  String gem_title(int number) {
    return 'Gemme $number';
  }

  @override
  String get getStartedPage_createChestButton => 'Neue Truhe erstellen';

  @override
  String get getStartedPage_invitationSection_noInvitations =>
      'Keine Einladungen';

  @override
  String get getStartedPage_invitationSection_title => 'Einladung annehmen';

  @override
  String get getStartedPage_invitationTile_acceptButton => 'Annehmen';

  @override
  String get getStartedPage_logoutButton => 'Ausloggen';

  @override
  String get getStartedPage_title => 'Legen wir los!';

  @override
  String get homePage_bottomNav_collections => 'Sammlungen';

  @override
  String get homePage_bottomNav_people => 'Personen';

  @override
  String get homePage_bottomNav_settings => 'Einstellungen';

  @override
  String get inputError_dropdown_empty => 'Bitte wähle eine Option aus.';

  @override
  String get inputError_email_empty => 'Bitte gebe deine E-Mail-Adresse ein.';

  @override
  String get inputError_email_invalid =>
      'Das ist keine gültige E-Mail-Adresse.';

  @override
  String get inputError_text_empty => 'Bitte gebe einen Text ein.';

  @override
  String get invitationsPage_acceptButton => 'Annehmen';

  @override
  String get invitationsPage_noInvitationsMessage => 'Keine Einladungen';

  @override
  String get invitationsPage_title => 'Einladungen';

  @override
  String get languageDialog_title => 'Sprache ändern';

  @override
  String get manageChestPage_chestNameTile_title => 'Name';

  @override
  String get manageChestPage_createInvitationDialog_hint_email =>
      'E-Mail-Adresse';

  @override
  String get manageChestPage_createInvitationDialog_title =>
      'Jemanden Einladen';

  @override
  String get manageChestPage_editChestNameDialog_hint => 'Name der Truhe';

  @override
  String get manageChestPage_editChestNameDialog_title => 'Name bearbeiten';

  @override
  String get manageChestPage_tab_invited => 'Eingeladen';

  @override
  String get manageChestPage_tab_members => 'Mitglieder';

  @override
  String get manageChestPage_title => 'Truhe verwalten';

  @override
  String get ok => 'Ok';

  @override
  String get or => 'oder';

  @override
  String get otpVerificationPage_error_invalidToken =>
      'Dieser Code ist ungültig. Bitte versuche es erneut.';

  @override
  String get otpVerificationPage_message =>
      'Bitte gebe den Code ein, den wir dir per E-Mail geschickt haben.';

  @override
  String get otpVerificationPage_title => 'Ein-Mal-Code-Bestätigung';

  @override
  String peoplePage_personItem_age(int age) {
    String _temp0 = intl.Intl.pluralLogic(
      age,
      locale: localeName,
      other: 'Jahre',
      one: 'Jahr',
      zero: 'Jahre',
    );
    return '$age $_temp0 alt';
  }

  @override
  String quoteItem_person(String nickname, int age) {
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
  String get settingsPage_contactTile_title => 'Impressum';

  @override
  String get settingsPage_createChestTile_title => 'Neue Truhe erstellen';

  @override
  String get settingsPage_invitationsTile_title => 'Einladungen';

  @override
  String get settingsPage_languageTile_device => 'Gerät';

  @override
  String get settingsPage_languageTile_title => 'Sprache';

  @override
  String get settingsPage_licensesTile_title => 'Lizenzen';

  @override
  String get settingsPage_logsTile_title => 'Protokolle';

  @override
  String get settingsPage_manageChestTile_title => 'Truhe verwalten';

  @override
  String get settingsPage_privacyPolicyTile_title => 'Datenschutzerklärung';

  @override
  String get settingsPage_signoutTile_title => 'Ausloggen';

  @override
  String get settingsPage_termsOfServiceTile_title => 'Nutzungsbedingungen';

  @override
  String get settingsPage_themeTile_title => 'Modus';

  @override
  String get signinPage_ageConfirmation => 'Ich bin mindestens 13 Jahre alt.';

  @override
  String get signinPage_agreement => 'Ich akzeptiere die ';

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
  String get signinPage_privacyPolicy => 'Datenschutzerklärung.';

  @override
  String get signinPage_signupButton => 'Registrieren';

  @override
  String get signinPage_tab_login => 'Einloggen';

  @override
  String get signinPage_tab_signup => 'Registrieren';

  @override
  String get signinPage_terms => 'Nutzungsbedingungen.';

  @override
  String get signinPage_title => 'Willkommen!';

  @override
  String get snackBar_error_defaultMessage =>
      'Hoppla! Etwas ist schiefgelaufen. Bitte überprüfe deine Internetverbindung und versuche es erneut.';

  @override
  String get stagingBanner_button => 'Zur Endversion';

  @override
  String get stagingBanner_message => 'Du nutzt die Vorabversion.';

  @override
  String get themeDialog_darkMode => 'Dunkelmodus';

  @override
  String get themeDialog_device => 'Gerät';

  @override
  String get themeDialog_lightMode => 'Hellmodus';

  @override
  String get themeDialog_title => 'Modus ändern';
}
