import 'package:bloc/bloc.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/shared/logic/request_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CGemYearsFetchState}
///
/// The state for the [CGemYearsFetchCubit].
///
/// {@endtemplate}
class CGemYearsFetchState
    extends CRequestCubitState<CGemYearsFetchException, List<int>> {
  /// {@macro CGemYearsFetchState}
  ///
  /// The initial state.
  CGemYearsFetchState.initial() : super.initial();

  /// {@macro CGemYearsFetchState}
  ///
  /// The in progress state.
  CGemYearsFetchState.inProgress() : super.inProgress();

  /// {@macro CGemYearsFetchState}
  ///
  /// The completed state.
  CGemYearsFetchState.completed({required super.outcome}) : super.completed();

  /// The destinct years of the all gems in the chest sorted in descending
  /// order.
  List<int> get years => success..sort((a, b) => b.compareTo(a));
}

/// {@template CGemYearsFetchCubit}
///
/// The cubit that handles fetching the destinct years of the gems in a chest.
///
/// {@endtemplate}
class CGemYearsFetchCubit extends Cubit<CGemYearsFetchState> {
  /// {@macro CGemYearsFetchCubit}
  CGemYearsFetchCubit({
    required this.gemRepository,
    required this.chestID,
  }) : super(CGemYearsFetchState.initial());

  /// The repository this bloc uses to fetch gem years.
  final CGemRepository gemRepository;

  /// The unique identifier of the chest that the gems belong to.
  final String chestID;

  /// Fetches the gem years.
  Future<void> fetchGemYears() async {
    emit(CGemYearsFetchState.inProgress());

    final result = await gemRepository.fetchGemYears(chestID: chestID).run();

    emit(CGemYearsFetchState.completed(outcome: result));
  }
}
