import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CChangeThemeDialog}
///
/// Shows a dialog for updating the current app theme mode.
///
/// {@endtemplate}
class CChangeThemeDialog extends StatelessWidget {
  /// {@macro CChangeThemeDialog}
  const CChangeThemeDialog({required this.cubit, super.key});

  /// The cubit that handles changing the theme mode.
  final CAppSettingsCubit cubit;

  void _onChanged(BuildContext context, ThemeMode? themeMode) {
    cubit.changeThemeMode(newThemeMode: themeMode!);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.cAppL10n.themeDialog_title),
      content: BlocBuilder<CAppSettingsCubit, CAppSettingsState>(
        bloc: cubit,
        builder: (context, state) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
              title: Text(context.cAppL10n.themeDialog_device),
              value: ThemeMode.system,
              groupValue: state.themeMode,
              onChanged: (t) => _onChanged(context, t),
              secondary: const Icon(Icons.auto_mode_rounded),
            ),
            RadioListTile(
              title: Text(context.cAppL10n.themeDialog_lightMode),
              value: ThemeMode.light,
              groupValue: state.themeMode,
              onChanged: (t) => _onChanged(context, t),
              secondary: const Icon(Icons.light_mode_rounded),
            ),
            RadioListTile(
              title: Text(context.cAppL10n.themeDialog_darkMode),
              value: ThemeMode.dark,
              groupValue: state.themeMode,
              onChanged: (t) => _onChanged(context, t),
              secondary: const Icon(Icons.dark_mode_rounded),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(context.cAppL10n.close),
        ),
      ],
    );
  }
}
