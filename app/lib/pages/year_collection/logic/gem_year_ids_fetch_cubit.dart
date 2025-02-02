import 'package:bloc/bloc.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CGemYearIDsFetchState}
///
/// The state for the [CGemYearIDsFetchCubit].
///
/// {@endtemplate}
class CGemYearIDsFetchState
    extends CRequestCubitState<CGemIDsFetchException, List<String>> {
  /// {@macro CGemYearIDsFetchState}
  ///
  /// The initial state.
  CGemYearIDsFetchState.initial() : super.initial();

  /// {@macro CGemYearIDsFetchState}
  ///
  /// The in progress state.
  CGemYearIDsFetchState.inProgress() : super.inProgress();

  /// {@macro CGemYearIDsFetchState}
  ///
  /// The completed state.
  CGemYearIDsFetchState.completed({required super.outcome}) : super.completed();

  /// The IDs of the gems that were fetched.
  List<String> get ids => success;
}

/// {@template CGemYearIDsFetchCubit}
///
/// The bloc for fetching the IDs of the gems for a specific year.
///
/// {@endtemplate}
class CGemYearIDsFetchCubit extends Cubit<CGemYearIDsFetchState> {
  /// {@macro CGemYearIDsFetchCubit}
  CGemYearIDsFetchCubit({
    required this.gemRepository,
    required this.chestID,
  }) : super(CGemYearIDsFetchState.initial());

  /// The repository this bloc uses to fetch the gem IDs.
  final CGemRepository gemRepository;

  /// The unique identifier of the chest.
  final String chestID;

  /// Fetches the gem IDs for a specific year.
  Future<void> fetchGemIDsForYear({required int year}) async {
    emit(CGemYearIDsFetchState.inProgress());

    final result = await gemRepository
        .fetchGemIDsForYear(chestID: chestID, year: year)
        .run();

    emit(CGemYearIDsFetchState.completed(outcome: result));
  }
}
