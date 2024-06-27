import 'dart:async';

import 'package:ccore/ccore.dart';

/// {@template CJob}
///
/// Represents a job that can either succeed or fail.
/// A job is a function that returns a [COutcome].
///
/// {@endtemplate}
class CJob<F, S> {
  /// {@macro CJob}
  const CJob({required FutureOr<COutcome<F, S>> Function() run}) : _job = run;

  /// Creates a new job that attempts to run the given function.
  ///
  /// The [run] function is the function to run.
  /// The [onError] function is called with the error if [run] throws an
  /// error.
  factory CJob.attempt({
    required FutureOr<S> Function() run,
    required F Function(Object error) onError,
  }) =>
      CJob<F, S>(
        run: () async {
          try {
            return CSuccess<F, S>(await run());
          } catch (error) {
            return CFailure<F, S>(onError(error));
          }
        },
      );

  final FutureOr<COutcome<F, S>> Function() _job;

  /// Chains a job with another job if the first job succeeds.
  ///
  /// The [run] function is the function to run with the successful outcome of
  /// the first job.
  CJob<F, S2> then<S2>({required FutureOr<S2> Function(S) run}) => CJob(
        run: () async {
          final result = await this.run();
          return result.evaluate(
            onFailure: CFailure<F, S2>.new,
            onSuccess: (success) async => CSuccess(await run(success)),
          );
        },
      );

  /// Chains the job with another job if the first job succeeds.
  ///
  /// The [run] function is the function to run with the successful outcome of
  /// the first job.
  /// The [onError] function is called with the error if [run] throws an
  /// error.
  CJob<F, S2> thenAttempt<S2>({
    required FutureOr<S2> Function(S) run,
    required F Function(Object error) onError,
  }) =>
      CJob(
        run: () async {
          final result = await this.run();
          return result.evaluate(
            onFailure: CFailure<F, S2>.new,
            onSuccess: (success) => CJob.attempt(
              run: () => run(success),
              onError: onError,
            ).run(),
          );
        },
      );

  /// Evaluates the outcome of the job.
  CJob<F2, S2> thenEvaluate<F2, S2>({
    required F2 Function(F error) onFailure,
    required S2 Function(S success) onSuccess,
  }) =>
      CJob(
        run: () async {
          final result = await this.run();
          return result.evaluate(
            onFailure: (failure) => CFailure<F2, S2>(onFailure(failure)),
            onSuccess: (success) => CSuccess<F2, S2>(onSuccess(success)),
          );
        },
      );

  /// Evaluates the outcome of the job but only in the case of a failure.
  CJob<F2, S> thenEvaluateOnFailure<F2>(F2 Function(F error) onFailure) => CJob(
        run: () async {
          final result = await this.run();
          return result.evaluate(
            onFailure: (failure) => CFailure<F2, S>(onFailure(failure)),
            onSuccess: CSuccess<F2, S>.new,
          );
        },
      );

  /// Runs the job.
  FutureOr<COutcome<F, S>> run() => _job.call();
}

/// Creates a fake job that always succeeds with the given value.
///
/// This is useful for testing.
CJob<F, S> cFakeSuccessJob<F, S>(S value) => CJob<F, S>(
      run: () async => CSuccess<F, S>(value),
    );

/// Creates a fake job that always fails with the given value.
///
/// This is useful for testing.
CJob<F, S> cFakeFailureJob<F, S>(F value) => CJob<F, S>(
      run: () async => CFailure<F, S>(value),
    );
