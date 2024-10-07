import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cauth_repository/cauth_repository.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CSignupState}
///
/// The state for the [CSignupCubit].
///
/// {@endtemplate}
class CSignupState extends CRequestCubitState<CSignupException, BobsNothing> {
  /// {@macro CSignupState}
  ///
  /// The initial state.
  CSignupState.initial()
      : email = '',
        super.initial();

  /// {@macro CSignupState}
  ///
  /// The in progress state.
  CSignupState.inProgress()
      : email = '',
        super.inProgress();

  /// {@macro CSignupState}
  ///
  /// The completed state.
  CSignupState.completed({required super.outcome, required this.email})
      : super.completed();

  /// The email that was used to sign up.
  final String email;

  @override
  List<Object?> get props => super.props..add(email);
}

/// {@template CSignupCubit}
///
/// The cubit for handling signing up.
///
/// {@endtemplate}
class CSignupCubit extends Cubit<CSignupState> {
  /// {@macro CSignupCubit}
  CSignupCubit({required this.authRepository}) : super(CSignupState.initial());

  /// The repository this cubit uses to sign up.
  final CAuthRepository authRepository;

  /// Logs in with the given `username` and `email`.
  Future<void> signUp({required String username, required String email}) async {
    emit(CSignupState.inProgress());

    final result = await authRepository
        .signUpWithOTP(username: username, email: email)
        .run(isDebugMode: kDebugMode);

    emit(CSignupState.completed(outcome: result, email: email));
  }
}
