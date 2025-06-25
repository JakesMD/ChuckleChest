import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:equatable/equatable.dart';

/// {@template CLine}
///
/// Represents a line of text in a gem like a narration or a quote.
///
/// {@endtemplate}
base class CLine with EquatableMixin {
  /// {@macro CLine}
  const CLine({
    required this.id,
    required this.text,
    required this.personID,
    required this.gemID,
    required this.chestID,
  });

  /// {@macro CLine}
  ///
  /// Converts a [CRawLine] to a [CLine].
  CLine.fromRaw(CRawLine raw)
      : id = raw.id,
        text = raw.text,
        personID = raw.personID,
        gemID = raw.gemID,
        chestID = raw.chestID;

  /// The unique identifier of the line.
  final BigInt? id;

  /// The text of the line.
  final String text;

  /// The unique identifier of the person who said the line.
  ///
  /// If `null`, the line is a narration.
  final BigInt? personID;

  /// The unique identifier of the gem the line belongs to.
  final String gemID;

  /// The unique identifier of the chest the line belongs to.
  final String chestID;

  /// {@macro CLine}
  ///
  /// Returns a new [CLine] with the given fields replaced.
  CLine copyWith({String? text, BigInt? personID}) => CLine(
        id: id,
        text: text ?? this.text,
        personID: personID ?? this.personID,
        gemID: gemID,
        chestID: chestID,
      );

  /// Converts the line to a [CLinesTableInsert].
  CLinesTableInsert toInsert() => CLinesTableInsert(
        id: id,
        text: text,
        personID: PgNullable(personID),
        gemID: gemID,
        chestID: chestID,
      );

  /// Whether the line is a quote.
  bool get isQuote => personID != null;

  @override
  List<Object?> get props => [id, text, personID, gemID, chestID];
}
