import 'package:cpub/equatable.dart';
import 'package:cpub/meta.dart';

/// A maybe type represents a value that may or may not be present.
sealed class CMaybe<T> {
  /// Evaluates the maybe.
  ///
  /// If the maybe is present, the [onPresent] function is called with the
  /// value.
  /// If the maybe is absent, the [onAbsent] function is called.
  T2 evaluate<T2>({
    required T2 Function(T value) onPresent,
    required T2 Function() onAbsent,
  }) {
    if (this is CPresent<T>) {
      return onPresent((this as CPresent<T>).value);
    } else {
      return onAbsent();
    }
  }

  /// Derives a new maybe from the current maybe.
  ///
  /// If the maybe is present, the value will be replaced with the result of
  /// [onPresent].
  CMaybe<T2> deriveOnPresent<T2>(T2 Function(T value) onPresent) {
    if (this is CPresent<T>) {
      return CPresent(onPresent((this as CPresent<T>).value));
    } else {
      return cAbsent<T2>();
    }
  }
}

/// {@template CPresent}
///
/// Represents a present value.
///
/// {@endtemplate}
final class CPresent<T> extends CMaybe<T> with EquatableMixin {
  /// {@macro CPresent}
  CPresent(this.value);

  /// The value.
  final T value;

  @override
  List<Object?> get props => [value];
}

/// {@template CAbsent}
///
/// Represents an absent value.
///
/// {@endtemplate}
@immutable
final class CAbsent<T> extends CMaybe<T> {
  @override
  bool operator ==(Object other) => other is CAbsent;

  @override
  int get hashCode => 0;
}

/// Creates an instance of [CAbsent].
CMaybe<T> cAbsent<T>() => CAbsent<T>();

/// Creates an instance of [CPresent].
CMaybe<T> cPresent<T>(T value) => CPresent(value);
