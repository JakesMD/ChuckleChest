import 'package:bloc/bloc.dart';
import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:ccore/ccore.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:cperson_repository/cperson_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CChestPeopleFetchState}
///
/// The state for the [CChestPeopleFetchCubit].
///
/// {@endtemplate}
class CChestPeopleFetchState
    extends CRequestCubitState<CChestPeopleFetchException, List<CPerson>> {
  /// {@macro CChestPeopleFetchState}
  ///
  /// The initial state.
  CChestPeopleFetchState.initial() : super.initial();

  /// {@macro CChestPeopleFetchState}
  ///
  /// The in progress state.
  CChestPeopleFetchState.inProgress() : super.inProgress();

  /// {@macro CChestPeopleFetchState}
  ///
  /// The completed state.
  CChestPeopleFetchState.completed({required super.outcome})
      : super.completed();

  /// The people in the chest.
  ///
  /// This will be empty if the request failed.
  List<CPerson> get people => outcome is BobsSuccess ? success : [];
}

/// {@template CChestPeopleFetchCubit}
///
/// The cubit that handles fetching chest people.
///
/// {@endtemplate}
class CChestPeopleFetchCubit extends Cubit<CChestPeopleFetchState> {
  /// {@macro CChestPeopleFetchCubit}
  CChestPeopleFetchCubit({required this.personRepository})
      : super(CChestPeopleFetchState.initial());

  /// The repository this cubit uses to fetch chest people.
  final CPersonRepository personRepository;

  /// Fetches the people in a chest.
  Future<void> fetchChestPeople({required String chestID}) async {
    emit(CChestPeopleFetchState.inProgress());

    final result = await personRepository
        .fetchChestPeople(chestID: chestID)
        .run(isDebugMode: kDebugMode);

    emit(CChestPeopleFetchState.completed(outcome: result));
  }

  /// Fetches a person by their ID.
  CPerson? fetchPerson(BigInt personID) =>
      state.people.cFirstWhereOrNull((p) => p.id == personID);
}