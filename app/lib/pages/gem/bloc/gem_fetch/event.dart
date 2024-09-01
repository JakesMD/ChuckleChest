part of 'bloc.dart';

sealed class _CGemFetchEvent {}

/// {@template CGemFetchTriggered}
///
/// The event for triggering a gem fetch.
///
/// {@endtemplate}
final class CGemFetchTriggered extends _CGemFetchEvent {
  /// {@macro CGemFetchTriggered}
  CGemFetchTriggered({required this.gemID});

  /// The unique identifier of the gem.
  final String gemID;
}

final class _CGemFetchCompleted extends _CGemFetchEvent {
  _CGemFetchCompleted({required this.result});

  BobsOutcome<CGemFetchException, CGem> result;
}
