import 'package:cgem_client/cgem_client.dart';
import 'package:cpub/equatable.dart';

/// {@template CRawLine}
///
/// The raw data that represents a line of a gem / story.
///
/// {@endtemplate}
class CRawLine with EquatableMixin {
  /// {@macro CRawLine}
  const CRawLine({
    required this.id,
    required this.text,
    required this.person,
  });

  /// {@macro CRawLine}
  CRawLine.fromJSON(Map<String, dynamic> json)
      : id = BigInt.from(json['id'] as num),
        text = json['text'] as String,
        person = json['people'] != null
            ? CRawPerson.fromJSON(
                json['people'] as Map<String, dynamic>,
              )
            : null;

  /// The unique identifier of the line.
  final BigInt id;

  /// The text of the line.
  final String text;

  /// The family or friend who is being quoted.
  final CRawPerson? person;

  @override
  List<Object?> get props => [id, text, person];
}
