import 'dart:async';

import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cperson_repository/cperson_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'state.dart';

/// {@template CPersonStreamCubit}
///
/// A cubit for streaming a person.
///
/// {@endtemplate}
class CPersonStreamCubit extends Cubit<CPersonStreamState> {
  /// {@macro CPersonStreamCubit}
  CPersonStreamCubit({required this.personRepository, required this.personID})
      : super(CPersonStreamInitial()) {
    _streamSubscription =
        personRepository.personStream(personID: personID).listen(
              (outcome) => emit(
                outcome.evaluate(
                  onFailure: (exception) =>
                      CPersonStreamFailure(exception: exception),
                  onSuccess: (person) => CPersonStreamSuccess(person: person),
                ),
              ),
            );
  }

  /// The ID of the person to stream.
  final BigInt personID;

  /// The repository for managing people.
  final CPersonRepository personRepository;

  late StreamSubscription<BobsOutcome<CPersonStreamException, CPerson>>
      _streamSubscription;

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
