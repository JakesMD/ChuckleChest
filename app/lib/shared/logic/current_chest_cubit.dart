import 'package:bloc/bloc.dart';
import 'package:cauth_repository/cauth_repository.dart';

/// {@template CCurrentChestCubit}
///
/// This cubit is used to store the current chest that the user is viewing.
///
/// If `chestID` is null, the first chest the user has access to will be
/// selected.
///
/// {@endtemplate}
class CCurrentChestCubit extends Cubit<CAuthUserChest> {
  /// {@macro CCurrentChestCubit}
  CCurrentChestCubit({
    required String? chestID,
    required String? lastViewedChest,
    required this.authRepository,
  }) : super(
          authRepository.currentUser!.chests.firstWhere(
            (chest) => chestID != null
                ? chest.id == chestID
                : chest.id == lastViewedChest,
            orElse: () => authRepository.currentUser!.chests.first,
          ),
        );

  /// The repository this cubit uses to retrieve user data.
  final CAuthRepository authRepository;

  /// Updates the name of the current chest locally to `name`.
  void updateName(String name) =>
      emit(CAuthUserChest(id: state.id, name: name, userRole: state.userRole));
}
