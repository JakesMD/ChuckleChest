part of 'bloc.dart';

/// The state for the [CGemSaveBloc].
sealed class CGemSaveState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

/// Indicates the initial state of the gem save.
final class CGemSaveInitial extends CGemSaveState {}

/// Indicates that the save is in progress.
final class CGemSaveInProgress extends CGemSaveState {}

/// {@template CGemSaveFailure}
///
/// Indicates that the save has failed.
///
/// {@endtemplate}
final class CGemSaveFailure extends CGemSaveState {
  /// {@macro CGemSaveFailure}
  CGemSaveFailure({required this.exception});

  /// The exception that caused the save to fail.
  final CGemSaveException exception;

  @override
  List<Object?> get props => [exception];
}

/// Indicates that the save has succeeded.
final class CGemSaveSuccess extends CGemSaveState {
  /// {@macro CGemSaveSuccess}
  CGemSaveSuccess({required this.gemID});

  /// The ID of the saved gem.
  final String gemID;

  @override
  List<Object?> get props => [gemID];
}
