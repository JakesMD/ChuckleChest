part of 'cubit.dart';

/// The state for the [CPersonStreamCubit].
sealed class CPersonStreamState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

/// Indicates the initial state of the person stream.
final class CPersonStreamInitial extends CPersonStreamState {}

/// {@template CPersonStreamFailure}
///
/// Indicates that the a failure occurred while streaming the person.
///
/// {@endtemplate}
final class CPersonStreamFailure extends CPersonStreamState {
  /// {@macro CPersonStreamFailure}
  CPersonStreamFailure({required this.exception});

  /// The exception that caused the stream to fail.
  final CPersonStreamException exception;

  @override
  List<Object?> get props => [exception];
}

/// Indicates that the person is streaming successfully.
final class CPersonStreamSuccess extends CPersonStreamState {
  /// {@macro CPersonStreamSuccess}
  CPersonStreamSuccess({required this.person});

  /// The latest person of the stream.
  final CPerson person;

  @override
  List<Object?> get props => [person];
}
