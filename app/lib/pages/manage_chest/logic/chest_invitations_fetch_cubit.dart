import 'package:cchest_repository/cchest_repository.dart';
import 'package:chuckle_chest/shared/logic/_logic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CChestInvitationsFetchState}
///
/// The state for the [CChestInvitationsFetchCubit].
///
/// {@endtemplate}
class CChestInvitationsFetchState extends CRequestCubitState<
    CChestInvitationsFetchException, List<CChestInvitation>> {
  /// {@macro CChestInvitationsFetchState}
  ///
  /// The initial state.
  CChestInvitationsFetchState.initial()
      : invitations = [],
        super.initial();

  /// {@macro CChestInvitationsFetchState}
  ///
  /// The in-progress state.
  CChestInvitationsFetchState.inProgress()
      : invitations = [],
        super.inProgress();

  /// {@macro CChestInvitationsFetchState}
  ///
  /// The completed state.
  CChestInvitationsFetchState.completed({
    required super.outcome,
    required this.invitations,
  }) : super.completed();

  /// The list of chest invitations that were fetched.
  final List<CChestInvitation> invitations;

  @override
  List<Object?> get props => super.props..addAll(invitations);
}

/// {@template CChestInvitationsFetchCubit}
///
/// The cubit that handles fetching chest invitations.
///
/// {@endtemplate}
class CChestInvitationsFetchCubit extends Cubit<CChestInvitationsFetchState> {
  /// {@macro CChestInvitationsFetchCubit}
  CChestInvitationsFetchCubit({
    required this.chestRepository,
    required this.chestID,
  }) : super(CChestInvitationsFetchState.initial());

  /// The repository this cubit uses to fetch chest invitations.
  final CChestRepository chestRepository;

  /// The ID of the chest to fetch invitations for.
  final String chestID;

  /// Fetches the chest invitations.
  Future<void> fetchChestInvitations() async {
    emit(CChestInvitationsFetchState.inProgress());

    final result =
        await chestRepository.fetchChestInvitations(chestID: chestID).run();

    emit(
      CChestInvitationsFetchState.completed(
        outcome: result,
        invitations: result.resolve(onFailure: (f) => [], onSuccess: (i) => i),
      ),
    );
  }

  /// Updates the state to include the given [invitation].
  void addInvitation({required CChestInvitation invitation}) {
    emit(
      CChestInvitationsFetchState.completed(
        outcome: state.outcome,
        invitations: List.from(state.invitations)..add(invitation),
      ),
    );
  }
}
