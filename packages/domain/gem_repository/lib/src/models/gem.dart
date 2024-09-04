import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:cgem_repository/src/models/_models.dart';
import 'package:equatable/equatable.dart';

/// {@template CGem}
///
/// Represents a story, made up of narration and quotes.
///
/// {@endtemplate}
class CGem with EquatableMixin {
  /// {@macro CGem}
  const CGem({
    required this.id,
    required this.number,
    required this.occurredAt,
    required this.lines,
    required this.chestID,
  });

  /// {@macro CGem}
  ///
  /// Converts a [CGemsTableRecord] to a [CGem].
  factory CGem.fromRecord(CGemsTableRecord record) {
    final sortedRawLines = record.lines..sort((a, b) => a.id.compareTo(b.id));

    return CGem(
      id: record.id,
      number: record.number,
      occurredAt: record.occurredAt,
      lines: sortedRawLines.map(CLine.fromRecord).toList(),
      chestID: record.chestID,
    );
  }

  /// The unique identifier of the gem.
  final String id;

  /// The number of the story.
  final int number;

  /// The date the story the gem represents happened.
  final DateTime occurredAt;

  /// The lines of the gem.
  final List<CLine> lines;

  /// The unique identifier of the chest the gem belongs to.
  final String chestID;

  /// {@macro CGem}
  ///
  /// Returns a new [CGem] with the given fields replaced.
  CGem copyWith({DateTime? occurredAt}) => CGem(
        id: id,
        number: number,
        occurredAt: occurredAt ?? this.occurredAt,
        lines: lines,
        chestID: chestID,
      );

  /// Converts the gem to a [CGemsTableInsert].
  CGemsTableInsert toInsert() => CGemsTableInsert(
        id: id,
        number: number,
        occurredAt: occurredAt,
        chestID: chestID,
      );

  @override
  List<Object?> get props => [id, number, occurredAt, lines, chestID];
}
