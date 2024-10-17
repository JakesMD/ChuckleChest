import 'package:chuckle_chest/pages/manage_chest/dialogs/_dialogs.dart';
import 'package:chuckle_chest/pages/manage_chest/logic/invitation_creation_cubit.dart';
import 'package:chuckle_chest/shared/logic/_logic.dart';
import 'package:chuckle_chest/shared/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CManageChestPageFAB}
///
/// The floating action button that allows the user to create an invitation to
/// the chest.
///
/// {@endtemplate}
class CManageChestPageFAB extends StatelessWidget {
  /// {@macro CManageChestPageFAB}
  const CManageChestPageFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CInvitationCreationCubit, CInvitationCreationState>(
      builder: (context, state) => FloatingActionButton(
        onPressed: state.status != CRequestCubitStatus.inProgress
            ? () => CCreateInvitationDialog(
                  chestID: context.read<CCurrentChestCubit>().state.id,
                  cubit: context.read(),
                ).show(context)
            : null,
        child: state.status != CRequestCubitStatus.inProgress
            ? const Icon(Icons.add_rounded)
            : const CBouncyBallLoadingIndicator(),
      ),
    );
  }
}
