import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'localizations_de.g.dart';
import 'localizations_en.g.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of CCoreL10n
/// returned by `CCoreL10n.of(context)`.
///
/// Applications need to include `CCoreL10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/localizations.g.dart';
///
/// return MaterialApp(
///   localizationsDelegates: CCoreL10n.localizationsDelegates,
///   supportedLocales: CCoreL10n.supportedLocales,
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
/// be consistent with the languages listed in the CCoreL10n.supportedLocales
/// property.
abstract class CCoreL10n {
  CCoreL10n(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static CCoreL10n of(BuildContext context) {
    return Localizations.of<CCoreL10n>(context, CCoreL10n)!;
  }

  static const LocalizationsDelegate<CCoreL10n> delegate = _CCoreL10nDelegate();

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

  /// No description provided for @inputError_email_empty.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email address.'**
  String get inputError_email_empty;

  /// No description provided for @inputError_email_invalid.
  ///
  /// In en, this message translates to:
  /// **'That\'s not a valid email address.'**
  String get inputError_email_invalid;

  /// No description provided for @inputError_text_empty.
  ///
  /// In en, this message translates to:
  /// **'Please enter some text.'**
  String get inputError_text_empty;
}

class _CCoreL10nDelegate extends LocalizationsDelegate<CCoreL10n> {
  const _CCoreL10nDelegate();

  @override
  Future<CCoreL10n> load(Locale locale) {
    return SynchronousFuture<CCoreL10n>(lookupCCoreL10n(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_CCoreL10nDelegate old) => false;
}

CCoreL10n lookupCCoreL10n(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return CCoreL10nDe();
    case 'en': return CCoreL10nEn();
  }

  throw FlutterError(
    'CCoreL10n.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
