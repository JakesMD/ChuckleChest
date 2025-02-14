import 'package:flutter/material.dart';

/// Useful extension methods for [BuildContext].
extension CContextX on BuildContext {
  /// Returns the [TextTheme] from the current [ThemeData].
  TextTheme get cTextTheme => Theme.of(this).textTheme;

  /// Returns the [ColorScheme] from the current [ThemeData].
  ColorScheme get cColorScheme => Theme.of(this).colorScheme;
}
