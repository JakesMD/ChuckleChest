import 'dart:math';

import 'package:flutter/material.dart';

final _seedColor = Colors.primaries[
    Random(DateTime.now().millisecondsSinceEpoch)
        .nextInt(Colors.primaries.length)];

/// The theme data for the application.
class CAppTheme {
  /// The light theme data for the application.
  static final theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: _seedColor),
    useMaterial3: true,
    fontFamily: 'ReadexPro',
  );

  /// The dark theme data for the application.
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
    fontFamily: 'ReadexPro',
  );
}
