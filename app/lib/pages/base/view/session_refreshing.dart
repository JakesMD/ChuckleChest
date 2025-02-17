import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';

/// {@template CSessionRefreshingView}
///
/// The view displayed when the session is being refreshed.
///
/// {@endtemplate}
class CSessionRefreshingView extends StatelessWidget {
  /// {@macro CSessionRefreshingView}
  const CSessionRefreshingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CCradleLoadingIndicator(color: context.cColorScheme.primary),
      ),
    );
  }
}
