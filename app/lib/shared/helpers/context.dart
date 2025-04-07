import 'package:cauth_repository/cauth_repository.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Useful extension methods for [BuildContext].
extension CContextX on BuildContext {
  /// Returns the [TextTheme] from the current [ThemeData].
  TextTheme get cTextTheme => Theme.of(this).textTheme;

  /// Returns the [ColorScheme] from the current [ThemeData].
  ColorScheme get cColorScheme => Theme.of(this).colorScheme;

  /// The current user of the app.
  CAuthUser? get currentUser => read<CCurrentUserCubit>().state.user;

  /// The currently selected chest.
  CAuthUserChest get currentChest => read<CCurrentChestCubit>().state;
}
