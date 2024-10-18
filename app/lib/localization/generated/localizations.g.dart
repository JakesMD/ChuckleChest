import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'localizations_de.g.dart';
import 'localizations_en.g.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of CAppL10n
/// returned by `CAppL10n.of(context)`.
///
/// Applications need to include `CAppL10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/localizations.g.dart';
///
/// return MaterialApp(
///   localizationsDelegates: CAppL10n.localizationsDelegates,
///   supportedLocales: CAppL10n.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the CAppL10n.supportedLocales
/// property.
abstract class CAppL10n {
  CAppL10n(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static CAppL10n of(BuildContext context) {
    return Localizations.of<CAppL10n>(context, CAppL10n)!;
  }

  static const LocalizationsDelegate<CAppL10n> delegate = _CAppL10nDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en')
  ];

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @changesPropagationBanner_message.
  ///
  /// In en, this message translates to:
  /// **'Changes will propagate to other users next time they open the app.'**
  String get changesPropagationBanner_message;

  /// No description provided for @chestCreationDialog_createButton.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get chestCreationDialog_createButton;

  /// No description provided for @chestCreationDialog_label_chestName.
  ///
  /// In en, this message translates to:
  /// **'Chest name'**
  String get chestCreationDialog_label_chestName;

  /// No description provided for @chestCreationDialog_title.
  ///
  /// In en, this message translates to:
  /// **'Create a new chest'**
  String get chestCreationDialog_title;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @collectionView_nowGemsTitle.
  ///
  /// In en, this message translates to:
  /// **'No gems to show'**
  String get collectionView_nowGemsTitle;

  /// No description provided for @collectionsPage_collection_random.
  ///
  /// In en, this message translates to:
  /// **'Randomly selected'**
  String get collectionsPage_collection_random;

  /// No description provided for @collectionsPage_collection_recents.
  ///
  /// In en, this message translates to:
  /// **'Recently added'**
  String get collectionsPage_collection_recents;

  /// No description provided for @collectionsPage_noGemsMessage.
  ///
  /// In en, this message translates to:
  /// **'Create a new gem to get started.'**
  String get collectionsPage_noGemsMessage;

  /// No description provided for @collectionsPage_section_title_other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get collectionsPage_section_title_other;

  /// No description provided for @collectionsPage_section_title_years.
  ///
  /// In en, this message translates to:
  /// **'Jump to year'**
  String get collectionsPage_section_title_years;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @editAvatarPage_pickPhotoButton.
  ///
  /// In en, this message translates to:
  /// **'Pick a photo'**
  String get editAvatarPage_pickPhotoButton;

  /// No description provided for @editAvatarPage_title.
  ///
  /// In en, this message translates to:
  /// **'Edit photo for {year}'**
  String editAvatarPage_title(int year);

  /// No description provided for @editGemPage_addNarrationButton.
  ///
  /// In en, this message translates to:
  /// **'Add a narration'**
  String get editGemPage_addNarrationButton;

  /// No description provided for @editGemPage_addQuoteButton.
  ///
  /// In en, this message translates to:
  /// **'Add a quote'**
  String get editGemPage_addQuoteButton;

  /// No description provided for @editGemPage_dateTile_title.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get editGemPage_dateTile_title;

  /// No description provided for @editGemPage_editLineDialog_hint_line.
  ///
  /// In en, this message translates to:
  /// **'Line'**
  String get editGemPage_editLineDialog_hint_line;

  /// No description provided for @editGemPage_editLineDialog_hint_person.
  ///
  /// In en, this message translates to:
  /// **'Person'**
  String get editGemPage_editLineDialog_hint_person;

  /// No description provided for @editGemPage_editLineDialog_title_createNarration.
  ///
  /// In en, this message translates to:
  /// **'New narration'**
  String get editGemPage_editLineDialog_title_createNarration;

  /// No description provided for @editGemPage_editLineDialog_title_createQuote.
  ///
  /// In en, this message translates to:
  /// **'New quote'**
  String get editGemPage_editLineDialog_title_createQuote;

  /// No description provided for @editGemPage_editLineDialog_title_editNarration.
  ///
  /// In en, this message translates to:
  /// **'Edit narration'**
  String get editGemPage_editLineDialog_title_editNarration;

  /// No description provided for @editGemPage_editLineDialog_title_editQuote.
  ///
  /// In en, this message translates to:
  /// **'Edit quote'**
  String get editGemPage_editLineDialog_title_editQuote;

  /// No description provided for @editGemPage_helperMessage.
  ///
  /// In en, this message translates to:
  /// **'Tap anything to edit.'**
  String get editGemPage_helperMessage;

