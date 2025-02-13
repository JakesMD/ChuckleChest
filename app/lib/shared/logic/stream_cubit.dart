import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// The status of the stream of a [CStreamCubit].
enum CStreamCubitStatus {
  /// The stream is waiting for data.
  waiting,

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
  F get failure => outcome!.asFailure;

  /// The success value of the latest item in the stream.
  S get success => outcome!.asSuccess;

  /// Returns `true` if no item has been received yet.
  bool get isWaiting => status == CStreamCubitStatus.waiting;

  /// Returns `true` if the latest item in the stream was a success.
  bool get hasSuccess => status == CStreamCubitStatus.hasSuccess;

  /// Returns `true` if the latest item in the stream was a failure.
  bool get hasFailure => status == CStreamCubitStatus.hasFailure;

  /// The status of the stream.
  CStreamCubitStatus get status {
    if (outcome is BobsSuccess) return CStreamCubitStatus.hasSuccess;
    if (outcome is BobsFailure) return CStreamCubitStatus.hasFailure;
    return CStreamCubitStatus.waiting;
  }

  @override
  List<Object?> get props => [outcome];

  @override
  String toString() => switch (status) {
        CStreamCubitStatus.hasSuccess => 'hasSuccess($success)',
        CStreamCubitStatus.hasFailure => 'hasFailure($failure)',
        CStreamCubitStatus.waiting => 'waiting()',
      };
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
  CStreamCubit(this.initialState) : super(initialState) {
    streamSubscription = initSubscription();
  }

  /// The subscription to the stream.
  late StreamSubscription<BobsOutcome<F, S>> streamSubscription;

  /// The initial state.
  final T initialState;

  /// Initialzes the stream subscription.
  @mustBeOverridden
  StreamSubscription<BobsOutcome<F, S>> initSubscription() =>
      throw UnimplementedError();

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }

  /// Closes the stream and resets the cubit starting a new stream.
  Future<void> restart() async {
    if (state.isWaiting) return;
    emit(initialState);
    unawaited(streamSubscription.cancel());
    await Future.delayed(Duration.zero);
    streamSubscription = initSubscription();
    await stream.firstWhere((state) => !state.isWaiting);
  }
}
