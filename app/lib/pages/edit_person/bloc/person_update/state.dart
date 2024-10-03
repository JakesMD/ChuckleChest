part of 'cubit.dart';

/// The state for the [CPersonUpdateCubit].
sealed class CPersonUpdateState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

/// Indicates the initial state of the update cubit.
final class CPersonUpdateInitial extends CPersonUpdateState {}

/// Indicates that the update is in progress.
final class CPersonUpdateInProgress extends CPersonUpdateState {}

/// {@template CPersonUpdateFailure}
///
/// Indicates that the a failure occurred while updating the person.
///
/// {@endtemplate}
final class CPersonUpdateFailure extends CPersonUpdateState {
  /// {@macro CPersonUpdateFailure}
  CPersonUpdateFailure({required this.exception});

  /// The exception that caused the update to fail.
  final CPersonUpdateException exception;

  @override
  List<Object?> get props => [exception];
}

/// Indicates that the person was updated successfully.
final class CPersonUpdateSuccess extends CPersonUpdateState {}
