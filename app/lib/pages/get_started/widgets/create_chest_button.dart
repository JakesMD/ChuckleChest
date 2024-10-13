import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:chuckle_chest/shared/dialogs/_dialogs.dart';
import 'package:flutter/material.dart';

/// {@template CCreateChestButton}
///
/// The button on the get started page that allows the user to create a new
/// chest.
///
/// {@endtemplate}
class CCreateChestButton extends StatelessWidget {
  /// {@macro CCreateChestButton}
  const CCreateChestButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CLoadingButton<CChestCreationCubit, CChestCreationState>(
      child: Text(context.cAppL10n.getStartedPage_createChestButton),
      isLoading: (state) => state.status == CRequestCubitStatus.inProgress,
      onPressed: (context, cubit) =>
          CChestCreationDialog(cubit: cubit).show(context),
      builder: (context, text, onPressed) =>
          FilledButton(onPressed: onPressed, child: text),
    );
  }
}
