import 'package:bloc/bloc.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CGemEditState}
///
/// The state for the [CGemEditCubit].
///
/// {@endtemplate}
class CGemEditState extends Equatable {
  /// {@macro CGemEditState}
  const CGemEditState({required this.gem, required this.deletedLines});

  /// The gem being edited.
  final CGem gem;

  /// The lines that have been deleted.
  final List<CLine> deletedLines;

  @override
  List<Object?> get props => [gem, deletedLines];
}

/// {@template CGemEditCubit}
///
/// The cubit that handles editing a gem.
///
/// If the gem is new, set `gem` to null and a new gem will be initialized.
///
/// {@endtemplate}
class CGemEditCubit extends Cubit<CGemEditState> {
  /// {@macro CGemEditCubit}
  CGemEditCubit({
    required this.chestID,
    required CGem? gem,
  }) : super(
          CGemEditState(
            gem: gem ??
                CGem(
                  id: '',
                  number: -1,
                  occurredAt: DateTime.now(),
                  lines: [],
                  chestID: chestID,
                ),
            deletedLines: const [],
          ),
        );

  /// The ID of the chest this gem belongs to.
  final String chestID;

  /// Adds a line to the gem.
  void addLine({required String text, required BigInt? personID}) {
    state.gem.lines.add(
      CLine(
        id: null,
        gemID: state.gem.id,
        chestID: chestID,
        text: text,
        personID: personID,
      ),
    );

    emit(CGemEditState(gem: state.gem, deletedLines: state.deletedLines));
  }

  /// Updates the line at the given `lineIndex`.
  void updateLine({
    required int lineIndex,
    required String text,
    required BigInt? personID,
  }) {
    final oldLine = state.gem.lines[lineIndex];
    final newLine = oldLine.copyWith(
      text: text,
      personID: personID,
    );

    state.gem.lines
      ..removeAt(lineIndex)
      ..insert(lineIndex, newLine);

    emit(CGemEditState(gem: state.gem, deletedLines: state.deletedLines));
  }

  /// Deletes the last line of the gem.
  void deleteLastLine() {
    final deletedLine = state.gem.lines.removeLast();

    if (deletedLine.id != null) state.deletedLines.add(deletedLine);

    emit(
      CGemEditState(gem: state.gem, deletedLines: state.deletedLines),
    );
  }

  /// Updates the occurred at date of the gem.
  void updateOccurredAt({required DateTime occurredAt}) {
    emit(
      CGemEditState(
        gem: state.gem.copyWith(occurredAt: occurredAt),
        deletedLines: state.deletedLines,
      ),
    );
  }
}
