import 'package:ccore/ccore.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/edit_gem/logic/_logic.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:cperson_repository/cperson_repository.dart';
import 'package:flutter/material.dart';
import 'package:signed_spacing_flex/signed_spacing_flex.dart';

/// {@template CEditQuoteDialog}
///
/// A dialog for creating or editing a quote.
///
/// {@endtemplate}
class CEditQuoteDialog extends StatelessWidget with CDialogMixin {
  /// {@macro CEditQuoteDialog}
  CEditQuoteDialog({
    required this.cubit,
    required this.people,
    required this.occurredAt,
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

  /// The date the gem occurred at.
  final DateTime occurredAt;

  /// The people to select from.
  final List<CPerson> people;

  final _formKey = GlobalKey<FormState>();
  final _lineText = CTextInput();
  final _personID = CDropdownInput<BigInt>();

  void _onOkPressed(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    if (line == null) {
      cubit.addLine(
        personID: _personID.value(context),
        text: _lineText.value(context),
      );
    } else {
      cubit.updateLine(
        lineIndex: index,
        personID: _personID.value(context),
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
            ? context.cAppL10n.editGemPage_editLineDialog_title_editQuote
            : context.cAppL10n.editGemPage_editLineDialog_title_createQuote,
      ),
      content: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: SignedSpacingColumn(
            mainAxisSize: MainAxisSize.min,
            spacing: 24,
            children: [
              _CPersonDropdownMenuFormField(
                line: line,
                occurredAt: occurredAt,
                people: people,
                personIDInput: _personID,
              ),
              TextFormField(
                initialValue: line?.text,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                validator: (value) => _lineText.validator(
                  context: context,
                  input: value,
                ),
                decoration: InputDecoration(
                  labelText:
                      context.cAppL10n.editGemPage_editLineDialog_hint_line,
                  border: const OutlineInputBorder(),
                ),
              ),
            ],
          ),
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

class _CPersonDropdownMenuFormField extends StatelessWidget {
  const _CPersonDropdownMenuFormField({
    required this.line,
    required this.occurredAt,
    required this.people,
    required this.personIDInput,
  });

  final CLine? line;
  final DateTime occurredAt;
  final List<CPerson> people;
  final CDropdownInput<BigInt> personIDInput;

  @override
  Widget build(BuildContext context) {
    people.sort((a, b) => b.dateOfBirth.compareTo(a.dateOfBirth));

    return FormField(
      initialValue: line?.personID,
      validator: (value) => personIDInput.validator(
        context: context,
        input: value,
      ),
      builder: (state) => SignedSpacingRow(
        spacing: 16,
        children: [
          CAvatar.fromPersonID(
            personID: state.value,
            people: people,
            date: occurredAt,
          ),
          Expanded(
            child: DropdownMenu(
              initialSelection: line?.personID,
              label: Text(
                context.cAppL10n.editGemPage_editLineDialog_hint_person,
              ),
              onSelected: state.didChange,
              width: 240,
              errorText: state.errorText,
              dropdownMenuEntries: people
                  .where(
                    (person) =>
                        person.dateOfBirth.difference(occurredAt).isNegative,
                  )
                  .map(
                    (person) => DropdownMenuEntry(
                      value: person.id,
                      label: person.nickname,
                      leadingIcon: CAvatar.fromPersonID(
                        personID: person.id,
                        people: people,
                        date: occurredAt,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
