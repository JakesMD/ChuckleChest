// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.g.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class CCoreL10nEn extends CCoreL10n {
  CCoreL10nEn([String locale = 'en']) : super(locale);

  @override
  String get userRole_collaborator => 'Collaborator';

  @override
  String get userRole_owner => 'Owner';

  @override
  String get userRole_viewer => 'Viewer';
}
