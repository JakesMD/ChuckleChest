part of 'bloc.dart';

/// The state for the [CSessionRefreshBloc].
sealed class CSessionRefreshState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

/// Indicates that a refresh has not yet been requested.
final class CSessionRefreshInitial extends CSessionRefreshState {}

/// Indicates that the refresh is in progress.
final class CSessionRefreshInProgress extends CSessionRefreshState {}

/// {@template CSessionRefreshFailure}
///
/// Indicates that the refresh has failed.
///
/// {@endtemplate}
final class CSessionRefreshFailure extends CSessionRefreshState {
  /// {@macro CSessionRefreshFailure}
  CSessionRefreshFailure({required this.exception});

  /// The exception that caused the login to fail.
  final CSessionRefreshException exception;

  @override
  List<Object?> get props => [exception];
}

/// Indicates that the refresh has succeeded.
final class CSessionRefreshSuccess extends CSessionRefreshState {}
