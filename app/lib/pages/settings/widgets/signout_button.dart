import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/logic/_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CSignoutButton}
///
/// The tile on the settings page that allows the user to sign out.
///
/// {@endtemplate}
class CSignoutButton extends StatelessWidget {
  /// {@macro CSignoutButton}
  const CSignoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CSignoutCubit>().state;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: FilledButton.icon(
        icon: const Icon(Icons.logout_rounded),
        label: Text(context.cAppL10n.settingsPage_signoutButton),
        onPressed: !state.inProgress
            ? () => context.read<CSignoutCubit>().signOut()
            : null,
      ),
    );
  }
}
