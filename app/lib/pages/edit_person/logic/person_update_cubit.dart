import 'package:bloc/bloc.dart';
import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:chuckle_chest/shared/logic/_logic.dart';
import 'package:cperson_repository/cperson_repository.dart';

/// {@template CPersonUpdateState}
///
/// The state for the [CPersonUpdateCubit].
///
/// {@endtemplate}
class CPersonUpdateState
    extends CRequestCubitState<CPersonUpdateException, BobsNothing> {
  /// {@macro CPersonUpdateState}
  ///
  /// The initial state.
  CPersonUpdateState.initial({required this.person}) : super.initial();

  /// {@macro CPersonUpdateState}
  ///
  /// The in progress state.
  CPersonUpdateState.inProgress({required this.person}) : super.inProgress();

  /// {@macro CPersonUpdateState}
  ///
  /// The completed state.
  CPersonUpdateState.completed({required super.outcome, required this.person})
      : super.completed();

  /// The person being updated.
  final CPerson person;

  /// {@macro CPersonUpdateState}
  ///
  /// Returns a copy of this state with the given fields replaced by the new
  /// values.
  CPersonUpdateState copyWith({CPerson? person}) => switch (status) {
        CRequestCubitStatus.initial =>
          CPersonUpdateState.initial(person: person ?? this.person),
        CRequestCubitStatus.inProgress =>
          CPersonUpdateState.inProgress(person: person ?? this.person),
        CRequestCubitStatus.failed => CPersonUpdateState.completed(
            outcome: outcome,
            person: person ?? this.person,
          ),
        CRequestCubitStatus.succeeded => CPersonUpdateState.completed(
            outcome: outcome,
            person: person ?? this.person,
          ),
      };

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
    emit(CPersonUpdateState.inProgress(person: state.person));

    final newPerson = state.person.copyWith(nickname: nickname);

    final result = await personRepository.updatePerson(person: newPerson).run();

    emit(
      CPersonUpdateState.completed(
        outcome: result,
        person: result.resolve(
          onFailure: (_) => state.person,
          onSuccess: (_) => newPerson,
        ),
      ),
    );
  }

  /// Updates the person's date of birth.
  Future<void> updateDateOfBirth({required DateTime dateOfBirth}) async {
    emit(CPersonUpdateState.inProgress(person: state.person));

    final newPerson = state.person.copyWith(dateOfBirth: dateOfBirth);

    final result = await personRepository.updatePerson(person: newPerson).run();

    emit(
      CPersonUpdateState.completed(
        outcome: result,
        person: result.resolve(
          onFailure: (_) => state.person,
          onSuccess: (_) => newPerson,
        ),
      ),
    );
  }

  /// Creates or replaces an avatar for the person.
  void updateAvatar({required CAvatarURL avatarURL}) {
    emit(
      state.copyWith(
        person: state.person
          ..avatarURLs.removeWhere((url) => url.year == avatarURL.year)
          ..avatarURLs.add(avatarURL),
      ),
    );
  }
}
