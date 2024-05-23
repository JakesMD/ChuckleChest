import 'package:chuckle_chest/localization/l10n.dart';
import 'package:cpub_dev/flutter_test.dart';
import 'package:cpub_dev/test_beautifier.dart';
import 'package:flutter/material.dart';

import '../mock_app.dart';

void main() {
  group('CAppL10n tests', () {
    testWidgets(
      requirement(
        Given: 'An app with CAppL10n delegate',
        When: 'fetching CAppL10n from BuildContext',
        Then: 'returns CAppL10n instance',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(
          MockCApp(
            child: Builder(
              builder: (context) {
                expect(context.cAppL10n, isNotNull);
                return Container();
              },
            ),
          ),
        );
      }),
    );
  });
}
