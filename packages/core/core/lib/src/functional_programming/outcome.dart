import 'package:cpub/equatable.dart';
import 'package:cpub_dev/flutter_test.dart';

/// Represents the outcome of a job.
///
/// A job can either succeed or fail.
///
/// The [F] type represents the failure type.
/// The [S] type represents the success type.
sealed class COutcome<F, S> {
  /// Evaluates the outcome of the job.
  ///
  /// If the job failed, the [onFailure] function is called with the failure
  /// value.
  /// If the job succeeded, the [onSuccess] function is called with the success
  /// value.
  T evaluate<T>({
    required T Function(F failure) onFailure,
    required T Function(S success) onSuccess,
  }) {
    if (this is CSuccess<F, S>) {
      return onSuccess((this as CSuccess<F, S>).value);
    } else {
      return onFailure((this as CFailure<F, S>).value);
    }
  }
}

/// {@template CSuccess}
///
/// Represents a successful outcome.
///
/// {@endtemplate}
final class CSuccess<F, S> extends COutcome<F, S> with EquatableMixin {
  /// {@macro CSuccess}
  CSuccess(this.value);

  /// The success value.
  final S value;

  @override
  List<Object?> get props => [value];
}

/// {@template CFailure}
///
/// Represents a failed outcome.
///
/// {@endtemplate}
final class CFailure<F, S> extends COutcome<F, S> with EquatableMixin {
  /// {@macro CFailure}
  CFailure(this.value);

  /// The failure value.
  final F value;

  @override
  List<Object?> get props => [value];
}

/// Creates a successful outcome.
COutcome<F, S> cSuccess<F, S>(S value) => CSuccess<F, S>(value);

/// Creates a failed outcome.
COutcome<F, S> cFailure<F, S>(F value) => CFailure<F, S>(value);

/// Expects the [actual] outcome to be equal to the [expected] successful
/// outcome.
void cExpectSuccess<F, S>(
  COutcome<F, S> actual,
  S expected, {
  String? reason,
  dynamic skip,
}) {
  return expect(actual, cSuccess<F, S>(expected), reason: reason, skip: skip);
}

/// Expects the [actual] outcome to be equal to the [expected] failed outcome.
void cExpectFailure<F, S>(
  COutcome<F, S> actual,
  F expected, {
  String? reason,
  dynamic skip,
}) {
  return expect(actual, cFailure<F, S>(expected), reason: reason, skip: skip);
}
