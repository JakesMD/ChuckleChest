import 'package:ccore/ccore.dart';
import 'package:cgem_client/cgem_client.dart';
import 'package:cgem_repository/src/models/_models.dart';
import 'package:cpub/equatable.dart';

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
  });

  /// {@macro CGem}
  ///
  /// Converts a [CRawGem] to a [CGem].
  factory CGem.fromRaw(CRawGem raw) {
    final lines = <CLine>[];

    final sortedRawLines = raw.lines..sort((a, b) => a.id.compareTo(b.id));

    for (final line in sortedRawLines) {
      if (line.person == null) {
        lines.add(CNarration(id: line.id, text: line.text));
      } else {
        final age = line.person!.dateOfBirth.cAge(raw.occurredAt);

        final avatarUrl = line.person!.avatarURLs
            .cFirstWhereOrNull((url) => url.age == age)
            ?.url;

        lines.add(
          CQuote(
            id: line.id,
            text: line.text,
            nickname: line.person!.nickname,
            age: age,
            avatarUrl: avatarUrl,
          ),
        );
      }
    }

    return CGem(
      id: raw.id,
      number: raw.number,
      occurredAt: raw.occurredAt,
      lines: lines,
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

  @override
  List<Object?> get props => [id, number, occurredAt, lines];
}
