import 'package:cauth_repository/cauth_repository.dart';
import 'package:cpub/bloc_concurrency.dart';
import 'package:cpub/bobs_jobs.dart';
import 'package:cpub/equatable.dart';
import 'package:cpub/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

/// {@template CLoginBloc}
///
/// The bloc for handling login.
///
/// {@endtemplate}
class CLoginBloc extends Bloc<_CLoginEvent, CLoginState> {
  /// {@macro CLoginBloc}
  CLoginBloc({required this.authRepository}) : super(CLoginInitial()) {
    on<CLoginFormSubmitted>(_onEmailSubmitted, transformer: droppable());
    on<_CLoginCompleted>(_onCompleted);
  }

  /// The repository for handling login.
  final CAuthRepository authRepository;

  Future<void> _onEmailSubmitted(
    CLoginFormSubmitted event,
    Emitter<CLoginState> emit,
  ) async {
    emit(CLoginInProgress(email: event.email));

    final result = await authRepository.logInWithOTP(email: event.email).run();

    add(_CLoginCompleted(result: result));
  }

  void _onCompleted(
    _CLoginCompleted event,
    Emitter<CLoginState> emit,
  ) {
    emit(
      event.result.evaluate(
        onFailure: (exception) => CLoginFailure(exception: exception),
        onSuccess: (_) => CLoginSuccess(
          email: (state as CLoginInProgress).email,
        ),
      ),
    );
  }
}
