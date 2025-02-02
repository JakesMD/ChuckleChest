import 'package:bloc/bloc.dart';
import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cchest_repository/cchest_repository.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CInvitationAcceptState}
///
/// The state for the [CInvitationAcceptCubit].
///
/// {@endtemplate}
class CInvitationAcceptState
    extends CRequestCubitState<CInvitationAcceptException, BobsNothing> {
  /// {@macro CInvitationAcceptState}
  ///
  /// The initial state.
  CInvitationAcceptState.initial()
      : chestID = '',
        super.initial();

  /// {@macro CInvitationAcceptState}
  ///
  /// The in progress state.
  CInvitationAcceptState.inProgress({required this.chestID})
      : super.inProgress();

  /// {@macro CInvitationAcceptState}
  ///
  /// The completed state.
  CInvitationAcceptState.completed({
    required super.outcome,
    required this.chestID,
  }) : super.completed();

  /// The ID of the chest that the invitation was accepted for.
  final String chestID;
}

/// {@template CInvitationAcceptCubit}
///
/// The cubit that handles accepting an invitation to a chest.
///
/// {@endtemplate}
class CInvitationAcceptCubit extends Cubit<CInvitationAcceptState> {
  /// {@macro CInvitationAcceptCubit}
  CInvitationAcceptCubit({required this.chestRepository})
      : super(CInvitationAcceptState.initial());

  /// The repository this cubit uses to accept invitations.
  final CChestRepository chestRepository;

  /// Accepts the invitation to the chest with the given [chestID].
  Future<void> acceptInvitation({required String chestID}) async {
    emit(CInvitationAcceptState.inProgress(chestID: chestID));

    final result =
        await chestRepository.acceptInvitation(chestID: chestID).run();

    emit(CInvitationAcceptState.completed(outcome: result, chestID: chestID));
  }
}
