import 'package:cauth_repository/cauth_repository.dart';
import 'package:cpub/bloc_concurrency.dart';
import 'package:cpub/bobs_jobs.dart';
import 'package:cpub/equatable.dart';
import 'package:cpub/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

/// {@template CSignupBloc}
///
/// The bloc for handling signup.
///
/// {@endtemplate}
class CSignupBloc extends Bloc<_CSignupEvent, CSignupState> {
  /// {@macro CSignupBloc}
  CSignupBloc({required this.authRepository}) : super(CSignupInitial()) {
    on<CSignupFormSubmitted>(_onFormSubmitted, transformer: droppable());
    on<_CSignupCompleted>(_onCompleted);
  }

  /// The repository for handling signup.
  final CAuthRepository authRepository;

  Future<void> _onFormSubmitted(
    CSignupFormSubmitted event,
    Emitter<CSignupState> emit,
  ) async {
    emit(CSignupInProgress(email: event.email));

    final result = await authRepository
        .signUpWithOTP(username: event.username, email: event.email)
        .run();

    add(_CSignupCompleted(result: result));
  }

  void _onCompleted(
    _CSignupCompleted event,
    Emitter<CSignupState> emit,
  ) {
    emit(
      event.result.evaluate(
        onFailure: (exception) => CSignupFailure(exception: exception),
        onSuccess: (_) => CSignupSuccess(
          email: (state as CSignupInProgress).email,
        ),
      ),
    );
  }
}
