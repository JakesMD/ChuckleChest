import 'package:cgem_client/src/models/raw_line.dart';
import 'package:cpub/equatable.dart';

/// {@template CRawGem}
///
/// The raw data that represents a gem (a story).
///
/// {@endtemplate}
class CRawGem with EquatableMixin {
  /// {@macro CRawGem}
  const CRawGem({
    required this.id,
    required this.number,
    required this.occurredAt,
    required this.lines,
  });

  /// {@macro CRawGem}
  ///
  /// Creates a [CRawGem] from a JSON object.
  CRawGem.fromJSON(Map<String, dynamic> json)
      : id = json['id'] as String,
        number = json['number'] as int,
        occurredAt = DateTime.parse(json['occurred_at'] as String),
        lines = List<Map<String, dynamic>>.from(
          (json['lines'] ?? []) as List<dynamic>,
        ).map(CRawLine.fromJSON).toList();

  /// The unique identifier of the gem.
  final String id;

  /// The number of the gem.
  final int number;

  /// The date and time when the story occurred.
  final DateTime occurredAt;

  /// The lines of the story.
  final List<CRawLine> lines;

  @override
  List<Object?> get props => [id, number, occurredAt, lines];
}
