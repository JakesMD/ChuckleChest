import 'package:flutter/material.dart';

void main() {
  runApp(const ChuckleChestApp());
}

/// {@template ChuckleChestApp}
///
/// The main application widget for the ChuckleChest app.
///
/// This widget is responsible for setting up the application theme and
/// routing.
///
/// {@endtemplate}
class ChuckleChestApp extends StatelessWidget {
  /// {@macro ChuckleChestApp}
  const ChuckleChestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chuckle Chest',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,
      ),
      home: Container(),
    );
  }
}
