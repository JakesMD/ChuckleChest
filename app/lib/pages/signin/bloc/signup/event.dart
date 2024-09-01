part of 'bloc.dart';

sealed class _CSignupEvent {}

/// {@template CSignupFormSubmitted}
///
/// Indicates that the signup form has been submitted.
///
/// {@endtemplate}
final class CSignupFormSubmitted extends _CSignupEvent {
  /// {@macro CSignupFormSubmitted}
  CSignupFormSubmitted({
    required this.username,
    required this.email,
  });

  /// The username that was submitted.
  final String username;

  /// The email that was submitted.
  final String email;
}

final class _CSignupCompleted extends _CSignupEvent {
  _CSignupCompleted({required this.result});

  final BobsOutcome<CSignupException, BobsNothing> result;
}