  /// No description provided for @editGemPage_title_create.
  ///
  /// In en, this message translates to:
  /// **'Create a gem'**
  String get editGemPage_title_create;

  /// No description provided for @editGemPage_title_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit the gem'**
  String get editGemPage_title_edit;

  /// No description provided for @editPersonPage_dateOfBirthTile_title.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get editPersonPage_dateOfBirthTile_title;

  /// No description provided for @editPersonPage_editNicknameDialog_title.
  ///
  /// In en, this message translates to:
  /// **'Edit nickname'**
  String get editPersonPage_editNicknameDialog_title;

  /// No description provided for @editPersonPage_nicknameTile_title.
  ///
  /// In en, this message translates to:
  /// **'Nickname'**
  String get editPersonPage_nicknameTile_title;

  /// No description provided for @editPersonPage_title.
  ///
  /// In en, this message translates to:
  /// **'Edit person'**
  String get editPersonPage_title;

  /// No description provided for @gem_restartMessage.
  ///
  /// In en, this message translates to:
  /// **'Pull to restart.'**
  String get gem_restartMessage;

  /// No description provided for @gem_share_message.
  ///
  /// In en, this message translates to:
  /// **'Check out this gem on ChuckleChest! 😂 {link}'**
  String gem_share_message(Object link);

  /// No description provided for @gem_share_subject.
  ///
  /// In en, this message translates to:
  /// **'This is so good! 😂'**
  String get gem_share_subject;

  /// No description provided for @getStartedPage_createChestButton.
  ///
  /// In en, this message translates to:
  /// **'Create a new chest'**
  String get getStartedPage_createChestButton;

  /// No description provided for @getStartedPage_invitationSection_noInvitations.
  ///
  /// In en, this message translates to:
  /// **'No invitations'**
  String get getStartedPage_invitationSection_noInvitations;

  /// No description provided for @getStartedPage_invitationSection_title.
  ///
  /// In en, this message translates to:
  /// **'Accept an invitation'**
  String get getStartedPage_invitationSection_title;

  /// No description provided for @getStartedPage_invitationTile_acceptButton.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get getStartedPage_invitationTile_acceptButton;

  /// No description provided for @getStartedPage_logoutButton.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get getStartedPage_logoutButton;

  /// No description provided for @getStartedPage_title.
  ///
  /// In en, this message translates to:
  /// **'Let\'s get started!'**
  String get getStartedPage_title;

  /// No description provided for @homePage_bottomNav_collections.
  ///
  /// In en, this message translates to:
  /// **'Collections'**
  String get homePage_bottomNav_collections;

  /// No description provided for @homePage_bottomNav_people.
  ///
  /// In en, this message translates to:
  /// **'People'**
  String get homePage_bottomNav_people;

  /// No description provided for @homePage_bottomNav_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get homePage_bottomNav_settings;

  /// No description provided for @invitationsPage_acceptButton.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get invitationsPage_acceptButton;

  /// No description provided for @invitationsPage_noInvitationsMessage.
  ///
  /// In en, this message translates to:
  /// **'No invitations'**
  String get invitationsPage_noInvitationsMessage;

  /// No description provided for @invitationsPage_title.
  ///
  /// In en, this message translates to:
  /// **'Invitations'**
  String get invitationsPage_title;

  /// No description provided for @manageChestPage_chestNameTile_title.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get manageChestPage_chestNameTile_title;

  /// No description provided for @manageChestPage_createInvitationDialog_hint_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get manageChestPage_createInvitationDialog_hint_email;

  /// No description provided for @manageChestPage_createInvitationDialog_title.
  ///
  /// In en, this message translates to:
  /// **'Invite someone'**
  String get manageChestPage_createInvitationDialog_title;

  /// No description provided for @manageChestPage_editChestNameDialog_hint.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get manageChestPage_editChestNameDialog_hint;

  /// No description provided for @manageChestPage_editChestNameDialog_title.
  ///
  /// In en, this message translates to:
  /// **'Edit chest name'**
  String get manageChestPage_editChestNameDialog_title;

  /// No description provided for @manageChestPage_tab_invited.
  ///
  /// In en, this message translates to:
  /// **'Invited'**
  String get manageChestPage_tab_invited;

  /// No description provided for @manageChestPage_tab_members.
  ///
  /// In en, this message translates to:
  /// **'Members'**
  String get manageChestPage_tab_members;

  /// No description provided for @manageChestPage_title.
  ///
  /// In en, this message translates to:
  /// **'Manage chest'**
  String get manageChestPage_title;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @otpVerificationPage_error_invalidToken.
  ///
  /// In en, this message translates to:
  /// **'This pin is invalid. Please try again.'**
  String get otpVerificationPage_error_invalidToken;

