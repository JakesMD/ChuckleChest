import 'package:chuckle_chest/localization/generated/localizations.g.dart';
import 'package:flutter/widgets.dart';

export 'generated/localizations.g.dart';

/// {@template CAppL10nExtension}
///
/// Provides access to this widget tree's [CAppL10n] instance.
///
/// {@endtemplate}
extension CAppL10nExtension on BuildContext {
  /// {@macro CAppL10nExtension}
  CAppL10n get cAppL10n => CAppL10n.of(this);
}
