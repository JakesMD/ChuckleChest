part of 'bloc.dart';

/// The state for the [COTPVerificationBloc].
sealed class COTPVerificationState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

/// Indicates that the pin has not yet been submitted.
final class COTPVerificationInitial extends COTPVerificationState {}

/// Indicates that the verification is in progress.
final class COTPVerificationInProgress extends COTPVerificationState {}

/// {@template COTPVerificationFailure}
///
/// Indicates that the verification has failed.
///
/// {@endtemplate}
final class COTPVerificationFailure extends COTPVerificationState {
  /// {@macro COTPVerificationFailure}
  COTPVerificationFailure({required this.exception});

  /// The exception that caused the login to fail.
  final COTPVerificationException exception;

  @override
  List<Object?> get props => [exception];
}

/// Indicates that the verification has succeeded.
final class COTPVerificationSuccess extends COTPVerificationState {}
