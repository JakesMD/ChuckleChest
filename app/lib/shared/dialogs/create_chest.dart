import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';

/// {@template CCreateChestDialog}
///
/// A dialog that allows the user to create a new chest.
///
/// {@endtemplate}
class CCreateChestDialog extends StatelessWidget with CDialogMixin {
  /// {@macro CCreateChestDialog}
  CCreateChestDialog({
    required this.cubit,
    super.key,
  });

  /// The cubit that handles creating the chest.
  ///
  /// Because the dialog is not a part of the page's context, the cubit is
  /// passed in as a parameter.
  final CChestCreationCubit cubit;

  final _formKey = GlobalKey<FormFieldState<String>>();
  final _nameInput = CTextInput();

  void _onCancelPressed(BuildContext context) => Navigator.of(context).pop();

  void _onCreatePressed(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      cubit.createChest(chestName: _nameInput.value!);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.cAppL10n.chestCreationDialog_title),
      content: TextFormField(
        key: _formKey,
        validator: (value) => _nameInput.formFieldValidator(value, context),
        decoration: InputDecoration(
          labelText: context.cAppL10n.chestCreationDialog_label_chestName,
          border: const OutlineInputBorder(),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => _onCancelPressed(context),
          child: Text(context.cAppL10n.cancel),
        ),
        TextButton(
          onPressed: () => _onCreatePressed(context),
          child: Text(context.cAppL10n.chestCreationDialog_createButton),
        ),
      ],
    );
  }
}
