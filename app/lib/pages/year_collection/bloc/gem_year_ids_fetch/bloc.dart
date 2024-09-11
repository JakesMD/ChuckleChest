import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

/// {@template CGemYearIDsFetchBloc}
///
/// Bloc that handles fetching a gem years.
///
/// {@endtemplate}
class CGemYearIDsFetchBloc
    extends Bloc<_CGemYearIDsFetchEvent, CGemYearIDsFetchState> {
  /// {@macro CGemYearIDsFetchBloc}
  CGemYearIDsFetchBloc({
    required this.gemRepository,
    required this.chestID,
    required this.year,
  }) : super(CGemYearIDsFetchInProgress()) {
    on<CGemYearIDsFetchRequested>(_onRequested, transformer: droppable());
    add(CGemYearIDsFetchRequested());
  }

  /// The repository this bloc uses to retrieve gem data.
  final CGemRepository gemRepository;

  /// The unique identifier of the chest.
  final String chestID;

  /// The year to fetch.
  final int year;

  Future<void> _onRequested(
    CGemYearIDsFetchRequested event,
    Emitter<CGemYearIDsFetchState> emit,
  ) async {
    emit(CGemYearIDsFetchInProgress());

    final result = await gemRepository
        .fetchGemIDsForYear(
          chestID: chestID,
          year: year,
        )
        .run();

    emit(
      result.evaluate(
        onFailure: (exception) => CGemYearIDsFetchFailure(exception: exception),
        onSuccess: (ids) => CGemYearIDsFetchSuccess(ids: ids),
      ),
    );
  }
}
