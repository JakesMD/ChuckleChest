import 'package:intl/intl.dart' as intl;

import 'localizations.g.dart';

/// The translations for English (`en`).
class CAppL10nEn extends CAppL10n {
  CAppL10nEn([String locale = 'en']) : super(locale);

  @override
  String get cancel => 'Cancel';

  @override
  String get close => 'Close';

  @override
  String get delete => 'Delete';

  @override
  String gem_share_message(Object link) {
    return 'Check out this gem on ChuckleChest! 😂 $link';
  }

  @override
  String get gem_share_subject => 'This is so good! 😂';

  @override
  String get ok => 'OK';

  @override
  String quoteItem_connection(Object nickname, int age) {
    String _temp0 = intl.Intl.pluralLogic(
      age,
      locale: localeName,
      other: 'years',
      one: 'year',
      zero: 'years',
    );
    return '$nickname • $age $_temp0 old';
  }

  @override
  String get save => 'Save';

  @override
  String get snackBar_error_defaultMessage => 'Oops! Something went wrong. Please check your internet connection and try again.';

  @override
  String get stagingBanner_button => 'Release version';

  @override
  String get stagingBanner_message => 'You\'re using the staging version.';
}
