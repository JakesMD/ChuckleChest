import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:equatable/equatable.dart';

/// The status of the [CRequestCubitState].
enum CRequestCubitStatus {
  /// No request has been made yet.
  initial,

  /// The request is currently in progress.
  inProgress,

  /// The request failed.
  failed,

  /// The request succeeded.
  succeeded,
}

/// {@template CRequestCubitState}
///
/// This is a generic class that can be extended to create a cubit state that
/// handles an asyncronous request.
///
/// This dramatically reduces the boilerplate code and creates a uniform API for
/// the UI.
///
/// {@endtemplate}
class CRequestCubitState<F, S> with EquatableMixin {
  /// {@macro CRequestCubitState}
  CRequestCubitState({required this.status, this.outcome});

  /// {@macro CRequestCubitState}
  ///
  /// The initial state. It sets `status` to `CRequestCubitStatus.initial`.
  CRequestCubitState.initial({this.outcome})
      : status = CRequestCubitStatus.initial;

  /// {@macro CRequestCubitState}
  ///
  /// The in progress state. It sets `status` to
  /// `CRequestCubitStatus.inProgress`.
  CRequestCubitState.inProgress({this.outcome})
      : status = CRequestCubitStatus.inProgress;

  /// {@macro CRequestCubitState}
  ///
  /// The completed state. It sets `status` to `CRequestCubitStatus.failed` or
  /// `CRequestCubitStatus.succeeded` based on the outcome.
  CRequestCubitState.completed({required this.outcome})
      : status = outcome is BobsFailure<F, S>
            ? CRequestCubitStatus.failed
            : CRequestCubitStatus.succeeded;

  /// {@macro CRequestCubitState}
  ///
  /// The completed state.
  CRequestCubitState.succeeded({required this.outcome})
      : status = CRequestCubitStatus.succeeded;

  /// The outcome of the latest item in the stream.
  final BobsOutcome<F, S>? outcome;

  /// The status of the request.
  final CRequestCubitStatus status;

  /// The failure value of the latest item in the stream.
  F get failure => (outcome! as BobsFailure<F, S>).value;

  /// The success value of the latest item in the stream.
  S get success => (outcome! as BobsSuccess<F, S>).value;

  @override
  List<Object?> get props => [outcome];
}
