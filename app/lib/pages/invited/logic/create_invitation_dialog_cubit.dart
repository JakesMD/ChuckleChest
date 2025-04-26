import 'package:ccore/ccore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CCreateInvitationDialogCubit}
///
/// Manages the state of the role selection in the create invitation dialog.
///
/// {@endtemplate}
class CCreateInvitationDialogCubit extends Cubit<CUserRole> {
  /// {@macro CCreateInvitationDialogCubit}
  CCreateInvitationDialogCubit() : super(CUserRole.viewer);

  /// Changes the role of the user.
  void changeRole(CUserRole role) {
    if (role != CUserRole.owner) emit(role);
  }
}
