import 'package:bloc/bloc.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:equatable/equatable.dart';

/// The status of the [CGemLikesState].
enum CGemLikesStatus {
  /// The liked gem IDs have not been fetched yet.
  initial,

  /// The liked gem IDs are being fetched.
  inProgress,

  /// The liked gem IDs failed to be fetched.
  failed,

  /// The liked gem IDs have been fetched.
  succeeded,
}

/// {@template CGemLikesState}
///
/// The state for the [CGemLikesCubit].
///
/// {@endtemplate}
class CGemLikesState extends Equatable {
  /// {@macro CGemLikesState}
  const CGemLikesState({
    required this.status,
    required this.likedGemIDs,
    required this.pendingGemIDs,
  });

  /// {@macro CGemLikesState}
  ///
  /// The initial state.
  const CGemLikesState.initial()
    : this(
        status: CGemLikesStatus.initial,
        likedGemIDs: const {},
        pendingGemIDs: const {},
      );

  /// The status of the liked gem IDs fetch.
  final CGemLikesStatus status;

  /// The IDs of the gems the user has liked.
  final Set<String> likedGemIDs;

  /// The IDs of the gems that have an in-flight like/unlike toggle.
  final Set<String> pendingGemIDs;

  /// Returns a copy of this state with the given fields replaced.
  CGemLikesState copyWith({
    CGemLikesStatus? status,
    Set<String>? likedGemIDs,
    Set<String>? pendingGemIDs,
  }) => CGemLikesState(
    status: status ?? this.status,
    likedGemIDs: likedGemIDs ?? this.likedGemIDs,
    pendingGemIDs: pendingGemIDs ?? this.pendingGemIDs,
  );

  @override
  List<Object?> get props => [status, likedGemIDs, pendingGemIDs];
}

/// {@template CGemLikesCubit}
///
/// The cubit that caches which gems in a chest the user has liked and lets
/// the user toggle a gem's liked status.
///
/// {@endtemplate}
class CGemLikesCubit extends Cubit<CGemLikesState> {
  /// {@macro CGemLikesCubit}
  CGemLikesCubit({required this.gemRepository, required this.chestID})
    : super(const CGemLikesState.initial());

  /// The repository this cubit uses to like/unlike gems.
  final CGemRepository gemRepository;

  /// The ID of the chest the liked gems belong to.
  final String chestID;

  /// Fetches the IDs of the gems the user has liked in this chest.
  Future<void> fetchLikedGemIDs() async {
    emit(state.copyWith(status: CGemLikesStatus.inProgress));

    final result = await gemRepository.fetchLikedGemIDs(chestID: chestID).run();

    result.resolve(
      onSuccess: (ids) => emit(
        state.copyWith(
          status: CGemLikesStatus.succeeded,
          likedGemIDs: ids.toSet(),
        ),
      ),
      onFailure: (_) => emit(state.copyWith(status: CGemLikesStatus.failed)),
    );
  }

  /// Toggles the liked status of the gem with the given [gemID].
  Future<void> toggle(String gemID) async {
    final wasLiked = state.likedGemIDs.contains(gemID);

    emit(
      state.copyWith(
        likedGemIDs: wasLiked
            ? (Set.of(state.likedGemIDs)..remove(gemID))
            : (Set.of(state.likedGemIDs)..add(gemID)),
        pendingGemIDs: Set.of(state.pendingGemIDs)..add(gemID),
      ),
    );

    final task = wasLiked
        ? gemRepository.unlikeGem(gemID: gemID)
        : gemRepository.likeGem(chestID: chestID, gemID: gemID);

    final result = await task.run();

    result.resolve(
      onSuccess: (_) => emit(
        state.copyWith(
          pendingGemIDs: Set.of(state.pendingGemIDs)..remove(gemID),
        ),
      ),
      onFailure: (_) => emit(
        state.copyWith(
          likedGemIDs: wasLiked
              ? (Set.of(state.likedGemIDs)..add(gemID))
              : (Set.of(state.likedGemIDs)..remove(gemID)),
          pendingGemIDs: Set.of(state.pendingGemIDs)..remove(gemID),
        ),
      ),
    );
  }
}
