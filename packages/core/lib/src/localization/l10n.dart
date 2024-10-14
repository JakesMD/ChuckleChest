import 'package:ccore/ccore.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

export 'generated/localizations.g.dart';

// coverage:ignore-start
/// Initializes the localization system.
Future<void> cInitializeL10n() => initializeDateFormatting();
// coverage:ignore-end

/// {@template CCoreL10nExtension}
///
/// Provides access to this widget tree's [cCoreL10n] instance.
///
/// {@endtemplate}
extension CCoreL10nExtension on BuildContext {
  /// {@macro CCoreL10nExtension}
  CCoreL10n get cCoreL10n => CCoreL10n.of(this);
}

/// The different ways of formatting dates in a localized string.
enum CDateFormat {
  /// 02/10/2024
  yearMonthNumDayNum,

  /// Feburary 2024
  yearMonth,
}

/// {@template CL10nDateExtension}
///
/// Formats the [DateTime] into a localized string with date and time
/// information for the current [BuildContext]'s locale.
///
/// {@endtemplate}
extension CL10nDateExtension on DateTime {
  /// {@macro CL10nDateExtension}
  String cLocalize(
    BuildContext context, {
    CDateFormat dateFormat = CDateFormat.yearMonthNumDayNum,
  }) {
    final pattern = switch (dateFormat) {
      CDateFormat.yearMonthNumDayNum => 'yMd',
      CDateFormat.yearMonth => 'yMMMM',
    };
    initializeDateFormatting();

    return DateFormat(
      pattern,
      Localizations.localeOf(context).toLanguageTag(),
    ).format(this);
  }
}

/// {@template CL10nNumExtension}
///
/// Formats the [num] into a localized string using the decimal pattern
/// for the current [BuildContext]'s locale.
///
/// {@endtemplate}
extension CL10nNumExtension on num {
  /// {@macro CL10nNumExtension}
  String cLocalize(BuildContext context, {int? decimalDigits}) {
    return NumberFormat.decimalPatternDigits(
      locale: Localizations.localeOf(context).toLanguageTag(),
      decimalDigits: decimalDigits,
    ).format(this);
  }
}

/// {@template CL10nStringExtension}
///
/// Returns the number represented by this string localized to the given
/// [BuildContext]'s locale, or null if the string does not contain a valid
/// number.
///
/// {@endtemplate}
extension CL10nStringExtension on String {
  /// {@macro CL10nStringExtension}
  num? cToLocalizedNum(BuildContext context) {
    try {
      return NumberFormat.decimalPattern(
        Localizations.localeOf(context).toLanguageTag(),
      ).parse(this);
    } on FormatException catch (_) {
      return null;
    }
  }
}

/// {@template CL10nUserRoleExtension}
///
/// Returns this role localized to the given [BuildContext]'s locale.
///
/// {@endtemplate}
extension CL10nUserRoleExtension on CUserRole {
  /// {@macro CL10nUserRoleExtension}
  String cLocalize(BuildContext context) => switch (this) {
        CUserRole.owner => context.cCoreL10n.userRole_owner,
        CUserRole.collaborator => context.cCoreL10n.userRole_collaborator,
        CUserRole.viewer => context.cCoreL10n.userRole_viewer,
      };
}
