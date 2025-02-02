import 'package:bloc/bloc.dart';
import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:chuckle_chest/shared/logic/_logic.dart';
import 'package:cperson_repository/cperson_repository.dart';
import 'package:flutter/foundation.dart';

/// {@template CAvatarPickState}
///
/// The state for the [CAvatarPickCubit].
///
/// {@endtemplate}
class CAvatarPickState
    extends CRequestCubitState<CAvatarPickException, BobsMaybe<Uint8List>> {
  /// {@macro CAvatarPickState}
  ///
  /// The initial state.
  CAvatarPickState.initial() : super.initial();

  /// {@macro CAvatarPickState}
  ///
  /// The in progress state.
  CAvatarPickState.inProgress() : super.inProgress();

  /// {@macro CAvatarPickState}
  ///
  /// The completed state.
  CAvatarPickState.completed({required super.outcome}) : super.completed();

  /// The image to be uploaded.
  BobsMaybe<Uint8List> get image => success;
}

/// {@template CAvatarPickCubit}
///
/// A cubit for allowing the user to pick an avatar.
///
/// {@endtemplate}
class CAvatarPickCubit extends Cubit<CAvatarPickState> {
  /// {@macro CAvatarPickCubit}
  CAvatarPickCubit({required this.personRepository})
      : super(CAvatarPickState.initial());

  /// The repository this cubit uses to pick an avatar.
  final CPersonRepository personRepository;

  /// Allows the user to pick an image from their gallery.
  Future<void> pickAvatar() async {
    emit(CAvatarPickState.inProgress());

    final result = await personRepository.pickAvatar().run();

    emit(CAvatarPickState.completed(outcome: result));
  }
}
