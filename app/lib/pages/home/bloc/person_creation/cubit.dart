import 'package:bloc/bloc.dart';
import 'package:cperson_repository/cperson_repository.dart';
import 'package:equatable/equatable.dart';

part 'state.dart';

/// {@template CPersonCreationCubit}
///
/// A cubit for creating a person.
///
/// {@endtemplate}
class CPersonCreationCubit extends Cubit<CPersonCreationState> {
  /// {@macro CPersonCreationCubit}
  CPersonCreationCubit({required this.personRepository, required this.chestID})
      : super(CPersonCreationInitial());

  /// The repository for managing people.
  final CPersonRepository personRepository;

  /// The ID of the chest to create the person in.
  final String chestID;

  /// Updates the person's nickname.
  Future<void> createPerson() async {
    emit(CPersonCreationInProgress());

    final result = await personRepository.insertPerson(chestID: chestID).run();

    emit(
      result.evaluate(
        onFailure: (exception) => CPersonCreationFailure(exception: exception),
        onSuccess: (personID) => CPersonCreationSuccess(personID: personID),
      ),
    );
  }
}
