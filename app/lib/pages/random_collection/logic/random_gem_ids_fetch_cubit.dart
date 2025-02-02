import 'package:bloc/bloc.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CRandomGemIDsFetchState}
///
/// The state for the [CRandomGemIDsFetchCubit].
///
/// {@endtemplate}
class CRandomGemIDsFetchState
    extends CRequestCubitState<CRandomGemIDsFetchException, List<String>> {
  /// {@macro CRandomGemIDsFetchState}
  ///
  /// The initial state.
  CRandomGemIDsFetchState.initial() : super.initial();

  /// {@macro CRandomGemIDsFetchState}
  ///
  /// The in progress state.
  CRandomGemIDsFetchState.inProgress() : super.inProgress();

  /// {@macro CRandomGemIDsFetchState}
  ///
  /// The completed state.
  CRandomGemIDsFetchState.completed({required super.outcome})
      : super.completed();

  /// The IDs of the random gems that were fetched.
  List<String> get ids => success;
}

/// {@template CRandomGemIDsFetchCubit}
///
/// The cubit for handling fetching the IDs of random gems.
///
/// {@endtemplate}
class CRandomGemIDsFetchCubit extends Cubit<CRandomGemIDsFetchState> {
  /// {@macro CRandomGemIDsFetchCubit}
  CRandomGemIDsFetchCubit({
    required this.gemRepository,
    required this.chestID,
  }) : super(CRandomGemIDsFetchState.initial());

  /// The repository this cubit uses to fetch the gem IDs.
  final CGemRepository gemRepository;

  /// The ID of the chest to fetch the gems from.
  final String chestID;

  /// Fetches the IDs of random gems.
  Future<void> fetchRandomGemIDs() async {
    emit(CRandomGemIDsFetchState.inProgress());

    final result =
        await gemRepository.fetchRandomGemIDs(chestID: chestID).run();

    emit(CRandomGemIDsFetchState.completed(outcome: result));
  }
}
