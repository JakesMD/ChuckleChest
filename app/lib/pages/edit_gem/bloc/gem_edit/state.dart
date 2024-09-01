part of 'bloc.dart';

/// {@template CGemEditState}
///
/// The state for the gem edit bloc.
///
/// {@endtemplate}
class CGemEditState {
  /// {@macro CGemEditState}
  const CGemEditState({required this.gem});

  /// The gem being edited.
  final CGem gem;
}
