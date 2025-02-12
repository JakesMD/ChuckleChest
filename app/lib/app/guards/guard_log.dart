import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/bootstrap/bootstrap.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// {@template CGuardLog}
///
/// A log for when auto route guards deny navigation.
///
/// {@endtemplate}
class CGuardLog extends TalkerLog {
  /// {@macro CGuardLog}
  CGuardLog(
    String guardName,
    NavigationResolver resolver,
  ) : super('Navigation to ${resolver.routeName} denied by $guardName.');

  @override
  String get title => 'guard';

  @override
  String? get key => 'guard_log_key';

  @override
  AnsiPen get pen => AnsiPen()..xterm(137);

  /// Logs the guard log to the talker.
  void log() => cTalker.logCustom(this);
}
