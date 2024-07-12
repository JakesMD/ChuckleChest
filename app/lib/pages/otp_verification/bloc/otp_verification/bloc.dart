import 'package:cauth_repository/cauth_repository.dart';
import 'package:ccore/ccore.dart';
import 'package:cpub/bloc_concurrency.dart';
import 'package:cpub/equatable.dart';
import 'package:cpub/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

/// {@template COTPVerificationBloc}
///
/// The bloc for handling OTP verification.
///
/// {@endtemplate}
class COTPVerificationBloc
    extends Bloc<_COTPVerificationEvent, COTPVerificationState> {
  /// {@macro COTPVerificationBloc}
  COTPVerificationBloc({required this.authRepository})
      : super(COTPVerificationInitial()) {
    on<COTPVerificationSubmitted>(_onEmailSubmitted, transformer: droppable());
    on<_COTPVerificationCompleted>(_onCompleted);
  }

  /// The repository for handling OTP verifcation.
  final CAuthRepository authRepository;

  Future<void> _onEmailSubmitted(
    COTPVerificationSubmitted event,
    Emitter<COTPVerificationState> emit,
  ) async {
    emit(COTPVerificationInProgress());

    final result = await authRepository
        .verifyOTP(email: event.email, pin: event.pin)
        .run();

    add(_COTPVerificationCompleted(result: result));
  }

  void _onCompleted(
    _COTPVerificationCompleted event,
    Emitter<COTPVerificationState> emit,
  ) {
    emit(
      event.result.evaluate(
        onFailure: (exception) => COTPVerificationFailure(exception: exception),
        onSuccess: (_) => COTPVerificationSuccess(),
      ),
    );
  }
}
