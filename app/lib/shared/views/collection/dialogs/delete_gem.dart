import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:chuckle_chest/shared/views/collection/logic/_logic.dart';
import 'package:flutter/material.dart';

/// {@template CDeleteGemDialog}
///
/// The dialog that asks the user to confirm the deletion of a gem.
///
/// {@endtemplate}
class CDeleteGemDialog extends StatelessWidget with CDialogMixin {
  /// {@macro CDeleteGemDialog}
  const CDeleteGemDialog({
    required this.gemID,
    required this.cubit,
    super.key,
  });

  /// The ID of the gem to delete.
  final String gemID;

  /// The cubit that will delete the gem.
  ///
  /// Because the dialog is not a part of the page's context, the cubit is
  /// passed in as a parameter.
  final CGemDeleteCubit cubit;

  void _onDeletePressed(BuildContext context) {
    cubit.deleteGem(gemID: gemID);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: const Key('delete_gem_dialog'),
      title: Text(context.cAppL10n.collectionView_deleteGemDialog_title),
      content: Text(context.cAppL10n.collectionView_deleteGemDialog_message),
      actions: [
        TextButton(
          key: const Key('delete_gem_dialog_cancel_button'),
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.cAppL10n.cancel),
        ),
        TextButton(
          key: const Key('delete_gem_dialog_delete_button'),
          onPressed: () => _onDeletePressed(context),
          child: Text(context.cAppL10n.delete),
        ),
      ],
    );
  }
}
