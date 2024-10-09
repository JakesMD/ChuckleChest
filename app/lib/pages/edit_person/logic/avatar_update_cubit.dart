import 'package:bloc/bloc.dart';
import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:chuckle_chest/shared/logic/_logic.dart';
import 'package:cperson_repository/cperson_repository.dart';
import 'package:flutter/foundation.dart';

/// {@template CAvatarUpdateState}
///
/// The state for the [CAvatarUpdateCubit].
///
/// {@endtemplate}
class CAvatarUpdateState
    extends CRequestCubitState<CAvatarUpdateException, BobsNothing> {
  /// {@macro CAvatarUpdateState}
  ///
  /// The initial state.
  CAvatarUpdateState.initial() : super.initial();

  /// {@macro CAvatarUpdateState}
  ///
  /// The in progress state.
  CAvatarUpdateState.inProgress() : super.inProgress();

  /// {@macro CAvatarUpdateState}
  ///
  /// The completed state.
  CAvatarUpdateState.completed({required super.outcome}) : super.completed();
}

/// {@template CAvatarUpdateCubit}
///
/// A cubit for updating a person's avatar for a given year.
///
/// {@endtemplate}
class CAvatarUpdateCubit extends Cubit<CAvatarUpdateState> {
  /// {@macro CAvatarUpdateCubit}
  CAvatarUpdateCubit({required this.personRepository})
      : super(CAvatarUpdateState.initial());

  /// The repository this cubit uses to update the person's avatar.
  final CPersonRepository personRepository;

  /// Updates the image for the given person for the given year.
  Future<void> updateAvatarForYear({
    required Uint8List image,
    required CPerson person,
    required int year,
  }) async {
    emit(CAvatarUpdateState.inProgress());

    final result = await personRepository
        .updateAvatar(person: person, year: year, image: image)
        .run(isDebugMode: kDebugMode);

    emit(CAvatarUpdateState.completed(outcome: result));
  }
}
