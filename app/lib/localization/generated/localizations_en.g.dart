// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.g.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class CAppL10nEn extends CAppL10n {
  CAppL10nEn([String locale = 'en']) : super(locale);

  @override
  String get cancel => 'Cancel';

  @override
  String get changesPropagationBanner_message =>
      'Changes will propagate to other users next time they open the app.';

  @override
  String get createChestPage_createButton => 'Create';

  @override
  String get createChestPage_hint_chestName => 'Chest name';

  @override
  String get createChestPage_title => 'Create a new chest';

  @override
  String get close => 'Close';

  @override
  String get collectionView_noGemsTitle => 'No gems to show';

  @override
  String get collectionView_shareSheet_createLinkButton =>
      'Create a share link';

  @override
  String get collectionView_shareSheet_deleteLinkButton => 'Delete the link';

  @override
  String get collectionView_shareSheet_shareLinkButton => 'Share the link';

  @override
  String get collectionsPage_collection_random => 'Randomly selected';

  @override
  String get collectionsPage_collection_recents => 'Recently added';

  @override
  String get collectionsPage_noGemsMessage =>
      'Create a new gem to get started.';

  @override
  String get collectionsPage_section_title_other => 'Other';

  @override
  String get collectionsPage_section_title_years => 'Jump to year';

  @override
  String get copiedToClipboard => 'Copied to clipboard.';

  @override
  String get delete => 'Delete';

  @override
  String get editAvatarPage_pickPhotoButton => 'Pick a photo';

  @override
  String editAvatarPage_title(int year) {
    return 'Edit photo for $year';
  }

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
  String get editGemPage_editLineDialog_title_createNarration =>
      'New narration';

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
  String get editPersonPage_dateOfBirthTile_title => 'Date of birth';

  @override
  String get editPersonPage_editNicknameDialog_title => 'Edit nickname';

  @override
  String get editPersonPage_nicknameTile_title => 'Nickname';

  @override
  String get editPersonPage_title => 'Edit person';

  @override
  String get gem_restartMessage => 'Pull to restart.';

  @override
  String gem_share_message(Object link) {
    return 'Check out this gem on ChuckleChest! 😂 $link';
  }

  @override
  String get gem_share_subject => 'This is so good! 😂';

  @override
  String get gem_swipeMessage => 'Swipe to view next.';

  @override
  String get getStartedPage_createChestButton => 'Create a new chest';

  @override
  String get getStartedPage_invitationSection_noInvitations => 'No invitations';

  @override
  String get getStartedPage_invitationSection_title => 'Accept an invitation';

  @override
  String get getStartedPage_invitationTile_acceptButton => 'Accept';

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
  String get inputError_dropdown_empty => 'Please select an option.';

  @override
  String get inputError_email_empty => 'Please enter your email address.';

  @override
  String get inputError_email_invalid => 'That\'s not a valid email address.';

  @override
  String get inputError_text_empty => 'Please enter some text.';

  @override
  String get invitationsPage_acceptButton => 'Accept';

  @override
  String get invitationsPage_noInvitationsMessage => 'No invitations';

  @override
  String get invitationsPage_title => 'Invitations';

  @override
  String get languageDialog_title => 'Change language';

  @override
  String get manageChestPage_chestNameTile_title => 'Name';

  @override
  String get manageChestPage_createInvitationDialog_hint_email => 'Email';

  @override
  String get manageChestPage_createInvitationDialog_title => 'Invite someone';

  @override
  String get manageChestPage_editChestNameDialog_hint => 'Name';

  @override
  String get manageChestPage_editChestNameDialog_title => 'Edit chest name';

  @override
  String get manageChestPage_tab_invited => 'Invited';

  @override
  String get manageChestPage_tab_members => 'Members';

  @override
  String get manageChestPage_title => 'Manage chest';

  @override
  String get ok => 'OK';

  @override
  String get or => 'or';

  @override
  String get otpVerificationPage_error_invalidToken =>
      'This pin is invalid. Please try again.';

  @override
  String get otpVerificationPage_message =>
      'Please enter the pin we sent to your inbox.';

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
  String quoteItem_person(String nickname, int age) {
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
  String get settingsPage_contactTile_title => 'Contact';

  @override
  String get settingsPage_createChestTile_title => 'Create a new chest';

  @override
  String get settingsPage_invitationsTile_title => 'Invitations';

  @override
  String get settingsPage_languageTile_device => 'Device';

  @override
  String get settingsPage_languageTile_title => 'Language';

  @override
  String get settingsPage_licensesTile_title => 'Licences';

  @override
  String get settingsPage_logsTile_title => 'Logs';

  @override
  String get settingsPage_manageChestTile_title => 'Manage this chest';

  @override
  String get settingsPage_privacyPolicyTile_title => 'Privacy policy';

  @override
  String get settingsPage_signoutTile_title => 'Log out';

  @override
  String get settingsPage_termsOfServiceTile_title => 'Terms of service';

  @override
  String get settingsPage_themeTile_title => 'Theme';

  @override
  String get signinPage_ageConfirmation => 'I am at least 13 years old.';

  @override
  String get signinPage_agreement => 'I agree to the ';

  @override
  String get signinPage_error_emailRateLimitExceeded =>
      'We\'ve reached our hourly sign-in limit. Please try again later.';

  @override
  String get signinPage_error_userNotFound => 'We couldn\'t find this user.';

  @override
  String get signinPage_hint_email => 'Email';

  @override
  String get signinPage_hint_username => 'Username';

  @override
  String get signinPage_loginButton => 'Log in';

  @override
  String get signinPage_privacyPolicy => 'privacy policy.';

  @override
  String get signinPage_signupButton => 'Sign up';

  @override
  String get signinPage_tab_login => 'Log in';

  @override
  String get signinPage_tab_signup => 'Sign up';

  @override
  String get signinPage_terms => 'terms and conditions.';

  @override
  String get signinPage_title => 'Welcome to ChuckleChest!';

  @override
  String get snackBar_error_defaultMessage =>
      'Oops! Something went wrong. Please check your internet connection and try again.';

  @override
  String get stagingBanner_button => 'Release version';

  @override
  String get stagingBanner_message => 'You\'re using the staging version.';

  @override
  String get themeDialog_darkMode => 'Dark mode';

  @override
  String get themeDialog_device => 'Device';

  @override
  String get themeDialog_lightMode => 'Light mode';

  @override
  String get themeDialog_title => 'Change theme';
}
