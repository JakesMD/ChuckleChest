part of 'bloc.dart';

/// Defines the different states of the [CGemYearsFetchBloc].
sealed class CGemYearsFetchState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

/// Indicates the fetch is in progress.
final class CGemYearsFetchInProgress extends CGemYearsFetchState {}

/// {@template CGemYearsFetchSuccess}
///
/// Indicates the fetch completed successfully.
///
/// {@endtemplate}
final class CGemYearsFetchSuccess extends CGemYearsFetchState {
  /// {@macro CGemYearsFetchSuccess}
  CGemYearsFetchSuccess({required this.years});

  /// The years that were fetched.
  final List<int> years;

  @override
  List<Object?> get props => [years];
}

/// {@template CGemYearsFetchFailure}
///
/// Indicates a failure occurred while fetching the years.
///
/// {@endtemplate}
final class CGemYearsFetchFailure extends CGemYearsFetchState {
  /// {@macro CGemYearsFetchFailure}
  CGemYearsFetchFailure({required this.exception});

  /// The exception that caused the fetch to fail.
  final CGemYearsFetchException exception;

  @override
  List<Object?> get props => [exception];
}
