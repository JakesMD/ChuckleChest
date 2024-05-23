part of 'bloc.dart';

sealed class _CGemShareEvent {}

/// {@template CGemShareTriggered}
///
/// The event for triggering a gem share.
///
/// {@endtemplate}
final class CGemShareTriggered extends _CGemShareEvent {
  /// {@macro CGemShareTriggered}
  CGemShareTriggered({
    required this.gemID,
    required this.sharePositionOrigin,
    required this.message,
    required this.subject,
  });

  /// The unique identifier of the gem.
  final String gemID;

  /// The position of the share button.
  final Rect sharePositionOrigin;

  /// The message to share.
  final String Function(String link) message;

  /// The subject of the share.
  final String subject;
}

final class _CGemShareCompleted extends _CGemShareEvent {
  _CGemShareCompleted({required this.result});

  Either<CGemShareException, CGemShareMethod> result;
}
