import 'package:bloc/bloc.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:mallard_bloc/mallard_bloc.dart';

/// The state for the [CGemDeleteCubit].
typedef CGemDeleteState = TaskBlocState<String, CGemDeleteException>;

/// {@template CGemDeleteCubit}
///
/// The cubit that handles deleting gems.
///
/// {@endtemplate}
class CGemDeleteCubit extends Cubit<CGemDeleteState> with TaskCubitMixin {
  /// {@macro CGemDeleteCubit}
  CGemDeleteCubit({required this.gemRepository})
    : super(TaskBlocState.initial());

  /// The repository this cubit uses to delete gems.
  final CGemRepository gemRepository;

  /// Deletes the gem with the given `gemID`.
  Future<void> deleteGem({required String gemID}) =>
      request(gemRepository.deleteGem(gemID: gemID));
}
