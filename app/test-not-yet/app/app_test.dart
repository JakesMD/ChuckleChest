import 'package:chuckle_chest/app/app.dart';
import 'package:cpub_dev/flutter_test.dart';
import 'package:cpub_dev/test_beautifier.dart';
import 'package:flutter/material.dart';

void main() {
  group('ChuckleChestApp tests', () {
    testWidgets(
      requirement(
        Given: 'Flavor is development',
        When: 'ChuckleChestApp is built',
        Then: 'MaterialBanner is not displayed',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(
          const ChuckleChestApp(flavor: CAppFlavor.development),
        );
        expect(find.byType(MaterialBanner), findsNothing);
      }),
    );

    testWidgets(
      requirement(
        Given: 'Flavor is staging',
        When: 'ChuckleChestApp is built',
        Then: 'PStagingBanner is displayed',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(
          const ChuckleChestApp(flavor: CAppFlavor.staging),
        );
        expect(find.byType(MaterialBanner), findsOneWidget);
      }),
    );

    testWidgets(
      requirement(
        Given: 'Flavor is production',
        When: 'ChuckleChestApp is built',
        Then: 'PStagingBanner is not displayed',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(
          const ChuckleChestApp(flavor: CAppFlavor.production),
        );
        expect(find.byType(MaterialBanner), findsNothing);
      }),
    );
  });
}
