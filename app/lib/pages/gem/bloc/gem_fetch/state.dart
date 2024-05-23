part of 'bloc.dart';

/// Defines the different states of the [CGemFetchBloc].
sealed class CGemFetchState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

/// Indicates the gem fetch is in progress.
final class CGemFetchInProgress extends CGemFetchState {}

/// {@template CGemFetchSuccess}
///
/// Indicates the gem fetch completed successfully.
///
/// {@endtemplate}
final class CGemFetchSuccess extends CGemFetchState {
  /// {@macro CGemFetchSuccess}
  CGemFetchSuccess({required this.gem});

  /// The gem that was fetched.
  final CGem gem;

  @override
  List<Object?> get props => [gem];
}

/// {@template CGemFetchFailure}
///
/// Indicates a failure occurred while fetching the gem.
///
/// {@endtemplate}
final class CGemFetchFailure extends CGemFetchState {
  /// {@macro CGemFetchFailure}
  CGemFetchFailure({required this.exception});

  /// The exception that caused the gem fetch to fail.
  final CGemFetchException exception;

  @override
  List<Object?> get props => [exception];
}