  /// No description provided for @otpVerificationPage_message.
  ///
  /// In en, this message translates to:
  /// **'Please enter the pin we sent to your inbox.'**
  String get otpVerificationPage_message;

  /// No description provided for @otpVerificationPage_title.
  ///
  /// In en, this message translates to:
  /// **'One-Time pin verification'**
  String get otpVerificationPage_title;

  /// No description provided for @peoplePage_personItem_age.
  ///
  /// In en, this message translates to:
  /// **'{age} {age, plural, =0{years} =1{year} other{years}} old'**
  String peoplePage_personItem_age(int age);

  /// No description provided for @quoteItem_person.
  ///
  /// In en, this message translates to:
  /// **'{nickname} • {age} {age, plural, =0{years} =1{year} other{years}} old'**
  String quoteItem_person(Object nickname, int age);

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @settingsPage_createChestTile_title.
  ///
  /// In en, this message translates to:
  /// **'Create a new chest'**
  String get settingsPage_createChestTile_title;

  /// No description provided for @settingsPage_invitationsTile_title.
  ///
  /// In en, this message translates to:
  /// **'Invitations'**
  String get settingsPage_invitationsTile_title;

  /// No description provided for @settingsPage_manageChestTile_title.
  ///
  /// In en, this message translates to:
  /// **'Manage this chest'**
  String get settingsPage_manageChestTile_title;

  /// No description provided for @settingsPage_signoutTile_title.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get settingsPage_signoutTile_title;

  /// No description provided for @signinPage_disabledBanner.
  ///
  /// In en, this message translates to:
  /// **'Temporarily disabled for legal reasons. Ask your awesome bruv to create an account for you.'**
  String get signinPage_disabledBanner;

  /// No description provided for @signinPage_disclaimer.
  ///
  /// In en, this message translates to:
  /// **'This application is a PRIVATE and EXPERIMENTAL project intended for AUTHORIZED users only. By accessing and using this application, you acknowledge that you do so AT YOUR OWN RISK.\n\nAccounts should only be created under the explicit authorization of the project owner. We make no guarantees regarding the security, privacy, or integrity of any data submitted or collected through this application, nor can we ensure the safety of your device while interacting with this service. As this is an experimental project, the application may change or cease to function without notice.\n\nThe project owner is not liable for any damages or loss resulting from the use of this application.'**
  String get signinPage_disclaimer;

  /// No description provided for @signinPage_disclaimer_title.
  ///
  /// In en, this message translates to:
  /// **'DISCLAIMER OF LIABILITY'**
  String get signinPage_disclaimer_title;

  /// No description provided for @signinPage_error_emailRateLimitExceeded.
  ///
  /// In en, this message translates to:
  /// **'We\'ve reached our hourly sign-in limit. Please try again later.'**
  String get signinPage_error_emailRateLimitExceeded;

  /// No description provided for @signinPage_error_userNotFound.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t find this user.'**
  String get signinPage_error_userNotFound;

  /// No description provided for @signinPage_hint_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get signinPage_hint_email;

  /// No description provided for @signinPage_hint_username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get signinPage_hint_username;

  /// No description provided for @signinPage_loginButton.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get signinPage_loginButton;

  /// No description provided for @signinPage_signupButton.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signinPage_signupButton;

  /// No description provided for @signinPage_tab_login.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get signinPage_tab_login;

  /// No description provided for @signinPage_tab_signup.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signinPage_tab_signup;

  /// No description provided for @signinPage_title.
  ///
  /// In en, this message translates to:
  /// **'Welcome to ChuckleChest!'**
  String get signinPage_title;

  /// No description provided for @snackBar_error_defaultMessage.
  ///
  /// In en, this message translates to:
  /// **'Oops! Something went wrong. Please check your internet connection and try again.'**
  String get snackBar_error_defaultMessage;

  /// No description provided for @stagingBanner_button.
  ///
  /// In en, this message translates to:
  /// **'Release version'**
  String get stagingBanner_button;

  /// No description provided for @stagingBanner_message.
  ///
  /// In en, this message translates to:
  /// **'You\'re using the staging version.'**
  String get stagingBanner_message;
}

class _CAppL10nDelegate extends LocalizationsDelegate<CAppL10n> {
  const _CAppL10nDelegate();

  @override
  Future<CAppL10n> load(Locale locale) {
    return SynchronousFuture<CAppL10n>(lookupCAppL10n(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_CAppL10nDelegate old) => false;
}

CAppL10n lookupCAppL10n(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return CAppL10nDe();
    case 'en': return CAppL10nEn();
  }

  throw FlutterError(
    'CAppL10n.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
