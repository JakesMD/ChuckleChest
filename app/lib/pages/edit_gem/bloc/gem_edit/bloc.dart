import 'package:bloc/bloc.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

/// {@template CGemEditBloc}
///
/// Bloc that handles creating and editing a gem.
///
/// {@endtemplate}
class CGemEditBloc extends Bloc<_CGemEditEvent, CGemEditState> {
  /// {@macro CGemEditBloc}
  CGemEditBloc({
    required this.gemRepository,
    required this.chestID,
    required CGem? gem,
  }) : super(
          CGemEditState(
            gem: gem ??
                CGem(
                  id: '',
                  number: 1,
                  occurredAt: DateTime.now(),
                  lines: [],
                  chestID: chestID,
                ),
            deletedLines: [],
          ),
        ) {
    on<CGemEditLineAdded>(_onLineAdded);
    on<CGemEditLineUpdated>(_onLineUpdated);
    on<CGemEditLastLineDeleted>(_onLastLineDeleted);
    on<CGemEditDateUpdated>(_onOccurredAtUpdated);
  }

  /// The repository this bloc uses to retrieve gem data.
  final CGemRepository gemRepository;

  /// The ID of the chest this gem belongs to.
  final String chestID;

  void _onLineAdded(
    CGemEditLineAdded event,
    Emitter<CGemEditState> emit,
  ) {
    state.gem.lines.add(
      CLine(
        gemID: state.gem.id,
        chestID: chestID,
        id: BigInt.zero,
        text: event.text,
        personID: event.personID,
      ),
    );

    emit(CGemEditState(gem: state.gem, deletedLines: state.deletedLines));
  }

  void _onLineUpdated(
    CGemEditLineUpdated event,
    Emitter<CGemEditState> emit,
  ) {
    final oldLine = state.gem.lines[event.lineIndex];
    final newLine = oldLine.copyWith(
      text: event.text,
      personID: event.personID,
    );

    state.gem.lines
      ..removeAt(event.lineIndex)
      ..insert(event.lineIndex, newLine);

    emit(CGemEditState(gem: state.gem, deletedLines: state.deletedLines));
  }

  void _onLastLineDeleted(
    CGemEditLastLineDeleted event,
    Emitter<CGemEditState> emit,
  ) {
    final deletedLine = state.gem.lines.removeLast();

    if (deletedLine.id != null) state.deletedLines.add(deletedLine);

    emit(
      CGemEditState(gem: state.gem, deletedLines: state.deletedLines),
    );
  }

  void _onOccurredAtUpdated(
    CGemEditDateUpdated event,
    Emitter<CGemEditState> emit,
  ) {
    emit(
      CGemEditState(
        gem: state.gem.copyWith(occurredAt: event.occurredAt),
        deletedLines: state.deletedLines,
      ),
    );
  }
}
