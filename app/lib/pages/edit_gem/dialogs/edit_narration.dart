import 'package:ccore/ccore.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/edit_gem/logic/gem_edit_cubit.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:flutter/material.dart';

/// {@template CEditNarrationDialog}
///
/// A dialog for creating or editing a narration.
///
/// {@endtemplate}
class CEditNarrationDialog extends StatelessWidget with CDialogMixin {
  /// {@macro CEditNarrationDialog}
  CEditNarrationDialog({
    required this.cubit,
    this.line,
    this.index = 0,
    super.key,
  });

  /// The line to edit.
  final CLine? line;

  /// The index of the line.
  final int index;

  /// The cubit that will update or add the line.
  ///
  /// Because the dialog is not a part of the page's context, the cubit is
  /// passed in as a parameter.
  final CGemEditCubit cubit;

  final _formKey = GlobalKey<FormFieldState<String>>();
  final _lineText = CTextInput();

  void _onOkPressed(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    if (line == null) {
      cubit.addLine(personID: null, text: _lineText.value(context));
    } else {
      cubit.updateLine(
        lineIndex: index,
        personID: null,
        text: _lineText.value(context),
      );
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        line != null
            ? context.cAppL10n.editGemPage_editLineDialog_title_editNarration
            : context.cAppL10n.editGemPage_editLineDialog_title_createNarration,
      ),
      content: TextFormField(
        key: _formKey,
        initialValue: line?.text,
        validator: (value) => _lineText.validator(
          input: value,
          context: context,
        ),
        keyboardType: TextInputType.multiline,
        maxLines: null,
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
          child: Text(context.cAppL10n.ok),
        ),
      ],
    );
  }
}
