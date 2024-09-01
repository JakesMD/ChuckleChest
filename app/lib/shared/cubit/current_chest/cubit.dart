import 'package:cauth_repository/cauth_repository.dart';
import 'package:cpub/flutter_bloc.dart';

/// {@template CCurrentChestCubit}
///
/// A cubit that stores the current chest.
///
/// {@endtemplate}
class CCurrentChestCubit extends Cubit<CAuthUserChest> {
  /// {@macro CCurrentChestCubit}
  CCurrentChestCubit({
    required String? chestID,
    required this.authRepository,
  }) : super(
          authRepository.currentUser!.chests.firstWhere(
            (chest) => chest.id == chestID,
            orElse: () => authRepository.currentUser!.chests.first,
          ),
        );

  /// The repository this cubit uses to retrieve user data.
  final CAuthRepository authRepository;
}
