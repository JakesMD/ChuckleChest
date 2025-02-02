import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cchest_repository/cchest_repository.dart';
import 'package:ccore/ccore.dart';
import 'package:chuckle_chest/shared/logic/_logic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CInvitationCreationState}
///
/// The state for the [CInvitationCreationCubit].
///
/// {@endtemplate}
class CInvitationCreationState
    extends CRequestCubitState<CInvitationCreationException, BobsNothing> {
  /// {@macro CInvitationCreationState}
  ///
  /// The initial state.
  CInvitationCreationState.initial()
      : invitation = bobsAbsent(),
        super.initial();

  /// {@macro CInvitationCreationState}
  ///
  /// The in-progress state.
  CInvitationCreationState.inProgress()
      : invitation = bobsAbsent(),
        super.inProgress();

  /// {@macro CInvitationCreationState}
  ///
  /// The completed state.
  CInvitationCreationState.completed({
    required super.outcome,
    required this.invitation,
  }) : super.completed();

  /// The invitation that was created.
  final BobsMaybe<CChestInvitation> invitation;
}

/// {@template CInvitationCreationCubit}
///
/// The cubit that handles creating invitations.
///
/// {@endtemplate}
class CInvitationCreationCubit extends Cubit<CInvitationCreationState> {
  /// {@macro CInvitationCreationCubit}
  CInvitationCreationCubit({required this.chestRepository})
      : super(CInvitationCreationState.initial());

  /// The repository this cubit uses to create invitations.
  final CChestRepository chestRepository;

  /// Creates an invitation with the given [email], [chestID], and [role].
  Future<void> createInvitation({
    required String email,
    required String chestID,
    required CUserRole role,
  }) async {
    emit(CInvitationCreationState.inProgress());

    final invitation = CChestInvitation(
      assignedRole: role,
      email: email,
      chestID: chestID,
    );

    final result =
        await chestRepository.createInvitation(invitation: invitation).run();

    emit(
      CInvitationCreationState.completed(
        outcome: result,
        invitation: result.resolve(
          onFailure: (f) => bobsAbsent(),
          onSuccess: (_) => bobsPresent(invitation),
        ),
      ),
    );
  }
}
