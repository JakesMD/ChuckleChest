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
    required this.connection,
  });

  /// {@macro CRawLine}
  CRawLine.fromJSON(Map<String, dynamic> json)
      : id = BigInt.from(json['id'] as num),
        text = json['text'] as String,
        connection = json['connections'] != null
            ? CRawConnection.fromJSON(
                json['connections'] as Map<String, dynamic>,
              )
            : null;

  /// The unique identifier of the line.
  final BigInt id;

  /// The text of the line.
  final String text;

  /// The family or friend who is being quoted.
  final CRawConnection? connection;

  @override
  List<Object?> get props => [id, text, connection];
}
