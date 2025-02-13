import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CThemeTile}
///
/// A tile on the settings page allows the user to change the app theme.
///
/// {@endtemplate}
class CThemeTile extends StatelessWidget {
  /// {@macro CThemeTile}
  const CThemeTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CAppSettingsCubit, CAppSettingsState>(
      builder: (context, state) => ListTile(
        leading: Icon(
          switch (state.themeMode) {
            ThemeMode.system => Icons.auto_mode_rounded,
            ThemeMode.light => Icons.light_mode_rounded,
            ThemeMode.dark => Icons.dark_mode_rounded,
          },
        ),
        title: Text(context.cAppL10n.settingsPage_themeTile_title),
        subtitle: Text(
          switch (state.themeMode) {
            ThemeMode.system => context.cAppL10n.themeDialog_device,
            ThemeMode.light => context.cAppL10n.themeDialog_lightMode,
            ThemeMode.dark => context.cAppL10n.themeDialog_darkMode,
          },
        ),
        onTap: () => showDialog(
          context: context,
          builder: (_) => CChangeThemeDialog(cubit: context.read()),
        ),
      ),
    );
  }
}
