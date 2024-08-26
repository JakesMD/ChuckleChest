part of 'bloc.dart';

sealed class _CChestCreationEvent {}

/// {@template CChestCreationTriggered}
///
/// The event for triggering a chest creation.
///
/// {@endtemplate}
final class CChestCreationTriggered extends _CChestCreationEvent {
  /// {@macro CChestCreationTriggered}
  CChestCreationTriggered({required this.chestName});

  /// The name of the chest to create.
  final String chestName;
}

final class _CChestCreationCompleted extends _CChestCreationEvent {
  _CChestCreationCompleted({required this.result});

  COutcome<CChestCreationException, String> result;
}
