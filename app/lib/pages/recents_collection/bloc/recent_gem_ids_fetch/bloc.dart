import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

/// {@template CRecentGemIDsFetchBloc}
///
/// Bloc that handles fetching a gem years.
///
/// {@endtemplate}
class CRecentGemIDsFetchBloc
    extends Bloc<_CRecentGemIDsFetchEvent, CRecentGemIDsFetchState> {
  /// {@macro CRecentGemIDsFetchBloc}
  CRecentGemIDsFetchBloc({
    required this.gemRepository,
    required this.chestID,
  }) : super(CRecentGemIDsFetchInProgress()) {
    on<CRecentGemIDsFetchRequested>(_onRequested, transformer: droppable());
    add(CRecentGemIDsFetchRequested());
  }

  /// The repository this bloc uses to retrieve gem data.
  final CGemRepository gemRepository;

  /// The unique identifier of the chest.
  final String chestID;

  Future<void> _onRequested(
    CRecentGemIDsFetchRequested event,
    Emitter<CRecentGemIDsFetchState> emit,
  ) async {
    emit(CRecentGemIDsFetchInProgress());

    final result =
        await gemRepository.fetchRecentGemIDs(chestID: chestID).run();

    emit(
      result.evaluate(
        onFailure: (exception) =>
            CRecentGemIDsFetchFailure(exception: exception),
        onSuccess: (ids) => CRecentGemIDsFetchSuccess(ids: ids),
      ),
    );
  }
}
