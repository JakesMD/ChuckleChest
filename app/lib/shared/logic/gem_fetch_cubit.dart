import 'package:bloc/bloc.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CGemFetchState}
///
/// The state for the [CGemFetchCubit].
///
/// {@endtemplate}
class CGemFetchState extends CRequestCubitState<CGemFetchException, CGem> {
  /// {@macro CGemFetchState}
  ///
  /// The initial state.
  CGemFetchState.initial()
      : gemID = '',
        super.initial();

  /// {@macro CGemFetchState}
  ///
  /// The in progress state.
  CGemFetchState.inProgress({required this.gemID}) : super.inProgress();

  /// {@macro CGemFetchState}
  ///
  /// The completed state.
  CGemFetchState.completed({required super.outcome, required this.gemID})
      : super.completed();

  /// The gem that was fetched.
  CGem get gem => success;

  /// The ID of the gem requested to be fetched.
  final String gemID;

  @override
  List<Object?> get props => super.props..add(gemID);
}

/// {@template CGemFetchCubit}
///
/// The cubit that handles fetching gems.
///
/// {@endtemplate}
class CGemFetchCubit extends Cubit<CGemFetchState> {
  /// {@macro CGemFetchCubit}
  CGemFetchCubit({required this.gemRepository})
      : super(CGemFetchState.initial());

  /// The repository this bloc uses to retrieve gem data.
  final CGemRepository gemRepository;

  /// Fetches the gem with the given [gemID].
  Future<void> fetchGem({required String gemID}) async {
    emit(CGemFetchState.inProgress(gemID: gemID));

    final result = await gemRepository.fetchGem(gemID: gemID).run();

    emit(CGemFetchState.completed(outcome: result, gemID: gemID));
  }
}
