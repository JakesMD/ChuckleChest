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
  });

  /// The unique identifier of the line.
  final BigInt id;

  /// The text of the line.
  final String text;

  @override
  List<Object?> get props => [id, text];
}

/// {@template CNarration}
///
/// Represents a narration line.
///
/// {@endtemplate}
final class CNarration extends CLine {
  /// {@macro CNarration}
  const CNarration({
    required super.id,
    required super.text,
  });
}

/// {@template CQuote}
///
/// Represents a quote line.
///
/// {@endtemplate}
final class CQuote extends CLine {
  /// {@macro CQuote}
  const CQuote({
    required super.id,
    required super.text,
    required this.nickname,
    required this.age,
    this.avatarUrl,
  });

  /// The name of the person who is being quoted.
  final String nickname;

  /// The age of the person who is being quoted.
  final int age;

  /// The URL of the photo of the person at that age.
  final String? avatarUrl;

  @override
  List<Object?> get props => [id, text, nickname, age, avatarUrl];
}
