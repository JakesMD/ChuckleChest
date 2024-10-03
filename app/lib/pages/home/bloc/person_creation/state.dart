part of 'cubit.dart';

/// The state for the [CPersonCreationCubit].
sealed class CPersonCreationState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

/// Indicates the initial state of the creation cubit.
final class CPersonCreationInitial extends CPersonCreationState {}

/// Indicates that the creation is in progress.
final class CPersonCreationInProgress extends CPersonCreationState {}

/// {@template CPersonCreationFailure}
///
/// Indicates that the a failure occurred while creating the person.
///
/// {@endtemplate}
final class CPersonCreationFailure extends CPersonCreationState {
  /// {@macro CPersonCreationFailure}
  CPersonCreationFailure({required this.exception});

  /// The exception that caused the creation to fail.
  final CPersonInsertException exception;

  @override
  List<Object?> get props => [exception];
}

/// {@template CPersonCreationSuccess}
///
/// Indicates that the person was created successfully.
///
/// {@endtemplate}
final class CPersonCreationSuccess extends CPersonCreationState {
  /// {@macro CPersonCreationSuccess}
  CPersonCreationSuccess({required this.personID});

  /// The ID of the created person.
  final BigInt personID;

  @override
  List<Object?> get props => [personID];
}
