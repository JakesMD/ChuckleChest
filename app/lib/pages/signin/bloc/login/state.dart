part of 'bloc.dart';

/// The state for the [CLoginBloc].
sealed class CLoginState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

/// Indicates that the email has not yet been submitted.
final class CLoginInitial extends CLoginState {}

/// {@template CLoginInProgress}
///
/// Indicates that the login is in progress.
///
/// {@endtemplate}
final class CLoginInProgress extends CLoginState {
  /// {@macro CLoginInProgress}
  CLoginInProgress({required this.email});

  /// The email that was submitted.
  final String email;

  @override
  List<Object?> get props => [email];
}

/// {@template CLoginFailure}
///
/// Indicates that the login has failed.
///
/// {@endtemplate}
final class CLoginFailure extends CLoginState {
  /// {@macro CLoginFailure}
  CLoginFailure({required this.exception});

  /// The exception that caused the login to fail.
  final CLoginException exception;

  @override
  List<Object?> get props => [exception];
}

/// {@template CLoginSuccess}
///
/// Indicates that the login has succeeded.
///
/// {@endtemplate}
final class CLoginSuccess extends CLoginState {
  /// {@macro CLoginSuccess}
  CLoginSuccess({required this.email});

  /// The email that was submitted.
  final String email;

  @override
  List<Object?> get props => [email];
}
