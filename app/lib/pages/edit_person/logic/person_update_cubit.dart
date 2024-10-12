import 'package:bloc/bloc.dart';
import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:chuckle_chest/shared/logic/_logic.dart';
import 'package:cperson_repository/cperson_repository.dart';
import 'package:flutter/foundation.dart';

/// {@template CPersonUpdateState}
///
/// The state for the [CPersonUpdateCubit].
///
/// {@endtemplate}
class CPersonUpdateState
    extends CRequestCubitState<CPersonUpdateException, BobsNothing> {
  CPersonUpdateState._({
    required this.person,
    required this.haveAvatarsChanged,
    required super.status,
    super.outcome,
  }) : super();

  /// {@macro CPersonUpdateState}
  ///
  /// The initial state.
  CPersonUpdateState.initial({
    required this.person,
  })  : haveAvatarsChanged = false,
        super.initial();

  /// {@macro CPersonUpdateState}
  ///
  /// The in progress state.
  CPersonUpdateState.inProgress({
    required this.person,
    required this.haveAvatarsChanged,
  }) : super.inProgress();

  /// {@macro CPersonUpdateState}
  ///
  /// The completed state.
  CPersonUpdateState.completed({
    required super.outcome,
    required this.person,
    required this.haveAvatarsChanged,
  }) : super.completed();

  /// The person being updated.
  final CPerson person;

  /// Whether the avatars have changed.
  final bool haveAvatarsChanged;

  /// {@macro CPersonUpdateState}
  ///
  /// Returns a copy of this state with the given fields replaced by the new
  /// values.
  CPersonUpdateState copyWith({CPerson? person, bool? haveAvatarsChanged}) =>
      CPersonUpdateState._(
        outcome: outcome,
        status: status,
        person: person ?? this.person,
        haveAvatarsChanged: haveAvatarsChanged ?? this.haveAvatarsChanged,
      );

  @override
  List<Object?> get props => super.props..add(person);
}

/// {@template CPersonUpdateCubit}
///
/// A cubit for updating a person.
///
/// {@endtemplate}
class CPersonUpdateCubit extends Cubit<CPersonUpdateState> {
  /// {@macro CPersonUpdateCubit}
  CPersonUpdateCubit({required this.personRepository, required CPerson person})
      : super(CPersonUpdateState.initial(person: person));

  /// The repository this cubit uses to update a person.
  final CPersonRepository personRepository;

  /// Updates the person's nickname.
  Future<void> updateNickname({required String nickname}) async {
    emit(
      CPersonUpdateState.inProgress(
        person: state.person,
        haveAvatarsChanged: state.haveAvatarsChanged,
      ),
    );

    final newPerson = state.person.copyWith(nickname: nickname);

    final result = await personRepository
        .updatePerson(person: newPerson)
        .run(isDebugMode: kDebugMode);

    emit(
      CPersonUpdateState.completed(
        outcome: result,
        haveAvatarsChanged: state.haveAvatarsChanged,
        person: result.evaluate(
          onFailure: (_) => state.person,
          onSuccess: (_) => newPerson,
        ),
      ),
    );
  }

  /// Updates the person's date of birth.
  Future<void> updateDateOfBirth({required DateTime dateOfBirth}) async {
    emit(
      CPersonUpdateState.inProgress(
        person: state.person,
        haveAvatarsChanged: state.haveAvatarsChanged,
      ),
    );

    final newPerson = state.person.copyWith(dateOfBirth: dateOfBirth);

    final result = await personRepository
        .updatePerson(person: newPerson)
        .run(isDebugMode: kDebugMode);

    emit(
      CPersonUpdateState.completed(
        outcome: result,
        person: result.evaluate(
          onFailure: (_) => state.person,
          onSuccess: (_) => newPerson,
        ),
        haveAvatarsChanged: state.haveAvatarsChanged,
      ),
    );
  }

  /// Creates or replaces an avatar for the person.
  void updateAvatar({required CAvatarURL avatarURL}) {
    emit(
      state.copyWith(
        haveAvatarsChanged: true,
        person: state.person
          ..avatarURLs.removeWhere((url) => url.year == avatarURL.year)
          ..avatarURLs.add(avatarURL),
      ),
    );
  }
}
