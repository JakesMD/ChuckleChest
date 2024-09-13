import 'package:intl/intl.dart' as intl;

import 'localizations.g.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class CAppL10nEn extends CAppL10n {
  CAppL10nEn([String locale = 'en']) : super(locale);

  @override
  String get cancel => 'Cancel';

  @override
  String get chestCreationDialog_createButton => 'Create';

  @override
  String get chestCreationDialog_label_chestName => 'Chest name';

  @override
  String get chestCreationDialog_title => 'Create a new chest';

  @override
  String get close => 'Close';

  @override
  String get collectionsPage_collection_recents => 'Recently added';

  @override
  String get collectionsPage_section_title_other => 'Other';

  @override
  String get collectionsPage_section_title_years => 'Jump to year';

  @override
  String get delete => 'Delete';

  @override
  String get editGemPage_addNarrationButton => 'Add a narration';

  @override
  String get editGemPage_addQuoteButton => 'Add a quote';

  @override
  String get editGemPage_dateTile_title => 'Date';

  @override
  String get editGemPage_editLineDialog_hint_line => 'Line';

  @override
  String get editGemPage_editLineDialog_hint_person => 'Person';

  @override
  String get editGemPage_editLineDialog_title_createNarration => 'New narration';

  @override
  String get editGemPage_editLineDialog_title_createQuote => 'New quote';

  @override
  String get editGemPage_editLineDialog_title_editNarration => 'Edit narration';

  @override
  String get editGemPage_editLineDialog_title_editQuote => 'Edit quote';

  @override
  String get editGemPage_helperMessage => 'Tap anything to edit.';

  @override
  String get editGemPage_title_create => 'Create a gem';

  @override
  String get editGemPage_title_edit => 'Edit the gem';

  @override
  String get gem_restartMessage => 'Pull to restart.';

  @override
  String gem_share_message(Object link) {
    return 'Check out this gem on ChuckleChest! 😂 $link';
  }

  @override
  String get gem_share_subject => 'This is so good! 😂';

  @override
  String get getStartedPage_createChestButton => 'Create a new chest';

  @override
  String get getStartedPage_logoutButton => 'Log out';

  @override
  String get getStartedPage_title => 'Let\'s get started!';

  @override
  String get homePage_bottomNav_collections => 'Collections';

  @override
  String get homePage_bottomNav_people => 'People';

  @override
  String get homePage_bottomNav_settings => 'Settings';

  @override
  String get ok => 'OK';

  @override
  String get otpVerificationPage_error_invalidToken => 'This pin is invalid. Please try again.';

  @override
  String get otpVerificationPage_message => 'Please enter the pin we sent to your inbox.';

  @override
  String get otpVerificationPage_title => 'One-Time pin verification';

  @override
  String peoplePage_personItem_age(int age) {
    String _temp0 = intl.Intl.pluralLogic(
      age,
      locale: localeName,
      other: 'years',
      one: 'year',
      zero: 'years',
    );
    return '$age $_temp0 old';
  }

  @override
  String quoteItem_person(Object nickname, int age) {
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
  String get signinPage_disabledBanner => 'Temporarily disabled for legal reasons. Ask your awesome bruv to create an account for you.';

  @override
  String get signinPage_error_emailRateLimitExceeded => 'We\'ve reached our hourly sign-in limit. Please try again later.';

  @override
  String get signinPage_error_userNotFound => 'We couldn\'t find this user.';

  @override
  String get signinPage_hint_email => 'Email';

  @override
  String get signinPage_hint_username => 'Username';

  @override
  String get signinPage_loginButton => 'Log in';

  @override
  String get signinPage_signupButton => 'Sign up';

  @override
  String get signinPage_tab_login => 'Log in';

  @override
  String get signinPage_tab_signup => 'Sign up';

  @override
  String get signinPage_title => 'Welcome to ChuckleChest!';

  @override
  String get snackBar_error_defaultMessage => 'Oops! Something went wrong. Please check your internet connection and try again.';

  @override
  String get stagingBanner_button => 'Release version';

  @override
  String get stagingBanner_message => 'You\'re using the staging version.';
}
