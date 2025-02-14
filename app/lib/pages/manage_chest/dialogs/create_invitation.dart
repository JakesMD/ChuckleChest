import 'package:ccore/ccore.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/manage_chest/logic/_logic.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signed_spacing_flex/signed_spacing_flex.dart';

/// {@template CNicknameTile}
///
/// The dialog on the manage chest page for editing the chest's name.
///
/// {@endtemplate}
class CCreateInvitationDialog extends StatelessWidget with CDialogMixin {
  /// {@macro CCreateInvitationDialog}
  CCreateInvitationDialog({
    required this.cubit,
    required this.chestID,
    super.key,
  });

  /// The current chest's ID.
  final String chestID;

  /// The cubit that will create the invitation.
  ///
  /// Because the dialog is not a part of the page's context, the cubit is
  /// passed in as a parameter.
  final CInvitationCreationCubit cubit;

  final _formKey = GlobalKey<FormFieldState<String>>();
  final _email = CEmailInput();

  void _onOkPressed(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    cubit.createInvitation(
      email: _email.value!,
      role: context.read<CCreateInvitationDialogCubit>().state,
      chestID: chestID,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CCreateInvitationDialogCubit(),
      child: Builder(
        builder: (context) => AlertDialog(
          title: Text(
            context.cAppL10n.manageChestPage_createInvitationDialog_title,
          ),
          content: SignedSpacingColumn(
            spacing: 24,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                key: _formKey,
                validator: (value) => _email.formFieldValidator(value, context),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: context.cAppL10n
                      .manageChestPage_createInvitationDialog_hint_email,
                  border: const OutlineInputBorder(),
                ),
              ),
              BlocBuilder<CCreateInvitationDialogCubit, CUserRole>(
                builder: (context, state) => SegmentedButton(
                  segments: [
                    ButtonSegment(
                      value: CUserRole.viewer,
                      label: Text(
                        CUserRole.viewer.cLocalize(context),
                      ),
                    ),
                    ButtonSegment(
                      value: CUserRole.collaborator,
                      label: Text(
                        CUserRole.collaborator.cLocalize(context),
                      ),
                    ),
                  ],
                  selected: {state},
                  onSelectionChanged: (selected) => context
                      .read<CCreateInvitationDialogCubit>()
                      .changeRole(selected.first),
                ),
              ),
            ],
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
        ),
      ),
    );
  }
}
