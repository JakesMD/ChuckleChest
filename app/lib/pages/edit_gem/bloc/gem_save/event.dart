part of 'bloc.dart';

sealed class _CGemSaveEvent {}

/// {@template CGemSaveSubmitted}
///
/// Event for saving a gem.
///
/// {@endtemplate}
final class CGemSaveSubmitted extends _CGemSaveEvent {
  /// {@macro CGemSaveSubmitted}
  CGemSaveSubmitted({required this.gem, required this.deletedLines});

  /// The gem to save.
  final CGem gem;

  /// The lines to delete.
  final List<CLine> deletedLines;
}
