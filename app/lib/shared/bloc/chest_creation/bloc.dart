import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cchest_repository/cchest_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

/// {@template CChestCreationBloc}
///
/// Bloc that handles creating a chest.
///
/// {@endtemplate}
class CChestCreationBloc
    extends Bloc<_CChestCreationEvent, CChestCreationState> {
  /// {@macro CChestCreationBloc}
  CChestCreationBloc({
    required this.chestRepository,
  }) : super(CChestCreationInitial()) {
    on<CChestCreationTriggered>(_onTriggered, transformer: droppable());
    on<_CChestCreationCompleted>(_onCompleted);
  }

  /// The repository this bloc uses to create the chest.
  final CChestRepository chestRepository;

  Future<void> _onTriggered(
    CChestCreationTriggered event,
    Emitter<CChestCreationState> emit,
  ) async {
    emit(CChestCreationInProgress());

    final result =
        await chestRepository.createChest(chestName: event.chestName).run();

    add(_CChestCreationCompleted(result: result));
  }

  void _onCompleted(
    _CChestCreationCompleted event,
    Emitter<CChestCreationState> emit,
  ) {
    emit(
      event.result.evaluate(
        onFailure: (exception) => CChestCreationFailure(exception: exception),
        onSuccess: (chestID) => CChestCreationSuccess(chestID: chestID),
      ),
    );
  }
}
