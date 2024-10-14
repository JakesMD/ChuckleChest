import 'package:bloc/bloc.dart';
import 'package:cauth_repository/cauth_repository.dart';
import 'package:cchest_repository/cchest_repository.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CUserInvitationsFetchState}
///
/// The state for the [CUserInvitationsFetchCubit].
///
/// {@endtemplate}
class CUserInvitationsFetchState extends CRequestCubitState<
    CUserInvitationsFetchException, List<CUserInvitation>> {
  /// {@macro CUserInvitationsFetchState}
  ///
  /// The initial state.
  CUserInvitationsFetchState.initial() : super.initial();

  /// {@macro CUserInvitationsFetchState}
  ///
  /// The in progress state.
  CUserInvitationsFetchState.inProgress() : super.inProgress();

  /// {@macro CUserInvitationsFetchState}
  ///
  /// The completed state.
  CUserInvitationsFetchState.completed({required super.outcome})
      : super.completed();

  /// The invitations that were fetched.
  List<CUserInvitation> get invitations => success;
}

/// {@template CUserInvitationsFetchCubit}
///
/// The cubit that handles fetching the current user's invitations.
///
/// {@endtemplate}
class CUserInvitationsFetchCubit extends Cubit<CUserInvitationsFetchState> {
  /// {@macro CUserInvitationsFetchCubit}
  CUserInvitationsFetchCubit({
    required this.chestRepository,
    required this.authRepository,
  }) : super(CUserInvitationsFetchState.initial());

  /// The repository this cubit uses to fetch the user's invitations.
  final CChestRepository chestRepository;

  /// The repository this cubit uses to fetch the user's email.
  final CAuthRepository authRepository;

  /// Fetches the user invitations for the current user.
  Future<void> fetchUserInvitations() async {
    emit(CUserInvitationsFetchState.inProgress());

    final result = await chestRepository
        .fetchUserInvitations(email: authRepository.currentUser!.email)
        .run(isDebugMode: kDebugMode);

    emit(CUserInvitationsFetchState.completed(outcome: result));
  }
}
