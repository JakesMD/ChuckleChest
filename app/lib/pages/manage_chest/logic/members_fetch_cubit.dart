import 'package:cchest_repository/cchest_repository.dart';
import 'package:chuckle_chest/shared/logic/_logic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CMembersFetchState}
///
/// The state for the [CMembersFetchCubit].
///
/// {@endtemplate}
class CMembersFetchState
    extends CRequestCubitState<CMembersFetchException, List<CMember>> {
  /// {@macro CMembersFetchState}
  ///
  /// The initial state.
  CMembersFetchState.initial()
      : members = [],
        super.initial();

  /// {@macro CMembersFetchState}
  ///
  /// The in-progress state.
  CMembersFetchState.inProgress()
      : members = [],
        super.inProgress();

  /// {@macro CMembersFetchState}
  ///
  /// The completed state.
  CMembersFetchState.completed({
    required super.outcome,
    required this.members,
  }) : super.completed();

  /// The list of chest members that were fetched.
  final List<CMember> members;

  @override
  List<Object?> get props => super.props..addAll(members);
}

/// {@template CMembersFetchCubit}
///
/// The cubit that handles fetching chest members
///
/// {@endtemplate}
class CMembersFetchCubit extends Cubit<CMembersFetchState> {
  /// {@macro CMembersFetchCubit}
  CMembersFetchCubit({
    required this.chestRepository,
    required this.chestID,
  }) : super(CMembersFetchState.initial());

  /// The repository this cubit uses to fetch chest members.
  final CChestRepository chestRepository;

  /// The ID of the chest to fetch members for.
  final String chestID;

  /// Fetches the chest members.
  Future<void> fetchMembers() async {
    emit(CMembersFetchState.inProgress());

    final result = await chestRepository.fetchMembers(chestID: chestID).run();

    emit(
      CMembersFetchState.completed(
        outcome: result,
        members: result.resolve(onFailure: (f) => [], onSuccess: (m) => m),
      ),
    );
  }

  /// Updates the member with the same 'userID' as the given 'member'.
  void updateMember({required CMember member}) {
    if (state.status != CRequestCubitStatus.succeeded) return;

    final index = state.members.indexWhere((m) => m.userID == member.userID);
    if (index == -1) return;

    final newMembers = List.from(state.members).cast<CMember>()
      ..removeAt(index)
      ..insert(index, member);

    emit(
      CMembersFetchState.completed(outcome: state.outcome, members: newMembers),
    );
  }
}
