import 'package:bloc/bloc.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CRecentGemIDsFetchState}
///
/// The state for the [CRecentGemIDsFetchCubit].
///
/// {@endtemplate}
class CRecentGemIDsFetchState
    extends CRequestCubitState<CGemIDsFetchException, List<String>> {
  /// {@macro CRecentGemIDsFetchState}
  ///
  /// The initial state.
  CRecentGemIDsFetchState.initial() : super.initial();

  /// {@macro CRecentGemIDsFetchState}
  ///
  /// The in progress state.
  CRecentGemIDsFetchState.inProgress() : super.inProgress();

  /// {@macro CRecentGemIDsFetchState}
  ///
  /// The completed state.
  CRecentGemIDsFetchState.completed({required super.outcome})
      : super.completed();

  /// The IDs of the recent gems that were fetched.
  List<String> get ids => success;
}

/// {@template CRecentGemIDsFetchCubit}
///
/// The cubit for handling fetching the IDs of the recent gems.
///
/// {@endtemplate}
class CRecentGemIDsFetchCubit extends Cubit<CRecentGemIDsFetchState> {
  /// {@macro CRecentGemIDsFetchCubit}
  CRecentGemIDsFetchCubit({
    required this.gemRepository,
    required this.chestID,
  }) : super(CRecentGemIDsFetchState.initial());

  /// The repository this cubit uses to fetch the gem IDs.
  final CGemRepository gemRepository;

  /// The ID of the chest to fetch the gems from.
  final String chestID;

  /// Fetches the IDs of the recent gems.
  Future<void> fetchRecentGemIDs() async {
    emit(CRecentGemIDsFetchState.inProgress());

    final result = await gemRepository
        .fetchRecentGemIDs(chestID: chestID)
        .run(isDebugMode: kDebugMode);

    emit(CRecentGemIDsFetchState.completed(outcome: result));
  }
}
