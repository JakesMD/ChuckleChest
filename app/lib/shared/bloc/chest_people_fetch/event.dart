part of 'bloc.dart';

sealed class _CChestPeopleFetchEvent {}

/// {@template CChestPeopleFetchRequested}
///
/// The event for triggering a chest people fetch.
///
/// {@endtemplate}
final class CChestPeopleFetchRequested extends _CChestPeopleFetchEvent {
  /// {@macro CChestPeopleFetchRequested}
  CChestPeopleFetchRequested({required this.chestID});

  /// The unique identifier of the chest.
  final String chestID;
}

final class _CChestPeopleFetchCompleted extends _CChestPeopleFetchEvent {
  _CChestPeopleFetchCompleted({required this.result});

  BobsOutcome<CChestPeopleFetchException, List<CPerson>> result;
}
