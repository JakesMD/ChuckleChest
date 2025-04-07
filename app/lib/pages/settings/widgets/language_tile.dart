import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CLanguageTile}
///
/// A tile on the settings page allows the user to change the app language.
///
/// {@endtemplate}
class CLanguageTile extends StatelessWidget {
  /// {@macro CLanguageTile}
  const CLanguageTile({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<CAppSettingsCubit>().state.locale;

    return ListTile(
      minVerticalPadding: 24,
      leading: const Icon(Icons.translate_rounded),
      title: Text(context.cAppL10n.settingsPage_languageTile_title),
      subtitle: Text(
        locale != null
            ? locale.languageCode == 'en'
                ? locale.countryCode == 'GB'
                    ? 'English GB'
                    : 'English US'
                : 'Deutsch'
            : context.cAppL10n.settingsPage_languageTile_device,
      ),
      onTap: () => showDialog(
        context: context,
        builder: (_) => CChangeLanguageDialog(cubit: context.read()),
      ),
    );
  }
}
