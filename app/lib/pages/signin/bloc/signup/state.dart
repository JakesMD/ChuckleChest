part of 'bloc.dart';

/// The state for the [CSignupBloc].
sealed class CSignupState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

/// Indicates that the signup form has not yet been submitted.
final class CSignupInitial extends CSignupState {}

/// {@template CSignupInProgress}
///
/// Indicates that the signup is in progress.
///
/// {@endtemplate}
final class CSignupInProgress extends CSignupState {
  /// {@macro CSignupInProgress}
  CSignupInProgress({required this.email});

  /// The email that was submitted.
  final String email;

  @override
  List<Object?> get props => [email];
}

/// {@template CSignupFailure}
///
/// Indicates that the signup has failed.
///
/// {@endtemplate}
final class CSignupFailure extends CSignupState {
  /// {@macro CSignupFailure}
  CSignupFailure({required this.exception});

  /// The exception that caused the signup to fail.
  final CSignupException exception;

  @override
  List<Object?> get props => [exception];
}

/// {@template CSignupSuccess}
///
/// Indicates that the signup has succeeded.
///
/// {@endtemplate}
final class CSignupSuccess extends CSignupState {
  /// {@macro CSignupSuccess}
  CSignupSuccess({required this.email});

  /// The email that was submitted.
  final String email;

  @override
  List<Object?> get props => [email];
}
