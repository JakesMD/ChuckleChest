import 'package:bloc/bloc.dart';
import 'package:cchest_repository/cchest_repository.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CChestCreationState}
///
/// The state for the [CChestCreationCubit].
///
/// {@endtemplate}
class CChestCreationState
    extends CRequestCubitState<CChestCreationException, String> {
  /// {@macro CChestCreationState}
  ///
  /// The initial state.
  CChestCreationState.initial() : super.initial();

  /// {@macro CChestCreationState}
  ///
  /// The in progress state.
  CChestCreationState.inProgress() : super.inProgress();

  /// {@macro CChestCreationState}
  ///
  /// The completed state.
  CChestCreationState.completed({required super.outcome}) : super.completed();

  /// The ID of the created chest.
  String get chestID => success;
}

/// {@template CChestCreationCubit}
///
/// The cubit that handles creating a chest.
///
/// {@endtemplate}
class CChestCreationCubit extends Cubit<CChestCreationState> {
  /// {@macro CChestCreationCubit}
  CChestCreationCubit({required this.chestRepository})
      : super(CChestCreationState.initial());

  /// The repository this cubit uses to create the chest.
  final CChestRepository chestRepository;

  /// Creates a chest with the given `chestName`.
  Future<void> createChest({required String chestName}) async {
    emit(CChestCreationState.inProgress());

    final result =
        await chestRepository.createChest(chestName: chestName).run();

    emit(CChestCreationState.completed(outcome: result));
  }
}
