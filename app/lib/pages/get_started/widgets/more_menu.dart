import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/app/_app.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CGetStartedPageMoreMenu}
///
/// The button on the app bar of the get started page that opens a menu with
/// additional options, such as signing out.
///
/// {@endtemplate}
class CGetStartedPageMoreMenu extends StatelessWidget {
  /// {@macro CGetStartedPageMoreMenu}
  const CGetStartedPageMoreMenu({super.key});

  void _onChangeThemePressed(BuildContext context) => showDialog(
        context: context,
        builder: (_) => CChangeThemeDialog(cubit: context.read()),
      );

  void _onChangeLanguagePressed(BuildContext context) => showDialog(
        context: context,
        builder: (_) => CChangeLanguageDialog(cubit: context.read()),
      );

  void _onSignOutPressed(BuildContext context) =>
      context.read<CSignoutCubit>().signOut();

  void _onLogsPressed(BuildContext context) =>
      context.pushRoute(const CLogsRoute());

  @override
  Widget build(BuildContext context) {
    final signoutState = context.watch<CSignoutCubit>().state;

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
          onTap: !signoutState.inProgress
              ? () => _onSignOutPressed(context)
              : null,
          child: const Icon(Icons.logout_rounded),
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
