import 'package:cauth_repository/cauth_repository.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/manage_chest/dialogs/_dialogs.dart';
import 'package:chuckle_chest/pages/manage_chest/logic/_logic.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CChestNameTile}
///
/// The tile on the manage chest page that allows the user to change the chest's
/// name.
///
/// {@endtemplate}
class CChestNameTile extends StatelessWidget {
  /// {@macro CChestNameTile}
  const CChestNameTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CCurrentChestCubit, CAuthUserChest>(
      builder: (context, chest) =>
          BlocBuilder<CChestNameUpdateCubit, CChestNameUpdateState>(
        builder: (context, state) => ListTile(
          minVerticalPadding: 32,
          title: Text(context.cAppL10n.manageChestPage_chestNameTile_title),
          subtitle: Text(chest.name),
          trailing: state.status != CRequestCubitStatus.inProgress
              ? const Icon(Icons.edit_rounded)
              : const CBouncyBallLoadingIndicator(),
          enabled: state.status != CRequestCubitStatus.inProgress,
          onTap: state.status != CRequestCubitStatus.inProgress
              ? () => CEditChestNameDialog(
                    initialName: chest.name,
                    cubit: context.read(),
                  ).show(context)
              : null,
        ),
      ),
    );
  }
}
