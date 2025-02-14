import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

/// {@template CAppSettingsState}
///
/// The state for the [CAppSettingsCubit].
///
/// {@endtemplate}
class CAppSettingsState {
  /// {@macro CAppSettingsState}
  const CAppSettingsState({
    required this.themeMode,
    this.locale,
    this.lastViewedChest,
  });

  /// The current locale of the app.
  final Locale? locale;

  /// The current theme mode of the app.
  final ThemeMode themeMode;

  /// The last viewed chest.
  final String? lastViewedChest;

  /// Creates a copy of this state with the given fields replaced with the
  /// given values.
  CAppSettingsState copyWith({
    Locale? locale,
    ThemeMode? themeMode,
    String? lastViewedChest,
  }) =>
      CAppSettingsState(
        locale: locale ?? this.locale,
        themeMode: themeMode ?? this.themeMode,
        lastViewedChest: lastViewedChest ?? this.lastViewedChest,
      );
}

/// {@template CAppSettingsCubit}
///
/// The contains handles updating the current locale of the app.
///
/// {@endtemplate}
class CAppSettingsCubit extends HydratedCubit<CAppSettingsState> {
  /// {@macro CAppSettingsCubit}
  CAppSettingsCubit()
      : super(const CAppSettingsState(themeMode: ThemeMode.system));

  /// Updates the current locale.
  void changeLocale({required Locale newLocale}) =>
      emit(state.copyWith(locale: newLocale));

  /// Updates the current theme mode.
  void changeThemeMode({required ThemeMode newThemeMode}) =>
      emit(state.copyWith(themeMode: newThemeMode));

  /// Updates the last viewed chest.
  void updateLastViewedChest(String chestID) =>
      emit(state.copyWith(lastViewedChest: chestID));

  @override
  CAppSettingsState fromJson(Map<String, dynamic> json) => CAppSettingsState(
        locale: json.containsKey('languageCode')
            ? Locale(
                json['languageCode'] as String,
                json['countryCode'] as String?,
              )
            : null,
        themeMode: json.containsKey('themeMode')
            ? ThemeMode.values[json['themeMode'] as int]
            : ThemeMode.system,
        lastViewedChest: json['lastViewedChest'] as String?,
      );

  @override
  Map<String, dynamic> toJson(CAppSettingsState state) => {
        if (state.locale != null) 'languageCode': state.locale!.languageCode,
        if (state.locale != null) 'countryCode': state.locale!.countryCode,
        'themeMode': state.themeMode.index,
        'lastViewedChest': state.lastViewedChest,
      };
}
