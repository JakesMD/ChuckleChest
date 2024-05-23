import 'package:intl/intl.dart' as intl;

import 'localizations.g.dart';

/// The translations for German (`de`).
class CAppL10nDe extends CAppL10n {
  CAppL10nDe([String locale = 'de']) : super(locale);

  @override
  String get stagingBanner_message => 'Sie nutzen die Vorabversion.';

  @override
  String get stagingBanner_button => 'Zur Endversion';

  @override
  String get snackBar_error_defaultMessage =>
      'Hoppla! Etwas ist schiefgelaufen. Bitte überprüfen Sie Ihre Internetverbindung und versuchen Sie es erneut.';

  @override
  String get ok => 'Ok';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get close => 'Schließen';

  @override
  String get save => 'Speichern';

  @override
  String get delete => 'Löschen';

  @override
  String gem_share_message(Object link) {
    return 'Schau dir dieses Gem auf ChuckleChest an! 😂 $link';
  }

  @override
  String get gem_share_subject => 'Das ist so gut! 😂';

  @override
  String quoteItem_connection(Object nickname, int age) {
    String _temp0 = intl.Intl.pluralLogic(
      age,
      locale: localeName,
      other: 'Jahre',
      one: 'Jahr',
      zero: 'Jahre',
    );
    return '$nickname • $age $_temp0 alt';
  }
}
