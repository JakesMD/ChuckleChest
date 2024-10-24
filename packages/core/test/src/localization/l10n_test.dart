import 'package:ccore/ccore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_beautifier/test_beautifier.dart';

MaterialApp localizedApp({required Widget Function(BuildContext) builder}) {
  return MaterialApp(
    locale: const Locale('en'),
    localizationsDelegates: const [CCoreL10n.delegate],
    home: Builder(builder: builder),
  );
}

void main() {
  group('CCoreL10n tests', () {
    testWidgets(
      requirement(
        Given: 'An app with CCoreL10n delegate',
        When: 'fetching CCoreL10n from BuildContext',
        Then: 'returns CCoreL10n instance',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(
          localizedApp(
            builder: (context) {
              expect(context.cCoreL10n, isNotNull);
              return Container();
            },
          ),
        );
      }),
    );
  });

  group('CL10nDateExtension tests', () {
    late String translation;

    testWidgets(
      requirement(
        Given: 'An app with CCoreL10n delegate and en locale',
        When: 'localizing a DateTime instance as yearMonthNumDayNum',
        Then: 'returns a localized string',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(
          localizedApp(
            builder: (context) {
              translation = DateTime(2024, 2, 10).cLocalize(context);
              return Container();
            },
          ),
        );

        expect(translation, '2/10/2024');
      }),
    );
    testWidgets(
      requirement(
        Given: 'An app with CCoreL10n delegate and en locale',
        When: 'localizing a DateTime instance as yearMonth',
        Then: 'returns a localized string',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(
          localizedApp(
            builder: (context) {
              translation = DateTime(2024, 2, 10).cLocalize(
                context,
                dateFormat: CDateFormat.yearMonth,
              );

              return Container();
            },
          ),
        );

        expect(translation, 'February 2024');
      }),
    );
  });

  group('CL10nNumExtension tests', () {
    late String translation;

    testWidgets(
      requirement(
        Given: 'An app with CCoreL10n delegate and en locale',
        When: 'localizing a num instance with 2 digits',
        Then: 'returns a localized string',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(
          localizedApp(
            builder: (context) {
              translation = 2.0399.cLocalize(context, decimalDigits: 2);
              return Container();
            },
          ),
        );

        expect(translation, '2.04');
      }),
    );
  });

  group('CL10nStringExtension tests', () {
    num? result;

    testWidgets(
      requirement(
        Given: 'An app with CCoreL10n delegate and en locale',
        When: 'turning localized string into num',
        Then: 'returns num with correct value',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(
          localizedApp(
            builder: (context) {
              result = '2.0399'.cToLocalizedNum(context);
              return Container();
            },
          ),
        );

        expect(result, 2.0399);
      }),
    );

    testWidgets(
      requirement(
        Given: 'An app with CCoreL10n delegate and en locale',
        When: 'turning badly formatted localized string into num',
        Then: 'returns null',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(
          localizedApp(
            builder: (context) {
              result = 'fsddjlsf'.cToLocalizedNum(context);
              return Container();
            },
          ),
        );

        expect(result, null);
      }),
    );
  });

  group('CL10nUserRoleExtension tests', () {
    late String translation;

    testWidgets(
      requirement(
        Given: 'An app with CCoreL10n delegate and en locale',
        When: 'localizing a [UserRole.owner] instance.',
        Then: 'returns a localized string',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(
          localizedApp(
            builder: (context) {
              translation = CUserRole.owner.cLocalize(context);
              return Container();
            },
          ),
        );

        expect(translation, isNotEmpty);
      }),
    );

    testWidgets(
      requirement(
        Given: 'An app with CCoreL10n delegate and en locale',
        When: 'localizing a [UserRole.collaborator] instance.',
        Then: 'returns a localized string',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(
          localizedApp(
            builder: (context) {
              translation = CUserRole.collaborator.cLocalize(context);
              return Container();
            },
          ),
        );

        expect(translation, isNotEmpty);
      }),
    );
    testWidgets(
      requirement(
        Given: 'An app with CCoreL10n delegate and en locale',
        When: 'localizing a [UserRole.viewer] instance.',
        Then: 'returns a localized string',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(
          localizedApp(
            builder: (context) {
              translation = CUserRole.viewer.cLocalize(context);
              return Container();
            },
          ),
        );

        expect(translation, isNotEmpty);
      }),
    );
  });
}
