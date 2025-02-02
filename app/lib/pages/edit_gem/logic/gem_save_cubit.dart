import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/shared/logic/_logic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CGemSaveState}
///
/// The state for the [CGemSaveCubit].
///
/// {@endtemplate}
class CGemSaveState extends CRequestCubitState<CGemSaveException, String> {
  /// {@macro CGemSaveState}
  ///
  /// The initial state.
  CGemSaveState.initial() : super.initial();

  /// {@macro CGemSaveState}
  ///
  /// The in-progress state.
  CGemSaveState.inProgress() : super.inProgress();

  /// {@macro CGemSaveState}
  ///
  /// The completed state.
  CGemSaveState.completed({required super.outcome}) : super.completed();

  /// The ID of the saved gem.
  String get gemID => success;
}

/// {@template CGemSaveCubit}
///
/// The cubit that handles saving gems.
///
/// {@endtemplate}
class CGemSaveCubit extends Cubit<CGemSaveState> {
  /// {@macro CGemSaveCubit}
  CGemSaveCubit({required this.gemRepository}) : super(CGemSaveState.initial());

  /// The repository this cubit uses to save gems.
  final CGemRepository gemRepository;

  /// Saves any updates to the given `gem` and deletes the `deletedLines`.
  Future<void> saveGem({
    required CGem gem,
    required List<CLine> deletedLines,
  }) async {
    emit(CGemSaveState.inProgress());

    final result =
        await gemRepository.saveGem(gem: gem, deletedLines: deletedLines).run();

    emit(CGemSaveState.completed(outcome: result));
  }
}
