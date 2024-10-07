import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

/// {@template CGemShareBloc}
///
/// Bloc that handles sharing a gem.
///
/// {@endtemplate}
class CGemShareBloc extends Bloc<_CGemShareEvent, CGemShareState> {
  /// {@macro CGemShareBloc}
  CGemShareBloc({
    required this.gemRepository,
  }) : super(CGemShareInitial()) {
    on<CGemShareTriggered>(_onTriggered, transformer: droppable());
    on<_CGemShareCompleted>(_onCompleted);
  }

  /// The repository this bloc uses to retrieve gem data.
  final CGemRepository gemRepository;

  Future<void> _onTriggered(
    CGemShareTriggered event,
    Emitter<CGemShareState> emit,
  ) async {
    emit(CGemShareInProgress());

    final result = await gemRepository
        .shareGem(
          gemID: event.gemID,
          sharePositionOrigin: event.sharePositionOrigin,
          message: event.message,
          subject: event.subject,
        )
        .run();

    add(_CGemShareCompleted(result: result));
  }

  void _onCompleted(
    _CGemShareCompleted event,
    Emitter<CGemShareState> emit,
  ) {
    emit(
      event.result.evaluate(
        onFailure: (exception) => CGemShareFailure(exception: exception),
        onSuccess: (method) => CGemShareSuccess(method: method),
      ),
    );
  }
}
