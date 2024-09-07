part of 'bloc.dart';

/// Defines the different states of the [CGemFetchBloc].
sealed class CGemFetchState with EquatableMixin {
  const CGemFetchState({required this.gemID});

  /// The ID of the gem being fetched.
  final String gemID;

  @override
  List<Object?> get props => [gemID];
}

/// {@template CGemFetchInitial}
///
/// Indicates that a fetch has not been started.
///
/// {@endtemplate}
final class CGemFetchInitial extends CGemFetchState {
  /// {@macro CGemFetchInitial}
  const CGemFetchInitial() : super(gemID: '');
}

/// {@template CGemFetchInProgress}
///
/// Indicates the gem fetch is in progress.
///
/// {@endtemplate}
final class CGemFetchInProgress extends CGemFetchState {
  /// {@macro CGemFetchInProgress}
  const CGemFetchInProgress({required super.gemID});
}

/// {@template CGemFetchSuccess}
///
/// Indicates the gem fetch completed successfully.
///
/// {@endtemplate}
final class CGemFetchSuccess extends CGemFetchState {
  /// {@macro CGemFetchSuccess}
  CGemFetchSuccess({required this.gem}) : super(gemID: gem.id);

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
  CGemFetchFailure({required this.exception, required super.gemID});

  /// The exception that caused the gem fetch to fail.
  final CGemFetchException exception;

  @override
  List<Object?> get props => [exception];
}
