// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.g.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class CCoreL10nDe extends CCoreL10n {
  CCoreL10nDe([String locale = 'de']) : super(locale);

  @override
  String get userRole_collaborator => 'Kollaborateur';

  @override
  String get userRole_owner => 'Besitzer';

  @override
  String get userRole_viewer => 'Betrachter';
}
