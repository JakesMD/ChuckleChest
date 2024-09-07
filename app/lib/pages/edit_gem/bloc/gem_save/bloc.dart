import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

/// {@template CGemSaveBloc}
///
/// The bloc for handling gem saving.
///
/// {@endtemplate}
class CGemSaveBloc extends Bloc<_CGemSaveEvent, CGemSaveState> {
  /// {@macro CGemSaveBloc}
  CGemSaveBloc({required this.gemRepository}) : super(CGemSaveInitial()) {
    on<CGemSaveSubmitted>(_onSaved, transformer: droppable());
  }

  /// The repository for handling gems.
  final CGemRepository gemRepository;

  Future<void> _onSaved(
    CGemSaveSubmitted event,
    Emitter<CGemSaveState> emit,
  ) async {
    emit(CGemSaveInProgress());

    final result = await gemRepository
        .saveGem(gem: event.gem, deletedLines: event.deletedLines)
        .run();

    emit(
      result.evaluate(
        onFailure: (exception) => CGemSaveFailure(exception: exception),
        onSuccess: (gemID) => CGemSaveSuccess(gemID: gemID),
      ),
    );
  }
}
