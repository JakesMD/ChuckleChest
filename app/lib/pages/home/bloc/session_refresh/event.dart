part of 'bloc.dart';

sealed class _CSessionRefreshEvent {}

/// Indicates that the refresh has been requested.
final class CSessionRefreshRequested extends _CSessionRefreshEvent {}

final class _CSessionRefreshCompleted extends _CSessionRefreshEvent {
  _CSessionRefreshCompleted({required this.result});

  final COutcome<CSessionRefreshException, CNothing> result;
}
