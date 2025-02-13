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
      content: BlocBuilder<CAppSettingsCubit, CAppSettingsState>(
        bloc: cubit,
        builder: (context, state) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
              title: const Text('English GB'),
              value: const Locale('en', 'GB'),
              groupValue: state.locale,
              onChanged: (l) => _onChanged(context, l),
            ),
            RadioListTile(
              title: const Text('English US'),
              value: const Locale('en', 'US'),
              groupValue: state.locale,
              onChanged: (l) => _onChanged(context, l),
            ),
            RadioListTile(
              title: const Text('Deutsch'),
              value: const Locale('de'),
              groupValue: state.locale,
              onChanged: (l) => _onChanged(context, l),
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
