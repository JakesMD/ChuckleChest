import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cauth_repository/cauth_repository.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CLoginState}
///
/// The state for the [CLoginCubit].
///
/// {@endtemplate}
class CLoginState extends CRequestCubitState<CLoginException, BobsNothing> {
  /// {@macro CLoginState}
  ///
  /// The initial state.
  CLoginState.initial()
      : email = '',
        super.initial();

  /// {@macro CLoginState}
  ///
  /// The in progress state.
  CLoginState.inProgress()
      : email = '',
        super.inProgress();

  /// {@macro CLoginState}
  ///
  /// The completed state.
  CLoginState.completed({required super.outcome, required this.email})
      : super.completed();

  /// The email that was used to log in.
  final String email;

  @override
  List<Object?> get props => super.props..add(email);
}

/// {@template CLoginCubit}
///
/// The cubit for handling logging in.
///
/// {@endtemplate}
class CLoginCubit extends Cubit<CLoginState> {
  /// {@macro CLoginCubit}
  CLoginCubit({required this.authRepository}) : super(CLoginState.initial());

  /// The repository this cubit uses to log in.
  final CAuthRepository authRepository;

  /// Logs in with the given `email`.
  Future<void> logIn({required String email}) async {
    emit(CLoginState.inProgress());

    final result = await authRepository
        .logInWithOTP(email: email)
        .run(isDebugMode: kDebugMode);

    emit(CLoginState.completed(outcome: result, email: email));
  }
}
