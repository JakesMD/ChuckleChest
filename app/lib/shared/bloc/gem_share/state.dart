part of 'bloc.dart';

/// Defines the different states of the [CGemShareBloc].
sealed class CGemShareState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

/// Indicates that no gem share has been triggered.
final class CGemShareInitial extends CGemShareState {}

/// Indicates the gem share is in progress.
final class CGemShareInProgress extends CGemShareState {}

/// {@template CGemShareSuccess}
///
/// Indicates the gem share completed successfully.
///
/// {@endtemplate}
final class CGemShareSuccess extends CGemShareState {
  /// {@macro CGemShareSuccess}
  CGemShareSuccess({required this.method});

  /// How the gem was shared.
  final CGemShareMethod method;

  @override
  List<Object?> get props => [method];
}

/// {@template CGemShareFailure}
///
/// Indicates a failure occurred while sharing the gem.
///
/// {@endtemplate}
final class CGemShareFailure extends CGemShareState {
  /// {@macro CGemShareFailure}
  CGemShareFailure({required this.exception});

  /// The exception that caused the gem share to fail.
  final CGemShareException exception;

  @override
  List<Object?> get props => [exception];
}
