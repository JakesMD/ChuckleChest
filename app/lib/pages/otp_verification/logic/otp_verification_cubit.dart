import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cauth_repository/cauth_repository.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template COTPVerificationState}
///
/// The state for the [COTPVerificationCubit].
///
/// {@endtemplate}
class COTPVerificationState
    extends CRequestCubitState<COTPVerificationException, BobsNothing> {
  /// {@macro COTPVerificationState}
  ///
  /// The initial state.
  COTPVerificationState.initial() : super.initial();

  /// {@macro COTPVerificationState}
  ///
  /// The in progress state.
  COTPVerificationState.inProgress() : super.inProgress();

  /// {@macro COTPVerificationState}
  ///
  /// The failure state.
  COTPVerificationState.completed({required super.outcome}) : super.completed();
}

/// {@template COTPVerificationCubit}
///
/// The cubit for handling OTP verification.
///
/// {@endtemplate}
class COTPVerificationCubit extends Cubit<COTPVerificationState> {
  /// {@macro COTPVerificationCubit}
  COTPVerificationCubit({required this.authRepository})
      : super(COTPVerificationState.initial());

  /// The repository this cubit will use to verify the OTP.
  final CAuthRepository authRepository;

  /// Verify the OTP for the given `email` and `pin`.
  Future<void> verifyOTP({required String email, required String pin}) async {
    emit(COTPVerificationState.inProgress());

    final result = await authRepository.verifyOTP(email: email, pin: pin).run();

    emit(COTPVerificationState.completed(outcome: result));
  }
}
