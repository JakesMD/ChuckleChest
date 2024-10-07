part of 'bloc.dart';

/// Defines the different states of the [CGemYearIDsFetchBloc].
sealed class CGemYearIDsFetchState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

/// Indicates the fetch is in progress.
final class CGemYearIDsFetchInProgress extends CGemYearIDsFetchState {}

/// {@template CGemYearIDsFetchSuccess}
///
/// Indicates the fetch completed successfully.
///
/// {@endtemplate}
final class CGemYearIDsFetchSuccess extends CGemYearIDsFetchState {
  /// {@macro CGemYearIDsFetchSuccess}
  CGemYearIDsFetchSuccess({required this.ids});

  /// The years that were fetched.
  final List<String> ids;

  @override
  List<Object?> get props => [ids];
}

/// {@template CGemYearIDsFetchFailure}
///
/// Indicates a failure occurred while fetching the IDs,
///
/// {@endtemplate}
final class CGemYearIDsFetchFailure extends CGemYearIDsFetchState {
  /// {@macro CGemYearIDsFetchFailure}
  CGemYearIDsFetchFailure({required this.exception});

  /// The exception that caused the fetch to fail.
  final CGemIDsFetchException exception;

  @override
  List<Object?> get props => [exception];
}
