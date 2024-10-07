part of 'bloc.dart';

/// Defines the different states of the [CRecentGemIDsFetchBloc].
sealed class CRecentGemIDsFetchState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

/// Indicates the fetch is in progress.
final class CRecentGemIDsFetchInProgress extends CRecentGemIDsFetchState {}

/// {@template CRecentGemIDsFetchSuccess}
///
/// Indicates the fetch completed successfully.
///
/// {@endtemplate}
final class CRecentGemIDsFetchSuccess extends CRecentGemIDsFetchState {
  /// {@macro CRecentGemIDsFetchSuccess}
  CRecentGemIDsFetchSuccess({required this.ids});

  /// The years that were fetched.
  final List<String> ids;

  @override
  List<Object?> get props => [ids];
}

/// {@template CRecentGemIDsFetchFailure}
///
/// Indicates a failure occurred while fetching the IDs,
///
/// {@endtemplate}
final class CRecentGemIDsFetchFailure extends CRecentGemIDsFetchState {
  /// {@macro CRecentGemIDsFetchFailure}
  CRecentGemIDsFetchFailure({required this.exception});

  /// The exception that caused the fetch to fail.
  final CGemIDsFetchException exception;

  @override
  List<Object?> get props => [exception];
}
