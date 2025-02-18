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
  F get failure => outcome!.asFailure;

  /// The success value of the latest item in the stream.
  S get success => outcome!.asSuccess;

  /// Returns true if the request is initial.
  bool get isInitial => status == CRequestCubitStatus.initial;

  /// Returns true if the request is in progress.
  bool get inProgress => status == CRequestCubitStatus.inProgress;

  /// Returns true if the request succeeded.
  bool get succeeded => status == CRequestCubitStatus.succeeded;

  /// Returns true if the request failed.
  bool get failed => status == CRequestCubitStatus.failed;

  @override
  List<Object?> get props => [outcome];

  @override
  String toString() => switch (status) {
        CRequestCubitStatus.initial => 'initial()',
        CRequestCubitStatus.inProgress => 'inProgress()',
        CRequestCubitStatus.failed => 'failed($failure)',
        CRequestCubitStatus.succeeded => 'succeeded($success)',
      };
}
