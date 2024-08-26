import 'package:cchest_repository/cchest_repository.dart';
import 'package:ccore/ccore.dart';
import 'package:cpub/bloc.dart';
import 'package:cpub/bloc_concurrency.dart';
import 'package:cpub/equatable.dart';
import 'package:cpub/flutter_bloc.dart';

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
