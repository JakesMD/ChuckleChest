// coverage:ignore-file

import 'package:cpub/flutter_bloc.dart';

/// {@template CClientProvider}
///
/// An extension of the [RepositoryProvider] for clients.
///
/// {@endtemplate}
class CClientProvider<T> extends RepositoryProvider<T> {
  /// {@macro CClientProvider}
  CClientProvider({
    required super.create,
    super.key,
    super.child,
    super.lazy,
  });
}

/// {@template CMultiClientProvider}
///
/// An extension of the [MultiRepositoryProvider] for clients.
///
/// {@endtemplate}
class CMultiClientProvider extends MultiRepositoryProvider {
  /// {@macro CMultiClientProvider}
  CMultiClientProvider({
    required super.providers,
    required super.child,
    super.key,
  });
}
