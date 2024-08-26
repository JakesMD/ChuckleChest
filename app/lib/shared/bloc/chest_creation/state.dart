part of 'bloc.dart';

/// Defines the different states of the [CChestCreationBloc].
sealed class CChestCreationState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

/// Indicates that no chest creation has been triggered.
final class CChestCreationInitial extends CChestCreationState {}

/// Indicates the chest creation is in progress.
final class CChestCreationInProgress extends CChestCreationState {}

/// {@template CChestCreationSuccess}
///
/// Indicates the chest creation completed successfully.
///
/// {@endtemplate}
final class CChestCreationSuccess extends CChestCreationState {
  /// {@macro CChestCreationSuccess}
  CChestCreationSuccess({required this.chestID});

  /// The ID of the chest that was created.
  final String chestID;

  @override
  List<Object?> get props => [chestID];
}

/// {@template CChestCreationFailure}
///
/// Indicates a failure occurred while creating the chest.
///
/// {@endtemplate}
final class CChestCreationFailure extends CChestCreationState {
  /// {@macro CChestCreationFailure}
  CChestCreationFailure({required this.exception});

  /// The exception that caused the chest creation to fail.
  final CChestCreationException exception;

  @override
  List<Object?> get props => [exception];
}
