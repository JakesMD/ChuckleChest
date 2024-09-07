// coverage:ignore-file

import 'package:flutter_bloc/flutter_bloc.dart';

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

  /// {@macro CClientProvider}
  CClientProvider.value({
    required super.value,
    super.key,
    super.child,
  }) : super.value();
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
