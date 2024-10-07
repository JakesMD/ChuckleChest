part of 'bloc.dart';

/// {@template CCollectionViewState}
///
/// The state for the [CCollectionViewCubit].
///
/// {@endtemplate}
class CCollectionViewState {
  /// {@macro CCollectionViewState}
  const CCollectionViewState({
    required this.gems,
    required this.currentIndex,
  });

  /// The gems that have been visited.
  final List<(String, CGem?)> gems;

  /// The index of the currently displayed gem.
  final int currentIndex;

  /// Creates a copy of this state with the given fields replaced by the new
  /// values.
  CCollectionViewState copyWith({
    List<(String, CGem?)>? gems,
    int? currentIndex,
  }) {
    return CCollectionViewState(
      gems: gems ?? this.gems,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  /// The currently displayed gem.
  CGem? get currentGem => gems.elementAt(currentIndex).$2;

  /// The title to display in the app bar.
  String get appBarTitle => currentGem?.number.toString() ?? '';

  /// Whether the current gem can be edited.
  bool get canEdit => currentGem != null;
}
