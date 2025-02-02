import 'package:bloc/bloc.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:cperson_repository/cperson_repository.dart';

/// {@template CPersonCreationState}
///
/// The state for the [CPersonCreationCubit].
///
/// {@endtemplate}
class CPersonCreationState
    extends CRequestCubitState<CPersonCreationException, CPerson> {
  /// {@macro CPersonCreationState}
  ///
  /// The initial state.
  CPersonCreationState.initial() : super.initial();

  /// {@macro CPersonCreationState}
  ///
  /// The in progress state.
  CPersonCreationState.inProgress() : super.inProgress();

  /// {@macro CPersonCreationState}
  ///
  /// The completed state.
  CPersonCreationState.completed({required super.outcome}) : super.completed();

  /// The person that was created.
  CPerson get person => success;
}

/// {@template CPersonCreationCubit}
///
/// A cubit for creating a person.
///
/// {@endtemplate}
class CPersonCreationCubit extends Cubit<CPersonCreationState> {
  /// {@macro CPersonCreationCubit}
  CPersonCreationCubit({required this.personRepository, required this.chestID})
      : super(CPersonCreationState.initial());

  /// The repository this cubit uses to create a person.
  final CPersonRepository personRepository;

  /// The ID of the chest to create the person in.
  final String chestID;

  /// Updates the person's nickname.
  Future<void> createPerson() async {
    emit(CPersonCreationState.inProgress());

    final result = await personRepository.createPerson(chestID: chestID).run();

    emit(CPersonCreationState.completed(outcome: result));
  }
}
