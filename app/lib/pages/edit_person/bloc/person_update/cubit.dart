import 'package:bloc/bloc.dart';
import 'package:cperson_repository/cperson_repository.dart';
import 'package:equatable/equatable.dart';

part 'state.dart';

/// {@template CPersonUpdateCubit}
///
/// A cubit for updating a person.
///
/// {@endtemplate}
class CPersonUpdateCubit extends Cubit<CPersonUpdateState> {
  /// {@macro CPersonUpdateCubit}
  CPersonUpdateCubit({required this.personRepository})
      : super(CPersonUpdateInitial());

  /// The repository for managing people.
  final CPersonRepository personRepository;

  /// Updates the person's nickname.
  Future<void> updateNickname(CPerson person, String nickname) async {
    emit(CPersonUpdateInProgress());

    final result = await personRepository
        .updatePerson(person: person.copyWith(nickname: nickname))
        .run();

    emit(
      result.evaluate(
        onFailure: (exception) => CPersonUpdateFailure(exception: exception),
        onSuccess: (_) => CPersonUpdateSuccess(),
      ),
    );
  }

  /// Updates the person's date of birth.
  Future<void> updateDateOfBirth(CPerson person, DateTime dateOfBirth) async {
    emit(CPersonUpdateInProgress());

    final result = await personRepository
        .updatePerson(person: person.copyWith(dateOfBirth: dateOfBirth))
        .run();

    emit(
      result.evaluate(
        onFailure: (exception) => CPersonUpdateFailure(exception: exception),
        onSuccess: (_) => CPersonUpdateSuccess(),
      ),
    );
  }
}
