part of 'bloc.dart';

sealed class _CLoginEvent {}

/// {@template CLoginFormSubmitted}
///
/// Indicates that the email has been submitted.
///
/// {@endtemplate}
final class CLoginFormSubmitted extends _CLoginEvent {
  /// {@macro CLoginFormSubmitted}
  CLoginFormSubmitted({required this.email});

  /// The email that was submitted.
  final String email;
}

final class _CLoginCompleted extends _CLoginEvent {
  _CLoginCompleted({required this.result});

  final COutcome<CLoginException, CNothing> result;
}
