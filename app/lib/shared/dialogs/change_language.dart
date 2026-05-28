import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/logic/_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CChangeLanguageDialog}
///
/// Shows a dialog for updating the current language of the app.
///
/// {@endtemplate}
class CChangeLanguageDialog extends StatelessWidget {
  /// {@macro CChangeLanguageDialog}
  const CChangeLanguageDialog({required this.cubit, super.key});

  /// The cubit that handles changing the app language.
  final CAppSettingsCubit cubit;

  void _onChanged(BuildContext context, Locale? locale) {
    cubit.changeLocale(newLocale: locale!);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.cAppL10n.languageDialog_title),
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
      content: BlocBuilder<CAppSettingsCubit, CAppSettingsState>(
        bloc: cubit,
        builder: (context, state) => RadioGroup(
          groupValue: state.locale,
          onChanged: (l) => _onChanged(context, l),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                title: Text('English GB'),
                value: Locale('en', 'GB'),
              ),
              RadioListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                title: Text('English US'),
                value: Locale('en', 'US'),
              ),
              RadioListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                title: Text('Deutsch'),
                value: Locale('de'),
              ),
            ],
          ),
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
