import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'localizations_de.g.dart';
import 'localizations_en.g.dart';

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

  /// No description provided for @stagingBanner_message.
  ///
  /// In en, this message translates to:
  /// **'You\'re using the staging version.'**
  String get stagingBanner_message;

  /// No description provided for @stagingBanner_button.
  ///
  /// In en, this message translates to:
  /// **'Release version'**
  String get stagingBanner_button;

  /// No description provided for @snackBar_error_defaultMessage.
  ///
  /// In en, this message translates to:
  /// **'Oops! Something went wrong. Please check your internet connection and try again.'**
  String get snackBar_error_defaultMessage;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @gem_share_message.
  ///
  /// In en, this message translates to:
  /// **'Checkout this gem on Chuckle Chest! 😂 {link}'**
  String gem_share_message(Object link);

  /// No description provided for @gem_share_subject.
  ///
  /// In en, this message translates to:
  /// **'This is so good! 😂'**
  String get gem_share_subject;

  /// No description provided for @quoteItem_connection.
  ///
  /// In en, this message translates to:
  /// **'{nickname} • {age} {age, plural, =0{years} =1{year} other{years}} old'**
  String quoteItem_connection(Object nickname, int age);
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
