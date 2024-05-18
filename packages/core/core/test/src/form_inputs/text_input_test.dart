import 'package:ccore/ccore.dart';
import 'package:cpub_dev/flutter_test.dart';
import 'package:cpub_dev/test_beautifier.dart';
import 'package:flutter/material.dart';

Widget localizations({required Widget Function(BuildContext context) builder}) {
  return Localizations(
    delegates: CCoreL10n.localizationsDelegates,
    locale: CCoreL10n.supportedLocales[0],
    child: Builder(builder: builder),
  );
}

void main() {
  group('CTextInput Tests', () {
    late CTextInput input;
    String? result;

    setUp(() => input = CTextInput());

    testWidgets(
      requirement(
        Given: 'empty input',
        When: 'validate',
        Then: 'returns string',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(
          localizations(
            builder: (context) {
              result = input.validator(input: ' ', context: context);
              return Container();
            },
          ),
        );
        expect(result, isNotNull);
      }),
    );

    testWidgets(
      requirement(
        Given: 'valid input',
        When: 'parse',
        Then: 'returns username',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(
          localizations(
            builder: (context) {
              result = input.parse(input: 'abc', context: context);
              return Container();
            },
          ),
        );
        expect(result, 'abc');
      }),
    );
  });
}
