import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// The status of the stream of a [CStreamCubit].
enum CStreamCubitStatus {
  /// The stream is waiting for data.
  isWaiting,

  /// The last item in the stream was a failure.
  hasFailure,

  /// The last item in the stream was a success.
  hasSuccess,
}

/// {@template CStreamCubitState}
///
/// This is a generic class that can be extended to create the state for a
/// [CStreamCubit] that handles streams.
///
/// This dramatically reduces the boilerplate code and creates a uniform API for
/// the UI.
///
/// {@endtemplate}
class CStreamCubitState<F, S> with EquatableMixin {
  /// {@macro CStreamCubitState}
  const CStreamCubitState({required this.outcome});

  /// The outcome of the latest item in the stream.
  final BobsOutcome<F, S>? outcome;

  /// The failure value of the latest item in the stream.
  F get failure => (outcome! as BobsFailure<F, S>).value;

  /// The success value of the latest item in the stream.
  S get success => (outcome! as BobsSuccess<F, S>).value;

  /// The status of the stream.
  CStreamCubitStatus get status {
    if (outcome is BobsSuccess) return CStreamCubitStatus.hasSuccess;
    if (outcome is BobsFailure) return CStreamCubitStatus.hasFailure;
    return CStreamCubitStatus.isWaiting;
  }

  @override
  List<Object?> get props => [outcome];
}

/// {@template CStreamCubit}
///
/// This is a generic class that can be extended to create a cubit that
/// handles streams.
///
/// This dramatically reduces the boilerplate code and creates a uniform API for
/// the UI.
///
/// {@endtemplate}
class CStreamCubit<T extends CStreamCubitState<F, S>, F, S> extends Cubit<T> {
  /// {@macro CStreamCubit}
  CStreamCubit(super.initialState) {
    streamSubscription = initSubscription();
  }

  /// The subscription to the stream.
  late StreamSubscription<BobsOutcome<F, S>> streamSubscription;

  /// Initialzes the stream subscription.
  @mustBeOverridden
  StreamSubscription<BobsOutcome<F, S>> initSubscription() =>
      throw UnimplementedError();

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
