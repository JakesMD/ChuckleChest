import 'package:cpub/equatable.dart';

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
  });

  /// The unique identifier of the line.
  final BigInt id;

  /// The text of the line.
  final String text;

  /// The unique identifier of the person who said the line.
  ///
  /// If `null`, the line is a narration.
  final BigInt? personID;

  /// {@macro CLine}
  ///
  /// Returns a new [CLine] with the given fields replaced.
  CLine copyWith({String? text, BigInt? personID}) => CLine(
        id: id,
        text: text ?? this.text,
        personID: personID ?? this.personID,
      );

  /// Whether the line is a quote.
  bool get isQuote => personID != null;

  @override
  List<Object?> get props => [id, text, personID];
}
