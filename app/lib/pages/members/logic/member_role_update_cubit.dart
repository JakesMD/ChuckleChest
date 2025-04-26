import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cchest_repository/cchest_repository.dart';
import 'package:ccore/ccore.dart';
import 'package:chuckle_chest/shared/logic/_logic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CMemberRoleUpdateState}
///
/// The state for the [CMemberRoleUpdateCubit].
///
/// {@endtemplate}
class CMemberRoleUpdateState
    extends CRequestCubitState<CMemberRoleUpdateException, BobsNothing> {
  /// {@macro CMemberRoleUpdateState}
  ///
  /// The initial state.
  CMemberRoleUpdateState.initial()
      : member = bobsAbsent(),
        super.initial();

  /// {@macro CMemberRoleUpdateState}
  ///
  /// The in-progress state.
  CMemberRoleUpdateState.inProgress()
      : member = bobsAbsent(),
        super.inProgress();

  /// {@macro CMemberRoleUpdateState}
  ///
  /// The completed state.
  CMemberRoleUpdateState.completed({
    required super.outcome,
    required this.member,
  }) : super.completed();

  /// The member that was updated.
  final BobsMaybe<CMember> member;
}

/// {@template CMemberRoleUpdateCubit}
///
/// The cubit that handles updating a member's role.
///
/// {@endtemplate}
class CMemberRoleUpdateCubit extends Cubit<CMemberRoleUpdateState> {
  /// {@macro CMemberRoleUpdateCubit}
  CMemberRoleUpdateCubit({required this.chestRepository})
      : super(CMemberRoleUpdateState.initial());

  /// The repository this cubit uses to update roles.
  final CChestRepository chestRepository;

  /// Updates the role of the member with the given 'role'.
  Future<void> updateMemberRole({
    required CMember member,
    required CUserRole role,
  }) async {
    emit(CMemberRoleUpdateState.inProgress());

    final result = await chestRepository
        .updateMemberRole(member: member, role: role)
        .run();

    emit(
      CMemberRoleUpdateState.completed(
        outcome: result,
        member: result.resolve(
          onFailure: (f) => bobsAbsent(),
          onSuccess: (_) => bobsPresent(
            CMember(
              chestID: member.chestID,
              userID: member.userID,
              username: member.username,
              role: role,
            ),
          ),
        ),
      ),
    );
  }
}
