import 'package:ccore/ccore.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:cpub/bloc.dart';
import 'package:cpub/bloc_concurrency.dart';
import 'package:cpub/equatable.dart';
import 'package:cpub/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

/// {@template CGemFetchBloc}
///
/// Bloc that handles fetching a gem.
///
/// {@endtemplate}
class CGemFetchBloc extends Bloc<_CGemFetchEvent, CGemFetchState> {
  /// {@macro CGemFetchBloc}
  CGemFetchBloc({
    required this.gemRepository,
    required this.gemID,
  }) : super(CGemFetchInProgress()) {
    on<CGemFetchTriggered>(_onTriggered, transformer: droppable());
    on<_CGemFetchCompleted>(_onCompleted);
    add(CGemFetchTriggered(gemID: gemID));
  }

  /// The repository this bloc uses to retrieve gem data.
  final CGemRepository gemRepository;

  /// The unique identifier of the gem.
  final String gemID;

  Future<void> _onTriggered(
    CGemFetchTriggered event,
    Emitter<CGemFetchState> emit,
  ) async {
    emit(CGemFetchInProgress());

    final result = await gemRepository.fetchGem(gemID: event.gemID).run();

    add(_CGemFetchCompleted(result: result));
  }

  void _onCompleted(
    _CGemFetchCompleted event,
    Emitter<CGemFetchState> emit,
  ) {
    emit(
      event.result.evaluate(
        onFailure: (exception) => CGemFetchFailure(exception: exception),
        onSuccess: (gem) => CGemFetchSuccess(gem: gem),
      ),
    );
  }
}
