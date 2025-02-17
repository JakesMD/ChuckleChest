import 'package:flutter/material.dart';

/// {@template CSessionRefreshFailedView}
///
/// The view displayed when the session fails to refresh.
///
/// {@endtemplate}
class CSessionRefreshFailedView extends StatelessWidget {
  /// {@macro CSessionRefreshFailedView}
  const CSessionRefreshFailedView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            Icon(Icons.error_outline),
            Text('Failed to refresh session'),
          ],
        ),
      ),
    );
  }
}
