import 'package:bloc/bloc.dart';
import 'package:bobs_jobs/bobs_jobs.dart';
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
    this.needsRestart = false,
  });

  /// The gems that have been visited.
  final List<(String, CGem?)> gems;

  /// The index of the currently displayed gem.
  final int currentIndex;

  /// Whether the gem animation needs to be restarted.
  final bool needsRestart;

  /// Creates a copy of this state with the given fields replaced by the new
  /// values.
  CCollectionViewState copyWith({
    List<(String, CGem?)>? gems,
    int? currentIndex,
    bool needsRestart = false,
  }) {
    return CCollectionViewState(
      gems: gems != null ? [...gems] : [...this.gems],
      currentIndex: currentIndex ?? this.currentIndex,
      needsRestart: needsRestart,
    );
  }

  /// The currently displayed gem.
  CGem? get currentGem => gems.elementAt(currentIndex).$2;

  /// Whether the current gem is the last gem.
  bool get isLastGem => currentIndex == gems.length - 1;

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
  CCollectionViewCubit({required this.gemTokens, required this.onNewGem})
      : super(
          CCollectionViewState(
            gems: gemTokens
                .map<(String, CGem?)>((token) => (token, null))
                .toList(),
            currentIndex: 0,
          ),
        ) {
    onPageChanged(0);
  }

  /// The IDs of the gems to display.
  ///
  /// This can also be the share token of a shared gem.
  final List<String> gemTokens;

  /// Callback to call when a new gem is displayed.
  final void Function(String gemID) onNewGem;

  /// Updates the current gem index and fetches the gem data if necessary.
  void onPageChanged(int index) {
    emit(state.copyWith(currentIndex: index));

    if (state.gems.elementAt(index).$2 == null) onNewGem(gemTokens[index]);
  }

  /// Updates the gem at the current index with the share token.
  void onShareTokenCreated(String gemID, String token) {
    final index = state.gems.indexWhere((record) => record.$2?.id == gemID);
    final record = state.gems.removeAt(index);
    state.gems.insert(
      index,
      (record.$1, record.$2?.copyWith(shareToken: bobsPresent(token))),
    );

    emit(state.copyWith(gems: state.gems));
  }

  /// Updates the gem at the current index with the edited gem.
  void onGemEdited(CGem gem) {
    final index = state.gems.indexWhere((record) => record.$2?.id == gem.id);
    final record = state.gems.removeAt(index);
    state.gems.insert(state.currentIndex, (record.$1, gem));

    emit(state.copyWith(gems: state.gems, needsRestart: true));
  }

  /// Adds the fetched gem to the visited gems.
  void onGemFetched(CGem gem, String token) {
    final index = state.gems.indexWhere((record) => record.$1 == token);
    final record = state.gems.removeAt(index);
    state.gems.insert(state.currentIndex, (record.$1, gem));

    emit(state.copyWith(gems: state.gems));
  }
}
