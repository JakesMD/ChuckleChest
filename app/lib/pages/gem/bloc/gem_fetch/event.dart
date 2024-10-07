part of 'bloc.dart';

sealed class _CGemFetchEvent {}

/// {@template CGemFetchRequested}
///
/// The event for triggering a gem fetch.
///
/// {@endtemplate}
final class CGemFetchRequested extends _CGemFetchEvent {
  /// {@macro CGemFetchRequested}
  CGemFetchRequested({required this.gemID});

  /// The unique identifier of the gem.
  final String gemID;
}
