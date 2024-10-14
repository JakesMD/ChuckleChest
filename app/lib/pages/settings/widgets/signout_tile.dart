import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/logic/_logic.dart';
import 'package:chuckle_chest/shared/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CSignoutTile}
///
/// The tile on the settings page that allows the user to sign out.
///
/// {@endtemplate}
class CSignoutTile extends StatelessWidget {
  /// {@macro CSignoutTile}
  const CSignoutTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CSignoutCubit, CSignoutState>(
      builder: (context, state) => ListTile(
        minVerticalPadding: 16,
        leading: const Icon(Icons.logout_rounded),
        title: Text(context.cAppL10n.settingsPage_signoutTile_title),
        enabled: state.status != CRequestCubitStatus.inProgress,
        onTap: context.read<CSignoutCubit>().signOut,
        trailing: state.status == CRequestCubitStatus.inProgress
            ? const CBouncyBallLoadingIndicator()
            : null,
      ),
    );
  }
}
