import 'package:ccore/ccore.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/edit_person/bloc/person_update/cubit.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:cperson_repository/cperson_repository.dart';
import 'package:flutter/material.dart';

/// {@template CNicknameTile}
///
/// A tile for displaying and editing a person's nickname.
///
/// {@endtemplate}
class CEditNicknameDialog extends StatelessWidget with CDialogMixin {
  /// {@macro CEditNicknameDialog}
  CEditNicknameDialog({
    required this.person,
    required this.cubit,
    super.key,
  });

  /// The person to change.
  final CPerson person;

  /// The cubit for updating people.
  final CPersonUpdateCubit cubit;

  final _formKey = GlobalKey<FormFieldState<String>>();
  final _name = CTextInput();

  void _onOkPressed(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    cubit.updateNickname(person, _name.value(context));

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.cAppL10n.editPersonPage_editNicknameDialog_title),
      content: TextFormField(
        key: _formKey,
        initialValue: person.nickname,
        validator: (value) => _name.validator(
          input: value,
          context: context,
        ),
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          labelText: context.cAppL10n.editGemPage_editLineDialog_hint_line,
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
