import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/dialogs/_dialogs.dart';
import 'package:chuckle_chest/shared/logic/_logic.dart';
import 'package:chuckle_chest/shared/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CCreateChestTile}
///
/// The tile on the settings page that allows the user to create a new chest of
/// their own.
///
/// {@endtemplate}
class CCreateChestTile extends StatelessWidget {
  /// {@macro CCreateChestTile}
  const CCreateChestTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CChestCreationCubit, CChestCreationState>(
      builder: (context, state) => ListTile(
        minVerticalPadding: 16,
        leading: const Icon(Icons.add_rounded),
        title: Text(context.cAppL10n.settingsPage_createChestTile_title),
        enabled: state.status != CRequestCubitStatus.inProgress,
        onTap: () => CCreateChestDialog(cubit: context.read()).show(context),
        trailing: state.status == CRequestCubitStatus.inProgress
            ? const CBouncyBallLoadingIndicator()
            : null,
      ),
    );
  }
}
