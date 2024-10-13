import 'package:bloc/bloc.dart';
import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cauth_repository/cauth_repository.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CSignoutState}
///
/// The state for the [CSignoutCubit].
///
/// {@endtemplate}
class CSignoutState extends CRequestCubitState<CSignoutException, BobsNothing> {
  /// {@macro CSignoutState}
  ///
  /// The initial state.
  CSignoutState.initial() : super.initial();

  /// {@macro CSignoutState}
  ///
  /// The in progress state.
  CSignoutState.inProgress() : super.inProgress();

  /// {@macro CSignoutState}
  ///
  /// The completed state.
  CSignoutState.completed({required super.outcome}) : super.completed();
}

/// {@template CSignoutCubit}
///
/// The cubit that handles logging the current user out.
///
/// {@endtemplate}
class CSignoutCubit extends Cubit<CSignoutState> {
  /// {@macro CSignoutCubit}
  CSignoutCubit({required this.authRepository})
      : super(CSignoutState.initial());

  /// The repository this bloc uses to log the current user out.
  final CAuthRepository authRepository;

  /// Logs the current user out.
  Future<void> signOut() async {
    emit(CSignoutState.inProgress());

    final result = await authRepository.signOut().run(isDebugMode: kDebugMode);

    emit(CSignoutState.completed(outcome: result));
  }
}
