import 'package:bloc/bloc.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:mallard_bloc/mallard_bloc.dart';

/// The state for the [CFavouriteGemIDsFetchCubit].
typedef CFavouriteGemIDsFetchState =
    TaskBlocState<List<String>, CGemIDsFetchException>;

/// {@template CFavouriteGemIDsFetchCubit}
///
/// The cubit for handling fetching the IDs of the liked gems.
///
/// {@endtemplate}
class CFavouriteGemIDsFetchCubit extends Cubit<CFavouriteGemIDsFetchState>
    with TaskCubitMixin {
  /// {@macro CFavouriteGemIDsFetchCubit}
  CFavouriteGemIDsFetchCubit({
    required this.gemRepository,
    required this.chestID,
  }) : super(TaskBlocState.initial());

  /// The repository this cubit uses to fetch the gem IDs.
  final CGemRepository gemRepository;

  /// The ID of the chest to fetch the liked gems from.
  final String chestID;

  /// Fetches the IDs of the liked gems.
  Future<void> fetchLikedGemIDs() =>
      request(gemRepository.fetchLikedGemIDs(chestID: chestID));
}
