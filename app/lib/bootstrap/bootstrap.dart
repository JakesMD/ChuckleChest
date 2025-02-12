import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:ccore/ccore.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// The talker that controls all logging across the app.
final cTalker = TalkerFlutter.init();

/// Bootstraps the app with the given [builder].
///
/// This function sets up the error handling, bloc observer and localization.
Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  await runZonedGuarded(() async {
    FlutterError.onError = (details) {
      cTalker.error(details.toString(), details.exception, details.stack);
    };

    WidgetsFlutterBinding.ensureInitialized();

    Bloc.observer = TalkerBlocObserver(
      talker: cTalker,
      settings: const TalkerBlocLoggerSettings(
        printChanges: true,
        printCreations: true,
        printClosings: true,
      ),
    );

    BigBob.onFailure = (failure, error, stack) =>
        cTalker.error(failure.toString(), error, stack);

    await Supabase.initialize(
      url: const String.fromEnvironment('SUPABASE_PROJECT_URL'),
      anonKey: const String.fromEnvironment('SUPABASE_ANON_KEY'),
      debug: false,
    );
    cTalker.info('Supabase initialized');

    await cInitializeL10n();
    cTalker.info('L10n initialized');

    runApp(await builder());
    cTalker.info('App started');
  }, (Object error, StackTrace stack) {
    cTalker.handle(error, stack, 'Uncaught app exception');
  });
}
