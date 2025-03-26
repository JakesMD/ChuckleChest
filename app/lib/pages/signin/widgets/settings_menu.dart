import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/app/routes.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CSettingsMenu}
///
/// The button on the app bar of the get started page that opens a menu with
/// additional options, such as changing the language.
///
/// {@endtemplate}
class CSettingsMenu extends StatelessWidget {
  /// {@macro CSettingsMenu}
  const CSettingsMenu({super.key});

  void _onChangeThemePressed(BuildContext context) => showDialog(
        context: context,
        builder: (_) => CChangeThemeDialog(cubit: context.read()),
      );

  void _onChangeLanguagePressed(BuildContext context) => showDialog(
        context: context,
        builder: (_) => CChangeLanguageDialog(cubit: context.read()),
      );

  void _onLogsPressed(BuildContext context) =>
      context.pushRoute(const CLogsRoute());

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert_rounded),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          onTap: () => _onChangeThemePressed(context),
          child: const Icon(Icons.light_mode_rounded),
        ),
        PopupMenuItem(
          value: 1,
          onTap: () => _onChangeLanguagePressed(context),
          child: const Icon(Icons.translate_rounded),
        ),
        PopupMenuItem(
          value: 1,
          onTap: () => _onLogsPressed(context),
          child: const Icon(Icons.developer_mode_rounded),
        ),
      ],
    );
  }
}
