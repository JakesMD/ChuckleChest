import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  }) : super(const CGemFetchInitial()) {
    on<CGemFetchRequested>(_onRequested, transformer: droppable());
  }

  /// The repository this bloc uses to retrieve gem data.
  final CGemRepository gemRepository;

  Future<void> _onRequested(
    CGemFetchRequested event,
    Emitter<CGemFetchState> emit,
  ) async {
    emit(CGemFetchInProgress(gemID: event.gemID));

    final result = await gemRepository.fetchGem(gemID: event.gemID).run();

    emit(
      result.evaluate(
        onFailure: (exception) => CGemFetchFailure(
          exception: exception,
          gemID: event.gemID,
        ),
        onSuccess: (gem) => CGemFetchSuccess(gem: gem),
      ),
    );
  }
}
