part of 'bloc.dart';

sealed class _CGemEditEvent {}

/// {@template CGemEditLineAdded}
///
/// The event that occurs when a line is added to the gem.
///
/// {@endtemplate}
final class CGemEditLineAdded extends _CGemEditEvent {
  /// {@macro CGemEditLineAdded}
  CGemEditLineAdded({
    required this.personID,
    required this.text,
  });

  /// The unique identifier of the person who said the line.
  final BigInt? personID;

  /// The text of the line.
  final String text;
}

/// {@template CGemEditLineUpdated}
///
/// The event that occurs when a line is updated in the gem.
///
/// {@endtemplate}
final class CGemEditLineUpdated extends _CGemEditEvent {
  /// {@macro CGemEditLineUpdated}
  CGemEditLineUpdated({
    required this.lineIndex,
    required this.personID,
    required this.text,
  });

  /// The index of the line to update.
  final int lineIndex;

  /// The unique identifier of the person who said the line.
  final BigInt? personID;

  /// The text of the line.
  final String text;
}

/// The event that occurs when the last line is deleted from the gem.
final class CGemEditLastLineDeleted extends _CGemEditEvent {}

/// {@template CGemEditDateUpdated}
///
/// The event that occurs when the date the gem represents is updated.
///
/// {@endtemplate}
final class CGemEditDateUpdated extends _CGemEditEvent {
  /// {@macro CGemEditDateUpdated}
  CGemEditDateUpdated({required this.occurredAt});

  /// The new date the gem represents.
  final DateTime occurredAt;
}

/// The event that occurs when the gem is saved.
final class CGemEditSaved extends _CGemEditEvent {}
