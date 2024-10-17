import 'package:ccore/ccore.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/manage_chest/logic/_logic.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:flutter/material.dart';

/// {@template CNicknameTile}
///
/// The dialog on the manage chest page for editing the chest's name.
///
/// {@endtemplate}
class CEditChestNameDialog extends StatelessWidget with CDialogMixin {
  /// {@macro CEditChestNameDialog}
  CEditChestNameDialog({
    required this.initialName,
    required this.cubit,
    super.key,
  });

  /// The initial name of the chest.
  final String initialName;

  /// The cubit that will update the chest's name.
  ///
  /// Because the dialog is not a part of the page's context, the cubit is
  /// passed in as a parameter.
  final CChestNameUpdateCubit cubit;

  final _formKey = GlobalKey<FormFieldState<String>>();
  final _name = CTextInput();

  void _onOkPressed(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    cubit.updateChestName(name: _name.value(context));

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.cAppL10n.manageChestPage_editChestNameDialog_title),
      content: TextFormField(
        key: _formKey,
        initialValue: initialName,
        validator: (value) => _name.validator(input: value, context: context),
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          labelText: context.cAppL10n.manageChestPage_editChestNameDialog_hint,
          border: const OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.cAppL10n.cancel),
        ),
        TextButton(
          onPressed: () => _onOkPressed(context),
          child: Text(context.cAppL10n.save),
        ),
      ],
    );
  }
}
