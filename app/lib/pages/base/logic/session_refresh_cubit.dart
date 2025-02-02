import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cauth_repository/cauth_repository.dart';
import 'package:chuckle_chest/shared/logic/request_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CSessionRefreshState}
///
/// The state for the [CSessionRefreshCubit].
///
/// {@endtemplate}
class CSessionRefreshState
    extends CRequestCubitState<CSessionRefreshException, BobsNothing> {
  /// {@macro CSessionRefreshState}
  ///
  /// The initial state.
  CSessionRefreshState.initial() : super.initial();

  /// {@macro CSessionRefreshState}
  ///
  /// The in progress state.
  CSessionRefreshState.inProgress() : super.inProgress();

  /// {@macro CSessionRefreshState}
  ///
  /// The completed state.
  CSessionRefreshState.completed({required super.outcome}) : super.completed();
}

/// {@template CSessionRefreshCubit}
///
/// The cubit for handling a session refresh.
///
/// The session refresh will fetch the users latest chests and roles.
///
/// {@endtemplate}
class CSessionRefreshCubit extends Cubit<CSessionRefreshState> {
  /// {@macro CSessionRefreshCubit}
  CSessionRefreshCubit({required this.authRepository})
      : super(CSessionRefreshState.initial());

  /// The repository this cubit uses to refresh the session.
  final CAuthRepository authRepository;

  /// Refreshes the session.
  Future<void> refreshSession() async {
    emit(CSessionRefreshState.inProgress());

    final result = await authRepository.refreshSession().run();

    emit(CSessionRefreshState.completed(outcome: result));
  }
}
