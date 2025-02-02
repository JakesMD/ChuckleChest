import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cchest_repository/cchest_repository.dart';
import 'package:chuckle_chest/shared/logic/_logic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CChestNameUpdateState}
///
/// The state for the [CChestNameUpdateCubit].
///
/// {@endtemplate}
class CChestNameUpdateState
    extends CRequestCubitState<CChestUpdateException, BobsNothing> {
  /// {@macro CChestNameUpdateState}
  ///
  /// The initial state.
  CChestNameUpdateState.initial()
      : name = '',
        super.initial();

  /// {@macro CChestNameUpdateState}
  ///
  /// The in-progress state.
  CChestNameUpdateState.inProgress({required this.name}) : super.inProgress();

  /// {@macro CChestNameUpdateState}
  ///
  /// The completed state.
  CChestNameUpdateState.completed({required super.outcome, required this.name})
      : super.completed();

  /// The name that was applied to the chest.
  final String name;
}

/// {@template CChestNameUpdateCubit}
///
/// The cubit that handles updating chest names.
///
/// {@endtemplate}
class CChestNameUpdateCubit extends Cubit<CChestNameUpdateState> {
  /// {@macro CChestNameUpdateCubit}
  CChestNameUpdateCubit({
    required this.chestRepository,
    required this.chestID,
  }) : super(CChestNameUpdateState.initial());

  /// The repository this cubit uses to update chest names.
  final CChestRepository chestRepository;

  /// The ID of the chest to update.
  final String chestID;

  /// Updates the name of the chest with the given `name`.
  Future<void> updateChestName({required String name}) async {
    emit(CChestNameUpdateState.inProgress(name: name));

    final result =
        await chestRepository.updateChest(chestID: chestID, name: name).run();

    emit(CChestNameUpdateState.completed(outcome: result, name: name));
  }
}
