import 'dart:async';

import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cauth_repository/cauth_repository.dart';
import 'package:chuckle_chest/shared/_shared.dart';

/// {@template CCurrentUserState}
///
/// The state for the [CCurrentUserCubit].
///
/// {@endtemplate}
class CCurrentUserState extends CStreamCubitState<CCurrentUserStreamException,
    BobsMaybe<CAuthUser>> {
  /// {@macro CCurrentUserState}
  const CCurrentUserState({required super.outcome});

  /// The current user.
  CAuthUser? get user => hasSuccess ? success.asNullable : null;

  /// Returns `true` if the user is signed in.
  bool get isSignedIn => hasSuccess && success.isPresent;

  /// Returns `true` if the user is signed out.
  bool get isSignedOut => !isSignedIn;

  @override
  String toString() => switch (status) {
        CStreamCubitStatus.hasSuccess => 'hasSuccess($user)',
        CStreamCubitStatus.hasFailure => 'hasFailure($failure)',
        CStreamCubitStatus.waiting => 'waiting()',
      };
}

/// {@template CCurrentUserCubit}
///
/// The cubit that handles streaming the current user.
///
/// {@endtemplate}
class CCurrentUserCubit extends CStreamCubit<CCurrentUserState,
    CCurrentUserStreamException, BobsMaybe<CAuthUser>> {
  /// {@macro CCurrentUserCubit}
  CCurrentUserCubit({required this.authRepository})
      : super(const CCurrentUserState(outcome: null));

  /// The repository this cubit uses to stream the auth user.
  final CAuthRepository authRepository;

  @override
  StreamSubscription<
          BobsOutcome<CCurrentUserStreamException, BobsMaybe<CAuthUser>>>
      initSubscription() => authRepository
          .currentUserStream()
          .stream()
          .listen((outcome) => emit(CCurrentUserState(outcome: outcome)));

  /// Stream that emits `true` if the user is signed in.
  Stream<bool> get isSignedInStream =>
      stream.map((state) => state.isSignedIn).distinct().skip(1);
}
