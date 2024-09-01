import 'dart:ui';

import 'package:cgem_repository/cgem_repository.dart';
import 'package:cpub/bloc.dart';
import 'package:cpub/bloc_concurrency.dart';
import 'package:cpub/bobs_jobs.dart';
import 'package:cpub/equatable.dart';
import 'package:cpub/flutter_bloc.dart';

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
