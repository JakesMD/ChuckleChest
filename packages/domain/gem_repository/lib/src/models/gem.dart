import 'package:bobs_jobs/bobs_jobs.dart';
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
    required this.shareToken,
  });

  /// {@macro CGem}
  ///
  /// Converts a [CRawGem] to a [CGem].
  factory CGem.fromRaw(CRawGem raw) {
    final sortedRawLines = raw.lines..sort((a, b) => a.id.compareTo(b.id));

    return CGem(
      id: raw.id,
      number: raw.number,
      occurredAt: raw.occurredAt,
      lines: sortedRawLines.map(CLine.fromRaw).toList(),
      chestID: raw.chestID,
      shareToken: raw.shareToken?.token,
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

  /// The token for sharing the gem.
  final String? shareToken;

  /// {@macro CGem}
  ///
  /// Returns a new [CGem] with the given fields replaced.
  CGem copyWith({DateTime? occurredAt, BobsMaybe<String>? shareToken}) => CGem(
        id: id,
        number: number,
        occurredAt: occurredAt ?? this.occurredAt,
        lines: [...lines],
        chestID: chestID,
        shareToken: shareToken?.resolve(
              onPresent: (p) => p,
              onAbsent: () => this.shareToken,
            ) ??
            this.shareToken,
      );

  /// Converts the gem to a [CGemsTableInsert].
  CGemsTableInsert toInsert() => CGemsTableInsert(
        id: id.isNotEmpty ? id : null,
        occurredAt: occurredAt,
        chestID: chestID,
      );

  @override
  List<Object?> get props => [
        id,
        number,
        occurredAt,
        lines,
        chestID,
        shareToken,
      ];
}
