import 'package:ccore/ccore.dart';
import 'package:cperson_repository/cperson_repository.dart';
import 'package:cpub/bloc.dart';
import 'package:cpub/bloc_concurrency.dart';
import 'package:cpub/bobs_jobs.dart';
import 'package:cpub/equatable.dart';
import 'package:cpub/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

/// {@template CChestPeopleFetchBloc}
///
/// Bloc that handles fetching chest people.
///
/// {@endtemplate}
class CChestPeopleFetchBloc
    extends Bloc<_CChestPeopleFetchEvent, CChestPeopleFetchState> {
  /// {@macro CChestPeopleFetchBloc}
  CChestPeopleFetchBloc({required this.personRepository, required this.chestID})
      : super(CChestPeopleFetchInProgress()) {
    on<CChestPeopleFetchRequested>(_onRequested, transformer: droppable());
    on<_CChestPeopleFetchCompleted>(_onCompleted);
    add(CChestPeopleFetchRequested(chestID: chestID));
  }

  /// The repository this bloc uses to retrieve person data.
  final CPersonRepository personRepository;

  /// The unique identifier of the chest.
  final String chestID;

  Future<void> _onRequested(
    CChestPeopleFetchRequested event,
    Emitter<CChestPeopleFetchState> emit,
  ) async {
    emit(CChestPeopleFetchInProgress());

    final result =
        await personRepository.fetchChestPeople(chestID: event.chestID).run();

    add(_CChestPeopleFetchCompleted(result: result));
  }

  void _onCompleted(
    _CChestPeopleFetchCompleted event,
    Emitter<CChestPeopleFetchState> emit,
  ) {
    emit(
      event.result.evaluate(
        onFailure: (exception) =>
            CChestPeopleFetchFailure(exception: exception),
        onSuccess: (people) => CChestPeopleFetchSuccess(people: people),
      ),
    );
  }

  /// Fetches a person by their unique identifier.
  CPerson? fetchPerson(BigInt personID) =>
      state.people.cFirstWhereOrNull((p) => p.id == personID);
}
