import 'package:cauth_repository/cauth_repository.dart';
import 'package:ccore/ccore.dart';
import 'package:cpub/bloc_concurrency.dart';
import 'package:cpub/equatable.dart';
import 'package:cpub/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

/// {@template CSessionRefreshBloc}
///
/// The bloc for handling a session refresh.
///
/// {@endtemplate}
class CSessionRefreshBloc
    extends Bloc<_CSessionRefreshEvent, CSessionRefreshState> {
  /// {@macro CSessionRefreshBloc}
  CSessionRefreshBloc({required this.authRepository})
      : super(CSessionRefreshInitial()) {
    on<CSessionRefreshRequested>(_onRequested, transformer: droppable());
    on<_CSessionRefreshCompleted>(_onCompleted);
  }

  /// The repository for handling the session refresh.
  final CAuthRepository authRepository;

  Future<void> _onRequested(
    CSessionRefreshRequested event,
    Emitter<CSessionRefreshState> emit,
  ) async {
    emit(CSessionRefreshInProgress());

    final result = await authRepository.refreshSession().run();

    add(_CSessionRefreshCompleted(result: result));
  }

  void _onCompleted(
    _CSessionRefreshCompleted event,
    Emitter<CSessionRefreshState> emit,
  ) {
    emit(
      event.result.evaluate(
        onFailure: (exception) => CSessionRefreshFailure(exception: exception),
        onSuccess: (_) => CSessionRefreshSuccess(),
      ),
    );
  }
}
