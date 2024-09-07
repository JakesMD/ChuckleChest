import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

/// {@template CGemYearsFetchBloc}
///
/// Bloc that handles fetching a gem years.
///
/// {@endtemplate}
class CGemYearsFetchBloc
    extends Bloc<_CGemYearsFetchEvent, CGemYearsFetchState> {
  /// {@macro CGemYearsFetchBloc}
  CGemYearsFetchBloc({
    required this.gemRepository,
    required this.chestID,
  }) : super(CGemYearsFetchInProgress()) {
    on<CGemYearsFetchRequested>(_onRequested, transformer: droppable());
    add(CGemYearsFetchRequested());
  }

  /// The repository this bloc uses to retrieve gem data.
  final CGemRepository gemRepository;

  /// The unique identifier of the chest.
  final String chestID;

  Future<void> _onRequested(
    CGemYearsFetchRequested event,
    Emitter<CGemYearsFetchState> emit,
  ) async {
    emit(CGemYearsFetchInProgress());

    final result = await gemRepository.fetchGemYears(chestID: chestID).run();

    emit(
      result.evaluate(
        onFailure: (exception) => CGemYearsFetchFailure(exception: exception),
        onSuccess: (years) =>
            CGemYearsFetchSuccess(years: years..sort((a, b) => b.compareTo(a))),
      ),
    );
  }
}
