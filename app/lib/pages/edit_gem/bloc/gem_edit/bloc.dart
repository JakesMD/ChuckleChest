import 'package:cgem_repository/cgem_repository.dart';
import 'package:cpub/bloc.dart';
import 'package:cpub/flutter_bloc.dart';

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
    required CGem? gem,
  }) : super(
          CGemEditState(
            gem: gem ??
                CGem(id: '', number: 1, occurredAt: DateTime.now(), lines: []),
          ),
        ) {
    on<CGemEditLineAdded>(_onLineAdded);
    on<CGemEditLineUpdated>(_onLineUpdated);
    on<CGemEditLastLineDeleted>(_onLastLineDeleted);
    on<CGemEditDateUpdated>(_onOccurredAtUpdated);
    on<CGemEditSaved>(_onSaved);
  }

  /// The repository this bloc uses to retrieve gem data.
  final CGemRepository gemRepository;

  void _onLineAdded(
    CGemEditLineAdded event,
    Emitter<CGemEditState> emit,
  ) {
    state.gem.lines.add(
      CLine(
        id: BigInt.zero,
        text: event.text,
        personID: event.personID,
      ),
    );

    emit(CGemEditState(gem: state.gem));
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

    emit(CGemEditState(gem: state.gem));
  }

  void _onLastLineDeleted(
    CGemEditLastLineDeleted event,
    Emitter<CGemEditState> emit,
  ) {
    emit(CGemEditState(gem: state.gem..lines.removeLast()));
  }

  void _onOccurredAtUpdated(
    CGemEditDateUpdated event,
    Emitter<CGemEditState> emit,
  ) {
    emit(
      CGemEditState(gem: state.gem.copyWith(occurredAt: event.occurredAt)),
    );
  }

  void _onSaved(
    CGemEditSaved event,
    Emitter<CGemEditState> emit,
  ) {
    emit(CGemEditState(gem: state.gem));
  }
}
