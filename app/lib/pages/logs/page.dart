import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/app/bootstrap/bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// {@template CLogsPage}
///
/// The page that displays all the logs.
///
/// {@endtemplate}
@RoutePage()
class CLogsPage extends StatelessWidget {
  /// {@macro CLogsPage}
  const CLogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TalkerScreen(talker: cTalker);
  }
}
