import 'package:bloc/bloc.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

/// {@template CCollectionViewCubit}
///
/// Cubit that handles the control of the collection view.
///
/// {@endtemplate}
class CCollectionViewCubit extends Cubit<CCollectionViewState> {
  /// {@macro CCollectionViewCubit}
  CCollectionViewCubit({required this.gemIDs, required this.onNewGem})
      : super(
          CCollectionViewState(
            gems:
                gemIDs.map<(String, CGem?)>((gemID) => (gemID, null)).toList(),
            currentIndex: 0,
          ),
        ) {
    onPageChanged(0);
  }

  /// The IDs of the gems to display.
  final List<String> gemIDs;

  /// Callback to call when a new gem is displayed.
  final void Function(String gemID) onNewGem;

  /// Updates the current gem index and fetches the gem data if necessary.
  void onPageChanged(int index) {
    emit(state.copyWith(currentIndex: index));

    if (state.gems.elementAt(index).$2 == null) onNewGem(gemIDs[index]);
  }

  /// Updates the gem at the current index with the edited gem.
  void onGemEdited(CGem gem) {
    final index = state.gems.indexWhere((record) => record.$1 == gem.id);
    final record = state.gems.removeAt(index);
    state.gems.insert(state.currentIndex, (record.$1, gem));

    emit(state.copyWith(gems: state.gems));
  }

  /// Adds the fetched gem to the visited gems.
  void onGemFetched(CGem gem) {
    final index = state.gems.indexWhere((record) => record.$1 == gem.id);
    final record = state.gems.removeAt(index);
    state.gems.insert(state.currentIndex, (record.$1, gem));

    emit(state.copyWith(gems: state.gems));
  }
}
