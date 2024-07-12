part of 'bloc.dart';

sealed class _COTPVerificationEvent {}

/// {@template COTPVerificationSubmitted}
///
/// Indicates that the email has been submitted.
///
/// {@endtemplate}
final class COTPVerificationSubmitted extends _COTPVerificationEvent {
  /// {@macro COTPVerificationSubmitted}
  COTPVerificationSubmitted({required this.email, required this.pin});

  /// The email to be verified.
  final String email;

  /// The one-time pin.
  final String pin;
}

final class _COTPVerificationCompleted extends _COTPVerificationEvent {
  _COTPVerificationCompleted({required this.result});

  final COutcome<COTPVerificationException, CNothing> result;
}
