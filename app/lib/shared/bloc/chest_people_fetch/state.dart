part of 'bloc.dart';

/// Defines the different states of the [CChestPeopleFetchBloc].
sealed class CChestPeopleFetchState with EquatableMixin {
  CChestPeopleFetchState({this.people = const <CPerson>[]});

  /// The people that were fetched.
  final List<CPerson> people;

  @override
  List<Object?> get props => [people];
}

/// Indicates the fetch is in progress.
final class CChestPeopleFetchInProgress extends CChestPeopleFetchState {}

/// {@template CChestPeopleFetchSuccess}
///
/// Indicates the fetch completed successfully.
///
/// {@endtemplate}
final class CChestPeopleFetchSuccess extends CChestPeopleFetchState {
  /// {@macro CChestPeopleFetchSuccess}
  CChestPeopleFetchSuccess({required super.people});
}

/// {@template CChestPeopleFetchFailure}
///
/// Indicates a failure occurred while fetching the gem.
///
/// {@endtemplate}
final class CChestPeopleFetchFailure extends CChestPeopleFetchState {
  /// {@macro CChestPeopleFetchFailure}
  CChestPeopleFetchFailure({required this.exception});

  /// The exception that caused the gem fetch to fail.
  final CChestPeopleFetchException exception;

  @override
  List<Object?> get props => [exception];
}
