import 'package:chuckle_chest/pages/invited/dialogs/_dialogs.dart';
import 'package:chuckle_chest/pages/invited/logic/_logic.dart';
import 'package:chuckle_chest/shared/logic/_logic.dart';
import 'package:chuckle_chest/shared/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CInviteFAB}
///
/// The floating action button that allows the user to create an invitation to
/// the chest.
///
/// {@endtemplate}
class CInviteFAB extends StatelessWidget {
  /// {@macro CInviteFAB}
  const CInviteFAB({super.key});

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
